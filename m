Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D8837ECD2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380350AbhELUBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:01:07 -0400
Received: from gate.crashing.org ([63.228.1.57]:41948 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355206AbhELS1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 14:27:43 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 14CIL4bD009429;
        Wed, 12 May 2021 13:21:04 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 14CIL4PD009428;
        Wed, 12 May 2021 13:21:04 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 12 May 2021 13:21:03 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Force inlining of csum_add()
Message-ID: <20210512182103.GX10366@gate.crashing.org>
References: <f7f4d4e364de6e473da874468b903da6e5d97adc.1620713272.git.christophe.leroy@csgroup.eu> <20210511105154.GJ10366@gate.crashing.org> <e996ef13-c25c-5e9c-edd2-444eded88802@csgroup.eu> <20210512143105.GW10366@gate.crashing.org> <2623fe98-7a73-f7a2-bcba-2d668d00ffd0@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2623fe98-7a73-f7a2-bcba-2d668d00ffd0@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 04:43:33PM +0200, Christophe Leroy wrote:
> Le 12/05/2021 à 16:31, Segher Boessenkool a écrit :
> >On Wed, May 12, 2021 at 02:56:56PM +0200, Christophe Leroy wrote:
> >>Le 11/05/2021 à 12:51, Segher Boessenkool a écrit :
> >>>Something seems to have decided this asm is more expensive than it is.
> >>>That isn't always avoidable -- the compiler cannot look inside asms --
> >>>but it seems it could be improved here.
> >>>
> >>>Do you have (or can make) a self-contained testcase?
> >>
> >>I have not tried, and I fear it might be difficult, because on a kernel
> >>build with dozens of calls to csum_add(), only ip6_tunnel.o exhibits such
> >>an issue.
> >
> >Yeah.  Sometimes you can force some of the decisions, but that usually
> >requires knowing too many GCC internals :-/
> >
> >>>>And there is even one completely unused instance of csum_add().
> >>>
> >>>That is strange, that should never happen.
> >>
> >>It seems that several .o include unused versions of csum_add. After the
> >>final link, one remains (in addition to the used one) in vmlinux.
> >
> >But it is a static function, so it should not end up in any object file
> >where it isn't used.
> 
> Well .... did I dream ?
> 
> Now I only find one extra .o with unused csum_add() : That's 
> net/ipv6/exthdrs.o
> It matches the one found in vmlinux.
> 
> Are you interested in -fdump-tree-einline-all for that one as well ?

Sure.  Hopefully it will show more :-)


Segher
