Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD51334D3FC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhC2PdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhC2Pcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:32:52 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5076EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 08:32:52 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so12636004ota.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J0PX3YGiA1lRp5I9tvaB7FhBfF0VCV3+C5FuFXW+3N8=;
        b=R7qAXPo48MkDyupC5FF0SAnrIPYqalufQi9jEF/AyiXeGdwtpjQKC2IISZQTDm0Ljy
         18iydmPuOnu4AqvRU50XKLjmTke58w2qa/CvRl56PD5Ip2u56geTp4QOPM0QDP9EFAbh
         DuKRql5xpAoKDSIwtkKbW4LnwQFO6UhJVqAa27TGm+ZokArrK8RIqyXIUtU/Wn8pTU1I
         BtU8omQwOIzfYpnhggk3SEr2k6QV9MTpNWvFN+eNLhgMfu153v9z9LQVSUPwT5guljTk
         PDQa+NKbRwzKA3wDy6tk9zegryjuiaUfn51ag1I8Ky+QCyDiRUIarOPV7aoFwhbXdeD/
         ECwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J0PX3YGiA1lRp5I9tvaB7FhBfF0VCV3+C5FuFXW+3N8=;
        b=BvrlGg7YLU1fnJ+/BavWF+zQjzBUOsyytYQfizdKHTohCEb5NSjRh0p0/NxO9Lwwvq
         v0YtXP/u7ANE2PZtUx7jbo4CGK0Dn6+qdYbzdr6ld2MsZAdpmrmvkIyuK9MT7h5yM3/z
         LwfmmQRYO3YnB+nfQ1xhFoS9ooT3vZpGJJY1lv9YIIexY+DyEuFE/AY6SFXZs/SiQzdl
         YXLBdogPlE5l0FYfWc7u6mqBbSgww/m8Up5wXzg42u4eKUj7Mk9DPB5L60CdyAQOWOx9
         ekZiSTmY0Cm11cT4e+YIVB801zNZ8xwvhazFCDgCY0ATPGDDWE21rLW9WM0UpZHiGIQs
         3EJA==
X-Gm-Message-State: AOAM532VQmZO+OX1lN2aW4zqgmgqc1LWMul9kO+FAFqg2Y+PF9NInSaX
        +d9Zm72DeW96ZrpwCfQEEHuOBi3NVBQNG2Zrz7E=
X-Google-Smtp-Source: ABdhPJxOsimt6cr4luFOFVZJ1XwLCVtQsyBX4tfE7t6HW5CPDFCtTqM68H6vH2Q/ipFoOCqxTayhzNmhx7KLfgaHZbk=
X-Received: by 2002:a05:6830:408f:: with SMTP id x15mr23976678ott.132.1617031971817;
 Mon, 29 Mar 2021 08:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210328053504.164301-1-diego.viola@gmail.com>
In-Reply-To: <20210328053504.164301-1-diego.viola@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 29 Mar 2021 11:32:41 -0400
Message-ID: <CADnq5_OTU-zVsKTOmxGMEhvTWrGUAVoqhFoQvjg-4ryQmi5xew@mail.gmail.com>
Subject: Re: [TRIVIAL] drm/amd/display: fix typo: liason -> liaison
To:     Diego Viola <diego.viola@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Jiri Kosina <trivial@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Sun, Mar 28, 2021 at 1:35 AM Diego Viola <diego.viola@gmail.com> wrote:
>
> Signed-off-by: Diego Viola <diego.viola@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 573cf17262da..1b4b4f508662 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -121,7 +121,7 @@ MODULE_FIRMWARE(FIRMWARE_NAVI12_DMCU);
>   * DOC: overview
>   *
>   * The AMDgpu display manager, **amdgpu_dm** (or even simpler,
> - * **dm**) sits between DRM and DC. It acts as a liason, converting DRM
> + * **dm**) sits between DRM and DC. It acts as a liaison, converting DRM
>   * requests into DC requests, and DC responses into DRM responses.
>   *
>   * The root control structure is &struct amdgpu_display_manager.
> --
> 2.31.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
