Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F7A3A1FD9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 00:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhFIWOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 18:14:17 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:37412 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229655AbhFIWOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 18:14:11 -0400
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D5CDBC09C8;
        Wed,  9 Jun 2021 22:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1623276736; bh=xNJqycAIra/5JitzpoHgUCk+zKsckQ6Z7yRl6gEQisw=;
        h=From:To:Cc:Subject:Date:From;
        b=WrYzuUQy0Lo8Dhm+eGQOp8HmJCTiDMJu7He5QuI4fCi5x21FARLnwVfdBHlmcBDmR
         zZpLCplsC9OLRctwht3FPQG/ZSWy63EPWAVkRBrxpKqKCz40MIGoPZ/IKOM5noJwv+
         I4ixztYdjUeGOTNkaa/rju3aNt5OS2OxgjxnWsfMBYubYXX6taf9kmNpNwvIymUh7O
         qTzrDLChYvUoc8wmVrgS0WcjUDAv8eMmNhVWkmakFGN7FIdZJsY6DFHjOyGnSAQjmG
         W2afTyUKGVtFFJnqKTRQD+lIKQ3yUUB3orR2FoLqEip3f4/DoBUxqhiCeGQdYJsnAs
         YJauqW2j3z+9A==
Received: from vineetg-Latitude-7400.internal.synopsys.com (snps-fugpbdpduq.internal.synopsys.com [10.202.17.37])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3A4C5A006D;
        Wed,  9 Jun 2021 22:12:12 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Subject: [PATCH] ARC: fix CONFIG_HARDENED_USERCOPY
Date:   Wed,  9 Jun 2021 15:12:11 -0700
Message-Id: <20210609221211.2457203-1-vgupta@synopsys.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently enabling this triggers a warning

| usercopy: Kernel memory overwrite attempt detected to kernel text (offset 155633, size 11)!
| usercopy: BUG: failure at mm/usercopy.c:99/usercopy_abort()!
|
|gcc generated __builtin_trap
|Path: /bin/busybox
|CPU: 0 PID: 84 Comm: init Not tainted 5.4.22
|
|[ECR ]: 0x00090005 => gcc generated __builtin_trap
|[EFA ]: 0x9024fcaa
|[BLINK ]: usercopy_abort+0x8a/0x8c
|[ERET ]: memfd_fcntl+0x0/0x470
|[STAT32]: 0x80080802 : IE K
|BTA: 0x901ba38c SP: 0xbe161ecc FP: 0xbf9fe950
|LPS: 0x90677408 LPE: 0x9067740c LPC: 0x00000000
|r00: 0x0000003c r01: 0xbf0ed280 r02: 0x00000000
|r03: 0xbe15fa30 r04: 0x00d2803e r05: 0x00000000
|r06: 0x675d7000 r07: 0x00000000 r08: 0x675d9c00
|r09: 0x00000000 r10: 0x0000035c r11: 0x61206572
|r12: 0x9024fcaa r13: 0x0000000b r14: 0x0000000b
|r15: 0x00000000 r16: 0x90169ffc r17: 0x90168000
|r18: 0x00000000 r19: 0xbf092010 r20: 0x00000001
|r21: 0x00000011 r22: 0x5ffffff1 r23: 0x90169ff1
|r24: 0xbe196c00 r25: 0xbf0ed280
|
|Stack Trace:
| memfd_fcntl+0x0/0x470
| usercopy_abort+0x8a/0x8c
| __check_object_size+0x10e/0x138
| copy_strings+0x1f4/0x38c
| __do_execve_file+0x352/0x848
| EV_Trap+0xcc/0xd0

Fixes: https://github.com/foss-for-synopsys-dwc-arc-processors/linux/issues/15
Reported-by: Evgeniy Didin <didin@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/kernel/vmlinux.lds.S b/arch/arc/kernel/vmlinux.lds.S
index 33ce59d91461..e2146a8da195 100644
--- a/arch/arc/kernel/vmlinux.lds.S
+++ b/arch/arc/kernel/vmlinux.lds.S
@@ -57,7 +57,6 @@ SECTIONS
 	.init.ramfs : { INIT_RAM_FS }
 
 	. = ALIGN(PAGE_SIZE);
-	_stext = .;
 
 	HEAD_TEXT_SECTION
 	INIT_TEXT_SECTION(L1_CACHE_BYTES)
@@ -83,6 +82,7 @@ SECTIONS
 
 	.text : {
 		_text = .;
+		_stext = .;
 		TEXT_TEXT
 		SCHED_TEXT
 		CPUIDLE_TEXT
-- 
2.25.1

