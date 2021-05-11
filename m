Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AB5379BBE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhEKA5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:57:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36855 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhEKA5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:57:07 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14B0tdw52504247
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 10 May 2021 17:55:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14B0tdw52504247
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620694548;
        bh=PsaMrDdeQP2GL36tY1Dj8HmhYQv+StDmnRKbgmNYjWU=;
        h=From:To:Cc:Subject:Date:From;
        b=Ykyc+eBS6w/oA4OxyvvyaBzuktMK6rBzDkI7o0wrSQMQcX+lLZPl4SgmU2YNBdY72
         bLWnSRivFgxumkRR1joAYVFmD/jQKhwynAMQM8fCJimVLxcV7cSaTGQ74pxFJV9ltm
         Q+Mdhi1z9KHYc1rW061KNEMJy/Zin1NNri161LzkP0WnNv2qTGaLjQlVstvTww/JIe
         JHKxh4SvVi1Q6DzoK1lMuwM6skTGGLqkqCOzHsWUpjEFGWnVS+OD4jmI0XpBCbcfKS
         /S+D3XX2DweeNxmtgzgP6TtO6l3umZqU9KeyDRvfaKLaXeDSvYQyeIOvyQWrraWHd0
         PnQjG9KhSf91g==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin (Intel)" <hpa@zytor.com>
Subject: [PATCH 0/6] x86/irq: trap and interrupt cleanups
Date:   Mon, 10 May 2021 17:55:25 -0700
Message-Id: <20210511005531.1065536-1-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

A collection of trap/interrupt-related patches, almost all
cleanups. The only patches that should have any possible effect at all
are:

4/6 - x86/irq: merge common code in DEFINE_IDTENTRY_SYSVEC[_SIMPLE]

	This patch reverses kvm_set_cpu_l1tf_flush_l1d() and
	__irq_enter_raw() in DEFINE_IDTENTRY_SYSVEC_SIMPLE() in order
	to be able to unify the code with DEFINE_IDTENTRY_SYSVEC().

	The reason for unification is mainly to avoid the possibility
	of inadvertent divergence rather than the rather modest amount
	of code.

5/6 - x86/irq: WARN_ONCE() if irq_move_cleanup is called on a pending interrupt

	This condition is believed to be impossible after many
	improvements to the IRQ vector allocation code since this
	function was written. Per discussion with tglx, add a
	WARN_ONCE() if this happens as a first step towards excising
	this hack.

--- 
    x86/traps: add X86_NR_HW_TRAPS to <asm/trapnr.h>
    x86/irqvector: add NR_EXTERNAL_VECTORS and NR_SYSTEM_VECTORS
    x86/idt: remove address argument to idt_invalidate()
    x86/irq: merge common code in DEFINE_IDTENTRY_SYSVEC[_SIMPLE]
    x86/irq: WARN_ONCE() if irq_move_cleanup is called on a pending interrupt
    x86/irq: remove unused vectors from <asm/irq_vectors.h>

 arch/x86/include/asm/desc.h              |  2 +-
 arch/x86/include/asm/idtentry.h          | 39 +++++++++++++++++---------------
 arch/x86/include/asm/irq_vectors.h       |  7 ++++--
 arch/x86/include/asm/trapnr.h            |  1 +
 arch/x86/kernel/apic/vector.c            |  5 ++++
 arch/x86/kernel/idt.c                    |  5 ++--
 arch/x86/kernel/machine_kexec_32.c       |  4 ++--
 arch/x86/kernel/reboot.c                 |  2 +-
 tools/arch/x86/include/asm/irq_vectors.h |  7 ++++--
 9 files changed, 43 insertions(+), 29 deletions(-)
