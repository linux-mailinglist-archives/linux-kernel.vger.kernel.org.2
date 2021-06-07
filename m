Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52CB39DA13
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 12:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhFGKtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 06:49:11 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:42890 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhFGKtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:49:08 -0400
Received: by mail-wm1-f44.google.com with SMTP id l7-20020a05600c1d07b02901b0e2ebd6deso1593212wms.1;
        Mon, 07 Jun 2021 03:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=KcIhVJsL3yrPFMmj6Xxxh1AoiEa6qKo1bMNhV5zzVU4=;
        b=nIfQIgvwVppIuEFSzUQVquUbbMHHEiotd+EFEBy2MJDMpTxLbCzIJy3aL/h4WE87Kn
         PZmaBHFFRSEyEXosjbP2EZuixX75V/ZhtvLfb3tXHHCLT8xBRROW5+nSD0zJLEcmoeVN
         No3BFvOuW2XoLcusEFKJVtfhw1/tV5mRmIZHmZJRb8Pp2eAcrbsrB0OQ5rgbeMGngY0n
         F5UJPn7xyZ2uBXdwMD5qm2oaerqyfBROtOylfHWUtzoeD5hz2o7dCgiBLTpn1poBCd0B
         DR0ZcEROaNyxZCGESxd5MgNG1KMlm08QE/eQ64AeQ500Wr/hrblXZHFYrAjA34LZIh3F
         1T6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KcIhVJsL3yrPFMmj6Xxxh1AoiEa6qKo1bMNhV5zzVU4=;
        b=cc1JVZIxKZW0a+djyAqq/rFlHGk635qzYj2jb2ueJ60SxYojxsxGxmen//TutYh4ac
         vmGT0K7lElurg/w8mWrTODV94HmvJVCNVsqATPz9St22v8ytiu6inWHc8pmr4u0kA80V
         eYENLcsCz/X0AODTKH9ZLQmPLeM8J3RrC3F6jGVmhI0mHcuIHdT4Vq74Uy7rx+RnQn8f
         5hYW0kLA5srN5X4dk+3QAL/cyUS0Nz0SOpkrt326P7Y3Ypz35G0ajDu474J/ElCf7ryA
         d9xTW8+LrSLdWdOIS2jy3awRLaz6lqsHzOku+bHsRE9FE3KduZIeX+JH8BOCUtsV1PZR
         958A==
X-Gm-Message-State: AOAM530W0qnuTWheOwa2XCPJeI6vIfdjo0PDySMdsf0VguiLXuYFMtMY
        Y4rI/PEzKWNKQH3TW3Z898wLWAHZLsk=
X-Google-Smtp-Source: ABdhPJz5mNoADFlUvoQOZLVGYoQSWnoQIBz5yANTWqTzpJFPZOVBzoohGEELM71BXZ+Lolragqs//Q==
X-Received: by 2002:a05:600c:5122:: with SMTP id o34mr8135390wms.168.1623062776700;
        Mon, 07 Jun 2021 03:46:16 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:ce67:4e4d:875d:ffeb? ([2a02:908:1252:fb60:ce67:4e4d:875d:ffeb])
        by smtp.gmail.com with ESMTPSA id v7sm17854646wrf.82.2021.06.07.03.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 03:46:16 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Fix a a typo in a comment
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <ea7ecbef546a03ef71d65bfe82608bb347e6f3c2.1622883895.git.christophe.jaillet@wanadoo.fr>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <99a5eba3-2d2a-65a8-9b03-a3d4043c5ec5@gmail.com>
Date:   Mon, 7 Jun 2021 12:46:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <ea7ecbef546a03ef71d65bfe82608bb347e6f3c2.1622883895.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 05.06.21 um 11:06 schrieb Christophe JAILLET:
> s/than/then/
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 89ebbf363e27..1476236f5c7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -662,7 +662,7 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
>    * @error:	error number
>    * @backoff:	indicator to backoff the reservation
>    *
> - * If error is set than unvalidate buffer, otherwise just free memory
> + * If error is set then unvalidate buffer, otherwise just free memory
>    * used by parsing context.
>    **/
>   static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser, int error,

