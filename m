Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA7245C7C9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 15:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354554AbhKXOp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 09:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354369AbhKXOpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 09:45:12 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F202C077ED9;
        Wed, 24 Nov 2021 06:13:42 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id r26so5594579oiw.5;
        Wed, 24 Nov 2021 06:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2z3U8O5vRhUaOMotVWyAU//EZivdVu6f+A08KEjRpo4=;
        b=S/mtB8ZzlO1LCCHiWJpLvCm/JFi/27wAj2r9zoyrKMfNmwOzZ0VQ/ZW3j3Tkn0lsru
         DMGqnqlmX8FC0Gv6fORIcJaHw1hlKtJPEGdUxxgkX2/zxKAkpsLoWdb3A+HTJPtYuXRe
         o7+tskvW/AsXI4x/qu+weV5ambeXUCucWSW21oGi6t8yf1pGCc0ICofH6P9KhsftZQJ/
         Vi3WqyrxQ/rybWJtHFHX17xFQpNdexfHYjZ4XnGQWRufrtHACmrx14lLV1g3hJqI4hBh
         4nzeYyO+MsfwPuy7jIBJH5FFlwCZBblkjv6pqTVnTORA2SWTLHFjtuqxhKAJGLBu6c1z
         ZnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2z3U8O5vRhUaOMotVWyAU//EZivdVu6f+A08KEjRpo4=;
        b=1WXDal+O8C9k2ITogM0QiWsvgaMmGX7zqT1m7fdLRAidjYZAhfuPfseYP4JUsox3mp
         9nE7qNaClZqRCaCqN1VjN+mGPW/I1EVWPfUR0iaoxPUQGxJ16o82Rk4kk1qTmZvcaenp
         w9Js6Ff2k1+XHD9XSrxz0pmtF+MtWydtxyg71ZClaaWJ+htmjyE4oU23DIQyIDxcUt0a
         wm0TM7VHZEQZUVjef6IQ/6Z7IZcQLyqfK81JsBpG2g2yKPp0MZ2nWTFZX1wDUzbWYp5s
         eQ6TBSs2lX6JzYXYVKnAM+fi5Vhw1G6QkW5URMnW2JWen0pOoWh4PkBvS+6aBuMdqNip
         aw0w==
X-Gm-Message-State: AOAM531e5bcPFLS08Wmi/7kfRtKAVzKrvE9nXCClZc9UUtouwFGofogV
        MnCnd/K6AWXSY/+vBWipWdj7GN5lF5I=
X-Google-Smtp-Source: ABdhPJwWmJ1UsYvSFbPmqoWtv0K6M6cBzdUTsg3b0HoziIzmqxIcutlqKRAkQNPHwQPAkyAcpoNpRg==
X-Received: by 2002:a05:6808:11c1:: with SMTP id p1mr6701641oiv.113.1637763221228;
        Wed, 24 Nov 2021 06:13:41 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w24sm2533915ots.10.2021.11.24.06.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 06:13:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 1/1] hwmon: Fix warnings in asus_wmi_sensors.rst
 documetation.
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Ed Brindley <kernel@maidavale.org>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211124162243.7db9ad02@canb.auug.org.au>
 <20211124064328.16048-1-pauk.denis@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8eb3d385-1e11-b3e3-d691-a7429e685cfc@roeck-us.net>
Date:   Wed, 24 Nov 2021 06:13:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211124064328.16048-1-pauk.denis@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/21 10:43 PM, Denis Pauk wrote:
> Fixes: 9d07e54a25b8 ("hwmon: (asus_wmi_sensors) Support X370 Asus WMI.")
> 
> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>

Squashed into offending commit.

However, for the future,
1) Please always provide a full description of the problem
2) Never send a patch as reply to a previous patch, or as reply
    to a bug report, unless you want it to get lost.

Where is that "send patch as reply" thing coming from ?
It seems to proliferate for some reason. Is someone promoting that ?

Thanks,
Guenter

> ---
>   Documentation/hwmon/asus_wmi_sensors.rst | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/hwmon/asus_wmi_sensors.rst b/Documentation/hwmon/asus_wmi_sensors.rst
> index 408fd3b4a0de..8f2096cf5183 100644
> --- a/Documentation/hwmon/asus_wmi_sensors.rst
> +++ b/Documentation/hwmon/asus_wmi_sensors.rst
> @@ -29,7 +29,9 @@ ASUS mainboards publish hardware monitoring information via WMI interface.
>   
>   ASUS WMI interface provides a methods to get list of sensors and values of
>   such, which is utilized by this driver to publish those sensor readings to the
> -HWMON system. The driver is aware of and reads the following sensors:
> +HWMON system.
> +
> +The driver is aware of and reads the following sensors:
>    * CPU Core Voltage,
>    * CPU SOC Voltage,
>    * DRAM Voltage,
> @@ -64,7 +66,7 @@ HWMON system. The driver is aware of and reads the following sensors:
>    * CPU VRM Output Current.
>   
>   Known Issues:
> -* The WMI implementation in some of Asus' BIOSes is buggy. This can result in
> + * The WMI implementation in some of Asus' BIOSes is buggy. This can result in
>      fans stopping, fans getting stuck at max speed, or temperature readouts
>      getting stuck. This is not an issue with the driver, but the BIOS. The Prime
>      X470 Pro seems particularly bad for this. The more frequently the WMI
> @@ -73,4 +75,4 @@ Known Issues:
>      sensors frequently, don't leave you computer unattended. Upgrading to new
>      BIOS version with method version greater than or equal to two should
>      rectify the issue.
> -* A few boards report 12v voltages to be ~10v.
> + * A few boards report 12v voltages to be ~10v.
> 
> base-commit: 9d07e54a25b84099983f56e33e00f2914f06b53f
> 

