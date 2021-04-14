Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F4735F9BD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350215AbhDNR0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:26:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:53260 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231475AbhDNR0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:26:02 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 13EHK42L023677;
        Wed, 14 Apr 2021 12:20:04 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 13EHK3HZ023672;
        Wed, 14 Apr 2021 12:20:03 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 14 Apr 2021 12:20:03 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v1 1/2] powerpc/bitops: Use immediate operand when possible
Message-ID: <20210414172003.GX26583@gate.crashing.org>
References: <09da6fec57792d6559d1ea64e00be9870b02dab4.1617896018.git.christophe.leroy@csgroup.eu> <20210412215428.GM26583@gate.crashing.org> <ecb1b1a5-ae92-e8a3-6490-26341edfbccb@csgroup.eu> <20210413215803.GT26583@gate.crashing.org> <1618365589.67fxh7cot9.astroid@bobo.none> <20210414122409.GV26583@gate.crashing.org> <daacce9f-1900-1034-980b-be5a58d6be09@csgroup.eu> <20210414151921.GW26583@gate.crashing.org> <efcabc9410cf4d03b203749a02e5a935@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efcabc9410cf4d03b203749a02e5a935@AcuMS.aculab.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 03:32:04PM +0000, David Laight wrote:
> From: Segher Boessenkool
> > Sent: 14 April 2021 16:19
> ...
> > > Could the kernel use GCC builtin atomic functions instead ?
> > >
> > > https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html
> > 
> > Certainly that should work fine for the simpler cases that the atomic
> > operations are meant to provide.  But esp. for not-so-simple cases the
> > kernel may require some behaviour provided by the existing assembler
> > implementation, and not by the atomic builtins.
> > 
> > I'm not saying this cannot work, just that some serious testing will be
> > needed.  If it works it should be the best of all worlds, so then it is
> > a really good idea yes :-)
> 
> I suspect they just add an extra layer of abstraction that makes it
> even more difficult to verify and could easily get broken by a compiler
> update (etc).

I would say it uses an existing facility, instead of creating a kernel-
specific one.

> The other issue is that the code needs to be correct with compiled
> with (for example) -O0.
> That could very easily break anything except the asm implementation
> if additional memory accesses and/or increased code size cause grief.

The compiler generates correct code.  New versions of the compiler or
old, -O0 or not, under any phase of the moon.

Of course sometimes the compiler is broken, but there are pre-existing
ways of dealing with that, and there is no reason at all to think this
would break more often than random other code.


Segher
