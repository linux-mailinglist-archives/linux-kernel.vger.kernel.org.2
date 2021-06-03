Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C5339AE03
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 00:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhFCWbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 18:31:15 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:46981 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhFCWbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 18:31:14 -0400
Received: by mail-ot1-f50.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso7253060otl.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 15:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NRaH6xYMOH9GBGnTmQ420f8rw11U6mdSQMJDfrz+ZTs=;
        b=C+n0G5uElXJr/WoVIEjsjtoL5nhie/oOvw86cte9R2nu8k55JrzLfXqOqJYfxmCPPQ
         KPBLShW5gurS0IURrM6OflTCHWf3Rx3LLsMewCI4nfKSb0xLsu7fX7lKZCGtfodTgwAm
         O+/NjRH1wKXHX8+1RtyOD6J2noJdQ4wfqX+Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NRaH6xYMOH9GBGnTmQ420f8rw11U6mdSQMJDfrz+ZTs=;
        b=LyFnDjtQgt5kP03TibuEB2D3vq47mhZBPQGqunX4A40D4NVNgDS6zIp/5TrW0VlSyU
         S79FBokEXVKcf9UUiuuKyFrHJYwQUysMChVBQ4KkBSlzigjWJ0hDPZ0CB7AM1bINT+7l
         9QFVQandq9cz9xFN3i3NCrIsnvChkm61sncsdpY4qTA3IIrJMf/Ocw1JThmDMGP9b3aG
         Q9dXYPiUFfFawDr6pJOfihUc+Wnwav96JdCDapE3I30fpqgFYIkv6McVuMV02drj8CY4
         Kx/Gg1+fyVCLF8xeHK9CEAdNO5DYFpHEqVhGH65JdPc2l02cJ5d8H98gqttCu+dEh9qq
         MX2Q==
X-Gm-Message-State: AOAM532Dp/qCZ7S3JZpGV146QauS8N/vsrw37fhKRjJa1v6uj8jnE263
        GqVucQp0wIbYNPJtcEiPo7jtMAv/zd/k7hFaxyRRsA==
X-Google-Smtp-Source: ABdhPJwngIQHqkXr8tNBFZq9yhVmK+A8kDiQKemQ82pD6xIk2L4DEDRbNLEodp7oRyr6RrAt7a2pPXoLvBYoMWvohMM=
X-Received: by 2002:a05:6830:1155:: with SMTP id x21mr1243547otq.303.1622759300667;
 Thu, 03 Jun 2021 15:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210603215819.3904733-1-keescook@chromium.org>
In-Reply-To: <20210603215819.3904733-1-keescook@chromium.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 4 Jun 2021 00:28:09 +0200
Message-ID: <CAKMK7uGbGSw-hDSq7+RM-LzdKeNcaf1Fn6SRfo=4WMJPXyA7rg@mail.gmail.com>
Subject: Re: [PATCH] drm/pl111: Actually fix CONFIG_VEXPRESS_CONFIG depends
To:     Kees Cook <keescook@chromium.org>
Cc:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 11:58 PM Kees Cook <keescook@chromium.org> wrote:
>
> VEXPRESS_CONFIG needs to either be missing, built-in, or modular when
> pl111 is modular. Update the Kconfig to reflect the need.
>
> Cc: Emma Anholt <emma@anholt.net>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Fixes: 4dc7c97d04dc ("drm/pl111: depend on CONFIG_VEXPRESS_CONFIG")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/gpu/drm/pl111/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/pl111/Kconfig b/drivers/gpu/drm/pl111/Kconfig
> index c5210a5bef1b..b84879ca430d 100644
> --- a/drivers/gpu/drm/pl111/Kconfig
> +++ b/drivers/gpu/drm/pl111/Kconfig
> @@ -2,7 +2,8 @@
>  config DRM_PL111
>         tristate "DRM Support for PL111 CLCD Controller"
>         depends on DRM
> -       depends on VEXPRESS_CONFIG
> +       depends on ARM || ARM64 || COMPILE_TEST
> +       depends on !VEXPRESS_CONFIG || VEXPRESS_CONFIG=DRM

Hm I thought the canonical way to express optional depdencies was


>         depends on COMMON_CLK
>         select DRM_KMS_HELPER
>         select DRM_KMS_CMA_HELPER
> --
> 2.25.1
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
