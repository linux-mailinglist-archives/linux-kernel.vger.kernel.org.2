Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B60638F33E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 20:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhEXSvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 14:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbhEXSvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 14:51:39 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB0EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 11:50:10 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so26133841oth.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 11:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OA4u1hUVW7+czWLOl7FPRNPAHAh/vc/gl/M2fiIZYJo=;
        b=tQ32gaJ+K524LKDCVZIVsFdMx5pCHrP/SDGMrpfkp0V7f+aQg0NutnYXMkesDoexif
         n2+tK4S+bphjLSN2kEcC6C7z9YBFVFBIreIhdg0x4rRIMU0jkHEkla0y5cDBNr3mHaPn
         kl8H3/DFY/rz9Dl+uqpvH3aJCCgzHC7tfzu/wQlTFe+UWJf9hTPXJ12olYhHAgghQGgO
         FSYeEShH7WQ1ssMxvkzVLmVtMoOpF7BFQdFzoPKM1HQYO+GKODiYM5nw84om2K2sR5Hf
         LJ9MmwmflUEZffrDx/bUSw6EugvN8R10GbN5W5H9uShfTJaZGM9EWKVUfVjCP36awygI
         55fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OA4u1hUVW7+czWLOl7FPRNPAHAh/vc/gl/M2fiIZYJo=;
        b=O2mB5BIX/LUm3i3zQD+senX0XYxfMjjT2KVlvXYGV8W8iniscqXTLYJU0T0DoIvte1
         aQMgdgwBpAuaRYPr8Z29A/FLBiu8RjTHCTg0RGKFznmlk+iziOFCp07/2PtE/7o97UG6
         /LUROLtW69pjkU5uN4TATq88mewH0UNJnuAeUTEBZgEcP6H+QGEhFXW5jrMDRcWfaF1n
         OfBYQ/f7qlJqZ+9eFxFUbWWkYyw8NaGvky0kwqiy8SZTOTEh3xG4Wm3B+sxC9xenkXba
         gMvRxcCjw1LZCRL7eb35JPLBbJXrOMzdoV9Ooig57s9bH1Lyh57tjEKvkc4QOhnwiO5P
         ny4Q==
X-Gm-Message-State: AOAM531SQ+Xpg4OPIMea73Z3UHbBN6rQiPC6zMz0lhGn+cEDH3zYd30I
        +m32hYEl248ubnnGe14NaDmEu4xHGS70xovncrU=
X-Google-Smtp-Source: ABdhPJwiKzX9Gj1sMzHOgN92igF3UyXdCiTIb4xlUH7OP/tM0D4aeQ/+U1aKEUBnpy8WLZa75emQN038NmfSWdArwjY=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr19783026oti.23.1621882209553;
 Mon, 24 May 2021 11:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210524071554.12344-1-nswdhpyhwt@163.com>
In-Reply-To: <20210524071554.12344-1-nswdhpyhwt@163.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 May 2021 14:49:58 -0400
Message-ID: <CADnq5_OoFF=zEr61yRj0c6xXTBO4qLwor76e4knyyPg1ZhHF0g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix typo
To:     nswdhpyhwt@163.com
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sonny Jiang <sonny.jiang@amd.com>, Leo Liu <leo.liu@amd.com>,
        Lee Jones <lee.jones@linaro.org>,
        "tony.huang_cp" <huangwentao@yulong.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, May 24, 2021 at 3:45 AM <nswdhpyhwt@163.com> wrote:
>
> From: "tony.huang_cp" <huangwentao@yulong.com>
>
> change 'interupt' to 'interrupt'
>
> Signed-off-by: tony.huang_cp <huangwentao@yulong.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> index 284447d..6c0e914 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> @@ -340,7 +340,7 @@ static int uvd_v3_1_start(struct amdgpu_device *adev)
>         /* enable VCPU clock */
>         WREG32(mmUVD_VCPU_CNTL,  1 << 9);
>
> -       /* disable interupt */
> +       /* disable interrupt */
>         WREG32_P(mmUVD_MASTINT_EN, 0, ~(1 << 1));
>
>  #ifdef __BIG_ENDIAN
> @@ -405,7 +405,7 @@ static int uvd_v3_1_start(struct amdgpu_device *adev)
>                 return r;
>         }
>
> -       /* enable interupt */
> +       /* enable interrupt */
>         WREG32_P(mmUVD_MASTINT_EN, 3<<1, ~(3 << 1));
>
>         WREG32_P(mmUVD_STATUS, 0, ~(1<<2));
> --
> 1.9.1
>
