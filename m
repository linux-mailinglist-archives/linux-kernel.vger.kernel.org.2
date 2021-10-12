Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5550E42AF77
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 00:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbhJLWFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 18:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbhJLWFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 18:05:12 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796C9C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 15:03:10 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id i84so1619831ybc.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 15:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ftKqaoZGMToDPlxiMR/hkrcdIKvYqHccSfyT6Zdak+w=;
        b=E2K/JHuLWHAwGOkBErV9EIGjL9VxVIkjV11E47Q6tcWifgmKKAy6QICUVuaLCRLHbF
         R2U0RxE4dVCzStCO7WkICmdqS765g4VZXWge7Dup+ZVu2hjTiQEL1cE+KNeHswmICc7O
         svaU3l0FSfV+ldc9E1X32nqUCaih8gUr48KlEucXIFpMJcpzZ4SrNkiGcyolcknqdJ7f
         x6oHH3XRVozET6g8BzwjTz7XW/9NuR9SujfBnT21XYh0oE5zn0olT4gDd5MbVpkDDcJf
         beQAqv6AegrhN/wtJsLIZ+ydJZX70UcWq6cc2kC9Ddr+1H42wIhWqfx2kSRFAAdWVRAG
         Q+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ftKqaoZGMToDPlxiMR/hkrcdIKvYqHccSfyT6Zdak+w=;
        b=5kAmEpk3BmwflV+NFyUY5JIAmFhlYKbwpZ2yaJJ7jQH1Avk9FbimupX6uSzkDLkUGw
         Yu3t8mtE+1PRNd8nqJc5L+oTrbC/fc5ATmf5XxM5l+PzQDS2pn2D0UPH/KGB5CB+4N97
         y62Ji2bkTb7UEqElxqYiJEpQsQQg26DVTv/6CFIa6LHp63AnyHZGUQ+Tl6aiq0GX7eCX
         cGfmNJ488BuHlSanOmE7FzKKT80pTePCZ6DFrJSOWXhqNnP949E8YDMBu2R1BbOKx7H9
         UlzCBVxYlltmj9JSieULiwRY1CfWTQL5MXQNLKH+ZZkgka2V9iZAz5jypIGQPLdLqO0b
         FW3w==
X-Gm-Message-State: AOAM5331Jah0HdfPRYSA9ThWl+GDzTDbTIvUI5s4SB8kOlzaGxlkHbfE
        BhCwzRqSIh0xXi8zTOE/R1QGitSWE/RSxV7D/8Q=
X-Google-Smtp-Source: ABdhPJzw6ADZ1dpJOkdrPmTrdt2J53tEY05Emb4iJxrIIwJ77Ol4xtvXG3biqdksy3qqRPnIlIgTb9kBkCt/R+OYf70=
X-Received: by 2002:a25:e6d0:: with SMTP id d199mr29939096ybh.527.1634076189634;
 Tue, 12 Oct 2021 15:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211012133334.1737918-1-kherbst@redhat.com>
In-Reply-To: <20211012133334.1737918-1-kherbst@redhat.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Wed, 13 Oct 2021 08:02:58 +1000
Message-ID: <CACAvsv47Xn07zM8pSqAAbTktjySaBeW_swrZAGjrfAVUnzdHzw@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau/mmu/gp100: remove unused variable
To:     Karol Herbst <kherbst@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        DRI <dri-devel@lists.freedesktop.org>,
        ML nouveau <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2021 at 23:33, Karol Herbst <kherbst@redhat.com> wrote:
>
> Fixes a compilation issue introduced because I forgot to test with WERROR
> enabled.
>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: DRI <dri-devel@lists.freedesktop.org>
> Cc: nouveau@lists.freedesktop.org
> Fixes: 404046cf4805 ("drm/nouveau/mmu/gp100-: drop unneeded assignment in the if condition.")
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
Reviewed-by: Ben Skeggs <bskeggs@redhat.com>

> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
> index 2b21f43069aa..17899fc95b2d 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
> @@ -488,7 +488,7 @@ gp100_vmm_fault_cancel(struct nvkm_vmm *vmm, void *argv, u32 argc)
>                 struct gp100_vmm_fault_cancel_v0 v0;
>         } *args = argv;
>         int ret = -ENOSYS;
> -       u32 inst, aper;
> +       u32 aper;
>
>         if ((ret = nvif_unpack(ret, &argv, &argc, args->v0, 0, 0, false)))
>                 return ret;
> --
> 2.31.1
>
