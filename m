Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C42442AF51
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 23:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbhJLVxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 17:53:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58340 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232272AbhJLVxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 17:53:44 -0400
Received: from zn.tnic (p200300ec2f194200461a217ceec11f7e.dip0.t-ipconnect.de [IPv6:2003:ec:2f19:4200:461a:217c:eec1:1f7e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 13B7B1EC0505;
        Tue, 12 Oct 2021 23:51:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634075501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XM25eiTujrxCX9qfazoWzC0pUkPyy/TH0HHL9FWK9DE=;
        b=luIAz9DxEX6T4PUHVVM5wAmM4XwZPaWGtzUf76Cc66bgrG4eHqLyjTFryKOpgpfs0UZ6Z5
        0ALwOrX5VODboOni3OlhD/S7/ie6dCisHPW0ejU3OFOGnN1ZQU9uay6VQzTUQF6GzCXwH3
        dwKNK/GZi8Wh5v6t0Q3uyfwfF/xoK1A=
Date:   Tue, 12 Oct 2021 23:51:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the
 clobber list
Message-ID: <YWYDal8HL3n5/qTr@zn.tnic>
References: <20211012052822.GA28951@1wt.eu>
 <20211012083644.543775-1-ammarfaizi2@gmail.com>
 <20211012090638.GD28951@1wt.eu>
 <YWXwQ2P0M0uzHo0o@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWXwQ2P0M0uzHo0o@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 10:29:55PM +0200, Borislav Petkov wrote:
> On Tue, Oct 12, 2021 at 11:06:38AM +0200, Willy Tarreau wrote:
> > Let's indeed wait for any of the x86 maintainers to confirm your
> > analysis.
> 
> I guess the official doc you guys are looking for is the x86-64 ABI:
> 
> https://gitlab.com/x86-psABIs/x86-64-ABI/
> 
> and recent pdfs are here:
> 
> https://gitlab.com/x86-psABIs/x86-64-ABI/-/wikis/x86-64-psABI
> 
> and there you scroll to
> 
> "A.2 AMD64 Linux Kernel Conventions
> 
> ...
> 
> A.2.1 Calling Conventions"
> 
> and that section explains which regs go where.

Ok, that didn't point to the exact answer - I realize now. I believe
what you're looking for in that doc is "Figure 3.4: Register Usage"
which has a column "callee saved" and says that the syscall arg
registers are all not callee-saved.

And I think that table is valid for the kernel too because the link
to it says "The Linux AMD64 kernel uses internally the same calling
conventions as user-level applications (see section 3.2.3 for details)."

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
