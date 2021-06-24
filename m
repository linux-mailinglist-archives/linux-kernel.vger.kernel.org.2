Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A27E3B2FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 15:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhFXNQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 09:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbhFXNQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 09:16:35 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5635C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 06:14:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c7so8457675edn.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 06:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jUpvJfClAkxaposL4wig5DpTTSGxzLyBZMJv9+3xraw=;
        b=FQOdUTnLrPgpw7RqaOdFwVkdK6V0R+CffRxI8pExGZ5EP7FPdfPrCM/lq5Kk9xN/Ax
         OOsEPWED13scD59Iy/xG0WEv2/gahupuaK0kdSkQ52JG0Uo8av+1aQ0EDUGNWPCXMe+b
         BTdFInlQtzg86zhedzR3z1aBlUe4Q580pEOW4PqDIDt+3M3mWy7rW98dWyZcDeqW6wDU
         fPYpykJZxP8M45korUPmkOtavSe/rNHnBa1V/EgE6iE1oL6MZzPzQkRwUBCobWVKzvuv
         Eyqri3V8ouKKIksJqYtzkrIi5cdpvTsfGfk4PrJPsw4ZSWStPvG1U7xLKfrqQeGIpREG
         3V9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jUpvJfClAkxaposL4wig5DpTTSGxzLyBZMJv9+3xraw=;
        b=X0PK9p5V8vOJcXZN0UMH/NYbFCp3d0gS7uLcdNB7IXP7pLApvm6SADz/GBK/trDe8k
         GB993ws1rTXOLPl8kEMjPzRoUhmxZwG2KXpjtpOy5SuTJcD7ZNovTTrGJg89WLpq9tSV
         TyzSmfJU6DPJN5tiEo3tIxsbxAuJbBdmnP44zutVPGzC6cNrGpL1YbbwNxchPx4o4TRo
         M8uzij06hT1DUuNoKFSQ6arDp9VOUo5bYqRFNciJI3Ls0zV8eC/JWoRNKNOQ7RpvnWxh
         ILtaL3Emd8lRJi8TiL6bDZ3kRa5ZgkJH+ycWdwP800K66GhNzp2PYpZdQv8yQQgFMXkL
         kg5g==
X-Gm-Message-State: AOAM530XP0DJo9Q2n/uow2W7JfRuUP1t+aw1Yr6gcPsOv9e7JTcoGtzw
        3BYmWHcxluDWxdKIhNB49UK37rREHeU=
X-Google-Smtp-Source: ABdhPJwDiSksAJEUv018050vDI8BTEvoX64fF/WRVHk+OAidWOjSXro8cnrGuTG9AWCDHo/y24qnqg==
X-Received: by 2002:a05:6402:336:: with SMTP id q22mr7118192edw.3.1624540453432;
        Thu, 24 Jun 2021 06:14:13 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:8a1c:e700:29c4:44b6? ([2a02:908:1252:fb60:8a1c:e700:29c4:44b6])
        by smtp.gmail.com with ESMTPSA id o14sm1967910edw.36.2021.06.24.06.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 06:14:13 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu:use kvcalloc instead of kvmalloc_array
To:     huqiqiao <huqiqiao@uniontech.com>, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20210623091242.12861-1-huqiqiao@uniontech.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e18c2147-cc19-7493-5feb-de28e3102d3f@gmail.com>
Date:   Thu, 24 Jun 2021 15:14:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623091242.12861-1-huqiqiao@uniontech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 23.06.21 um 11:12 schrieb huqiqiao:
> kvmalloc_array + __GFP_ZERO is the same with kvcalloc.
>
> Signed-off-by: huqiqiao <huqiqiao@uniontech.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 9acee4a5b2ba..50edc73525b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -908,9 +908,8 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
>   		unsigned num_entries;
>   
>   		num_entries = amdgpu_vm_num_entries(adev, cursor->level);
> -		entry->entries = kvmalloc_array(num_entries,
> -						sizeof(*entry->entries),
> -						GFP_KERNEL | __GFP_ZERO);
> +		entry->entries = kvcalloc(num_entries,
> +						sizeof(*entry->entries), GFP_KERNEL);

Sounds like a good idea in general, but the indentation on the second 
line seems to be of.

Christian.

>   		if (!entry->entries)
>   			return -ENOMEM;
>   	}

