Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3337C4503C5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 12:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhKOLwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 06:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhKOLwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 06:52:02 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD547C061746
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 03:49:05 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a9so3908814wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 03:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=F9Fa9nV2d1oN0zSyfwagffKh9yytiJ7gGM/yAK7IOVY=;
        b=N1gksOf+HQ35CVcZoqzQzpTqmczAKWCVPasTjHCJXRNDvFq8CKqd2YnmfVFW0XrVs+
         5bUfQFJtCH9HtvVP4newx5mWyPWyUWW40E9xuCz3iQ7dART24Nf8UP2aYIb1siaqxRJ7
         QqVz5aBrnFVo8j0C5BLfFjp8x13Qe5HYv4kzDgEJQrPiUGIn6Dusagj8ewPZZTyve13P
         FxKXrl1EqG/4CddeJLTSyQBZ4cz0O7XoMAPexILNpj2aiJ7X75Q3+UOOa1oPv2UT5DfJ
         aqrbCBXvLO5KCXCwwdg8Kca2GRqSKX2lmpINd+wb26mrPbTrDpCPXLjLcGQBRXyIv3Ug
         8w5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=F9Fa9nV2d1oN0zSyfwagffKh9yytiJ7gGM/yAK7IOVY=;
        b=Ji2Ysvk5DszNEPIn0/7JivbcrlCgOziFUTQ1itqjrfHQLjDARoD7G+Q/OLiU+xbnNa
         dtUYqzC8NBofN19Fn35dDn16kkOzQ30INaf459EOakRqb8aNgoe9WGemlnThPd8rmUFx
         Ot3wUovTH3JDWwezgI6KDwkinvSbtfcQgROymKjuj0kW5a6LUfE7uDmWyQTaAOY+4dQL
         2cgoeCJ+YKWfg3LLK23RiabeK2/jyxURsZ38x5PCb/en6zOD1+HrK6dznlXotGz4dARG
         xuprycAin6vTh9c3bQdD0Tfpu2thda0pSHCNrqvCfuAlfGpSHQaYF9FTLLBGNto3nMD0
         pL0Q==
X-Gm-Message-State: AOAM532OOJvraMdPrZqI9b3a2UejKGEer6dW8oku5/mVapf9zpFu6cV/
        5dF+Gjmr958f5pixnkDz5XUtLtpjyGo=
X-Google-Smtp-Source: ABdhPJzugAmCckcr+WT+yOHGwg2UX+IBqinv3ZVNQqngdscuwZUtPNkDJ02Qr3ZLyHJofxNhZd4cMQ==
X-Received: by 2002:adf:ce08:: with SMTP id p8mr23055236wrn.154.1636976944428;
        Mon, 15 Nov 2021 03:49:04 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:bf0c:d52c:6ba0:cfc6? ([2a02:908:1252:fb60:bf0c:d52c:6ba0:cfc6])
        by smtp.gmail.com with ESMTPSA id d6sm14045603wrx.60.2021.11.15.03.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 03:49:04 -0800 (PST)
Subject: Re: [PATCH] drm/amd/amdgpu: cleanup the code style a bit
To:     Bernard Zhao <bernard@vivo.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jingwen Chen <Jingwen.Chen2@amd.com>,
        Candice Li <candice.li@amd.com>,
        John Clements <john.clements@amd.com>,
        Monk liu <monk.liu@amd.com>,
        Peng Ju Zhou <PengJu.Zhou@amd.com>,
        Jiawei Gu <Jiawei.Gu@amd.com>,
        Bokun Zhang <bokun.zhang@amd.com>,
        Zhigang Luo <zhigang.luo@amd.com>,
        Lee Jones <lee.jones@linaro.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20211115070714.7007-1-bernard@vivo.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <ebcf8b30-7311-9d77-07ab-1b92756c0ae0@gmail.com>
Date:   Mon, 15 Nov 2021 12:49:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211115070714.7007-1-bernard@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 15.11.21 um 08:07 schrieb Bernard Zhao:
> This change is to cleanup the code style a bit.

To be honest I think the old style looked better. It took me a moment to 
validate this now.

What you could to instead is to have goto style error handling which 
would make this a bit more cleaner I think.

Christian.

>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 04cf9b207e62..90070b41136a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -286,12 +286,14 @@ static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
>   		return -ENOMEM;
>   
>   	bps = kmalloc_array(align_space, sizeof((*data)->bps), GFP_KERNEL);
> +	if (!bps) {
> +		kfree(*data);
> +		return -ENOMEM;
> +	}
>   	bps_bo = kmalloc_array(align_space, sizeof((*data)->bps_bo), GFP_KERNEL);
> -
> -	if (!bps || !bps_bo) {
> -		kfree(bps);
> -		kfree(bps_bo);
> +	if (!bps_bo) {
>   		kfree(*data);
> +		kfree(bps);
>   		return -ENOMEM;
>   	}
>   

