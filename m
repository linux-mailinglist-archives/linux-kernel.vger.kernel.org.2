Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7FF34693A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 20:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhCWTkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 15:40:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47065 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230406AbhCWTkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 15:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616528420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gTg0YZwN5hFKhiavzk2/eEE2JZuUQxCKgti32JKf8OQ=;
        b=TQgTnftXQ3cDXmqLyPmDmFUuCotCSdP6FtDbeNSLWE8QaaRUxkc4M1bafY8QvwfP5vBU0X
        tpZObC0YdprDv2U/QSkxER/lvzpf6Xsut3F/1Oh0Cq+8RhPZb47Tdjb94WNXPd+6qcGW/o
        ghiP3/cJUT1e+jyjSuW/7CKzgAHPk2U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-C3OpOrNVOby9bGUhbiv15w-1; Tue, 23 Mar 2021 15:40:19 -0400
X-MC-Unique: C3OpOrNVOby9bGUhbiv15w-1
Received: by mail-ej1-f69.google.com with SMTP id jo6so1526953ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 12:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gTg0YZwN5hFKhiavzk2/eEE2JZuUQxCKgti32JKf8OQ=;
        b=eY4n3eWsoO9w/6gAWx8vOebUzWn14IUg8ybJI9gZftXdAMn+dfWaCxBXTSBg98bfBB
         F1wMI6/5+23u0vNHeM6tZJ3Qzk52ZJMu3ZFiPMaAAFIo+ReajtgbAS3YiNby53KN7onj
         NjqlroMbxEryCetdp6VTUTRpwIAOo1ve1dvoXPai8pc+32jBpNnJixMsdmcJnZ/JSqgl
         7uw28xwningmh4NM1x7bpK+2ZQv7fB+3GdXLm2j1DZDiJ6HJQay9KURw4g4kZ0w6FiRP
         xhMTpG84qCP6Gfvb2AcUnAM/BbQ+GMfla1qRtOFcTy5r9l6XcxBJoH+w0YJv2+khDgrl
         HtNQ==
X-Gm-Message-State: AOAM531ssnJYMQ+N4OUc8arTP+GuDIlN3uz4eiPzMRy1iK4YEmwR2YxQ
        LQqB7Iu/JPGvlH7Fdfi70+ZrMTeZNn7rAEZCpETrsvFDl7NiNCfQ/YIemz+QyHbf6pqWC3EaAdl
        zSZWIRYM1dn1Qk7IMdywOQidH
X-Received: by 2002:a05:6402:110b:: with SMTP id u11mr6397939edv.356.1616528418169;
        Tue, 23 Mar 2021 12:40:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWHFAwTK7ag1Wvv7Id+c3/SYEgI+THVgdw8ygYHwpZENXbTKwxMbLV2w6ixKzeZOeLR4v7Vg==
X-Received: by 2002:a05:6402:110b:: with SMTP id u11mr6397924edv.356.1616528418074;
        Tue, 23 Mar 2021 12:40:18 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id m14sm13563701edr.13.2021.03.23.12.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 12:40:17 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Perry Yuan <Perry.Yuan@dell.com>, pobrn@protonmail.com,
        oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        mgross@linux.intel.com, Mario.Limonciello@dell.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, platform-driver-x86@vger.kernel.org,
        broonie@kernel.org
References: <20210322093841.11840-1-Perry_Yuan@Dell.com>
 <a1fae1fc-2d4f-63e8-e0be-0f9c4c91640c@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c61b975a-a771-eb63-5232-2da184ca95fe@redhat.com>
Date:   Tue, 23 Mar 2021 20:40:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <a1fae1fc-2d4f-63e8-e0be-0f9c4c91640c@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/23/21 7:57 PM, Pierre-Louis Bossart wrote:
> Minor comments below.

<snip<

>> +int __init dell_privacy_acpi_init(void)
> 
> is the __init necessary? You call this routine from another which already has this qualifier.

Yes this is necessary, all functions which are only used during module_load / from the
module's init function must be marked as __init so that the kernel can unload them
after module loading is done.

I do wonder if this one should not be static though (I've not looked at this patch in
detail yet).

> 
>> +{
>> +    int err;
>> +    struct platform_device *pdev;
>> +
>> +    if (!wmi_has_guid(DELL_PRIVACY_GUID))
>> +        return -ENODEV;
>> +
>> +    privacy_acpi = kzalloc(sizeof(*privacy_acpi), GFP_KERNEL);
>> +    if (!privacy_acpi)
>> +        return -ENOMEM;
>> +
>> +    err = platform_driver_register(&dell_privacy_platform_drv);
>> +    if (err)
>> +        goto pdrv_err;
>> +
>> +    pdev = platform_device_register_simple(
>> +            PRIVACY_PLATFORM_NAME, PLATFORM_DEVID_NONE, NULL, 0);
>> +    if (IS_ERR(pdev)) {
>> +        err = PTR_ERR(pdev);
>> +        goto pdev_err;
>> +    }
>> +
>> +    return 0;
>> +
>> +pdev_err:
>> +    platform_device_unregister(pdev);
>> +pdrv_err:
>> +    kfree(privacy_acpi);
>> +    return err;
>> +}
>> +
>> +void __exit dell_privacy_acpi_exit(void)
> 
> is the __exit required here?

Idem. Also static ?

Regards,

Hans



> 
>> +{
>> +    struct platform_device *pdev = to_platform_device(privacy_acpi->dev);
>> +
>> +    platform_device_unregister(pdev);
>> +    platform_driver_unregister(&dell_privacy_platform_drv);
>> +    kfree(privacy_acpi);
>> +}
>> +
>> +MODULE_AUTHOR("Perry Yuan <perry_yuan@dell.com>");
>> +MODULE_DESCRIPTION("DELL Privacy ACPI Driver");
>> +MODULE_LICENSE("GPL");
> 
> 

