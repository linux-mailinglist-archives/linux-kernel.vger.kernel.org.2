Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D55C42C6CC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 18:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhJMQy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbhJMQyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:54:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AB0C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 09:52:17 -0700 (PDT)
Received: from zn.tnic (p200300ec2f12080010afaa72f664282d.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:800:10af:aa72:f664:282d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 664261EC04DA;
        Wed, 13 Oct 2021 18:52:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634143935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CYlq4Z0CU11JO4DMc/n1FjuHCLMGi6LgIMUI7lxn0oc=;
        b=j0kfytO5dmQbgQuWDsVJr0CSNetLm0YY+pBrCLp1lqPlr3M5v1mXEW4im2rMplWnxa0qg9
        39CzJhCGicwjQ8/pGCcciP87g4teZ1AnhFcRS+jxZ7+21sw/4eUwoSdW9TBiyb1AJTvu+M
        X3X1Rjy/fT9xTpCZULV7jmDniKAig2Y=
Date:   Wed, 13 Oct 2021 18:52:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Michael Matz <matz@suse.de>,
        Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
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
Message-ID: <YWcOvmXkSiecGkER@zn.tnic>
References: <YWXwQ2P0M0uzHo0o@zn.tnic>
 <20211012222311.578581-1-ammar.faizi@students.amikom.ac.id>
 <YWbUbSUVLy/tx7Zu@zn.tnic>
 <20211013125142.GD5485@1wt.eu>
 <YWbZz7gHBV18QJC3@zn.tnic>
 <20211013140723.GE5485@1wt.eu>
 <YWbrR1BqI1CxneN/@zn.tnic>
 <20211013142433.GB8557@1wt.eu>
 <alpine.LSU.2.20.2110131601000.26294@wotan.suse.de>
 <20211013163023.GD8557@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211013163023.GD8557@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 06:30:23PM +0200, Willy Tarreau wrote:
> Hello Michael,
> 
> On Wed, Oct 13, 2021 at 04:24:28PM +0000, Michael Matz wrote:
> (...)
> > In short:  Ammars initial claim:
> > 
> > > Linux x86-64 syscall only clobbers rax, rcx and r11 (and "memory").
> > > 
> > >   - rax for the return value.
> > >   - rcx to save the return address.
> > >   - r11 to save the rflags.
> > > 
> > > Other registers are preserved.
> > 
> > is accurate and I will clarify the psABI to make that explicit.
> 
> Many thanks for this very detailed explanation! Ammar, I'll take your
> patch.

Great, why are we dealing with some funky document when the law is in
glibc sources?!

:-)))

Ammar, if you wanna fixup the comment in entry_64.S too - make sure you
explain that glibc expects argument registers to be restored - I'll take
that patch too.

:-)

Thx, that was fun.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
