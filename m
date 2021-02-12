Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96D7319762
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 01:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhBLAVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 19:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhBLAUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 19:20:39 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5EFC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 16:19:58 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4DcDf40prGz9sVr; Fri, 12 Feb 2021 11:19:55 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>, msuchanek@suse.de,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <cover.1612796617.git.christophe.leroy@csgroup.eu>
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v5 00/22] powerpc/32: Implement C syscall entry/exit
Message-Id: <161308904681.3606979.5796787680805325099.b4-ty@ellerman.id.au>
Date:   Fri, 12 Feb 2021 11:19:55 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Feb 2021 15:10:19 +0000 (UTC), Christophe Leroy wrote:
> This series implements C syscall entry/exit for PPC32. It reuses
> the work already done for PPC64.
> 
> This series is based on today's merge-test (b6f72fc05389e3fc694bf5a5fa1bbd33f61879e0)
> 
> In terms on performance we have the following number of cycles on an
> 8xx running null_syscall benchmark:
> - mainline: 296 cycles
> - after patch 4: 283 cycles
> - after patch 16: 304 cycles
> - after patch 17: 348 cycles
> - at the end of the series: 320 cycles
> 
> [...]

Patches 1-15 and 21 applied to powerpc/next.

[01/22] powerpc/32s: Add missing call to kuep_lock on syscall entry
        https://git.kernel.org/powerpc/c/57fdfbce89137ae85cd5cef48be168040a47dd13
[02/22] powerpc/32: Always enable data translation on syscall entry
        https://git.kernel.org/powerpc/c/eca2411040c1ee15b8882c6427fb4eb5a48ada69
[03/22] powerpc/32: On syscall entry, enable instruction translation at the same time as data
        https://git.kernel.org/powerpc/c/76249ddc27080b6b835a89cedcc4185b3b5a6b23
[04/22] powerpc/32: Reorder instructions to avoid using CTR in syscall entry
        https://git.kernel.org/powerpc/c/2c59e5104821c5720e88bafa9e522f8bea9ce8fa
[05/22] powerpc/irq: Add helper to set regs->softe
        https://git.kernel.org/powerpc/c/fb5608fd117a8b48752d2b5a7e70847c1ed33d33
[06/22] powerpc/irq: Rework helpers that manipulate MSR[EE/RI]
        https://git.kernel.org/powerpc/c/08353779f2889305f64e04de3e46ed59ed60f859
[07/22] powerpc/irq: Add stub irq_soft_mask_return() for PPC32
        https://git.kernel.org/powerpc/c/6650c4782d5788346a25a4f698880d124f2699a0
[08/22] powerpc/syscall: Rename syscall_64.c into interrupt.c
        https://git.kernel.org/powerpc/c/ab1a517d55b01b54ba70f5d54f926f5ab4b18339
[09/22] powerpc/syscall: Make interrupt.c buildable on PPC32
        https://git.kernel.org/powerpc/c/344bb20b159dd0996e521c0d4c131a6ae10c322a
[10/22] powerpc/syscall: Use is_compat_task()
        https://git.kernel.org/powerpc/c/72b7a9e56b25babfe4c90bf3ce88285c7fb62ab9
[11/22] powerpc/syscall: Save r3 in regs->orig_r3
        https://git.kernel.org/powerpc/c/8875f47b7681aa4e4484a9b612577b044725f839
[12/22] powerpc/syscall: Change condition to check MSR_RI
        https://git.kernel.org/powerpc/c/c01b916658150e98f00a4981750c37a3224c8735
[13/22] powerpc/32: Always save non volatile GPRs at syscall entry
        https://git.kernel.org/powerpc/c/fbcee2ebe8edbb6a93316f0a189ae7fcfaa7094f
[14/22] powerpc/syscall: implement system call entry/exit logic in C for PPC32
        https://git.kernel.org/powerpc/c/6f76a01173ccaa363739f913394d4e138d92d718
[15/22] powerpc/32: Remove verification of MSR_PR on syscall in the ASM entry
        https://git.kernel.org/powerpc/c/4d67facbcbdb3d9e3c9cb82e4ec47fc63d298dd8
[21/22] powerpc/32: Remove the counter in global_dbcr0
        https://git.kernel.org/powerpc/c/eb595eca74067b78d36fb188b555e30f28686fc7

cheers
