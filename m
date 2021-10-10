Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB0E42818D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 15:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbhJJNkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 09:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbhJJNko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 09:40:44 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98541C061570;
        Sun, 10 Oct 2021 06:38:46 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id o204so12628388oih.13;
        Sun, 10 Oct 2021 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OWKRDGZ5rAqsuw0Zk1+oKWf/bbuzyyhS8ftArwSfVmw=;
        b=l/LE4Y+d9MgqGBacDqp1rPMPnUYwpD51P5IhKW9PSw04l0LTNp4RTUlv6IL3cfLeJG
         cMwtB4U0VVVSPPoV1U7RjWooIelNno/cgko06cxdESBS9DtRtCCWiiHiAZ3gQ4h5z/QR
         kyc+qqymFPK/pjCzFOI8+KHgKdbVd5QQPLeK2w7/r5fbZl4dJJTFiW6JsrKTHnwCwBSj
         1NLUFIRIZmJFTwWpD9suZSWJbWHlKhA9FlLGs2UBw1jbODM1dk7yXS2tBeGnJJJBh5Iz
         4JGgxNeYwKvuv8qe99Hv4DAp9pIUQIboV928gx6wiHq9koMvpaxAtI3Qcf3UOE9IcWHJ
         8JLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OWKRDGZ5rAqsuw0Zk1+oKWf/bbuzyyhS8ftArwSfVmw=;
        b=gX/6j39sgt9MSVjcrMpg6Ackfzi7JDsC/XYBT6JPyaxF1lv6FGxbk+kScxfWhgZHuK
         dklhPJv0kWuVIViBz+N6+0bTD2SzEzFUcGw1Vf4oRIShD/8VhXsaWvqxf24KTnO2tvdB
         MqtG/x5IRWVCwcziyVOASPZ7W6NcveREfvcQ6fpIS34Td0rePWeXd9ZmEki6WivLPHoz
         kf4bP1XzmkNHFA3zk1QtkQ0lG6kKNOWsE0yIoykDmcRh/ktOf/jE8r9whwxp3Gu/eQno
         YEZa+vBh/8jHeYWzQJdZAD/xxfQrA+/tpn4LWFNfsHRe+lNHniW9AX7Xis9vLiDWUbxi
         XeAA==
X-Gm-Message-State: AOAM532XE+kOfgDpKgPmRLsbZtlcbYX4E7bZYb1OjyTzVDWYN+76ncBX
        skZtmdClc8oHSW1mfp5ObXBcmqV9y5w=
X-Google-Smtp-Source: ABdhPJz4S7H0JVjGJQEJydGjfwXqFW2azHzh8r08zifJnHHsghnxY3f3+uk7WEyImgYHnKqnAubLQQ==
X-Received: by 2002:a05:6808:318:: with SMTP id i24mr23845094oie.60.1633873125599;
        Sun, 10 Oct 2021 06:38:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z83sm1121536oiz.41.2021.10.10.06.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 06:38:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>,
        Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        Ed Brindley <kernel@maidavale.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211010095216.25115-1-pauk.denis@gmail.com>
 <20211010095216.25115-3-pauk.denis@gmail.com>
 <0a037ce5-87bb-4aad-a30a-d954ff0910a7@t-8ch.de>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 2/2] hwmon: (asus_wmi_sensors) Support X370 Asus WMI.
Message-ID: <7658358e-5ba6-b764-463c-317f5b318707@roeck-us.net>
Date:   Sun, 10 Oct 2021 06:38:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <0a037ce5-87bb-4aad-a30a-d954ff0910a7@t-8ch.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/21 3:20 AM, Thomas Weißschuh wrote:
> Hi,
> 
> for WMI drivers the list platform-driver-x86@vger.kernel.org should probably be
> on CC too.
> Also all other WMI drivers, even for hwmon stuff are located in
> drivers/platform/x86 so it may be better to put it there, too.
> 

Not really. If any of those other drivers are pure hwmon drivers, they
should reside in drivers/hwmon instead. And, yes, that really includes
the gigabyte-wmi driver. We don't have arbitrary drivers in drivers/pci
either just because they are drivers for pci devices.

Guenter

> One comment inline.
> 
> On 2021-10-10T12:52+0300, Denis Pauk wrote:
>> +static struct platform_driver asus_wmi_sensors_platform_driver = {
>> +	.driver = {
>> +		.name	= "asus-wmi-sensors",
>> +	},
>> +	.probe = asus_wmi_probe,
>> +};
>> +
>> +static struct platform_device *sensors_pdev;
>> +
>> +static int __init asus_wmi_init(void)
>> +{
>> +	if (!dmi_check_system(asus_wmi_dmi_table))
>> +		return -ENODEV;
>> +
>> +	sensors_pdev = platform_create_bundle(&asus_wmi_sensors_platform_driver,
>> +					      asus_wmi_probe,
>> +					      NULL, 0,
>> +					      NULL, 0);
>> +
>> +	return PTR_ERR_OR_ZERO(sensors_pdev);
>> +}
>> +module_init(asus_wmi_init);
>> +
>> +static void __exit asus_wmi_exit(void)
>> +{
>> +	platform_device_unregister(sensors_pdev);
>> +	platform_driver_unregister(&asus_wmi_sensors_platform_driver);
>> +}
>> +module_exit(asus_wmi_exit);
> 
> This should bind to the WMI bus instead of being a platform device.
> See drivers/platform/x86/gigabyte-wmi.c
> 
> (Some goes also for the other driver)
> 
> Thomas
> 

