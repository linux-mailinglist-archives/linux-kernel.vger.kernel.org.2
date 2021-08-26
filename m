Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861653F896A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 15:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242730AbhHZNzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 09:55:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:35066 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229793AbhHZNzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:55:20 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 17QDlx1Q018576;
        Thu, 26 Aug 2021 08:47:59 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 17QDlwDa018574;
        Thu, 26 Aug 2021 08:47:58 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 26 Aug 2021 08:47:58 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] powerpc/bug: Provide better flexibility to WARN_ON/__WARN_FLAGS() with asm goto
Message-ID: <20210826134758.GZ1583@gate.crashing.org>
References: <b286e07fb771a664b631cd07a40b09c06f26e64b.1618331881.git.christophe.leroy@csgroup.eu> <389962b1b702e3c78d169e59bcfac56282889173.1618331882.git.christophe.leroy@csgroup.eu> <YSa1O4fcX1nNKqN/@Ryzen-9-3900X.localdomain> <87h7fcc2m4.fsf@mpe.ellerman.id.au> <3fad8702-278a-d9f9-1882-6958ce570bcc@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fad8702-278a-d9f9-1882-6958ce570bcc@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 08:37:09AM +0200, Christophe Leroy wrote:
> Le 26/08/2021 à 05:21, Michael Ellerman a écrit :
> >This patch seems to fix it. Not sure if that's just papering over it 
> >though.
> >
> >diff --git a/arch/powerpc/include/asm/bug.h 
> >b/arch/powerpc/include/asm/bug.h
> >index 1ee0f22313ee..75fcb4370d96 100644
> >--- a/arch/powerpc/include/asm/bug.h
> >+++ b/arch/powerpc/include/asm/bug.h
> >@@ -119,7 +119,7 @@ __label_warn_on:					 \
> >  								\
> >  			WARN_ENTRY(PPC_TLNEI " %4, 0",		\
> >  				   BUGFLAG_WARNING | 
> >  				   BUGFLAG_TAINT(TAINT_WARN),	\
> >-				   __label_warn_on, "r" (x));	\
> >+				   __label_warn_on, "r" (!!(x))); \
> >  			break;					\
> >  __label_warn_on:						\
> >  			__ret_warn_on = true;			\
> 
> But for a simple WARN_ON() call:
> 
> void test(unsigned long b)
> {
> 	WARN_ON(b);
> }
> 
> Without your change with GCC you get:
> 
> 00000000000012d0 <.test>:
>     12d0:	0b 03 00 00 	tdnei   r3,0
>     12d4:	4e 80 00 20 	blr
> 
> 
> With the !! change you get:
> 
> 00000000000012d0 <.test>:
>     12d0:	31 23 ff ff 	addic   r9,r3,-1
>     12d4:	7d 29 19 10 	subfe   r9,r9,r3
>     12d8:	0b 09 00 00 	tdnei   r9,0
>     12dc:	4e 80 00 20 	blr

That is because the asm (unlike the builtin) cannot be optimised by the
compiler.


Segher
