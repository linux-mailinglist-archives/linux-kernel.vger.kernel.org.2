Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F3F39C0E1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 21:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhFDUAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 16:00:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58685 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231177AbhFDUAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 16:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622836724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0fVhjAHeVRgfpGwbjD+B87pacxHTlTdVbrkucRo5wXo=;
        b=UlgnXzPCOFY+DauC5pcfJoB1a4WqOxI0EDzT0B7hhSIkq/d4XhMmxu9UWfFWSHploMsWF/
        0S4dI+iOSKTT1umJXU8h0r32jgPS+RqFFTeZbaDUruzZOB4iwI33nNyMfhbjeR2vpv0x9A
        8i8cr9Jz4T9mSSKRF0gcFW+2MKmvrh0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-gG4PwNVXM4u2YAoP8ApJBg-1; Fri, 04 Jun 2021 15:58:43 -0400
X-MC-Unique: gG4PwNVXM4u2YAoP8ApJBg-1
Received: by mail-ej1-f71.google.com with SMTP id p5-20020a17090653c5b02903db1cfa514dso3912246ejo.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 12:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0fVhjAHeVRgfpGwbjD+B87pacxHTlTdVbrkucRo5wXo=;
        b=NZ9zJ+2wmpFAROwj2B0NDT1qKYaFHgicRPJiu9VdAlSzai9e1uA8xhhlzuVI/dIj5p
         IQlxIQ0ikd5vtorC9jGVD0ddqsRLFGMD4muniEKZjYGACsw2HVOtNoBKQ8odk84G6Lpw
         EdQz2yQbV95gEfwsO7B8fZeWKnw5WBupvSxxYtFrYFT6fTiAn9aGJ90xSJaV9zmFKt1h
         2I9OVIR6zJJ0BQRB/jTLpWTQHQvZEAYkTt2AwzkMAV4H7B5JZEJ9MR5hYXdhL7zvnjPW
         zIuZ8vsR7fMMIxryEsXNIgMruWQ8fRTA+kUrLWZE2fON/2yO4qUEdseoGjdPk0JvCGf5
         +w3w==
X-Gm-Message-State: AOAM531ScF+6I8CebWcLx2HiLy0f0sPv2Mfkd4q4FpZKzRRItUEiO9do
        lkhDroijxsXEZTex821cD4ErtkLmFEn/kf/4Bs1DC375zSgmaBRCTjktT2prB7bvH470mtabNmz
        /bvGEt4FvH3sQSaN0ARscfsmJru4SuZCxvVN11yeMqYDgCfTPgf8dUc6Ir8KsjEYhYDGjg0nN3m
        Bj
X-Received: by 2002:a17:906:b754:: with SMTP id fx20mr5476944ejb.201.1622836722344;
        Fri, 04 Jun 2021 12:58:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeCbTbe6DUYucYVbhatoqJpQOqnbWTeTzTFKFcrz7PYXhjYAZidL0BezyF9QtAI0xjmGAW5A==
X-Received: by 2002:a17:906:b754:: with SMTP id fx20mr5476926ejb.201.1622836722103;
        Fri, 04 Jun 2021 12:58:42 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id o4sm3561290edc.94.2021.06.04.12.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 12:58:41 -0700 (PDT)
Subject: Re: [PATCH] platform/surface: dtx: Add missing mutex_destroy() call
 in failure path
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210604132540.533036-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8a317463-5c5f-fd64-f319-1df513e6956a@redhat.com>
Date:   Fri, 4 Jun 2021 21:58:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210604132540.533036-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/4/21 3:25 PM, Maximilian Luz wrote:
> When we fail to open the device file due to DTX being shut down, the
> mutex is initialized but never destroyed. We are destroying it when
> releasing the file, so add the missing call in the failure path as well.
> 
> Fixes: 1d609992832e ("platform/surface: Add DTX driver")
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I'll also add this to the fixes branch, so that it gets included
in my next pull-req to Linus for 5.13.

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  drivers/platform/surface/surface_dtx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/surface/surface_dtx.c b/drivers/platform/surface/surface_dtx.c
> index 5d9b758a99bb..1203b9a82993 100644
> --- a/drivers/platform/surface/surface_dtx.c
> +++ b/drivers/platform/surface/surface_dtx.c
> @@ -427,6 +427,7 @@ static int surface_dtx_open(struct inode *inode, struct file *file)
>  	 */
>  	if (test_bit(SDTX_DEVICE_SHUTDOWN_BIT, &ddev->flags)) {
>  		up_write(&ddev->client_lock);
> +		mutex_destroy(&client->read_lock);
>  		sdtx_device_put(client->ddev);
>  		kfree(client);
>  		return -ENODEV;
> 

