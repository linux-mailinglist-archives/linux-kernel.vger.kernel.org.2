Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9D7318D90
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 15:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhBKOoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 09:44:00 -0500
Received: from gate.crashing.org ([63.228.1.57]:53778 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230071AbhBKOij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 09:38:39 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 11BEUxQ2020284;
        Thu, 11 Feb 2021 08:30:59 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 11BEUxVp020283;
        Thu, 11 Feb 2021 08:30:59 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 11 Feb 2021 08:30:59 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/bug: Remove specific powerpc BUG_ON()
Message-ID: <20210211143059.GE28121@gate.crashing.org>
References: <694c7195c81d1bcc781b3c14f452886683d6c524.1613029237.git.christophe.leroy@csgroup.eu> <20210211114910.GA28121@gate.crashing.org> <6126ca14-419a-9e15-7ffa-b295f26a552e@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6126ca14-419a-9e15-7ffa-b295f26a552e@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 03:09:43PM +0100, Christophe Leroy wrote:
> Le 11/02/2021 � 12:49, Segher Boessenkool a �crit�:
> >On Thu, Feb 11, 2021 at 07:41:52AM +0000, Christophe Leroy wrote:
> >>powerpc BUG_ON() is based on using twnei or tdnei instruction,
> >>which obliges gcc to format the condition into a 0 or 1 value
> >>in a register.
> >
> >Huh?  Why is that?
> >
> >Will it work better if this used __builtin_trap?  Or does the kernel only
> >detect very specific forms of trap instructions?
> 
> We already made a try with __builtin_trap() 1,5 year ago, see 
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20510ce03cc9463f1c9e743c1d93b939de501b53.1566219503.git.christophe.leroy@c-s.fr/
> 
> The main problems encountered are:
> - It is only possible to use it for BUG_ON, not for WARN_ON because GCC 
> considers it as noreturn. Is there any workaround ?

A trap is noreturn by definition:

 -- Built-in Function: void __builtin_trap (void)
     This function causes the program to exit abnormally.

> - The kernel (With CONFIG_DEBUG_BUGVERBOSE) needs to be able to identify 
> the source file and line corresponding to the trap. How can that be done 
> with __builtin_trap() ?

The DWARF debug info should be sufficient.  Perhaps you can post-process
some way?

You can create a trap that falls through yourself (by having a trap-on
condition with a condition that is always true, but make the compiler
not see that).  This isn't efficient though.

Could you file a feature request (in bugzilla)?  It is probably useful
for generic code as well, but we could implement this for powerpc only
if needed.


Segher
