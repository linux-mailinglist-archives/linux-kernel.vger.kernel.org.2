Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42484318586
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 08:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhBKHDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 02:03:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:54392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhBKHDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 02:03:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EE3464E66;
        Thu, 11 Feb 2021 07:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613026984;
        bh=CWq+pji4/XiLPEOlolpq26pX1Yyz0/9QKDbeBkiamTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QLyT0WLjNpNSZaKjNmMm7/ONa841uQYyH2X5kJGfzEyKfnLYHHNy9w9x2kSHt0KAt
         OeMaekB3lLg0hvxzfTINJ3lQkNIutHo9oz1CdAStryCAYwsaFeXVomANiEsLeOOfeG
         XaMFD0zibLyssxeaafvk5cH+sMRqI9R5Ox3EnMnI=
Date:   Thu, 11 Feb 2021 08:03:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthias Kaehlcke <mka@chromium.org>
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
Message-ID: <YCTWpUqD7vSu0c4k@kroah.com>
References: <20210210171040.684659-1-mka@chromium.org>
 <20210210091015.v5.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210091015.v5.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 09:10:37AM -0800, Matthias Kaehlcke wrote:
> +static int onboard_hub_add_usbdev(struct onboard_hub *hub, struct usb_device *udev)
> +{
> +	struct udev_node *node;
> +	char link_name[64];
> +	int ret = 0;
> +
> +	mutex_lock(&hub->lock);
> +
> +	if (hub->going_away) {
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +
> +	node = devm_kzalloc(hub->dev, sizeof(*node), GFP_KERNEL);
> +	if (!node) {
> +		ret = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	node->udev = udev;
> +
> +	list_add(&node->list, &hub->udev_list);
> +
> +	snprintf(link_name, sizeof(link_name), "usb_dev.%s", dev_name(&udev->dev));
> +	WARN_ON(sysfs_create_link(&hub->dev->kobj, &udev->dev.kobj, link_name));

Never use WARN_ON() unless you want the machine to reboot if it triggers
(panic on warn).

But the larger question is what is this sysfs link for?  It's not
documented anywhere, and so, shouldn't be allowed.  Who is going to use
it and why is it needed?



> +
> +unlock:
> +	mutex_unlock(&hub->lock);
> +
> +	return ret;
> +}
> +
> +static void onboard_hub_remove_usbdev(struct onboard_hub *hub, struct usb_device *udev)
> +{
> +	struct udev_node *node;
> +	char link_name[64];
> +
> +	snprintf(link_name, sizeof(link_name), "usb_dev.%s", dev_name(&udev->dev));
> +	sysfs_remove_link(&hub->dev->kobj, link_name);
> +
> +	mutex_lock(&hub->lock);
> +
> +	list_for_each_entry(node, &hub->udev_list, list) {
> +		if (node->udev == udev) {
> +			list_del(&node->list);
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&hub->lock);
> +}
> +
> +static ssize_t always_powered_in_suspend_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct onboard_hub *hub = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%d\n", hub->always_powered_in_suspend);

sysfs_emit()?

And you forgot the Documentation/ABI/ entries for this driver, so it
really can not be reviewed...


> +}
> +
> +static ssize_t always_powered_in_suspend_store(struct device *dev, struct device_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	struct onboard_hub *hub = dev_get_drvdata(dev);
> +	bool val;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	hub->always_powered_in_suspend = val;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(always_powered_in_suspend);
> +
> +static struct attribute *onboard_hub_sysfs_entries[] = {
> +	&dev_attr_always_powered_in_suspend.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group onboard_hub_sysfs_group = {
> +	.attrs = onboard_hub_sysfs_entries,
> +};
> +
> +static int onboard_hub_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct onboard_hub *hub;
> +	int err;
> +
> +	hub = devm_kzalloc(dev, sizeof(*hub), GFP_KERNEL);
> +	if (!hub)
> +		return -ENOMEM;
> +
> +	hub->vdd = devm_regulator_get(dev, "vdd");
> +	if (IS_ERR(hub->vdd))
> +		return PTR_ERR(hub->vdd);
> +
> +	hub->dev = dev;
> +	mutex_init(&hub->lock);
> +	INIT_LIST_HEAD(&hub->udev_list);
> +
> +	dev_set_drvdata(dev, hub);
> +
> +	err = devm_device_add_group(dev, &onboard_hub_sysfs_group);

You just raced userspace and lost :(

Please use the correct api to add sysfs attributes to the device
automatically by the driver core.  But the larger question is why do you
need them at all?  What do they do that we can't already do with
existing apis that you feel a one-off api for this driver is required?



> +	if (err) {
> +		dev_err(dev, "failed to create sysfs entries: %d\n", err);
> +		return err;
> +	}
> +
> +	err = onboard_hub_power_on(hub);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * The USB driver might have been detached from the USB devices by
> +	 * onboard_hub_remove() make sure to re-attach it if needed.
> +	 */
> +	(void)driver_attach(&onboard_hub_usbdev_driver.drvwrap.driver);

(void)????

Please no, do it right.

But, why is a driver calling this function anyway?  That feels really
really wrong...

thanks,

greg k-h
