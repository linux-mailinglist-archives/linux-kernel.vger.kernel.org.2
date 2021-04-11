Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1277035B290
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 11:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhDKJLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 05:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhDKJLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 05:11:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA99C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 02:11:02 -0700 (PDT)
Received: from zn.tnic (p200300ec2f23de002e7d52dd33d8f804.dip0.t-ipconnect.de [IPv6:2003:ec:2f23:de00:2e7d:52dd:33d8:f804])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AC62B1EC0283;
        Sun, 11 Apr 2021 11:10:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618132253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=svSF31M3oFbZ9V2FDwXhbROkIW9AJXBuhafMKygyAlw=;
        b=RXfiXJEljQJLnEqDEBoroE8a3v1TrOc/tARoBVtgFB6fYxpjjEwYYPGtFWqwJKFgbCJo/g
        hjneJm0UyT0XTnmKdJ4HfTuJj8187MAjDKq9SbX5Q6V9HjGcb2TK6ATpCjTeZEwstcljJm
        0IE1kir7YSJY0EJ2I0/HZ8ARmrMpOc4=
Date:   Sun, 11 Apr 2021 11:10:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jan Kiszka <jan.kiszka@web.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86 <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86: pat: Do not compile stubbed functions when
 X86_PAT is off
Message-ID: <20210411091056.GA14022@zn.tnic>
References: <198c94a8-12ea-88e7-6f08-b3456473e5c3@siemens.com>
 <87r1z6xxh5.fsf@nanos.tec.linutronix.de>
 <a2788ff7-c524-52de-3f45-82613410f872@siemens.com>
 <a9351615-7a0d-9d47-af65-d9e2fffe8192@siemens.com>
 <802cefc7-b475-c6d6-ece7-8232d7f3891d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <802cefc7-b475-c6d6-ece7-8232d7f3891d@web.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 10:22:19AM +0200, Jan Kiszka wrote:
> On 26.10.20 18:39, Jan Kiszka wrote:
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> >
> > Those are already provided by linux/io.h as stubs.
> >
> > The conflict remains invisible until someone would pull linux/io.h into
> > memtype.c.
> >
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> >
> > Change in v2:
> >  - correct commit message
> >
> >  arch/x86/mm/pat/memtype.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> > index 8f665c352bf0..41a4ac585af3 100644
> > --- a/arch/x86/mm/pat/memtype.c
> > +++ b/arch/x86/mm/pat/memtype.c
> > @@ -800,6 +800,7 @@ void memtype_free_io(resource_size_t start, resource_size_t end)
> >  	memtype_free(start, end);
> >  }
> >
> > +#ifdef CONFIG_X86_PAT
> >  int arch_io_reserve_memtype_wc(resource_size_t start, resource_size_t size)
> >  {
> >  	enum page_cache_mode type = _PAGE_CACHE_MODE_WC;
> > @@ -813,6 +814,7 @@ void arch_io_free_memtype_wc(resource_size_t start, resource_size_t size)
> >  	memtype_free_io(start, start + size);
> >  }
> >  EXPORT_SYMBOL(arch_io_free_memtype_wc);
> > +#endif
> >
> >  pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
> >  				unsigned long size, pgprot_t vma_prot)
> >
> 
> What happened to this?

What is this patch and your other asm/proto.h thing fixing?

Looks like you're using kernel headers in something else and don't want
to include the whole world thus those fixes... so that you can include
upstream kernel headers without having to touch them...

Or am I way off base here?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
