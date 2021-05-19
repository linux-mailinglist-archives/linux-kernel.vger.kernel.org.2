Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75FC38988E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 23:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhESVYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 17:24:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47051 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229972AbhESVXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 17:23:55 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14JLM1Eb4187848
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 19 May 2021 14:22:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14JLM1Eb4187848
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621459331;
        bh=UHJLOhAURTpIPJFtqZTOsSzlJqC70K5wfYxEan62/qU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fcD5SyREVAgy1P46+LEb2ivumIdobtPiHEyUplFzN4/pzpgyzNgOpXAWEcjkHPBu+
         eWTMRLB024gMGiKCYYK7Ieuli8ep1QUpsNCgYcWOHk/QXRc43TYB6gO5Ovb25QjDAW
         K9BLob48eYrwBXEBAj3iNycj5DtOMt5KuCbyE8ET+21MfZEz3RRDLw4tSkTPXRq2E3
         hzdpYvwrfhRGv/iNU3U3DwG8SNd2AJH7KXAUZv5Vgr9r1hOf+zANqc5hWg2wJM/4c7
         lt1MbgTELALpm7dR9FD6YlE0tx+Kc8zEb2ydVtdUGauNIoJTD9EEVkEIUzErqnGAoD
         VxnllMASFyKig==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [PATCH v3 3/8] x86/irq: remove unused vectors from <asm/irq_vectors.h>
Date:   Wed, 19 May 2021 14:21:49 -0700
Message-Id: <20210519212154.511983-4-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519212154.511983-1-hpa@zytor.com>
References: <20210519212154.511983-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

UV_BAU_MESSAGE is defined but not used anywhere in the
kernel. Presumably this is a stale vector number that can be
reclaimed.

MCE_VECTOR is not an actual vector: #MC is an exception, not an
interrupt vector, and as such is correctly described as
X86_TRAP_MC. MCE_VECTOR is not used anywhere is the kernel.

Note that NMI_VECTOR *is* used; specifically it is the vector number
programmed into the APIC LVT when an NMI interrupt is configured. At
the moment it is always numerically identical to X86_TRAP_NMI, that is
not necessarily going to be the case indefinitely.

Acked-by: Steve Wahl <steve.wahl@hpe.com>
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: Russ Anderson <russ.anderson@hpe.com>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/include/asm/irq_vectors.h       | 4 ++--
 tools/arch/x86/include/asm/irq_vectors.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index d2ef35927770..43dcb9284208 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -26,8 +26,8 @@
  * This file enumerates the exact layout of them:
  */
 
+/* This is used as an interrupt vector when programming the APIC. */
 #define NMI_VECTOR			0x02
-#define MCE_VECTOR			0x12
 
 /*
  * IDT vectors usable for external interrupt sources start at 0x20.
@@ -84,7 +84,7 @@
  */
 #define IRQ_WORK_VECTOR			0xf6
 
-#define UV_BAU_MESSAGE			0xf5
+/* 0xf5 - unused, was UV_BAU_MESSAGE */
 #define DEFERRED_ERROR_VECTOR		0xf4
 
 /* Vector on which hypervisor callbacks will be delivered */
diff --git a/tools/arch/x86/include/asm/irq_vectors.h b/tools/arch/x86/include/asm/irq_vectors.h
index d2ef35927770..43dcb9284208 100644
--- a/tools/arch/x86/include/asm/irq_vectors.h
+++ b/tools/arch/x86/include/asm/irq_vectors.h
@@ -26,8 +26,8 @@
  * This file enumerates the exact layout of them:
  */
 
+/* This is used as an interrupt vector when programming the APIC. */
 #define NMI_VECTOR			0x02
-#define MCE_VECTOR			0x12
 
 /*
  * IDT vectors usable for external interrupt sources start at 0x20.
@@ -84,7 +84,7 @@
  */
 #define IRQ_WORK_VECTOR			0xf6
 
-#define UV_BAU_MESSAGE			0xf5
+/* 0xf5 - unused, was UV_BAU_MESSAGE */
 #define DEFERRED_ERROR_VECTOR		0xf4
 
 /* Vector on which hypervisor callbacks will be delivered */
-- 
2.31.1

