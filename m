Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDD43BCAF8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 12:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhGFKzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 06:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhGFKzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 06:55:23 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E40C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 03:52:45 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GJzsk2R2hz9sWl; Tue,  6 Jul 2021 20:52:42 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     npiggin@gmail.com, Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <024bb05105050f704743a0083fe3548702be5706.1625138205.git.christophe.leroy@csgroup.eu>
References: <024bb05105050f704743a0083fe3548702be5706.1625138205.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/mm: Fix lockup on kernel exec fault
Message-Id: <162556873360.460578.10834762081536677498.b4-ty@ellerman.id.au>
Date:   Tue, 06 Jul 2021 20:52:13 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jul 2021 11:17:08 +0000 (UTC), Christophe Leroy wrote:
> The powerpc kernel is not prepared to handle exec faults from kernel.
> Especially, the function is_exec_fault() will return 'false' when an
> exec fault is taken by kernel, because the check is based on reading
> current->thread.regs->trap which contains the trap from user.
> 
> For instance, when provoking a LKDTM EXEC_USERSPACE test,
> current->thread.regs->trap is set to SYSCALL trap (0xc00), and
> the fault taken by the kernel is not seen as an exec fault by
> set_access_flags_filter().
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/mm: Fix lockup on kernel exec fault
      https://git.kernel.org/powerpc/c/cd5d5e602f502895e47e18cd46804d6d7014e65c

cheers
