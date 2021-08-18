Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA353F0799
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 17:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbhHRPOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 11:14:08 -0400
Received: from gate.crashing.org ([63.228.1.57]:33052 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239042AbhHRPOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 11:14:04 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 17IF6smb011664;
        Wed, 18 Aug 2021 10:06:54 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 17IF6ric011660;
        Wed, 18 Aug 2021 10:06:53 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 18 Aug 2021 10:06:53 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] powerpc/bug: Remove specific powerpc BUG_ON() and WARN_ON() on PPC32
Message-ID: <20210818150653.GJ1583@gate.crashing.org>
References: <b286e07fb771a664b631cd07a40b09c06f26e64b.1618331881.git.christophe.leroy@csgroup.eu> <1628834356.pr4zgn1xf1.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628834356.pr4zgn1xf1.astroid@bobo.none>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 04:08:13PM +1000, Nicholas Piggin wrote:
> This one possibly the branches end up in predictors, whereas conditional 
> trap is always just speculated not to hit. Branches may also have a
> throughput limit on execution whereas trap could be more (1 per cycle
> vs 4 per cycle on POWER9).

I thought only *taken* branches are just one per cycle?  And those
branches are only taken for the exceptional condition (or the case where
we do not care about performance, anyway, if we do have an error most of
the time ;-) )

> On typical ppc32 CPUs, maybe it's a more obvious win. As you say there
> is the CFAR issue as well which makes it a problem for 64s. It would
> have been nice if it could use the same code though.

On 64-bit the code looks better for the no-error path as well.

> Maybe one day gcc's __builtin_trap() will become smart enough around
> conditional statements that it it generates better code and tries to
> avoid branches.

Internally *all* traps are conditional, in GCC.  It also can optimise
them quite well.  There must be something in the kernel macros that
prevents good optimisation.


Segher
