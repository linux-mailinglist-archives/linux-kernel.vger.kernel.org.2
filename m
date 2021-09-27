Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4CA418D69
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 03:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhI0BQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 21:16:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:58567 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhI0BQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 21:16:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10119"; a="288047046"
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; 
   d="scan'208";a="288047046"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 18:15:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; 
   d="scan'208";a="519881777"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 26 Sep 2021 18:15:16 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.53])
        by linux.intel.com (Postfix) with ESMTP id 5179258073D;
        Sun, 26 Sep 2021 18:15:16 -0700 (PDT)
Message-ID: <3392aea6b112926b063bbe46b1decaad4c9f9e6e.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] platform/x86: Add Intel Software Defined Silicon
 driver
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Greg KH <gregkh@linuxfoundation.org>, lee.jones@linaro.org
Cc:     hdegoede@redhat.com, mgross@linux.intel.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Date:   Sun, 26 Sep 2021 18:15:16 -0700
In-Reply-To: <YU7BPIH123HUZKhw@kroah.com>
References: <20210924213157.3584061-1-david.e.box@linux.intel.com>
         <20210924213157.3584061-2-david.e.box@linux.intel.com>
         <YU7BPIH123HUZKhw@kroah.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-09-25 at 08:27 +0200, Greg KH wrote:
> On Fri, Sep 24, 2021 at 02:31:57PM -0700, David E. Box wrote:
> 
> Quick review:
> 
> > +static int sdsi_probe(struct platform_device *pdev)
> > +{
> > +       void __iomem *disc_addr;
> > +       struct sdsi_priv *priv;
> > +       int ret;
> > +
> > +       disc_addr = devm_platform_ioremap_resource(pdev, 0);
> > +       if (IS_ERR(disc_addr))
> > +               return PTR_ERR(disc_addr);
> > +
> > +       priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > +       if (!priv)
> > +               return -ENOMEM;
> > +
> > +       kref_init(&priv->kref);
> > +
> > +       platform_set_drvdata(pdev, priv);
> > +       priv->pdev = pdev;
> > +       mutex_init(&priv->mb_lock);
> > +       mutex_init(&priv->akc_lock);
> > +
> > +       memcpy_fromio(&priv->disc_table, disc_addr, DISC_TABLE_SIZE);
> > +
> > +       ret = sdsi_map_sdsi_registers(pdev);
> > +       if (ret)
> > +               goto put_kref;
> > +
> > +       ret = sdsi_create_misc_device(pdev);
> > +       if (ret)
> > +               goto put_kref;
> > +
> > +       ret = sdsi_add_bin_attrs(pdev);
> 
> You just raced with userspace and lost.  Please attach your attributes
> to the misc device before registering it.
> 
> Also, you need a Documentation/ABI/ entry for your new sysfs file(s).

Ack

> 
> > +       if (ret)
> > +               goto deregister_misc;
> > +
> > +       priv->dev_present = true;
> > +
> > +       return 0;
> > +
> > +deregister_misc:
> > +       misc_deregister(&priv->miscdev);
> > +put_kref:
> > +       kref_put(&priv->kref, sdsi_priv_release);
> > +
> > +       return ret;
> > +}
> > +
> > +static int sdsi_remove(struct platform_device *pdev)
> > +{
> > +       struct sdsi_priv *priv = platform_get_drvdata(pdev);
> > +
> > +       priv->dev_present = false;
> > +       sysfs_remove_bin_file(&priv->pdev->dev.kobj, &priv->registers_bin_attr);
> > +       misc_deregister(&priv->miscdev);
> > +       kref_put(&priv->kref, sdsi_priv_release);
> 
> Why do you need a kref for a structure that already can be controlled by
> a different lifetime rule?

Which rule am I missing? This kref allows the structure to remain in case the device is removed
while the file is open.

> 
> > +
> > +       return 0;
> > +}
> > +
> > +static struct platform_driver sdsi_driver = {
> > +       .driver = {
> > +               .name           = SDSI_DEV_NAME,
> > +               .dev_groups     = sdsi_groups,
> > +       },
> > +       .probe  = sdsi_probe,
> > +       .remove = sdsi_remove,
> > +};
> > +module_platform_driver(sdsi_driver);
> 
> What causes the platform to know to register, and enable, this platform
> driver?  Shouldn't there be some hardware involved that is discoverable
> to enable it to load dynamically?

Ah. The patch that adds the SDSi platform device string was added to a series for the intel_pmt MFD
driver and it's still waiting review. I see that complicates things. I can combine the two series
together.

David

> 
> thanks,
> 
> greg k-h


