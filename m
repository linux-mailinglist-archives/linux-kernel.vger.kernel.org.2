Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850013F51F0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 22:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhHWUSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 16:18:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:60137 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232165AbhHWUSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 16:18:48 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 17NKCUqC005302;
        Mon, 23 Aug 2021 15:12:30 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 17NKCOGl005277;
        Mon, 23 Aug 2021 15:12:24 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 23 Aug 2021 15:12:19 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/booke: Avoid link stack corruption in several places
Message-ID: <20210823201219.GZ1583@gate.crashing.org>
References: <d7435e616336fd5f07bb19ec61e97d71e5c53568.1629705153.git.christophe.leroy@csgroup.eu> <20210823155837.GX1583@gate.crashing.org> <67a5be3f-a443-03eb-aa8e-a1fa6c0b3d3f@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67a5be3f-a443-03eb-aa8e-a1fa6c0b3d3f@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 07:05:38PM +0200, Christophe Leroy wrote:
> Le 23/08/2021 à 17:58, Segher Boessenkool a écrit :
> >On Mon, Aug 23, 2021 at 07:53:01AM +0000, Christophe Leroy wrote:
> >>  /* Be careful, this will clobber the lr register. */
> >>  #define LOAD_REG_ADDR_PIC(reg, name)		\
> >>-	bl	0f;				\
> >>+	bcl	20,31,0f			\
> >>  0:	mflr	reg;				\
> >>  	addis	reg,reg,(name - 0b)@ha;		\
> >>  	addi	reg,reg,(name - 0b)@l;
> >
> >The code ended each line with a semicolon before, for absolutely no
> >reason that I can see, but still.  Fixing that would be nice, but only
> >doing it on one line isn't good.
> 
> Sure, forgetting the semicolon broke the build. That's because the 
> backslash removes the newline.

Ah right, one of the surprises you get from using the C preprocessor on
non-C code :-)

> The cleanest way I found to fix that quite of stuff is by using GAS macro, 
> as I did for LOAD_REG_IMMEDIATE() some time ago.

Yeah, good plan.  You can use loops and saner parameters etc. as well if
you do :-)

> >Btw.  Both the 7450 and the modern cores implementing this really need
> >this to be $+4, so it is a lot clearer to write that instead of 1f or
> >a named label.
> 
> I like that, removing unneeded labels will make it smoother and clearer. 
> I'll do it.

Cool, thanks!


Segher
