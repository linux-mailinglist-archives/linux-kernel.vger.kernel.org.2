Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3157379BC4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhEKA51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:57:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45457 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhEKA5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:57:07 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14B0tdwA2504247
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 10 May 2021 17:55:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14B0tdwA2504247
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620694551;
        bh=xkymiY+8+CNIxsNAedZC22OCKPl0xAPTK6wwAANss68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g4zQdja8QHTFnL5/D4O+bxSzoMo6fsDRfirHuEUrYDS32Z3kZoiwhT2+5XLiXLLL6
         aMDRJOQA9uCDjc8lqmzQ23eFSzTSLS3Qq062NUbS4f8r79vpqPTgZHk09SY0j30JR3
         oRgVE8RvTH07O7p6OofskwgTwbhwkBsWlVw5sK2F3znd62nE6qiUR5aXphG8AgHJXp
         YJz8zj6Ji3Rn7Frb57TFPiBnp9TtSycMsoeGj8ggCK6158+3z8u0oEQmw/tTpoeYCq
         NvpRU+ByegS5QW3QwL90ML0Z0nFxN5fK4iqLT6Ld2bo7Diye0tuG34uacW7C3XfZf5
         i9KDuWZvbyQ4w==
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
Subject: [PATCH 5/6] x86/irq: WARN_ONCE() if irq_move_cleanup is called on a pending interrupt
Date:   Mon, 10 May 2021 17:55:30 -0700
Message-Id: <20210511005531.1065536-6-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511005531.1065536-1-hpa@zytor.com>
References: <20210511005531.1065536-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

The current IRQ vector allocation code should be "clean" and never
issue a IRQ_MOVE_CLEANUP_VECTOR IPI for an interrupt that could still
be pending. This should make it possible to move it to the "normal"
system IRQ vector range. This should probably be a three-step process:

1. Introduce this WARN_ONCE() on this event ever occurring.
2. Move the IRQ_MOVE_CLEANUP_VECTOR to the sysvec range.
3. Remove the self-IPI hack.

This implements step 1.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/kernel/apic/vector.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 6dbdc7c22bb7..7ba2982a3585 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -939,9 +939,14 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_irq_move_cleanup)
 		 * to this CPU. IRQ_MOVE_CLEANUP_VECTOR is the lowest
 		 * priority external vector, so on return from this
 		 * interrupt the device interrupt will happen first.
+		 *
+		 * *** This should never happen with the current IRQ
+		 * cleanup code, so WARN_ONCE() for now, and
+		 * eventually get rid of this hack.
 		 */
 		irr = apic_read(APIC_IRR + (vector / 32 * 0x10));
 		if (irr & (1U << (vector % 32))) {
+			WARN_ONCE(1, "irq_move_cleanup called on still pending interrupt\n");
 			apic->send_IPI_self(IRQ_MOVE_CLEANUP_VECTOR);
 			continue;
 		}
-- 
2.31.1

