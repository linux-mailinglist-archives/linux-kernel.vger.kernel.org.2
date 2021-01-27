Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38245306141
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 17:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhA0Qs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 11:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbhA0Qsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 11:48:41 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73446C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 08:48:01 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id r12so3578774ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 08:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=95TSrifribrBiQvYeW7oeDR3coDlFThL26tZkibpkw0=;
        b=Ei/vSaVvlagR765TYOxKEyRxm/djxNDTo1eo93ZrR9L73SOEhERzxBHGW790RPCtxf
         3hx/J60PakltGTz93hCnlG6DfSgc8fFrgzrMlBwmF2AM1k0VNetctFdvViJQE9DrwrI+
         sXr0XZVnfGDN6fJzhZBeEfVk+XnBnIg4MpnqKeAFgoh76jxqJrp7jrUUpJoeMWOO9sb0
         0Y3C/9s9+iBnM5SUtLe7HRSX9W7rAG/NrPfQKWhwpEkRLkCYVCY9g/ve+BY8V3R33S7S
         XwkeSS9SzEzGBYCUKSjGtAdR/EzOfPw5aoNb6XjO6dhg2C2+yjKAfvnra5oefOF3wta1
         GzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=95TSrifribrBiQvYeW7oeDR3coDlFThL26tZkibpkw0=;
        b=Y17clgqZPgf3RtcsCquydpypq2gQAALhpKYx5rsb6IeIb7+tutEcFA0ZsLAQweYm+r
         liIDLWU/Y9BxFRjHcl8rNFX0pr2aPjDYcrOhKGa327qhhHY6CgBeZ5H5dMHRkFSo1/e5
         RASLESeLR+5QzMgVA0xQgCr45H1O2YqTUEr9vLyGKjAV0eL2ltf4QGGQsuBfXPAaWiRN
         2AK1sEs63SQA9vxW04WG8Ki/xggoSyhTSZE3rU83FIoBYurgepvs2h2YR5vRO7d5fZpd
         PGkGQ+Jz0NGIW2vCTs96tECWCcIr1h+QFw5L84DRLVk1Jf8cfGl1lwm2ME1h+u5Zv/ZL
         YBQw==
X-Gm-Message-State: AOAM532YwFQAttApXkkaXoxiMKTWQYK6pzq+t1VnmAVNHp9QIMnR1RLH
        10AL/hW3D7wkGQDO22XD1ly+3ed3m8YDMLBjV3NWNQ==
X-Google-Smtp-Source: ABdhPJzY/0E7pKaHXMugYVU++KnMNQWLvbtaXIlDKuzPhoWRjT3DXhIBF/1wneCQyLEivHzmXwnOjEa4rc1XacysGE4=
X-Received: by 2002:a17:906:eb95:: with SMTP id mh21mr7778201ejb.175.1611766080094;
 Wed, 27 Jan 2021 08:48:00 -0800 (PST)
MIME-Version: 1.0
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
 <20210125191923.1060122-17-pasha.tatashin@soleen.com> <d5b91732-1985-4d90-89a1-4873deaa5592@soleen.com>
 <20210127164230.GA584465@sequoia>
