Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326013EB4ED
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 13:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240000AbhHML7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 07:59:34 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59615 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239468AbhHML71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 07:59:27 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GmMXg4qVCz9t23; Fri, 13 Aug 2021 21:58:59 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        fthain@linux-m68k.org, npiggin@gmail.com,
        Michael Ellerman <mpe@ellerman.id.au>, userm57@yahoo.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <c17d234f4927d39a1d7100864a8e1145323d33a0.1628611927.git.christophe.leroy@csgroup.eu>
References: <c17d234f4927d39a1d7100864a8e1145323d33a0.1628611927.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/interrupt: Fix OOPS by not calling do_IRQ() from timer_interrupt()
Message-Id: <162885586792.2317031.17954514979013171970.b4-ty@ellerman.id.au>
Date:   Fri, 13 Aug 2021 21:57:47 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2021 16:13:16 +0000 (UTC), Christophe Leroy wrote:
> An interrupt handler shall not be called from another interrupt
> handler otherwise this leads to problems like the following:
> 
> 	Kernel attempted to write user page (afd4fa84) - exploit attempt? (uid: 1000)
> 	------------[ cut here ]------------
> 	Bug: Write fault blocked by KUAP!
> 	WARNING: CPU: 0 PID: 1617 at arch/powerpc/mm/fault.c:230 do_page_fault+0x484/0x720
> 	Modules linked in:
> 	CPU: 0 PID: 1617 Comm: sshd Tainted: G        W         5.13.0-pmac-00010-g8393422eb77 #7
> 	NIP:  c001b77c LR: c001b77c CTR: 00000000
> 	REGS: cb9e5bc0 TRAP: 0700   Tainted: G        W          (5.13.0-pmac-00010-g8393422eb77)
> 	MSR:  00021032 <ME,IR,DR,RI>  CR: 24942424  XER: 00000000
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/interrupt: Fix OOPS by not calling do_IRQ() from timer_interrupt()
      https://git.kernel.org/powerpc/c/98694166c27d473c36b434bd3572934c2f2a16ab

cheers
