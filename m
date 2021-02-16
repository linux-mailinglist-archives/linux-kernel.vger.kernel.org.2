Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E98431CD09
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 16:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhBPPdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 10:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhBPPcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 10:32:36 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F98C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 07:31:55 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id s17so2336777ioj.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 07:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bePSxi8P+mopBsJyKhZfJ0ylENCPirau9uKWEklbXfU=;
        b=PiBnwMMkI8Z0xJz4NSxr7IlBW3KAIOw/SSFDqK3qw21H0AVBmvLCKMzqRWNsEjwHgI
         2XJrBVD4ayDdk/LqYY08O29r8Bhqk+kpswdloGfRB+ieVHj25LeVNNhPSr6AL0c7DfHR
         AyWT/22s202VskApoPuzInKSsb9lWFVGGXStY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bePSxi8P+mopBsJyKhZfJ0ylENCPirau9uKWEklbXfU=;
        b=ANH+bKCfWOY+l8lW0HvB0Y/wyi2AcBELhOU96HJISh92Wl4HTcgtf7UTmscwH8BJOw
         Yewl6KGLYCrHhjb/fW0t+AUV0Ta6ZFN1OJX3sCS4qDy9VINmWKc0MFS/5UiUBZDLeXJV
         OOLu0KnjbBjpHFIb7wnashRd9mzuWkR2+GlzjTTPT3AjdRIv3zmUDgEIFlb0IyuviLUz
         hutAl98JQdnT9hq50ErmJAkn9+2+k/2JTCJIEaz4IQ7c1buWL/qFI8n1Os2Dy8UL7QMs
         tuOL/DWfegPMHjRKtW/Hq5aM7CjoHgm3nDGjyC5c3XOsSWKKNhbNp44m1plnWotwab1Q
         CIYQ==
X-Gm-Message-State: AOAM532hNGRQwtMCCwJ0g5ECwqfjobOF0y4ZjQrQ6bR2rMinFXVtrJi6
        ExYy0H20MdeySQovBJ+T7btBLTQT/byMZM3N
X-Google-Smtp-Source: ABdhPJwoqQ029vOtAseft2NEwBaD7TLrVcTkRURos0sC8/KIa3QTnbWUF1Zy/JG8lsXU9hTL+Dcw5w==
X-Received: by 2002:a05:6638:58:: with SMTP id a24mr21031085jap.40.1613489514697;
        Tue, 16 Feb 2021 07:31:54 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id o16sm1326647ilt.21.2021.02.16.07.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 07:31:54 -0800 (PST)
Subject: Re: [PATCH] staging: greybus: minor code style fix
To:     Manikantan Ravichandran <ravman1991@gmail.com>,
        vaibhav.sr@gmail.com, mgreer@animalcreek.com, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20210212225035.GA16260@whach>
From:   Alex Elder <elder@ieee.org>
Message-ID: <356e8c33-36d9-95f3-1a30-322e7ef6e168@ieee.org>
Date:   Tue, 16 Feb 2021 09:31:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210212225035.GA16260@whach>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/21 4:50 PM, Manikantan Ravichandran wrote:
> checkpatch warning fix for string split across lines
> 
> Signed-off-by: Manikantan Ravichandran <ravman1991@gmail.com>

I think what you're doing here *looks* reasonable.  But
the GB_AUDIO_MANAGER_MODULE_NAME_LEN_SSCANF symbol is
a (string) numeric value that is associated with the
"s" that immediately follows it.

So I don't think your change makes sense, given the
meaning of the line you're changing.

Thanks.

					-Alex

> ---
>   drivers/staging/greybus/audio_manager_sysfs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/audio_manager_sysfs.c b/drivers/staging/greybus/audio_manager_sysfs.c
> index ab882cc49b41..fcd518f9540c 100644
> --- a/drivers/staging/greybus/audio_manager_sysfs.c
> +++ b/drivers/staging/greybus/audio_manager_sysfs.c
> @@ -18,8 +18,8 @@ static ssize_t manager_sysfs_add_store(struct kobject *kobj,
>   	struct gb_audio_manager_module_descriptor desc = { {0} };
>   
>   	int num = sscanf(buf,
> -			"name=%" GB_AUDIO_MANAGER_MODULE_NAME_LEN_SSCANF "s "
> -			"vid=%d pid=%d intf_id=%d i/p devices=0x%X o/p devices=0x%X",
> +			"name=%" GB_AUDIO_MANAGER_MODULE_NAME_LEN_SSCANF
> +			"s vid=%d pid=%d intf_id=%d i/p devices=0x%X o/p devices=0x%X",
>   			desc.name, &desc.vid, &desc.pid, &desc.intf_id,
>   			&desc.ip_devices, &desc.op_devices);
>   
> 

