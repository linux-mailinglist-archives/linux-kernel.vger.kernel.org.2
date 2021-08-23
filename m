Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF493F526F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 22:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbhHWUuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 16:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbhHWUt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 16:49:58 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE6BC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 13:49:15 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso18972323otv.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 13:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kRioPTSwPNPQIawlVjBYUzUe1ixS3CDqz1E0OToKW/0=;
        b=icpSRXFrtIwMTLAq6k0FjigYljXDSrKlLfXeaeSKo/wAwMoFAeBhdLvRma2cWEv9NR
         UbsbezU+0isWZA8E2r2S87/URdtr1zQi2UdendocMFoE/H2Ho//YphDzly87MlR/eprh
         IDy9cTW1Az3ondfyIOyZB5JLj7A0BNDuu2sewBCHJhVMpvDh2vvdx2XBhzu6Tykou4dz
         XuDR2Z9U7ahgH701PeiYMoZUGXvjTSz0q6gVd5cNrf9VIbx7R51v+teDzl+8/tRmvPnY
         GzFUXCfK1mX+22cFGPlhZ/FMqPPxHR6wnQ0+E9az6KdQnWwXAseoFKNmGieYhEFtTKkS
         hgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kRioPTSwPNPQIawlVjBYUzUe1ixS3CDqz1E0OToKW/0=;
        b=B0JlcQHM4w8o1nX2Yl0ubGUnAK6UhDPVkWf6arr5HuAQ+Hgy4MmtG2leMaBuAe645p
         1FU2MhJSP6Lqxz6iS++f0WOsSGrRDnA6r7BWBGgxxagwwevtu8bz3dCC6bY1FQKSM7gR
         hIY3qA8bZHj0Wwkmu9N4ncK5AEIVQjPQVc2dMtOIx+wKG8mqy+JI1edCKc4a2K/bergg
         gsdWXOw9cNJaplKFMQQD1GM2i4+icSctCblcgRY+ZEEZrtTldY1QfNSY04P9ZXpEYKch
         i3/uuPubCSnALdO/lFK831aQzhkLC48USILzyQwdXU9DcQragzCQ6gQWqiILYyH9RfZL
         HXCw==
X-Gm-Message-State: AOAM5303p5VwTSxAOcp5M2Ctq9Ms+wEu/gWyB0/m+BKufZIY1SBHp57z
        MJyJmwutsaGR2pZwAjVwc9AzLK1W/VnHOJ31Nz4=
X-Google-Smtp-Source: ABdhPJyTqOIR/h/yNMKFNF14JH+tbIbDvdaqQ6ajhKxsEA97mpcrsd9PxJlq5thk1Mhopi+qdXRRBiBCkWCotwFi7JM=
X-Received: by 2002:a9d:4c15:: with SMTP id l21mr16178721otf.311.1629751755213;
 Mon, 23 Aug 2021 13:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <YSP6Lv53QV0cOAsd@zn.tnic> <CADnq5_O3cg+VtyCBGUDEVxb768jHK6m814W8u-q-kSX9jkHAAw@mail.gmail.com>
 <YSQE6fN9uO0CIWeh@zn.tnic> <CADnq5_PEOr=bcmLF2x67hx24=EWwH7DAgEsPjYqXgf8i-beEhg@mail.gmail.com>
 <YSQJL0GBzO2ulEpm@zn.tnic>
In-Reply-To: <YSQJL0GBzO2ulEpm@zn.tnic>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 23 Aug 2021 16:49:04 -0400
Message-ID: <CADnq5_N0q8Rfm++O3jK6wcbePxg_Oj3=Xx9Utw60npKrEsSp8A@mail.gmail.com>
Subject: Re: ERROR: modpost: "pm_suspend_target_state" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko]
 undefined!
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Lijo Lazar <Lijo.Lazar@amd.com>,
        Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 4:46 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Aug 23, 2021 at 04:31:42PM -0400, Alex Deucher wrote:
> > Thanks. I think that should do the trick. Care to send that as a
> > formal patch?
>
> Sure, but let me run it through the randconfigs tests first to make sure
> nothing else breaks. It is late here so if I don't manage now I'll send
> you a formal version tomorrow morning, CET, the latest.
>

Sounds good.  Thanks!

Alex
