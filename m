Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281B733CA2E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 00:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhCOXxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 19:53:43 -0400
Received: from gate.crashing.org ([63.228.1.57]:44877 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232029AbhCOXxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 19:53:14 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 12FNlGwa003537;
        Mon, 15 Mar 2021 18:47:16 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 12FNlEh4003533;
        Mon, 15 Mar 2021 18:47:14 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 15 Mar 2021 18:47:14 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/vdso32: Add missing _restgpr_31_x to fix build failure
Message-ID: <20210315234714.GC16691@gate.crashing.org>
References: <a7aa198a88bcd33c6e35e99f70f86c7b7f2f9440.1615270757.git.christophe.leroy@csgroup.eu> <20210312022940.GO29191@gate.crashing.org> <023afd0c-dc61-5891-5145-5bcdce8227be@prevas.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <023afd0c-dc61-5891-5145-5bcdce8227be@prevas.dk>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 05:23:44PM +0100, Rasmus Villemoes wrote:
> On 12/03/2021 03.29, Segher Boessenkool wrote:
> > On Tue, Mar 09, 2021 at 06:19:30AM +0000, Christophe Leroy wrote:
> >> With some defconfig including CONFIG_CC_OPTIMIZE_FOR_SIZE,
> >> (for instance mvme5100_defconfig and ps3_defconfig), gcc 5
> >> generates a call to _restgpr_31_x.
> > 
> >> I don't know if there is a way to tell GCC not to emit that call, because at the end we get more instructions than needed.
> > 
> > The function is required by the ABI, you need to have it.
> > 
> > You get *fewer* insns statically, and that is what -Os is about: reduce
> > the size of the binaries.
> 
> Is there any reason to not just always build the vdso with -O2? It's one
> page/one VMA either way, and the vdso is about making certain system
> calls cheaper, so if unconditional -O2 could save a few cycles compared
> to -Os, why not? (And if, as it seems, there's only one user within the
> DSO of _restgpr_31_x, yes, the overall size of the .text segment
> probably increases slightly).

You can use exactly the same reasoning for using -O2 instead of -Os
anywhere else.

-Os doesn't mean "smaller code, but only where that is reasonable".  It
means "smaller code".


Segher
