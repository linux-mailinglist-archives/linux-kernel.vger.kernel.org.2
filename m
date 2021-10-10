Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE03A42806B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 12:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhJJKXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 06:23:00 -0400
Received: from todd.t-8ch.de ([159.69.126.157]:37307 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231244AbhJJKW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 06:22:59 -0400
Date:   Sun, 10 Oct 2021 12:20:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1633861257; bh=kYgiB3mpSyhh585RKGCOlcRIPt6QyKHC+NFIgj/DWts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aeFP250nclC+jxOIQjmCdnrj/A6/duHqIgB8687HtCuMWDOV+BTPJju7o6Wg9SqKT
         Ahricalo9nebKyYGa2ASlS3yT7bLaIhc2subITHSgNHcoDr3ha7Cgjy2WY6tClEfF2
         ee7Kt9EcSvTp4FUZN5zr7AdoUfTggEs8mZme+TAI=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        Ed Brindley <kernel@maidavale.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] hwmon: (asus_wmi_sensors) Support X370 Asus WMI.
Message-ID: <0a037ce5-87bb-4aad-a30a-d954ff0910a7@t-8ch.de>
References: <20211010095216.25115-1-pauk.denis@gmail.com>
 <20211010095216.25115-3-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211010095216.25115-3-pauk.denis@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

for WMI drivers the list platform-driver-x86@vger.kernel.org should probably be
on CC too.
Also all other WMI drivers, even for hwmon stuff are located in
drivers/platform/x86 so it may be better to put it there, too.

One comment inline.

On 2021-10-10T12:52+0300, Denis Pauk wrote:
> +static struct platform_driver asus_wmi_sensors_platform_driver = {
> +	.driver = {
> +		.name	= "asus-wmi-sensors",
> +	},
> +	.probe = asus_wmi_probe,
> +};
> +
> +static struct platform_device *sensors_pdev;
> +
> +static int __init asus_wmi_init(void)
> +{
> +	if (!dmi_check_system(asus_wmi_dmi_table))
> +		return -ENODEV;
> +
> +	sensors_pdev = platform_create_bundle(&asus_wmi_sensors_platform_driver,
> +					      asus_wmi_probe,
> +					      NULL, 0,
> +					      NULL, 0);
> +
> +	return PTR_ERR_OR_ZERO(sensors_pdev);
> +}
> +module_init(asus_wmi_init);
> +
> +static void __exit asus_wmi_exit(void)
> +{
> +	platform_device_unregister(sensors_pdev);
> +	platform_driver_unregister(&asus_wmi_sensors_platform_driver);
> +}
> +module_exit(asus_wmi_exit);

This should bind to the WMI bus instead of being a platform device.
See drivers/platform/x86/gigabyte-wmi.c

(Some goes also for the other driver)

Thomas
