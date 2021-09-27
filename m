Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDF5419D94
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbhI0Ryz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:54:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:49997 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235703AbhI0Ryr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:54:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="288190732"
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="288190732"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 10:53:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="456328547"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 27 Sep 2021 10:53:09 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.53])
        by linux.intel.com (Postfix) with ESMTP id 66BCA5802BD;
        Mon, 27 Sep 2021 10:53:09 -0700 (PDT)
Message-ID: <10bee4a609c48b8e10458c25755f17222c43c33c.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] platform/x86: Add Intel Software Defined Silicon
 driver
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Date:   Mon, 27 Sep 2021 10:53:09 -0700
In-Reply-To: <YVFCetbrNV+WkJ5Q@kroah.com>
References: <20210924213157.3584061-1-david.e.box@linux.intel.com>
         <20210924213157.3584061-2-david.e.box@linux.intel.com>
         <YU7BPIH123HUZKhw@kroah.com>
         <3392aea6b112926b063bbe46b1decaad4c9f9e6e.camel@linux.intel.com>
         <YVFCetbrNV+WkJ5Q@kroah.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-09-27 at 06:03 +0200, Greg KH wrote:
> On Sun, Sep 26, 2021 at 06:15:16PM -0700, David E. Box wrote:
> > > > +static int sdsi_remove(struct platform_device *pdev)
> > > > +{
> > > > +       struct sdsi_priv *priv = platform_get_drvdata(pdev);
> > > > +
> > > > +       priv->dev_present = false;
> > > > +       sysfs_remove_bin_file(&priv->pdev->dev.kobj, &priv->registers_bin_attr);
> > > > +       misc_deregister(&priv->miscdev);
> > > > +       kref_put(&priv->kref, sdsi_priv_release);
> > > 
> > > Why do you need a kref for a structure that already can be controlled by
> > > a different lifetime rule?
> > 
> > Which rule am I missing? This kref allows the structure to remain in case the device is removed
> > while the file is open.
> 
> This device is on a hardware bus that allows removal?

Well the device can be unbound. A test case covers this.

> 
> Anyway, you now are dealing with lifetime rules of 3 structures all at
> once, and the interactions between them is not very obvious.  It would
> probably be simpler just to stick with 2, right?  You really only care
> about the misc structure here.

In the case that the device is unbound, both the pdev and miscdev go away. Something has to outlive
them in order to handle any open files still trying to use the ioctl.

David

> 
> thanks,
> 
> greg k-h


