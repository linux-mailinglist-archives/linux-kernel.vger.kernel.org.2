Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1057439B38B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 09:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFDHGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 03:06:14 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:37778 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhFDHGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 03:06:14 -0400
Received: by mail-ej1-f42.google.com with SMTP id ce15so12920701ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 00:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=JxPiXyyxmrcft44toq/bGBBHxD6goLW29hTUFEaks9I=;
        b=DqZfNfrcD/kZVU60HoE1MhYt+t5wnXPhiB29YDLOjzGIkia1orIae3vA6RUd/SMjAh
         NIlW5e5QcJFUbZYMkW98wKUkjfJpAEqr9cC4NdJsVBUokvj5gl7BG+J2hoKVfACcvZnh
         dCESB2q1vobP96x3gTtRM3E05+XcBF6UyxL2GLoed7BAligajoeLzr2vlR9/f7ze0uw3
         6NpdlsCQn/NIX3XI7TPZ26e4QZd1D83DoHqB/Ia8PtozdJxRlMtlKjEK+Pr46QawXYgd
         sJQ17QV7NUdaiZpOelFF63E/2Tp2L/R+K9lwZdaxjjIyOz1h5kwFc70DHR2Vajstg8UL
         0fbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JxPiXyyxmrcft44toq/bGBBHxD6goLW29hTUFEaks9I=;
        b=rmVUQ1KyYNVSEB3qefPauz7uoc5vVh7gRI8+F/X0OWjTtgdiB/FOgPMBwXBmGOSMBD
         DSAH6yMtDyAopLq8J9LllkIljkEybpCVvz2laHjzV0HPI4duwa+T6UNlKML1NSPuG5XK
         bbRTVOO1BEgJK69iGqW7hiDTi7dj7nVMe3lpHGC12J/kdxwty0T8iJgWtKGAs9YMROC1
         1YK9pk/BpWd8pppzaWUgFr5aBoNop9i1dZ/ECMzyV0t1/HztNgEun9UloPx+8X4L4fzT
         /Nt+9/Oeh/J98ZSNBavzX7IgR1l+H/u07ylw2OLNsTQyjXww0KAlqDOYcSPyKLqjdQNN
         suIg==
X-Gm-Message-State: AOAM533DCMPgP+DrT3OfrLMGXhlBo9meK+yv0WYGTRT0C8gTqDPlPK5j
        31ucUaC6XmTNSVgXuEevWLCRmYEEshE=
X-Google-Smtp-Source: ABdhPJx2vnZVx5FWV0r9/ik2kgxEsnp35h53vw1wSJF3RN31o1NnkMZDceURVJhlfhN1mSkfN+w/iQ==
X-Received: by 2002:a17:906:4341:: with SMTP id z1mr2909890ejm.422.1622790192787;
        Fri, 04 Jun 2021 00:03:12 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:7b4b:873a:17b5:b581? ([2a02:908:1252:fb60:7b4b:873a:17b5:b581])
        by smtp.gmail.com with ESMTPSA id t2sm2355698ejx.72.2021.06.04.00.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 00:03:12 -0700 (PDT)
Subject: Re: [PATCH] drm: amdgpu: Remove unneeded semicolon in amdgpu_vm.c
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Nirmoy Das <nirmoy.das@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Mihir Bhogilal Patel <Mihir.Patel@amd.com>,
        Roy Sun <Roy.Sun@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1622690940-10972-1-git-send-email-wanjiabing@vivo.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <3d7fcdb9-990b-270b-f87b-d7fe157c6b2f@gmail.com>
Date:   Fri, 4 Jun 2021 09:03:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1622690940-10972-1-git-send-email-wanjiabing@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.06.21 um 05:28 schrieb Wan Jiabing:
> Fix following coccicheck warning:
> ./drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1726:2-3: Unneeded semicolon
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 2460371..231745b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1723,7 +1723,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>   
>   		amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SIZE);
>   		start = tmp;
> -	};
> +	}
>   
>   	r = vm->update_funcs->commit(&params, fence);
>   

