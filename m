Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F8531FF8E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 20:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhBSTqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 14:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhBSTqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 14:46:06 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F3AC061756
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 11:45:26 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id do6so15705806ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 11:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vNXss2R439WReA4A5p2aVRtiZkryvFn/KdsgQqDMpz8=;
        b=UGIej+Y90hr2tcZqfj6uEvrLTS/vpeYC4x6P6hOI08vsf67gC7FUzKWPuALawpLvpp
         xILpSNf7Fa7PznY65dx4RgT+lcZ9uYWVmi2F+3BzLXGTQll34qJuz2eO3SmJVggG6Oac
         7gKtbRoKe8f2THu394yw8nGyphMxvKZ17E+ls4lXCx196oqtxWg/9kORGlRigJ6R2IYz
         wViSQurw95LjF3LgzXzKB8AzBt7nM2airi2EnEgSgTdsxzeiEYal1ATQVY+Nf4co7xZz
         Ict8+c2QOzuhIbDE+aqQbhuXZUKY6D1H2L3wu3VDuvWYIVDdDrzXl2lCJ2abrm2OItnC
         Tvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vNXss2R439WReA4A5p2aVRtiZkryvFn/KdsgQqDMpz8=;
        b=iIItPbieaAJ59SQ8svnP8ShYDbCfaiVS37j10uZQmhIpfHLTj486ZKCtinqwaDid8m
         AEVJmVHSbclO2dEwCO/19H3GOxZxnAMY0gkWN0SfvNkuqeVrmPAer0liWabKKW2WcGB5
         vDL7ek90qdNkByf8BWTkG4GNOF6BTkv9qGhngBDTfQhIYcAAOgd2MzoP2b1VdNxzLDq6
         j3SnonBmrHL9EoTaCm5TLnUJr1ZSMFuLCVRYWedGAj1zvZ2njRAI4Bcj583+fc42jf9/
         AOj54OyMtstA+z9+YgkNa+A3aCla4VaBir3ESpgKbdCmvfyubEQ9ZdyQX2uukY/H+JQq
         35Tg==
X-Gm-Message-State: AOAM5307O7I07x4khEmo+HMIMgKhE4a8rfXf4Ngb68ESya1hxO5g96+z
        I2PMna7xvhdH5Vb78gp7EMN+eQPjKiHb313VLPy/epo+vnlTxsy9
X-Google-Smtp-Source: ABdhPJzz9ma1y8TEtYg/cIfXA1568VmifuPk++cNwcZ4+5SidEFivtvGtejnx/f3t9SmxhagutwJzw6f6GWzr3bBolQ=
X-Received: by 2002:a17:906:17d5:: with SMTP id u21mr10394249eje.541.1613763924973;
 Fri, 19 Feb 2021 11:45:24 -0800 (PST)
MIME-Version: 1.0
References: <20210216150351.129018-1-pasha.tatashin@soleen.com>
 <20210216150351.129018-2-pasha.tatashin@soleen.com> <20210219191807.GB6683@willie-the-truck>
In-Reply-To: <20210219191807.GB6683@willie-the-truck>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 19 Feb 2021 14:44:49 -0500
Message-ID: <CA+CK2bB13G4wTm6P_hdkwi2cbu=774GnpwBV7giy77-fEHDKow@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] arm64: mm: correct the inside linear map range
 during hotplug check
To:     Will Deacon <will@kernel.org>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        James Morris <jmorris@namei.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 2:18 PM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Feb 16, 2021 at 10:03:51AM -0500, Pavel Tatashin wrote:
> > Memory hotplug may fail on systems with CONFIG_RANDOMIZE_BASE because the
> > linear map range is not checked correctly.
> >
> > The start physical address that linear map covers can be actually at the
> > end of the range because of randomization. Check that and if so reduce it
> > to 0.
> >
> > This can be verified on QEMU with setting kaslr-seed to ~0ul:
> >
> > memstart_offset_seed = 0xffff
> > START: __pa(_PAGE_OFFSET(vabits_actual)) = ffff9000c0000000
> > END:   __pa(PAGE_END - 1) =  1000bfffffff
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Fixes: 58284a901b42 ("arm64/mm: Validate hotplug range before creating linear mapping")
> > Tested-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > ---
> >  arch/arm64/mm/mmu.c | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
>
> I tried to queue this as a fix, but unfortunately it doesn't apply.
> Please can you send a v4 based on the arm64 for-next/fixes branch?

Hi Will,

The previous version, that is not built against linux-next would still
applies against current mainlein/for-next/fixes

https://lore.kernel.org/lkml/20210215192237.362706-2-pasha.tatashin@soleen.com/

I just tried it. I think it would make sense to take v2 fix, so it
could also be backported to stables.

Thank you,
Pasha
