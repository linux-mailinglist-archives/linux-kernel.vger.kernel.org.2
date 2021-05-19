Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD14F389889
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 23:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhESVXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 17:23:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38407 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhESVXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 17:23:42 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14JLM1Ef4187848
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 19 May 2021 14:22:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14JLM1Ef4187848
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621459333;
        bh=mYIyPbWt416077Ac95zHgIkOiIsfWRZri0qtmd+e6g8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XQNcG2icYyzt5D35Kwww91iLhZvdOk7FAMD6Daq6SpJxThSuVOBggG7kMIaC25oaO
         BwY/XD5asCWLAbWV0oZazWB5xtmW6kfWS/q7ipRUE/ZRHB/cC8In23PM51H7A1J0du
         Jgpld0wYtTTaMBWioJ6XYX1BOwQHn55KuFiyMylEVCILodMCw2puWRIgTnZSWCeHhS
         9Mp57PZiMtQRF8tuvOlgSnoBSnyPc40RUVcwVvXUG1f+Q3WCXJQ4AG3IaXEcznkwKW
         CMhYWy/r/iDzcRrpdnc2pfaQshQtukGjid/fMFl2v0jipxYBXRGZfC3nNGiHTCClEg
         wbOBnkFRRy+kQ==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 7/8] x86/irq: WARN_ONCE() if irq_move_cleanup is called on a pending interrupt
Date:   Wed, 19 May 2021 14:21:53 -0700
Message-Id: <20210519212154.511983-8-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519212154.511983-1-hpa@zytor.com>
References: <20210519212154.511983-1-hpa@zytor.com>
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
2. Remove the self-IPI hack.
3. Move the IRQ_MOVE_CLEANUP_VECTOR to the sysvec range.

This implements step 1.

[ Previous versions of this patch had steps 2 and 3 reversed. ]

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

