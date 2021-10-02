Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5821641FBC1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 14:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbhJBMWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 08:22:41 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:35328 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbhJBMWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 08:22:38 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 192CKon7028630
        for <linux-kernel@vger.kernel.org>; Sat, 2 Oct 2021 15:20:50 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1633177245; x=1635769245;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4A4MSIlG8iektNntI+uuecfDrhfzG/JLUOwt3FYqOrU=;
        b=nL0FNii7EtXxyO8kDWzrljGNWM8CLvf46er+/ArISkxJ+XJejrABDnjNXTx9eDd4
        Ft4d2CyNOfy2n70Xgd55SxCWy3eHya7WnD28eitGd6VMg4HXbZk2IHprNdSn3rB5
        251hc/9yYHl0tFd7/0lVJuzIvKg9Q6NVlGh6ol2F0fiPtSto+UlDzqldfYUj2+Ry
        trUKOPJyC9GeFooZUM+otk7fPMPtPqUIx5NKkMOARwtIbkUiAIvHzZ5+wyJ3GnZx
        +IwapXPJ0ZJju/XQTxPghLvaILCw6DKMI+tiuwLZuEYLZth4v3lAOchX0fI0OL6+
        wz1vN2bzqU9aFqq1eDL0pw==;
X-AuditID: 8b5b014d-b84f570000005d46-54-61584e9dc1a9
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id F6.7A.23878.D9E48516; Sat,  2 Oct 2021 15:20:45 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user: mick@ics.forth.gr at ics.forth.gr
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick Kossifidis <mick@ics.forth.gr>
Subject: [PATCH] riscv: Don't use va_pa_offset on kdump
Date:   Sat,  2 Oct 2021 15:20:26 +0300
Message-Id: <20211002122026.1451269-1-mick@ics.forth.gr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupiluLIzCtJLcpLzFFi42Lpjp6urDvXLyLR4MphBYutv2exW1zeNYfN
        YtvnFjaL5nfn2C1eXu5htmibxe/A5vHm5UsWj8MdX9g9Hm66xOSxeUm9x6Xm6+wenzfJBbBF
        cdmkpOZklqUW6dslcGUsOniApeCvQMXrXX+YGxgv83YxcnJICJhITF2/iqmLkYtDSOAoo0T/
        nEksEAk3idv3d7KC2GwCmhLzLx0Ei4sIuEusnvyHCcRmFsiX2PblHHMXIweHsIC5xI39ISBh
        FgFViXl/zzCD2LwCFhJ/Z09jhBgpL3Fq2UEmiLigxMmZT1ggxshLNG+dzTyBkWcWktQsJKkF
        jEyrGAUSy4z1MpOL9dLyi0oy9NKLNjGCg4vRdwfj7c1v9Q4xMnEwHmKU4GBWEuHVCwxPFOJN
        SaysSi3Kjy8qzUktPsQozcGiJM7LqzchXkggPbEkNTs1tSC1CCbLxMEp1cC0lZf38CXReSnC
        rpcXaO2otJbqWiJw44fVHttjRQJLr4v92XCs7nTsREUBUWd+DUmBGcuFdmT8n5R5TMa28rbJ
        F8bFZ3MYXzCxfZirXvxBdpvXx9s9mxeLaZbs0eEJyuPP+RhzZJ62v2xo45yuQqff2fHyzXNi
        JvcIFKxS2Kb/Ot6gIOjqiev2V2Puur9z2LD+b8SUJcbvVvs/WKxVsllbY8XlbeoKx78Jf/nF
        6fPyUv0fXrm1vkvVQxrjPO4E5v7RepzdudM0LvCzjLNitohv2RH+hxxiSQGeQe9OPHkfw+i0
        WklQp3eN72rmnooFmq4HMiZU8Ytk2d9Wu8PzrNZKxuAHa0S7Wt0xI+Xa7UosxRmJhlrMRcWJ
        AN2IwPSdAgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On kdump instead of using an intermediate step to relocate the kernel, that
lives in a "control buffer" outside the current kernel's mapping, we jump
to the crash kernel directly by calling riscv_kexec_norelocate(). The
current implementation uses va_pa_offset while switching to physical
addressing, however since we moved the kernel outside the linear mapping
this won't work anymore since riscv_kexec_norelocate() is part of the
kernel mapping and we should use kernel_map.va_kernel_pa_offset, and also
take XIP kernel into account.

We don't really need to use va_pa_offset on riscv_kexec_norelocate, we can
just set STVEC to the physical address of the new kernel instead and let
the hart jump to the new kernel on the next instruction after setting
SATP to zero. This fixes kdump and is also simpler/cleaner.

Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
---
 arch/riscv/kernel/kexec_relocate.S | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/kernel/kexec_relocate.S b/arch/riscv/kernel/kexec_relocate.S
index a80b52a74..e2f34196e 100644
--- a/arch/riscv/kernel/kexec_relocate.S
+++ b/arch/riscv/kernel/kexec_relocate.S
@@ -159,25 +159,15 @@ SYM_CODE_START(riscv_kexec_norelocate)
 	 * s0: (const) Phys address to jump to
 	 * s1: (const) Phys address of the FDT image
 	 * s2: (const) The hartid of the current hart
-	 * s3: (const) kernel_map.va_pa_offset, used when switching MMU off
 	 */
 	mv	s0, a1
 	mv	s1, a2
 	mv	s2, a3
-	mv	s3, a4
 
 	/* Disable / cleanup interrupts */
 	csrw	CSR_SIE, zero
 	csrw	CSR_SIP, zero
 
-	/* Switch to physical addressing */
-	la	s4, 1f
-	sub	s4, s4, s3
-	csrw	CSR_STVEC, s4
-	csrw	CSR_SATP, zero
-
-.align 2
-1:
 	/* Pass the arguments to the next kernel  / Cleanup*/
 	mv	a0, s2
 	mv	a1, s1
@@ -214,6 +204,11 @@ SYM_CODE_START(riscv_kexec_norelocate)
 	csrw	CSR_SCAUSE, zero
 	csrw	CSR_SSCRATCH, zero
 
+	/* Switch to physical addressing */
+	csrw	CSR_STVEC, a2
+	csrw	CSR_SATP, zero
+
+	/* This will trigger a jump to CSR_STVEC anyway */
 	jalr	zero, a2, 0
 SYM_CODE_END(riscv_kexec_norelocate)
 
-- 
2.32.0

