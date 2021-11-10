Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9327B44BF9A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhKJLEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 06:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbhKJLD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:03:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E50DC06120C
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=3QWgB4jgH1oOTnBTc67bHn9ZnzyC8lfbTd3CFqnLiv4=; b=fJeZnC/2p+39zc9XhEuKgzGZcB
        8kltMsayqURhUXbMWDvWMpM6qdE51LASa0zCLChrTNoPtbbYRMTAkNVw5T2kZY0SYPweC3nJ7u+Vu
        qPJSXG+aFui5hvpE9/80pmF68bBoirYjbfLQO/+C/b/UE+4gYCAhDcUFay+92gWT3gdEraCwwhHuK
        0xU4ezn/uoh/jAA+rdAJFW5zCSwJglwa5hnuZr0boHMrkx3KwpckHMSwGfljzsf5DXeRg5EnKw1yU
        IEYf6u1U3S6dyg40j/B2M7xytfox0Z3BG8GQviWoPgeYqYwNeFkKnBrXlc8LG905/jQZwUCKOWdRB
        GYR9vHDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mklLL-001ns0-QK; Wed, 10 Nov 2021 11:00:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CA7D830003C;
        Wed, 10 Nov 2021 12:00:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8D8F1210EC044; Wed, 10 Nov 2021 12:00:39 +0100 (CET)
Date:   Wed, 10 Nov 2021 12:00:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, seanjc@google.com,
        pbonzini@redhat.com, mbenes@suse.cz
Subject: Re: [PATCH v2 11/23] x86,xen: Remove .fixup usage
Message-ID: <YYumVx7qO3gY2tgD@hirez.programming.kicks-ass.net>
References: <20211110100102.250793167@infradead.org>
 <20211110101325.545019822@infradead.org>
 <42933d6b-c6f4-7420-1d0f-7f5d6ec17d8e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <42933d6b-c6f4-7420-1d0f-7f5d6ec17d8e@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 11:35:37AM +0100, Juergen Gross wrote:
> On 10.11.21 11:01, Peter Zijlstra wrote:
> > Employ the fancy new EX_TYPE_IMM_REG to store -EFAULT in the return
> > register and use this to remove some Xen .fixup usage.
> >=20
> > All callers of these functions only test for 0 return, so the actual
> > return value change from -1 to -EFAULT is immaterial.
> >=20
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >   arch/x86/include/asm/xen/page.h |   14 +++-----------
> >   1 file changed, 3 insertions(+), 11 deletions(-)
> >=20
> > --- a/arch/x86/include/asm/xen/page.h
> > +++ b/arch/x86/include/asm/xen/page.h
> > @@ -96,11 +96,7 @@ static inline int xen_safe_write_ulong(u
> >   	asm volatile("1: mov %[val], %[ptr]\n"
> >   		     "2:\n"
> > -		     ".section .fixup, \"ax\"\n"
> > -		     "3: sub $1, %[ret]\n"
> > -		     "   jmp 2b\n"
> > -		     ".previous\n"
> > -		     _ASM_EXTABLE(1b, 3b)
> > +		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG, %[ret])
> >   		     : [ret] "+r" (ret), [ptr] "=3Dm" (*addr)
> >   		     : [val] "r" (val));
> > @@ -110,16 +106,12 @@ static inline int xen_safe_write_ulong(u
> >   static inline int xen_safe_read_ulong(const unsigned long *addr,
> >   				      unsigned long *val)
> >   {
> > -	int ret =3D 0;
> >   	unsigned long rval =3D ~0ul;
> > +	int ret =3D 0;
>=20
> Spurious change.

Yeah, can't help myself, must be reverse xmas tree :-)

> >   	asm volatile("1: mov %[ptr], %[rval]\n"
> >   		     "2:\n"
> > -		     ".section .fixup, \"ax\"\n"
> > -		     "3: sub $1, %[ret]\n"
> > -		     "   jmp 2b\n"
> > -		     ".previous\n"
> > -		     _ASM_EXTABLE(1b, 3b)
> > +		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAUL_REG, %[ret])
>=20
> I guess you didn't compile that? There is a typo: s/EFAUL/EFAULT/

Damn.. I figure that must've gotten lost in the robot spam telling me
clang can't do __cold on labels :/
