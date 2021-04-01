Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9147350F1E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 08:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbhDAGhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 02:37:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:18679 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233080AbhDAGhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:37:39 -0400
IronPort-SDR: knuMgLHOezQ2r6b9r/22kzvcxhXs/pmM9QVDX9yO0yXNZBFzvuMrTF4p+RdD77hZUqYHNGdOxn
 N6KBaEo5XqkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="212414570"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="212414570"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 23:37:36 -0700
IronPort-SDR: xrOLOLJxgHvR5ZRV7Icjk6hgoUlE8iWeyUxgW0aK8wgXIkkRl//aJshplmJ/s9tDgdYeWWiUoi
 kmcPM/DtcODA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="517212558"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 31 Mar 2021 23:37:34 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 01 Apr 2021 09:37:33 +0300
Date:   Thu, 1 Apr 2021 09:37:33 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] usb: Iterator for ports
Message-ID: <YGVqLVMaUeqgvT4x@kuha.fi.intel.com>
References: <20210331105908.67066-1-heikki.krogerus@linux.intel.com>
 <20210331105908.67066-6-heikki.krogerus@linux.intel.com>
 <7cf8093e-20ab-ab88-5ba1-c2e6128c0480@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cf8093e-20ab-ab88-5ba1-c2e6128c0480@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 09:41:22AM -0700, Guenter Roeck wrote:
> > diff --git a/include/linux/usb.h b/include/linux/usb.h
> > index ddd2f5b2a2827..ebcd03d835d04 100644
> > --- a/include/linux/usb.h
> > +++ b/include/linux/usb.h
> > @@ -882,6 +882,15 @@ extern struct usb_host_interface *usb_find_alt_setting(
> >  		unsigned int iface_num,
> >  		unsigned int alt_num);
> >  
> > +#ifdef CONFIG_USB
> 
> #if IS_ENABLED(CONFIG_USB)

Thanks Guenter.

> > +int usb_for_each_port(void *data, int (*fn)(struct device *, void *));
> > +#else
> > +static inline int usb_for_each_port(void *data, int (*fn)(struct device *, void *))
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> >  /* port claiming functions */
> >  int usb_hub_claim_port(struct usb_device *hdev, unsigned port1,
> >  		struct usb_dev_state *owner);
> > 

-- 
heikki
