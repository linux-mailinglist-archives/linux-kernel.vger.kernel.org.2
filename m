Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D21417FF9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 08:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345323AbhIYG3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 02:29:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345279AbhIYG27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 02:28:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4437610EA;
        Sat, 25 Sep 2021 06:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632551241;
        bh=w/RmY89HXVNcF3MIRfDsLE3A3/k+cgoLYf1wKuMYh6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=envukjmadSqGDHOgmKb4kmDliNEB+0CbjGBRY8z0KTgHbCK8HlvfBIoILMoviWgrT
         Yj66dY9cSnNlf7vopUZlldWQRHJrWN1cBCUh/XHcldi2i5q2gYBd3FvZ+RzwuUqzIe
         FOzJRwx9Wbrpmx8OoX9CderpGqhUOvdUp03WKQBA=
Date:   Sat, 25 Sep 2021 08:27:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     hdegoede@redhat.com, mgross@linux.intel.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 2/2] platform/x86: Add Intel Software Defined Silicon
 driver
Message-ID: <YU7BPIH123HUZKhw@kroah.com>
References: <20210924213157.3584061-1-david.e.box@linux.intel.com>
 <20210924213157.3584061-2-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924213157.3584061-2-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 02:31:57PM -0700, David E. Box wrote:

Quick review:

> +static int sdsi_probe(struct platform_device *pdev)
> +{
> +	void __iomem *disc_addr;
> +	struct sdsi_priv *priv;
> +	int ret;
> +
> +	disc_addr = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(disc_addr))
> +		return PTR_ERR(disc_addr);
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	kref_init(&priv->kref);
> +
> +	platform_set_drvdata(pdev, priv);
> +	priv->pdev = pdev;
> +	mutex_init(&priv->mb_lock);
> +	mutex_init(&priv->akc_lock);
> +
> +	memcpy_fromio(&priv->disc_table, disc_addr, DISC_TABLE_SIZE);
> +
> +	ret = sdsi_map_sdsi_registers(pdev);
> +	if (ret)
> +		goto put_kref;
> +
> +	ret = sdsi_create_misc_device(pdev);
> +	if (ret)
> +		goto put_kref;
> +
> +	ret = sdsi_add_bin_attrs(pdev);

You just raced with userspace and lost.  Please attach your attributes
to the misc device before registering it.

Also, you need a Documentation/ABI/ entry for your new sysfs file(s).

> +	if (ret)
> +		goto deregister_misc;
> +
> +	priv->dev_present = true;
> +
> +	return 0;
> +
> +deregister_misc:
> +	misc_deregister(&priv->miscdev);
> +put_kref:
> +	kref_put(&priv->kref, sdsi_priv_release);
> +
> +	return ret;
> +}
> +
> +static int sdsi_remove(struct platform_device *pdev)
> +{
> +	struct sdsi_priv *priv = platform_get_drvdata(pdev);
> +
> +	priv->dev_present = false;
> +	sysfs_remove_bin_file(&priv->pdev->dev.kobj, &priv->registers_bin_attr);
> +	misc_deregister(&priv->miscdev);
> +	kref_put(&priv->kref, sdsi_priv_release);

Why do you need a kref for a structure that already can be controlled by
a different lifetime rule?

> +
> +	return 0;
> +}
> +
> +static struct platform_driver sdsi_driver = {
> +	.driver = {
> +		.name		= SDSI_DEV_NAME,
> +		.dev_groups	= sdsi_groups,
> +	},
> +	.probe  = sdsi_probe,
> +	.remove = sdsi_remove,
> +};
> +module_platform_driver(sdsi_driver);

What causes the platform to know to register, and enable, this platform
driver?  Shouldn't there be some hardware involved that is discoverable
to enable it to load dynamically?

thanks,

greg k-h
