Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DD2388F2C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240121AbhESNb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:31:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54262 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238062AbhESNbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621431018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0enBGImmf0zzRSgY4Jvs9Yb1j7HX7ZFUvmCoMGislyU=;
        b=VDTuZznTv9Dq1M2t9s4GzscJGaI0FMsrsWFahLiSmuS0JjCoS3uVmmyTvs6M7H6wGRCNbz
        ow0QuBXvKl/fiNqhtPOj0e3wgcAy+djTaY/1FFqIpefxBIzgAU9sZZ5gW820NZ/XsoDNbB
        LDtIO/2VaStTQ+kFS2bnDUjZqJXqHw4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-DbvdyS4TON6hNqg2fov8dA-1; Wed, 19 May 2021 09:30:15 -0400
X-MC-Unique: DbvdyS4TON6hNqg2fov8dA-1
Received: by mail-ed1-f70.google.com with SMTP id r19-20020a05640251d3b02903888eb31cafso7695823edd.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 06:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0enBGImmf0zzRSgY4Jvs9Yb1j7HX7ZFUvmCoMGislyU=;
        b=E4hh818ACMZJ8FNfMJCXXqSdoAvQGda1MFersYFJrGgmPoB3ESPurIvvIufCB+nB+Q
         crsL98HtJ2qy7LQb194kwSUTnIZRX+VfYx4dcLM4Ueem/oww6gMqaSihAqmTF1HoYV7h
         OLPaUkcjG4t5Ln1vl0uShaf+7hVNR6nDwFX+3C1ezgC0SHaj+J0c6cta0n9suATyVPZF
         5RPfU1ODrFVOKMV9Yw+eU1yETjuM0sS0r8WAr9hRwKyWuxiBG9PHLQ3buHLpltKKGdnO
         LCU2yZ6XeyPP1UdP0N/fQE+Y1Qy81C1HeHHXZSA9lHyFiy+7SZzWsmduvqNMKWgCaQGi
         OSzQ==
X-Gm-Message-State: AOAM5311qxbNQFqY1AstJDOsWvsrGY153ZOowRxnjhCBFRHxzy8Z/VWt
        xebtXMv/H6LccusAs+cfGvq591ptPhclaz0anFxT0PU2kVtc/cv7Gkv6Mmt1awU4piE9A13OtiU
        jo9B/tToyO2z9IttDvGAUF+Qq
X-Received: by 2002:a05:6402:524d:: with SMTP id t13mr14673583edd.209.1621431014287;
        Wed, 19 May 2021 06:30:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhQYmo98nIJU06ikZWUMw+VNg8NVZR1DVoi2wiFl3JQLCr8KbjzI8qgU97PezGaXRfM/T7zA==
X-Received: by 2002:a05:6402:524d:: with SMTP id t13mr14673549edd.209.1621431014120;
        Wed, 19 May 2021 06:30:14 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id t23sm11492856edq.74.2021.05.19.06.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 06:30:13 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] platform/x86: intel_punit_ipc: Append
 MODULE_DEVICE_TABLE for ACPI
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zha Qipeng <qipeng.zha@intel.com>,
        Mark Gross <mgross@linux.intel.com>
References: <20210519101521.79338-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5d04884e-2094-3272-cf13-d661ec9025f9@redhat.com>
Date:   Wed, 19 May 2021 15:30:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210519101521.79338-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/19/21 12:15 PM, Andy Shevchenko wrote:
> The intel_punit_ipc driver might be compiled as a module.
> When udev handles the event of the devices appearing
> the intel_punit_ipc module is missing.
> 
> Append MODULE_DEVICE_TABLE for ACPI case to fix the loading issue.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I will also include this in the next pdx86-fixes pull-req for 5.13.

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  drivers/platform/x86/intel_punit_ipc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/intel_punit_ipc.c b/drivers/platform/x86/intel_punit_ipc.c
> index e0f838f0791b..b5763ca699b9 100644
> --- a/drivers/platform/x86/intel_punit_ipc.c
> +++ b/drivers/platform/x86/intel_punit_ipc.c
> @@ -320,6 +320,7 @@ static const struct acpi_device_id punit_ipc_acpi_ids[] = {
>  	{ "INT34D4", 0 },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(acpi, punit_ipc_acpi_ids);
>  
>  static struct platform_driver intel_punit_ipc_driver = {
>  	.probe = intel_punit_ipc_probe,
> 