In-Reply-To: <20210127164230.GA584465@sequoia>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 27 Jan 2021 11:47:24 -0500
Message-ID: <CA+CK2bA6k_RMiX7P2ptO-yK8pU2w9tABA+p6QxNKRwvmEemuKw@mail.gmail.com>
Subject: Re: [PATCH v10 16/18] arm64: kexec: configure trans_pgd page table
 for kexec
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 11:42 AM Tyler Hicks
<tyhicks@linux.microsoft.com> wrote:
>
> On 2021-01-25 19:21:22, Pavel Tatashin wrote:
> > I forgot to make changes to arch/arm64/Kconfig. The correct patch is
> > below.
> >
> > ---
> >
> > From a2bc374320d7c7efd3c40644ad3d6d59a024b301 Mon Sep 17 00:00:00 2001
> > From: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Date: Mon, 29 Jul 2019 21:24:25 -0400
> > Subject: [PATCH v10 16/18] arm64: kexec: configure trans_pgd page table for
> >  kexec
> >
> > Configure a page table located in kexec-safe memory that has
> > the following mappings:
> >
> > 1. identity mapping for text of relocation function with executable
> >    permission.
> > 2. va mappings for all source ranges
> > 3. va mappings for all destination ranges.
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  arch/arm64/Kconfig                |  2 +-
> >  arch/arm64/include/asm/kexec.h    | 12 ++++
> >  arch/arm64/kernel/asm-offsets.c   |  6 ++
> >  arch/arm64/kernel/machine_kexec.c | 91 ++++++++++++++++++++++++++++++-
> >  4 files changed, 109 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index fc0ed9d6e011..440abd0c0ee1 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1134,7 +1134,7 @@ config CRASH_DUMP
> >
> >  config TRANS_TABLE
> >       def_bool y
> > -     depends on HIBERNATION
> > +     depends on HIBERNATION || KEXEC_CORE
> >
> >  config XEN_DOM0
> >       def_bool y
> > diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> > index b96d8a6aac80..049cde429b1b 100644
> > --- a/arch/arm64/include/asm/kexec.h
> > +++ b/arch/arm64/include/asm/kexec.h
> > @@ -105,6 +105,12 @@ extern const char arm64_kexec_el2_vectors[];
> >   * el2_vector        If present means that relocation routine will go to EL1
> >   *           from EL2 to do the copy, and then back to EL2 to do the jump
> >   *           to new world.
> > + * trans_ttbr0       idmap for relocation function and its argument
> > + * trans_ttbr1       map for source/destination addresses.
> > + * trans_t0sz        t0sz for idmap page in trans_ttbr0
> > + * src_addr  start address for source pages.
> > + * dst_addr  start address for destination pages.
> > + * copy_len  Number of bytes that need to be copied
> >   */
> >  struct kern_reloc_arg {
> >       phys_addr_t head;
> > @@ -114,6 +120,12 @@ struct kern_reloc_arg {
> >       phys_addr_t kern_arg2;
> >       phys_addr_t kern_arg3;
> >       phys_addr_t el2_vector;
> > +     phys_addr_t trans_ttbr0;
> > +     phys_addr_t trans_ttbr1;
> > +     unsigned long trans_t0sz;
> > +     unsigned long src_addr;
> > +     unsigned long dst_addr;
> > +     unsigned long copy_len;
> >  };
> >
> >  #define ARCH_HAS_KIMAGE_ARCH
> > diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> > index 8a9475be1b62..06278611451d 100644
> > --- a/arch/arm64/kernel/asm-offsets.c
> > +++ b/arch/arm64/kernel/asm-offsets.c
> > @@ -160,6 +160,12 @@ int main(void)
> >    DEFINE(KEXEC_KRELOC_KERN_ARG2,     offsetof(struct kern_reloc_arg, kern_arg2));
> >    DEFINE(KEXEC_KRELOC_KERN_ARG3,     offsetof(struct kern_reloc_arg, kern_arg3));
> >    DEFINE(KEXEC_KRELOC_EL2_VECTOR,    offsetof(struct kern_reloc_arg, el2_vector));
> > +  DEFINE(KEXEC_KRELOC_TRANS_TTBR0,   offsetof(struct kern_reloc_arg, trans_ttbr0));
> > +  DEFINE(KEXEC_KRELOC_TRANS_TTBR1,   offsetof(struct kern_reloc_arg, trans_ttbr1));
> > +  DEFINE(KEXEC_KRELOC_TRANS_T0SZ,    offsetof(struct kern_reloc_arg, trans_t0sz));
> > +  DEFINE(KEXEC_KRELOC_SRC_ADDR,      offsetof(struct kern_reloc_arg, src_addr));
> > +  DEFINE(KEXEC_KRELOC_DST_ADDR,      offsetof(struct kern_reloc_arg, dst_addr));
> > +  DEFINE(KEXEC_KRELOC_COPY_LEN,      offsetof(struct kern_reloc_arg, copy_len));
> >  #endif
> >    return 0;
> >  }
> > diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> > index 41d1e3ca13f8..dc1b7e5a54fb 100644
> > --- a/arch/arm64/kernel/machine_kexec.c
> > +++ b/arch/arm64/kernel/machine_kexec.c
> > @@ -21,6 +21,7 @@
> >  #include <asm/mmu_context.h>
> >  #include <asm/page.h>
> >  #include <asm/sections.h>
> > +#include <asm/trans_pgd.h>
> >
> >  #include "cpu-reset.h"
> >
> > @@ -71,11 +72,91 @@ static void *kexec_page_alloc(void *arg)
> >       return page_address(page);
> >  }
> >
> > +/*
> > + * Map source segments starting from src_va, and map destination
> > + * segments starting from dst_va, and return size of copy in
> > + * *copy_len argument.
> > + * Relocation function essentially needs to do:
> > + * memcpy(dst_va, src_va, copy_len);
> > + */
> > +static int map_segments(struct kimage *kimage, pgd_t *pgdp,
> > +                     struct trans_pgd_info *info,
> > +                     unsigned long src_va,
> > +                     unsigned long dst_va,
> > +                     unsigned long *copy_len)
> > +{
> > +     unsigned long *ptr = 0;
> > +     unsigned long dest = 0;
> > +     unsigned long len = 0;
> > +     unsigned long entry, addr;
> > +     int rc;
> > +
> > +     for (entry = kimage->head; !(entry & IND_DONE); entry = *ptr++) {
> > +             addr = entry & PAGE_MASK;
> > +
> > +             switch (entry & IND_FLAGS) {
> > +             case IND_DESTINATION:
> > +                     dest = addr;
> > +                     break;
> > +             case IND_INDIRECTION:
> > +                     ptr = __va(addr);
> > +                     if (rc)
>
> We're checking a potentially uninitialized value here. I think this
> whole "if (rc) return rc;" conditional can go away.

Thank you Tyler. This is indeed not needed.

Pasha
