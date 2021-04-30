Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3126336F71E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhD3IaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhD3IaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:30:14 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F54C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:29:24 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g10so13700786edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xiDthqOA1PKLysyz3wEBzr+UCVf/K0s/TKR2SGLkpIA=;
        b=GruLo53yNG6MBZKgHZj1JzSTn7ZktLWswSqtU0vQNU7BxStGMebOufdzCpM5uP0egC
         tNSv+jkPs6o0V4dPXsBqFk8U1Aijbqt7G2T+9zhjUxam3hY6xQP7wHZ8xwolmVNanx97
         /SFJmsRgrPi5tyDssGFTMw1dTKihSHwT3AKZa63d3F6JiHG1Il9GrjPh7ITJjOzh44tP
         M6kGpN3PW442oBNXVIt9IL/02b9C+ENV2bgY6LXgCyIlLUaTI9k6v2dj6SlfZXDwKnd/
         CQFIBicgBNMDso79g4c/Gy9lOhjhuq43EYPXYMDa3cm04EBuEhFYUw1gzbWJLO5f99D7
         2VrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xiDthqOA1PKLysyz3wEBzr+UCVf/K0s/TKR2SGLkpIA=;
        b=I0cs8l5pP4Bat0DaTZEkR52Aoy70T7ZI6qeEjQ9WoYt1CgdVE+C0nge5uE6avi0Jvz
         WwB6weCA70A51MftdIpI+ElIpT2/pzK57qA2PvSHEp2ruSUZjRyla9wpxagotrOQpZNs
         9lZVH/JR5LPCSD08N5SqQosnGOQJyiktraYmNKTRAG1JrDUvIqSWdpu38UufahMfHC9t
         E5AgzpEzJ4GQrUkKEQ8wvLBHjRz1Dy7fcR54GkvZwxdnSYdT6/xGxlmDop1tPPPeuKJp
         lT7uA5oBdteXu1IRUxNVYLFhTN0u+YfKDGp5D146FjzufaiuX8aFepbxPhizTBQC6oZy
         C9bQ==
X-Gm-Message-State: AOAM532WIRE00zx3bavhbJpA0Jes8D55RdmYYdVea4eLy+z4C3NzGKRW
        ABKy/vg0cUy/mRT+xVKTgcCB5sifVSl74JIJF8UA
X-Google-Smtp-Source: ABdhPJwBAUS8SfZ4s/ZySS64bjWjl+kpdjqmtnMQeW58mKxNjfZJR/SCaa+OVtAo9sYqzzoUX0IXzFjujcsuB0eVxh0=
X-Received: by 2002:a05:6402:1255:: with SMTP id l21mr4337362edw.362.1619771363167;
 Fri, 30 Apr 2021 01:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210423205159.830854-1-morbo@google.com> <20210428172847.GC4022@arm.com>
 <20210428174010.GA4593@sirena.org.uk> <CAGG=3QUATefn9AG+HvnCfEOBv3iRu4fzFwfmA7Djrh2CmP_weA@mail.gmail.com>
 <CAGG=3QUNykCfkS22g+HRWb0Goa8DJ72TUueLtMe5v1YfnStojw@mail.gmail.com>
 <20210429075454.GQ9028@arm.com> <CAGG=3QV0kR__23yEmwwXBpcE1gvjLqRNmF667hhVeY0B3urTqQ@mail.gmail.com>
 <20210429095027.GR9028@arm.com> <CAGG=3QW9t2zUPYLt_La=qQTZeHzfLBCXgZRbiia8T6K7n=YrdQ@mail.gmail.com>
 <20210430081632.GS9028@arm.com>
In-Reply-To: <20210430081632.GS9028@arm.com>
From:   Bill Wendling <morbo@google.com>
Date:   Fri, 30 Apr 2021 01:29:12 -0700
Message-ID: <CAGG=3QWX+7aiF6okY0ybsaa1bK4pJn4YPGUhnGZotiz+cN8Xrg@mail.gmail.com>
Subject: Re: [PATCH] arm64/vdso: Discard .note.gnu.property sections in vDSO
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Kiss <Daniel.Kiss@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 1:17 AM Szabolcs Nagy <szabolcs.nagy@arm.com> wrote:
> The 04/29/2021 11:52, Bill Wendling wrote:
> > $ readelf -lW arch/arm64/kernel/vdso/vdso.so
> >
> > Elf file type is DYN (Shared object file)
> > Entry point 0x300
> > There are 4 program headers, starting at offset 64
> >
> > Program Headers:
> >   Type           Offset   VirtAddr           PhysAddr
> > FileSiz  MemSiz   Flg Align
> >   LOAD           0x000000 0x0000000000000000 0x0000000000000000
> > 0x000968 0x000968 R E 0x8
> >   DYNAMIC        0x0008a8 0x00000000000008a8 0x00000000000008a8
> > 0x0000c0 0x0000c0 R   0x8
> >   NOTE           0x000288 0x0000000000000288 0x0000000000000288
> > 0x000074 0x000074 R   0x8
> >   GNU_EH_FRAME   0x0008a4 0x00000000000008a4 0x00000000000008a4
> > 0x000000 0x000000 R E 0x1
>
> this is wrong because the abi specifically says properties
> are in PT_GNU_PROPERTY, not in PT_NOTE.
>
Right. The issue is more complex than this fix is meant for, to be
honest. That is, it seems that there needs to be a generalized way of
handling the different .note sections.

-bw

> so the original patch that removes them from notes is fine,
> but ideally they should be readded under PT_GNU_PROPERTY.
>
> (x86 needs it there too, but also needs it under PT_NOTE for
> historical reasons. ideally the section would have been named
> other than .note and was not marked as SHF_NOTE, because
> properties are merged completely differently by the linker
> than notes, so now linkers have to special case it by section
> name. properties should have been designed like the
>  .ARM.attributes section except that is not in a load segment
> and thus has no runtime semantics while the key feature of
> properties is the runtime semantics. however accessing the
> program headers of the vdso is not trivial at runtime from
> user code so dropping the properties might work too, but can
> bite us in the future depending on how they evolve: the ld.so
> can look at vdso program headers.)
