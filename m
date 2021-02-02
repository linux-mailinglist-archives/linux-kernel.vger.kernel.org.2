Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5242A30BFF0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 14:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhBBNqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 08:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbhBBNnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:43:40 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9B2C0613ED
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 05:42:59 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id m6so14366246pfk.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 05:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ULfru5VoR6la+blRMAgVbCUtmZDEDwFPNm2BTtvrXik=;
        b=wJMp7HySx4KIdAfdpQKRivgJiFrR11aqd2RkFKHhHaSMRpxjRdRAlU+kVIGqEcKgCH
         X6+x9LPPUtmvAhp06gH47PgpOxyNvB2a90xkoeAggnBu3pitEyajvqBsX9DzvXq1kUzA
         areD2oWxIV0EztVWVUvcBVVfx94P2045WVEZhegGKlbQl1mLEN5X6JnbItdB939khERd
         I/NVm21Oo7gMneX/70y0igmjHuLs/we8A+JxiGZDfXLGdbNkQZlw2AkDWhy+I49XXSVR
         DUnn2QZRkT2coIHw6b5yE/mtR30i0aADKrGsTPJAA9UckxbnLeS2IAAqttEXIhdDDwiU
         RuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ULfru5VoR6la+blRMAgVbCUtmZDEDwFPNm2BTtvrXik=;
        b=Fx2Cl6AqO96R29O6b9ZOYn7SjvlXkA4ZOOWzG4fwSix/obavUJIClK0CWrpnxRr5JT
         5SaiBf2MTrhuCDZN3OurU+T7yJv3cD6SkGuX2Buxpt8WcFZEpFO1Ych64sVcZ7FPthv8
         Ny1Hkl8Y5vPxKEAYcoBnn1BShWxB+jl4LKP8Q9cM0NK7Ss8SzW3foK0641ZrY3/3yd2C
         pas0Rni6QspuudM10rjxvvqyBDQXD+D1p7AcBmt3cSaGQLqYWCE9UMXCkB81G47G0T6q
         PRidY4C+P2noNSG8L0Cxj7ppKzzW781hCXx1iTDjkQs6CD4uM8NsNzd9PV3kLBQspYDV
         FuCA==
X-Gm-Message-State: AOAM530ie/WcRrC/Pyq9P1o96xKBX13NUet87Xl8oGE2ngs8Ht7rTe8+
        bvkxkMQvg7lvY9r3ApXDU1U8TNnByYITghyV2+8MdA==
X-Google-Smtp-Source: ABdhPJw9OokT1/NJk7DMk27RSiNrkvpfczhQWVIvDigRIJcuRYPtlyIML4onllZUdx6kuUPeg8ZSauBOz58xE6Q26Jk=
X-Received: by 2002:a62:18d6:0:b029:1bf:1c5f:bfa4 with SMTP id
 205-20020a6218d60000b02901bf1c5fbfa4mr21354404pfy.24.1612273379132; Tue, 02
 Feb 2021 05:42:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612208222.git.andreyknvl@google.com> <d128216d3b0aea0b4178e11978f5dd3e8dbeb590.1612208222.git.andreyknvl@google.com>
 <20210202104618.GA16723@willie-the-truck>
In-Reply-To: <20210202104618.GA16723@willie-the-truck>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 2 Feb 2021 14:42:48 +0100
Message-ID: <CAAeHK+yACsAfZqx2gbgoTMZHym5eMNr8e9XSh2+OL_UuK3CiQQ@mail.gmail.com>
Subject: Re: [PATCH 12/12] arm64: kasan: export MTE symbols for KASAN tests
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 11:46 AM Will Deacon <will@kernel.org> wrote:
>
> On Mon, Feb 01, 2021 at 08:43:36PM +0100, Andrey Konovalov wrote:
> > Export mte_enable_kernel() and mte_set_report_once() to fix:
> >
> > ERROR: modpost: "mte_enable_kernel" [lib/test_kasan.ko] undefined!
> > ERROR: modpost: "mte_set_report_once" [lib/test_kasan.ko] undefined!
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  arch/arm64/kernel/mte.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> > index 8b27b70e1aac..2c91bd288ea4 100644
> > --- a/arch/arm64/kernel/mte.c
> > +++ b/arch/arm64/kernel/mte.c
> > @@ -120,6 +120,7 @@ void mte_enable_kernel_sync(void)
> >  {
> >       __mte_enable_kernel("synchronous", SCTLR_ELx_TCF_SYNC);
> >  }
> > +EXPORT_SYMBOL(mte_enable_kernel_sync);
> >
> >  void mte_enable_kernel_async(void)
> >  {
> > @@ -130,6 +131,7 @@ void mte_set_report_once(bool state)
> >  {
> >       WRITE_ONCE(report_fault_once, state);
> >  }
> > +EXPORT_SYMBOL(mte_set_report_once);
>
> EXPORT_SYMBOL_GPL ?

SGTM, will do in v2, thanks!
