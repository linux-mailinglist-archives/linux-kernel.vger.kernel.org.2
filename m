Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFCA3F50C9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 20:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhHWSxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 14:53:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:34788 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229883AbhHWSxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 14:53:11 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 17NIktDE030226;
        Mon, 23 Aug 2021 13:46:55 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 17NIksWh030223;
        Mon, 23 Aug 2021 13:46:54 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 23 Aug 2021 13:46:48 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32: Don't use lmw/stmw for saving/restoring non volatile regs
Message-ID: <20210823184648.GY1583@gate.crashing.org>
References: <316c543b8906712c108985c8463eec09c8db577b.1629732542.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <316c543b8906712c108985c8463eec09c8db577b.1629732542.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 03:29:12PM +0000, Christophe Leroy wrote:
> Instructions lmw/stmw are interesting for functions that are rarely
> used and not in the cache, because only one instruction is to be
> copied into the instruction cache instead of 19. However those
> instruction are less performant than 19x raw lwz/stw as they require
> synchronisation plus one additional cycle.

lmw takes N+2 cycles for loading N words on 603/604/750/7400, and N+3 on
7450.  stmw takes N+1 cycles for storing N words on 603, N+2 on 604/750/
7400, and N+3 on 7450 (load latency is 3 instead of 2 on 7450).

There is no synchronisation needed, although there is some serialisation,
which of course doesn't mean much since there can be only 6 or 8 or so
insns executing at once anyway.

So, these insns are almost never slower, they can easily win cycles back
because of the smaller code, too.

What 32-bit core do you see where load/store multiple are more than a
fraction of a cycle (per memory access) slower?

> SAVE_NVGPRS / REST_NVGPRS are used in only a few places which are
> mostly in interrupts entries/exits and in task switch so they are
> likely already in the cache.

Nothing is likely in the cache on the older cores (except in
microbenchmarks), the caches are not big enough for that!

> Using standard lwz improves null_syscall selftest by:
> - 10 cycles on mpc832x.
> - 2 cycles on mpc8xx.

And in real benchmarks?

On mpccore both lmw and stmw are only N+1 btw.  But the serialization
might cost another cycle here?


Segher
