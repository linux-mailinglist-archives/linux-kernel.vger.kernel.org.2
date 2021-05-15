Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7B53814FB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 03:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbhEOBpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 21:45:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33297 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234799AbhEOBpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 21:45:35 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14F1i7an3212185
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 14 May 2021 18:44:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14F1i7an3212185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621043057;
        bh=xkymiY+8+CNIxsNAedZC22OCKPl0xAPTK6wwAANss68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RDMQYC3pBOYO5otHcHqta/pHNKgzu38vU0Bh5OD1KBZDDMjUmH3guILQvhCTGoX49
         isiIPoEIWfMbaHZ1PP8x8pKu/FHa846kUkNCX32RznKT+2ZLcGdDdsi4IFylXISfp5
         XUfQqrHvhUMoK5Io4fbF7UwYKRdd7d1JbIJJHM1sLQ5xXR+eMY7O7rUcSiNYbuJ1HT
         aahgvdCl+WvS8gStUR1fmEIQIZFNrrvW75FBQkbdQhpnVK0JhcEDEjemDB054ESA0K
         tvgV8/+aHpiu9Sza9ayET0gkpriSXzie9BI/5tOxyLibGo2KNh3dphs0woO3rAQX0d
         JkeVPISGCISUA==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 7/9] x86/irq: WARN_ONCE() if irq_move_cleanup is called on a pending interrupt
Date:   Fri, 14 May 2021 18:43:59 -0700
Message-Id: <20210515014400.2999028-8-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515014400.2999028-1-hpa@zytor.com>
References: <20210515014400.2999028-1-hpa@zytor.com>
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

