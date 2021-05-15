Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C31138176C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 11:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhEOKAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 06:00:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48941 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhEOKAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 06:00:49 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14F9xGu43273647
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 15 May 2021 02:59:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14F9xGu43273647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621072764;
        bh=mYIyPbWt416077Ac95zHgIkOiIsfWRZri0qtmd+e6g8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kmOL0K2aTK4gBI8e+1/YkGjKEhGrJS+ZtZDeUd1iiAYFA4MsmymXfiQ0YwB4ocqb7
         ostzm1myMnTGENQwgykJt0Bqjw+8RUTU6CHpHwhtW3ZZ/C7jvKeC+9gSAsdT8ZkCuX
         j2dfCHv+0HjnjlEtFpwMxQPFur9Dm+imUX3Y+dyJPGE48S26iGkanPKF+mAl36yUrB
         ySSjKb9yGFX5OBWkVz+7lgBbRBwC7aLwYynyJUa4fMB4tK8f5wzvdov9oWKQL0BkyU
         B/eimkU34YGXtsuFJIHqc1zNVIBA+zhBzY+Ej4gPs2s1MmT4jUv9GErcN/cbV9G6Q4
         NTBPVQECJxM2g==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2.1 7/8] x86/irq: WARN_ONCE() if irq_move_cleanup is called on a pending interrupt
Date:   Sat, 15 May 2021 02:59:07 -0700
Message-Id: <20210515095907.3020486-1-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515014400.2999028-8-hpa@zytor.com>
References: <20210515014400.2999028-8-hpa@zytor.com>
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

