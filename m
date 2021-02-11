Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBF231921B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhBKSUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbhBKSEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 13:04:53 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED745C06178B
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 10:04:11 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id o38so4441244pgm.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 10:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ABmGACKj8AbXK76X6Oa7fcPA01DfnOcIma2NBDr+Ii8=;
        b=gdDg+trAg1mnOAYW198dpCWFTvXYocL6QHdOt952qYu1iFidwX9K64iSDFdFlMpaas
         /UPo99v23QnfYtMzFZCBYxt7DtkTQyRdQq0zB/TE8/VxDRKXUYnxvf4Ncf1zAer5315c
         5JSozgsGTijUu53setjDkpshgqAIqJpq6Jvow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ABmGACKj8AbXK76X6Oa7fcPA01DfnOcIma2NBDr+Ii8=;
        b=YE2gfvZzTk2VXTT7aNo8VBCUkLWS4/13eTiVAI/Z4DBgjQ6BSBgmUSx98rpJMb5T7o
         +RLcHf/cB06RUR6e3C/CIBW9OoU+7YrIOUA0JCF1dJIGoCKfvaDcJqs5m+9fd1diD/gW
         PNe0CLcwalnMutbm450elRN9qsC6sMDyY9R7T/iY8lMvvCuP0K2i9miXQCG48kTZuSgh
         eEwRcIdN4u6w/HnDIDJIVAnuMsjszl1bhm2DBfYdGUMzkc3SB0obWF05ElLu01qz2/sH
         rECJ5uGnXg8luGu6kLrI250AxatEAhfN8CgcyiJugEsaR6bMtlaIM3VKdXT70wwHwrai
         jGmg==
X-Gm-Message-State: AOAM533qmXgTgmzx0kv6wsaLrj/bVT+0xahYY+4RehAinTydF83OEPV9
        jl1c+9xeb/PD26FZwWV3+lWGdQ==
X-Google-Smtp-Source: ABdhPJxgeZDClYTwM7w3KSD3XpIZZ3WMRSb8LUUqNHFWQ2sSL1PVnza2+m10uol/5oUW2d5jDTZqrA==
X-Received: by 2002:a05:6a00:22d6:b029:1cb:35ac:d8e0 with SMTP id f22-20020a056a0022d6b02901cb35acd8e0mr8938502pfj.17.1613066651431;
        Thu, 11 Feb 2021 10:04:11 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fc92:99c:fc2f:8603])
        by smtp.gmail.com with UTF8SMTPSA id h11sm3967858pjc.27.2021.02.11.10.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 10:04:10 -0800 (PST)
Date:   Thu, 11 Feb 2021 10:04:08 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Bastien Nocera <hadess@hadess.net>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Al Cooper <alcooperx@gmail.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v5 2/4] USB: misc: Add onboard_usb_hub driver
Message-ID: <YCVxmA8VraYuwN3y@google.com>
References: <20210210171040.684659-1-mka@chromium.org>
 <20210210091015.v5.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <YCTWpUqD7vSu0c4k@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCTWpUqD7vSu0c4k@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Feb 11, 2021 at 08:03:01AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Feb 10, 2021 at 09:10:37AM -0800, Matthias Kaehlcke wrote:
> > +static int onboard_hub_add_usbdev(struct onboard_hub *hub, struct usb_device *udev)
> > +{
> > +	struct udev_node *node;
> > +	char link_name[64];
> > +	int ret = 0;
> > +
> > +	mutex_lock(&hub->lock);
> > +
> > +	if (hub->going_away) {
> > +		ret = -EINVAL;
> > +		goto unlock;
> > +	}
> > +
> > +	node = devm_kzalloc(hub->dev, sizeof(*node), GFP_KERNEL);
> > +	if (!node) {
> > +		ret = -ENOMEM;
> > +		goto unlock;
> > +	}
> > +
> > +	node->udev = udev;
> > +
> > +	list_add(&node->list, &hub->udev_list);
> > +
> > +	snprintf(link_name, sizeof(link_name), "usb_dev.%s", dev_name(&udev->dev));
> > +	WARN_ON(sysfs_create_link(&hub->dev->kobj, &udev->dev.kobj, link_name));
> 
> Never use WARN_ON() unless you want the machine to reboot if it triggers
> (panic on warn).

Ah, thanks, I wasn't aware of that. Will change to some type of log if the
sysfs attributes stick around.

> But the larger question is what is this sysfs link for?  It's not
> documented anywhere, and so, shouldn't be allowed.  Who is going to use
> it and why is it needed?

Alan asked to add them: https://lore.kernel.org/patchwork/patch/1313000/#1514338

I'm fine with either way, let's just agree on something :)

