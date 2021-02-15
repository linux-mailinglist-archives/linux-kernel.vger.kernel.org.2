Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770FB31BA8E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 14:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhBONu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 08:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbhBONug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 08:50:36 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3EEC061788
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 05:42:56 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y18so7994840edw.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 05:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=66WmrtkERToRflEh1NkJZylM3MvlhQYc1fqz316mmYg=;
        b=dGA6/1K7WB5g0NqY78ObZYwIcZmc0F9k05zMGKMBhvlDobYNhNwyxDrJCGDjELsrp6
         b4qPclwgwWmdpBG64hG2O2NCSIChCsOchdw0b8JUlAlycklQ3C3LqFzqcITchqb6kyUa
         C9kzapxYQ8/w3n1jjDWxixulc5dDlyItGrKx0uZfELZwEsMUQXYQCYFVCzrT/tOZmEzb
         oqITUKaZTWLc/L8ILxdZwWFxL1xrkSYG3J2tMEFl7IyrRqJk8VSnOeEMxPrYU9hl1UYg
         eKhejbOxTYtQzwTApDOZIsR4Lfp5WN1CYKvb9f7QqQTVnYi8nmotSse+euRdY13wvWGQ
         gvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=66WmrtkERToRflEh1NkJZylM3MvlhQYc1fqz316mmYg=;
        b=d+XHZVqLqtRo1C3LObtPAJrdNixW+bdpHG/DdGjvNA1F5QHe9NJOivnyauCN3bk8Bl
         ssdwD/qsWaeYwc0ccb00bnSmoSElBGcXCGzRHNAiyhc+zugdDYKnfKvzNmUa6eIRRlDT
         vIXswZ6f8IqJ93BlTopP+G5pJKUR9LiVIoXrNYZx99I65YTZZn2Nfrm+ophGLuUCHbRP
         FR4Z9m2xhSAJ6/1yNy89z1yZM9X/e3L1+ODSRKtYGYr2l+N4T2c4Xq7I9VQsRcYaupzi
         dFnyHenGZZvBp9xOCedKYCfNmk9YOH+utU03P3QynP4PfXOiIv6ZtPPW0JddYHxeKzLx
         VkQA==
X-Gm-Message-State: AOAM532U28WpOjK4ReL6pR8BkZ24WUaJ4iaDwvu1cnO8gXUOh31lm0de
        tqBpJYDQhA8AQuCMXoAJuG1a72ZX26jMoFeugY+eVQ==
X-Google-Smtp-Source: ABdhPJxI7FQDhtpLAKe3rQJjPFJ+XlEBd0EKdUOVDwTuMuR/aX5l5bqXxceb3zDbhKHswLBWbL6YAZWkwUplP/bQcJc=
X-Received: by 2002:aa7:d9cb:: with SMTP id v11mr1794256eds.153.1613396573980;
 Mon, 15 Feb 2021 05:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20210213012316.1525419-1-pasha.tatashin@soleen.com> <06b7bfd1-99cd-a9be-e3cc-9fe13f2cf2a6@arm.com>
In-Reply-To: <06b7bfd1-99cd-a9be-e3cc-9fe13f2cf2a6@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 15 Feb 2021 08:42:17 -0500
Message-ID: <CA+CK2bBvaSzfD_mN3HdBdLrvQ3XDEPY0o2J8Ho8sViWX2apWyA@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: correct the start of physical address in
 linear map
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        James Morris <jmorris@namei.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>, ardb@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 12:26 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> Hello Pavel,
>
> On 2/13/21 6:53 AM, Pavel Tatashin wrote:
> > Memory hotplug may fail on systems with CONFIG_RANDOMIZE_BASE because the
> > linear map range is not checked correctly.
> >
> > The start physical address that linear map covers can be actually at the
> > end of the range because of randmomization. Check that and if so reduce it
> > to 0.
>
> Looking at the code, this seems possible if memstart_addr which is a signed
> value becomes large (after falling below 0) during arm64_memblock_init().

Right.

>
> >
> > This can be verified on QEMU with setting kaslr-seed to ~0ul:
> >
> > memstart_offset_seed = 0xffff
> > START: __pa(_PAGE_OFFSET(vabits_actual)) = ffff9000c0000000
> > END:   __pa(PAGE_END - 1) =  1000bfffffff
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Fixes: 58284a901b42 ("arm64/mm: Validate hotplug range before creating linear mapping")
> > ---
> >  arch/arm64/mm/mmu.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index ae0c3d023824..6057ecaea897 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -1444,14 +1444,25 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
> >
> >  static bool inside_linear_region(u64 start, u64 size)
> >  {
> > +     u64 start_linear_pa = __pa(_PAGE_OFFSET(vabits_actual));
> > +     u64 end_linear_pa = __pa(PAGE_END - 1);
> > +
> > +     /*
> > +      * Check for a wrap, it is possible because of randomized linear mapping
> > +      * the start physical address is actually bigger than the end physical
> > +      * address. In this case set start to zero because [0, end_linear_pa]
> > +      * range must still be able to cover all addressable physical addresses.
> > +      */
>
> If this is possible only with randomized linear mapping, could you please
> add IS_ENABLED(CONFIG_RANDOMIZED_BASE) during the switch over. Wondering
> if WARN_ON(start_linear_pa > end_linear_pa) should be added otherwise i.e
> when linear mapping randomization is not enabled.

Yeah, good idea, I will add ifdef for CONFIG_RANDOMIZED_BASE.

>
> > +     if (start_linear_pa > end_linear_pa)
> > +             start_linear_pa = 0;
>
> This looks okay but will double check and give it some more testing.

Thank you,
Pasha
