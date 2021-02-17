Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBBF31D9C0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 13:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbhBQMss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 07:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbhBQMsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 07:48:42 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D42C061756;
        Wed, 17 Feb 2021 04:48:01 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id z7so7358039plk.7;
        Wed, 17 Feb 2021 04:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=LxFn4W9o9jOzv9KLzMHQXyxirKKlLx5EMaZ9RsITOuw=;
        b=DzngJu7Z6z0/+kWv251zZ4GEzpARMockZt/9+QoKi5MQQtIJ+Y0umbS8cDEkpyOmfw
         ust/Kiuu4JyHc4DrgnrYRTx33vMhPnjXlD5m+tFjFIM6TDOubmyumNbqrhprZ9PK0y5x
         D+E5p3IPfUC23iiACIODUi+NBXs35cdUu9w/OYlSxnbGgHUph2wNx0AxPQENgw6L1/Cm
         ReRRr6F9A1k2w25Vx4AxCdH7nF/fSu+oD7eGReffZTF6rzN7K6K4Gy8awLP7SsgeNqxq
         ylpvMnwqKpHrFmriMWbrTFK+ut8aiSKcDi7kIlHnRRnAfyn3xuheT6yQYRpcPjCHwbE/
         4V6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=LxFn4W9o9jOzv9KLzMHQXyxirKKlLx5EMaZ9RsITOuw=;
        b=fx9ITt69/9ZbK8Ra6kCOohzX25GwioOBgfmm8JW4nOg6H6T3IGhw+PhuDmYTmxCoyN
         QZQL5Fh0k2uestWnScKbu/PqlfiX92rWB5elYLkzOER2tNokZK+iWfH1jdyweMKmVN2y
         8i0DaMoIxBimhI2j5+TUJcEBIcI9O0FaboQ0lPNCQOKQbDQ4JB+vHgTwmZncZ44bWSTY
         9LE4ZIIY+XUlEYrqwdtFJlOLRZQnCya1nJBnd7h8J5RMoQTyt3j0SVZ9+e+RmGbkR+UZ
         aBHFkiYWmt87AZS/TySPrTeq96Lcsz4Z1x3nf1Bg7yr5hHSHyjt8T6eg10/8LPmOAib/
         8RKQ==
X-Gm-Message-State: AOAM531CLhbCUphXaFMn0mOYe+SweImYb+uLxtY8iAyKvEZy+h8TCubI
        a6M9yvspin+k/KKAen9ZM2A=
X-Google-Smtp-Source: ABdhPJzja9YOfu921M8CWphegsgmA9y9BsmyYOmipRer8O9IXuclHZHnGiUjpqUjW0uuVCoGFT8YNw==
X-Received: by 2002:a17:902:bcc6:b029:e3:f95:6da5 with SMTP id o6-20020a170902bcc6b02900e30f956da5mr24612328pls.6.1613566081427;
        Wed, 17 Feb 2021 04:48:01 -0800 (PST)
Received: from [0.0.0.0] ([2605:52c0:2:4a5::])
        by smtp.gmail.com with ESMTPSA id i1sm2322259pjd.37.2021.02.17.04.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 04:48:01 -0800 (PST)
Subject: Re: [PATCH v3 1/3] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Perry Yuan <Perry.Yuan@dell.com>, oder_chiou@realtek.com,
        perex@perex.cz, tiwai@suse.com, hdegoede@redhat.com,
        mgross@linux.intel.com
Cc:     alsa-devel@alsa-project.org, Mario.Limonciello@dell.com,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        platform-driver-x86@vger.kernel.org, broonie@kernel.org
References: <20210112171723.19484-1-Perry_Yuan@Dell.com>
 <bf048701-4e6b-ad18-1a73-8bca5c922425@linux.intel.com>
 <79277bf2-3c9e-8b66-47a9-b926a2576f7f@gmail.com>
 <31982e8d-3b0d-7187-8798-900f95d876ee@linux.intel.com>
From:   Perry Yuan <perry979106@gmail.com>
Message-ID: <e66d8098-beb6-1299-20aa-42cfe13882f6@gmail.com>
Date:   Wed, 17 Feb 2021 20:47:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <31982e8d-3b0d-7187-8798-900f95d876ee@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre:
On 2021/2/16 22:56, Pierre-Louis Bossart wrote:
> 
>>>> +static const struct acpi_device_id privacy_acpi_device_ids[] = {
>>>> +    {"PNP0C09", 0},
>>>> +    { },
>>>> +};
>>>> +MODULE_DEVICE_TABLE(acpi, privacy_acpi_device_ids);
>>>> +
>>>> +static struct platform_driver dell_privacy_platform_drv = {
>>>> +    .driver = {
>>>> +        .name = PRIVACY_PLATFORM_NAME,
>>>> +        .acpi_match_table = ACPI_PTR(privacy_acpi_device_ids),
>>>> +    },
>>>
>>> no .probe?
>> Originally i added the probe here, but it cause the driver  .probe 
>> called twice. after i use platform_driver_probe to register the driver 
>> loading process, the duplicated probe issue resolved.
>>
>> I
>>>
>>>> +    .remove = dell_privacy_acpi_remove,
>>>> +};
>>>> +
>>>> +int __init dell_privacy_acpi_init(void)
>>>> +{
>>>> +    int err;
>>>> +    struct platform_device *pdev;
>>>> +    int privacy_capable = wmi_has_guid(DELL_PRIVACY_GUID);
>>>> +
>>>> +    if (!wmi_has_guid(DELL_PRIVACY_GUID))
>>>> +        return -ENODEV;
>>>> +
>>>> +    privacy_acpi = kzalloc(sizeof(*privacy_acpi), GFP_KERNEL);
>>>> +    if (!privacy_acpi)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    pdev = platform_device_register_simple(
>>>> +            PRIVACY_PLATFORM_NAME, PLATFORM_DEVID_NONE, NULL, 0);
>>>> +    if (IS_ERR(pdev)) {
>>>> +        err = PTR_ERR(pdev);
>>>> +        goto pdev_err;
>>>> +    }
>>>> +    err = platform_driver_probe(&dell_privacy_platform_drv,
>>>> +            dell_privacy_acpi_probe);
>>>> +    if (err)
>>>> +        goto pdrv_err;
>>>
>>> why is the probe done here? Put differently, what prevents you from 
>>> using a 'normal' platform driver, and do the leds_setup in the .probe()?
>> At first ,I used the normal platform driver framework, however tt 
>> cause the driver  .probe called twice. after i use 
>> platform_driver_probe to register the driver loading process, the 
>> duplicated probe issue resolved.
> 
> This sounds very odd...
> 
> this looks like a conflict with the ACPI subsystem finding a device and 
> probing the driver that's associated with the PNP0C09 HID, and then this 
> module __init  creating a device manually which leads to a second probe
> 
> Neither the platform_device_register_simple() nor 
> platform_driver_probe() seem necessary?Because this privacy acpi driver file has dependency on the ec handle, 
so i want to determine if the driver can be loaded basing on the EC ID 
PNP0C09 matching.

So far,It works well for me to register the privacy driver with  the 
register sequence.
Dose it hurt to keep current registering process with 
platform_driver_probe used?

Perry