> > +
> > +unlock:
> > +	mutex_unlock(&hub->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static void onboard_hub_remove_usbdev(struct onboard_hub *hub, struct usb_device *udev)
> > +{
> > +	struct udev_node *node;
> > +	char link_name[64];
> > +
> > +	snprintf(link_name, sizeof(link_name), "usb_dev.%s", dev_name(&udev->dev));
> > +	sysfs_remove_link(&hub->dev->kobj, link_name);
> > +
> > +	mutex_lock(&hub->lock);
> > +
> > +	list_for_each_entry(node, &hub->udev_list, list) {
> > +		if (node->udev == udev) {
> > +			list_del(&node->list);
> > +			break;
> > +		}
> > +	}
> > +
> > +	mutex_unlock(&hub->lock);
> > +}
> > +
> > +static ssize_t always_powered_in_suspend_show(struct device *dev, struct device_attribute *attr,
> > +			   char *buf)
> > +{
> > +	struct onboard_hub *hub = dev_get_drvdata(dev);
> > +
> > +	return sprintf(buf, "%d\n", hub->always_powered_in_suspend);
> 
> sysfs_emit()?

ok

> And you forgot the Documentation/ABI/ entries for this driver, so it
> really can not be reviewed...

I'll add it in the next version.

> > +}
> > +
> > +static ssize_t always_powered_in_suspend_store(struct device *dev, struct device_attribute *attr,
> > +			    const char *buf, size_t count)
> > +{
> > +	struct onboard_hub *hub = dev_get_drvdata(dev);
> > +	bool val;
> > +	int ret;
> > +
> > +	ret = kstrtobool(buf, &val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	hub->always_powered_in_suspend = val;
> > +
> > +	return count;
> > +}
> > +static DEVICE_ATTR_RW(always_powered_in_suspend);
> > +
> > +static struct attribute *onboard_hub_sysfs_entries[] = {
> > +	&dev_attr_always_powered_in_suspend.attr,
> > +	NULL,
> > +};
> > +
> > +static const struct attribute_group onboard_hub_sysfs_group = {
> > +	.attrs = onboard_hub_sysfs_entries,
> > +};
> > +
> > +static int onboard_hub_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct onboard_hub *hub;
> > +	int err;
> > +
> > +	hub = devm_kzalloc(dev, sizeof(*hub), GFP_KERNEL);
> > +	if (!hub)
> > +		return -ENOMEM;
> > +
> > +	hub->vdd = devm_regulator_get(dev, "vdd");
> > +	if (IS_ERR(hub->vdd))
> > +		return PTR_ERR(hub->vdd);
> > +
> > +	hub->dev = dev;
> > +	mutex_init(&hub->lock);
> > +	INIT_LIST_HEAD(&hub->udev_list);
> > +
> > +	dev_set_drvdata(dev, hub);
> > +
> > +	err = devm_device_add_group(dev, &onboard_hub_sysfs_group);
> 
> You just raced userspace and lost :(
> 
> Please use the correct api to add sysfs attributes to the device
> automatically by the driver core.

ok

> But the larger question is why do you need them at all?  What do they
> do that we can't already do with existing apis that you feel a one-off
> api for this driver is required?

The 'always_powered_in_suspend' attribute allows the admin to configure whether
the hub should always been kept on in suspend. I'm know about existing APIs that
would be suitable for that, but that might be just my ignorance. If you have any
suggestions please let me know.

> > +	if (err) {
> > +		dev_err(dev, "failed to create sysfs entries: %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	err = onboard_hub_power_on(hub);
> > +	if (err)
> > +		return err;
> > +
> > +	/*
> > +	 * The USB driver might have been detached from the USB devices by
> > +	 * onboard_hub_remove() make sure to re-attach it if needed.
> > +	 */
> > +	(void)driver_attach(&onboard_hub_usbdev_driver.drvwrap.driver);
> 
> (void)????
> 
> Please no, do it right.

Ok, driver_attach() does not return an error when the driver is already
attached, so it should be fine to change this to an error check.

> But, why is a driver calling this function anyway?  That feels really
> really wrong...

I found during testing that this is needed to make sure the driver is attached
again after it was released in onboard_hub_remove(). Alan requested to release
the driver to avoid dangling references:
https://lore.kernel.org/patchwork/patch/1310889/#1506598

Thanks

Matthias
