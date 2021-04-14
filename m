Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE36A35F78B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 17:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbhDNPZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:25:11 -0400
Received: from gate.crashing.org ([63.228.1.57]:38657 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232358AbhDNPZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:25:05 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 13EFJM4R012182;
        Wed, 14 Apr 2021 10:19:22 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 13EFJLFh012181;
        Wed, 14 Apr 2021 10:19:21 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 14 Apr 2021 10:19:21 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v1 1/2] powerpc/bitops: Use immediate operand when possible
Message-ID: <20210414151921.GW26583@gate.crashing.org>
References: <09da6fec57792d6559d1ea64e00be9870b02dab4.1617896018.git.christophe.leroy@csgroup.eu> <20210412215428.GM26583@gate.crashing.org> <ecb1b1a5-ae92-e8a3-6490-26341edfbccb@csgroup.eu> <20210413215803.GT26583@gate.crashing.org> <1618365589.67fxh7cot9.astroid@bobo.none> <20210414122409.GV26583@gate.crashing.org> <daacce9f-1900-1034-980b-be5a58d6be09@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <daacce9f-1900-1034-980b-be5a58d6be09@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 02:42:51PM +0200, Christophe Leroy wrote:
> Le 14/04/2021 à 14:24, Segher Boessenkool a écrit :
> >On Wed, Apr 14, 2021 at 12:01:21PM +1000, Nicholas Piggin wrote:
> >>Would be nice if we could let the compiler deal with it all...
> >>
> >>static inline unsigned long lr(unsigned long *mem)
> >>{
> >>         unsigned long val;
> >>
> >>         /*
> >>          * This doesn't clobber memory but want to avoid memory 
> >>          operations
> >>          * moving ahead of it
> >>          */
> >>         asm volatile("ldarx     %0, %y1" : "=r"(val) : "Z"(*mem) : 
> >>         "memory");
> >>
> >>         return val;
> >>}
> >
> >(etc.)
> >
> >That can not work reliably: the compiler can put random instructions
> >between the larx and stcx. this way, and you then do not have guaranteed
> >forward progress anymore.  It can put the two in different routines
> >(after inlining and other interprocedural optimisations), duplicate
> >them, make a different number of copies of them, etc.
> >
> >Nothing of that is okay if you want to guarantee forward progress on all
> >implementations, and also not if you want to have good performance
> >everywhere (or anywhere even).  Unfortunately you have to write all
> >larx/stcx. loops as one block of assembler, so that you know exactly
> >what instructions will end up in your binary.
> >
> >If you don't, it will fail mysteriously after random recompilations, or
> >have performance degradations, etc.  You don't want to go there :-)
> >
> 
> Could the kernel use GCC builtin atomic functions instead ?
> 
> https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html

Certainly that should work fine for the simpler cases that the atomic
operations are meant to provide.  But esp. for not-so-simple cases the
kernel may require some behaviour provided by the existing assembler
implementation, and not by the atomic builtins.

I'm not saying this cannot work, just that some serious testing will be
needed.  If it works it should be the best of all worlds, so then it is
a really good idea yes :-)


Segher
