Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5913930C2EA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 16:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbhBBPDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 10:03:46 -0500
Received: from mga03.intel.com ([134.134.136.65]:38166 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234921AbhBBPC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 10:02:58 -0500
IronPort-SDR: OPXWHv5vWDOExESCi3weiZl62nHF1+i85ltzNtF5q46SiQphcYrlpZTQJcDyCiWVVBSiAKh0rI
 07CXn92h4RBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="180941069"
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="180941069"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 07:01:06 -0800
IronPort-SDR: +s0fCS9Fjq4/R6UZgAdxjeShz1QH1UzkitSPJuILcnR1hafmwqMxYRd14nT6NGVVGTZZwiLTD/
 1EFhaH8SXtVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="479822168"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 02 Feb 2021 07:01:03 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 02 Feb 2021 17:01:02 +0200
Date:   Tue, 2 Feb 2021 17:01:02 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 1/6] software node: Provide replacement for
 device_add_properties()
Message-ID: <20210202150102.GA1687065@kuha.fi.intel.com>
References: <20210202125032.64982-1-heikki.krogerus@linux.intel.com>
 <20210202125032.64982-2-heikki.krogerus@linux.intel.com>
 <CAJZ5v0gMEBV=Gm-R=5zkN-J_p7cMTBwoOJrv=ec1j6SfSYRg_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gMEBV=Gm-R=5zkN-J_p7cMTBwoOJrv=ec1j6SfSYRg_w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Tue, Feb 02, 2021 at 03:44:05PM +0100, Rafael J. Wysocki wrote:
> > +/**
> > + * device_create_managed_software_node - Create a software node for a device
> > + * @dev: The device the software node is assigned to.
> > + * @properties: Device properties for the software node.
> > + * @parent: Parent of the software node.
> > + *
> > + * Creates a software node as a managed resource for @dev, which means the
> > + * lifetime of the newly created software node is tied to the lifetime of @dev.
> > + * Software nodes created with this function should not be reused or shared
> > + * because of that. The function takes a deep copy of @properties for the
> > + * software node.
> > + *
> > + * Since the new software node is assigned directly to @dev, and since it should
> > + * not be shared, it is not returned to the caller. The function returns 0 on
> > + * success, and errno in case of an error.
> > + */
> > +int device_create_managed_software_node(struct device *dev,
> > +                                       const struct property_entry *properties,
> > +                                       const struct software_node *parent)
> > +{
> > +       struct fwnode_handle *p = software_node_fwnode(parent);
> > +       struct fwnode_handle *fwnode;
> > +
> > +       if (parent && !p)
> > +               return -EINVAL;
> > +
> > +       fwnode = fwnode_create_software_node(properties, p);
                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
To answer your question below: here.

> > +       if (IS_ERR(fwnode))
> > +               return PTR_ERR(fwnode);
> > +
> > +       to_swnode(fwnode)->managed = true;
> > +       set_secondary_fwnode(dev, fwnode);
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(device_create_managed_software_node);
> > +
> >  int software_node_notify(struct device *dev, unsigned long action)
> >  {
> >         struct swnode *swnode;
> > @@ -1073,6 +1111,11 @@ int software_node_notify(struct device *dev, unsigned long action)
> >                 sysfs_remove_link(&swnode->kobj, dev_name(dev));
> >                 sysfs_remove_link(&dev->kobj, "software_node");
> >                 kobject_put(&swnode->kobj);
> > +
> > +               if (swnode->managed) {
> > +                       set_secondary_fwnode(dev, NULL);
> > +                       kobject_put(&swnode->kobj);
> 
> Where does the corresponding kobject_get() get called?

So in function fwnode_create_software_node() we use
kobject_init_and_add().


thanks,

-- 
heikki
