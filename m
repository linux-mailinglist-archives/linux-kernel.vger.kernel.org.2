Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AFC3446C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhCVOJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60776 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230119AbhCVOIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616422107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FVgT8cREJNNCZgsvwdo4IVCZkhVlPEV4H/HRfF+vQHs=;
        b=CHZliN66hPXgCQNWamKXsT2D0mInGwS8uG4hgCmsTfQi5FLDKkc6QSeA1HeoyfwVbZsGef
        lty5iL/GSY3FJOovgyCFuyKJi3E9xoKDQ+Pchl8Z0C0wm3gw3MyXZ9g6umWnZ1RG9mNorM
        7MhIcuURK9RTjjX61xkl+oWWx/zWMik=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-eK7cFVmaMW6mdIcgfIuOyA-1; Mon, 22 Mar 2021 10:08:26 -0400
X-MC-Unique: eK7cFVmaMW6mdIcgfIuOyA-1
Received: by mail-qt1-f199.google.com with SMTP id t5so31879854qti.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FVgT8cREJNNCZgsvwdo4IVCZkhVlPEV4H/HRfF+vQHs=;
        b=hEjGbwVMCcjigjuStj1nP/eptQVk0gZfvxbBmcY7chrYI3O86jcIhrgOJwoYoLV4zs
         QluOfF9U18IBKnI749hN5sKJMVajjCQ7yJk0aIImRWHQ/RVXhmMYQDqkgRvBTCyp4ae5
         q+xcwfxK9jczSPCI++PCvLem6NsJWHjz48iahxljJ9/80BJAW/woXga7M2SGfz56kz6/
         +SJ3fHg8LWHYDTsmDvtjioLcZyCo8gsuBeHmz0Xmo7gXuowyoeq6y4LyW9hJ97PILlJw
         Siyhs3XXFRZGcEdwW+Ulf9uTez1BMNSUDmWmuDX6Lf5vSx7+rkYFHvbN+aecAV/SAEWG
         yheQ==
X-Gm-Message-State: AOAM532XiXVmclzHFG4XShaKaBzLn0pziuYenBz0g04z6u0/VcCuD0ES
        yDXSNnYNfcOmjUyDLbC7GsvpgILWhapCN391bKnbUeaX9l/i4KTXK/vP637SYFEiyDXRxR/VZqj
        d2tqUttqZDMiRRZ1QHjB9vs9j
X-Received: by 2002:a37:a74e:: with SMTP id q75mr170967qke.165.1616422105589;
        Mon, 22 Mar 2021 07:08:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrUVuJJE09nrcOBM4NdtiV05nyirk+Tg8pFgeTN9VypOp5y986vzL315hHiWdFn7UBNMA7CQ==
X-Received: by 2002:a37:a74e:: with SMTP id q75mr170943qke.165.1616422105378;
        Mon, 22 Mar 2021 07:08:25 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z8sm9014413qtn.12.2021.03.22.07.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 07:08:25 -0700 (PDT)
Subject: Re: [PATCH] amdgpu: avoid incorrect %hu format string
To:     Arnd Bergmann <arnd@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Chen Li <chenli@uniontech.com>,
        Sonny Jiang <sonny.jiang@amd.com>,
        xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20210322115458.3961825-1-arnd@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <eefe9a55-4212-4d51-6add-9eb9ead0b5ed@redhat.com>
Date:   Mon, 22 Mar 2021 07:08:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322115458.3961825-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/22/21 4:54 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang points out that the %hu format string does not match the type
> of the variables here:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:263:7: warning: format specifies type 'unsigned short' but the argument has type 'unsigned int' [-Wformat]
>                                   version_major, version_minor);
>                                   ^~~~~~~~~~~~~
> include/drm/drm_print.h:498:19: note: expanded from macro 'DRM_ERROR'
>         __drm_err(fmt, ##__VA_ARGS__)
>                   ~~~    ^~~~~~~~~~~
>
> Change it to a regular %u, the same way a previous patch did for
> another instance of the same warning.

It would be good to explicitly call out the change.

ex/ do you mean mine ?

0b437e64e0af ("drm/amdgpu: remove h from printk format specifier")

This was for a different reason.

imo, you do not need to include what another patch did.

so you could also just remove this bit from the commit log.


The change itself looks good.

Reviewed-by: Tom Rix <trix@redhat.com>

>
> Fixes: 0b437e64e0af ("drm/amdgpu: remove h from printk format specifier")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index e2ed4689118a..c6dbc0801604 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -259,7 +259,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>  		if ((adev->asic_type == CHIP_POLARIS10 ||
>  		     adev->asic_type == CHIP_POLARIS11) &&
>  		    (adev->uvd.fw_version < FW_1_66_16))
> -			DRM_ERROR("POLARIS10/11 UVD firmware version %hu.%hu is too old.\n",
> +			DRM_ERROR("POLARIS10/11 UVD firmware version %u.%u is too old.\n",
>  				  version_major, version_minor);
>  	} else {
>  		unsigned int enc_major, enc_minor, dec_minor;

