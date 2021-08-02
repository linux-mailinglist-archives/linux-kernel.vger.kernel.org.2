Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F19D3DDFC3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 21:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhHBTBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 15:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhHBTBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 15:01:05 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7BEC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 12:00:55 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 21so25276735oin.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 12:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nbrc0x7cBePFWpue6P0CQy4Z2rROhmn1R5Qbq29mtWk=;
        b=mY2MMpizcw6Sj9yi5PQnA4xrr7aT0f6pxShy7s9f0RQOhanYcGVkoRA07y0Bsh/qdd
         iw3MGtB6UYkz0tF6he4rhTl55dZGVYybvR8zgCA83a9FRZ1GBA49B+oXHnmoJ+g+bWrd
         tieUmLjeOuOtAky2s6peDZa6+VRmk/G1HE+gUPm6KdCZV6QmQKaLHSRmkLssIocoUMlq
         1qE2c5pqlgz5udxH1R6ceMM2x8fGx9wiYYuCHZBuo+rniDizQeXX7eOOnGKsVfKDyvWy
         ox2+aU/PmObjbPbBh7fasmhEbAAfrPoeQFAtm07GAuTKd1VKrPgESJoWOrFtNZb+Ztkv
         72EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nbrc0x7cBePFWpue6P0CQy4Z2rROhmn1R5Qbq29mtWk=;
        b=b/bn6pKU+MGTfl2lG0vGpXQuBC7CBe3wh+FPE8VmL7U0vj0mi+fjhiwGnTpQVRUvlq
         z5BBQdcRhHjr5oXpqajP3hemMdgYpO2eB+CL+LAMw0c0K2Ki1LznXLAWJKkXAbaURA4F
         Bu9M8rAUGrnJWfT7oh55uNoksOOczIejlIU0EwxXz6XCta8lZRz/TL+wgVY6geGZ0UKt
         7A1He5mSYcE5HN+AXYacdd1Q2gbbsmDlaZwR3K8yXguPQqlAFOqQDK/CK/MF3YltPZ7S
         ngU2zuwHR0Q/MFnK/z72d0jExwLzpvQEC+a6iOMzq4IR++obtJ2j4t9onXAVUEB+6cfj
         4Wiw==
X-Gm-Message-State: AOAM532Dv6p9S9JBlTEdoBavcpe7LwCeUmQmmBX8kUQ6DY1ZoDlN/MpS
        /cYbaGGxOrmvCrsJtpoHsdNmxne8aCgU72l2wUg=
X-Google-Smtp-Source: ABdhPJzvruV9/L01NSfd/N3KeYc5cMMjB7KrWCYzZhNaVKsPAtHsNwOUIPCfEfaY2OjNgL+guDmnHj/A6MELoI80HOs=
X-Received: by 2002:aca:53ca:: with SMTP id h193mr320764oib.5.1627930854745;
 Mon, 02 Aug 2021 12:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <1627889555-56431-1-git-send-email-zhouchuangao@vivo.com>
In-Reply-To: <1627889555-56431-1-git-send-email-zhouchuangao@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 2 Aug 2021 15:00:43 -0400
Message-ID: <CADnq5_Peu054E8AOZ0Wo5Sg-ADR0F_pwaT6_e5PmN_ji3=BmWw@mail.gmail.com>
Subject: Re: [PATCH] gpu/drm/amd: Remove duplicated include of drm_drv.h
To:     zhouchuangao <zhouchuangao@vivo.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        John Clements <john.clements@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Wenhui Sheng <Wenhui.Sheng@amd.com>,
        Victor Zhao <Victor.Zhao@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 2, 2021 at 3:32 AM zhouchuangao <zhouchuangao@vivo.com> wrote:
>
> Duplicate include header file <drm/drm_drv.h>
> line 28: #include <drm/drm_drv.h>
> line 44: #include <drm/drm_drv.h>
>
> Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 3ec5099..05f864f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -41,8 +41,6 @@
>  #include "amdgpu_securedisplay.h"
>  #include "amdgpu_atomfirmware.h"
>
> -#include <drm/drm_drv.h>
> -
>  static int psp_sysfs_init(struct amdgpu_device *adev);
>  static void psp_sysfs_fini(struct amdgpu_device *adev);
>
> --
> 2.7.4
>
