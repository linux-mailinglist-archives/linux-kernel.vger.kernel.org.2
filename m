Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C883436458C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 16:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239128AbhDSOCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 10:02:10 -0400
Received: from gate.crashing.org ([63.228.1.57]:50295 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230021AbhDSOCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 10:02:09 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 13JDvFjo030774;
        Mon, 19 Apr 2021 08:57:15 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 13JDvEBR030773;
        Mon, 19 Apr 2021 08:57:14 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 19 Apr 2021 08:57:14 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc: add ALTIVEC support to lib/ when PPC_FPU not set
Message-ID: <20210419135714.GS26583@gate.crashing.org>
References: <20210418201726.32130-1-rdunlap@infradead.org> <20210418201726.32130-2-rdunlap@infradead.org> <20210419133209.GR26583@gate.crashing.org> <4f5aea37-f638-3fde-0680-ec456ad91141@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f5aea37-f638-3fde-0680-ec456ad91141@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 03:38:02PM +0200, Christophe Leroy wrote:
> Le 19/04/2021 à 15:32, Segher Boessenkool a écrit :
> >On Sun, Apr 18, 2021 at 01:17:26PM -0700, Randy Dunlap wrote:
> >>Add ldstfp.o to the Makefile for CONFIG_ALTIVEC and add
> >>externs for get_vr() and put_vr() in lib/sstep.c to fix the
> >>build errors.
> >
> >>  obj-$(CONFIG_PPC_FPU)	+= ldstfp.o
> >>+obj-$(CONFIG_ALTIVEC)	+= ldstfp.o
> >
> >It is probably a good idea to split ldstfp.S into two, one for each of
> >the two configuration options?
> >
> 
> Or we can build it all the time and #ifdef the FPU part.
> 
> Because it contains FPU, ALTIVEC and VSX stuff.

So it becomes an empty object file if none of the options are selected?
Good idea :-)


Segher
