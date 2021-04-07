Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC44C356B28
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 13:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343506AbhDGL0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 07:26:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26091 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243162AbhDGL0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 07:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617794772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hevnKcQ4I9jq+ZzW4AWSbIV29KiYxHuVFGDAD6+MJjk=;
        b=InqJH9Na46w5hPszAycdni17NJfTNm4qYSpDXmLNNBh/6csKrSu4cq/mW10hgvxNKG00Zy
        5TsyV6y5scwq0MrJRIZU5ThFEHfiwix1lQ64mWjIrWPxNfUnu9Q7iw3Af4r5orwStQ3Xaw
        MCH2jd7WhvkZPsNr5XYpSjQsbIUCQT8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-aqH710yjNv2cQy2MQY91ww-1; Wed, 07 Apr 2021 07:26:11 -0400
X-MC-Unique: aqH710yjNv2cQy2MQY91ww-1
Received: by mail-ej1-f71.google.com with SMTP id yk6so3012400ejb.21
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 04:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hevnKcQ4I9jq+ZzW4AWSbIV29KiYxHuVFGDAD6+MJjk=;
        b=Nu9O0ob4oMypCx7YuTwYQ8Oss+UAxVyFqqVIAPzjS6p/i0F2FqmhMGSMQz3ss+rZQa
         dPTtJ9wg29FI+waT/RVD1w8s/Fh+GfyF1+zTnYcwbgmqrRpFH0WqQRT8UHijmehEQPUf
         yvlbUYhVR0d1j240BCFnd8V4zqjKO1LQ4EfGq5wT+RHs8GmTCJnakLsbs9KNwK+0rd6+
         JwxOqTyJ2sCoxZoEr/05LlirE2o9UxjgBJ+92o9EPIZQ78kL97VmWOsOAghwo7Y6eV8U
         RvXuW8rt4rLnm6q8pt0Jbdqa6/ONToF3gyxcg79MInQSB5q3952Zg07jYdjU9VxoG58L
         /XQA==
X-Gm-Message-State: AOAM530RFoxEGRRd4iC2qeGAF+CFA1/oKsJDX2Qod7RJEAtk/FRyWccZ
        ZyiJo3hhsNxcKRHZiX//fO/+JBWD4ql+KHIv3wn25RcC+NU0fgAn5hznuFY7rgRRybDqGB5at/q
        s2RdYBI1mvqpztY8tSYjlqf2htvFj8C59SWMp0ES0Y2S2Q0Zi4jtYd1eut0xM0lmm8WqliLtPE6
        aK
X-Received: by 2002:a17:906:5056:: with SMTP id e22mr3077612ejk.289.1617794769550;
        Wed, 07 Apr 2021 04:26:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJltS0uUBU91wWC+Pkq7DwEgumF1o8eQ6ZXJwpirqAtiwQthRhT5WzUwSkKd89iCBCI/whxQ==
X-Received: by 2002:a17:906:5056:: with SMTP id e22mr3077593ejk.289.1617794769324;
        Wed, 07 Apr 2021 04:26:09 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id k19sm8306722ejk.117.2021.04.07.04.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 04:26:09 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: panasonic-laptop: remove redundant
 assignment of variable result
To:     Colin King <colin.king@canonical.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210326192022.623001-1-colin.king@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e270b8b9-2562-ba49-32af-0f9d5ea1760b@redhat.com>
Date:   Wed, 7 Apr 2021 13:26:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210326192022.623001-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/26/21 8:20 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable result is being assigned a value that is never
> read and it is being updated later with a new value. The
> assignment is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  drivers/platform/x86/panasonic-laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
> index 6388c3c705a6..d4f444401496 100644
> --- a/drivers/platform/x86/panasonic-laptop.c
> +++ b/drivers/platform/x86/panasonic-laptop.c
> @@ -973,7 +973,7 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
>  	pcc->mute = pcc->sinf[SINF_MUTE];
>  	pcc->ac_brightness = pcc->sinf[SINF_AC_CUR_BRIGHT];
>  	pcc->dc_brightness = pcc->sinf[SINF_DC_CUR_BRIGHT];
> -	result = pcc->current_brightness = pcc->sinf[SINF_CUR_BRIGHT];
> +	pcc->current_brightness = pcc->sinf[SINF_CUR_BRIGHT];
>  
>  	/* add sysfs attributes */
>  	result = sysfs_create_group(&device->dev.kobj, &pcc_attr_group);
> 

