Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C27E30EC01
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 06:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhBDF2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 00:28:16 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:43786 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhBDF2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 00:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612416494; x=1643952494;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yq2a5kpgE+6TdPCNXjfWQtCixV8BN1i4FQgs4xdcets=;
  b=GA7wlNBbaTjmCrHgwv+75ohAece4gihEGkCKA4Jd1rYwSauMGclMOsbs
   yVHuNKGe7Uh5NQ+OfWJlgKrIZ54eAcyEahSTh19Z4E6LMu0bneuxOATxX
   O9KuAW970uVljq1NBP5lvttwcavK6e3GZ3PKdNcvKL6AOL79dhpNAQIZ3
   Pewrvb1ihYzaKEIxwU0J2rvDEN85ODF8i8A0zGzuXSP9OXyuw5TmFFkxv
   9vVtOn5sBPFGuSpm6D6mKz7VC9cJNyN8QdGdocW61vR8KK853NUVuSijd
   1FTlTo4U/TzbMGNRFvqu4ETRH3ITQdH70PwkvdJqh8hkNIbtx1vZi4cH5
   w==;
IronPort-SDR: ptZNgBMEN5StPoUvbg9GbmdbUPEELvqnCizVOuXCvoyzCPlSQ6MR/56tdMq1u7d6n5ppccTR0W
 pUl4lT7X8cN0QCzgdJVkARhbyG7ZXwzcO79QGU2fROj0APECO0lpY630mXiO4cKF8mcDGAOyxP
 yqyyD6jG7Jgjyb/5/XQfYuRYLZPSnqeFNqPNa9n9t3EOmkTCQUR7KPXM8vUIV1aTU7/kz/dJbO
 Tq6kF99vZB/XmqtwyiQdiSBKNG7WP6dHj9ivH6/HsNxnksAiZ9v3Ztr1Qfqa0Pm2nPT8PUWb6y
 pVM=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159086086"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 13:27:09 +0800
IronPort-SDR: fd0BtlncqsWu5Ez8P428v1UoGVhuzz+CHRhre1d7yfGfMWNtE2ifFVCTrfwZZC+SIZXKVYQzZ4
 QuEYFCTeP1KALVevq44JE0yXtC0ZdksdJYuQ11hFMS46xsf0YbKKFfTKmxdLme6AxmXVDKlAwx
 BR4XLyiCUe8nqKv+odjnBapWDskTegRb5WWb9IEVqvHtshJCBk/Xw0YlBqM5pNgy0CoA/DfceF
 KrvWamfaooySapWE1oYjmmK5dqEB/4syEkgxMh6DXNKH3si2pqkB9S9pCd+rGev/H5u1of2l5e
 7QN4nP943A9VRCgVrRvhUBWL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 21:09:12 -0800
IronPort-SDR: Fsg2IHeItNjsgVSOmyJudO88BgXJORjFuZkaZo7fFQ8BgukMWrt+ARsJz+dz49xKcTt2uURMLV
 40bukx3NGRViuKwLqRy4hp6RoaXtvrl2uqvuKu8jU1/1PL2xtZBE/TJtHui7QDCiMJrnXGf80A
 r6SP3x7aDYB/7+W7Sy34BWKkUqhlWtS+zPo52ve7M4CWOZvGbv3R/NxiCjWktd1h+9jxwOBmwP
 X4qjRm2eMydCIkEN2STyZFWX3DP9cd8JIhua4NpbelKNX6Ur7U69U4Rwp/4ES2kdz/n3R1ObHC
 ZeM=
WDCIronportException: Internal
Received: from cnf008142.ad.shared (HELO jedi-01.hgst.com) ([10.86.63.165])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Feb 2021 21:27:09 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH] RISC-V: Add a non-void return for sbi v02 functions
Date:   Wed,  3 Feb 2021 21:26:43 -0800
Message-Id: <20210204052643.1608586-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SBI v0.2 functions can return an error code from SBI implementation.
We are already processing the SBI error code and coverts it to the Linux
error code.

Propagate to the error code to the caller as well. As of now, kvm is the
only user of these error codes.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/sbi.h | 10 +++++-----
 arch/riscv/kernel/sbi.c      | 32 ++++++++++++++++----------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 1b26ec8e6a15..3e7141a7d11f 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -116,13 +116,13 @@ int sbi_console_getchar(void);
 void sbi_set_timer(uint64_t stime_value);
 void sbi_shutdown(void);
 void sbi_clear_ipi(void);
-void sbi_send_ipi(const unsigned long *hart_mask);
-void sbi_remote_fence_i(const unsigned long *hart_mask);
-void sbi_remote_sfence_vma(const unsigned long *hart_mask,
+int sbi_send_ipi(const unsigned long *hart_mask);
+int sbi_remote_fence_i(const unsigned long *hart_mask);
+int sbi_remote_sfence_vma(const unsigned long *hart_mask,
 			   unsigned long start,
 			   unsigned long size);
 
-void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
+int sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
 				unsigned long start,
 				unsigned long size,
 				unsigned long asid);
@@ -163,7 +163,7 @@ static inline unsigned long sbi_minor_version(void)
 
 int sbi_err_map_linux_errno(int err);
 #else /* CONFIG_RISCV_SBI */
-static inline void sbi_remote_fence_i(const unsigned long *hart_mask) {}
+static inline int sbi_remote_fence_i(const unsigned long *hart_mask) {}
 static inline void sbi_init(void) {}
 #endif /* CONFIG_RISCV_SBI */
 #endif /* _ASM_RISCV_SBI_H */
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 8d60b2ebcad3..f904af48635d 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -352,7 +352,7 @@ static int __sbi_rfence_v02(int fid, const unsigned long *hart_mask,
  * sbi_set_timer() - Program the timer for next timer event.
  * @stime_value: The value after which next timer event should fire.
  *
- * Return: None
+ * Return: None.
  */
 void sbi_set_timer(uint64_t stime_value)
 {
@@ -363,11 +363,11 @@ void sbi_set_timer(uint64_t stime_value)
  * sbi_send_ipi() - Send an IPI to any hart.
  * @hart_mask: A cpu mask containing all the target harts.
  *
- * Return: None
+ * Return: 0 on success, appropriate linux error code otherwise.
  */
-void sbi_send_ipi(const unsigned long *hart_mask)
+int sbi_send_ipi(const unsigned long *hart_mask)
 {
-	__sbi_send_ipi(hart_mask);
+	return __sbi_send_ipi(hart_mask);
 }
 EXPORT_SYMBOL(sbi_send_ipi);
 
@@ -375,12 +375,12 @@ EXPORT_SYMBOL(sbi_send_ipi);
  * sbi_remote_fence_i() - Execute FENCE.I instruction on given remote harts.
  * @hart_mask: A cpu mask containing all the target harts.
  *
- * Return: None
+ * Return: 0 on success, appropriate linux error code otherwise.
  */
-void sbi_remote_fence_i(const unsigned long *hart_mask)
+int sbi_remote_fence_i(const unsigned long *hart_mask)
 {
-	__sbi_rfence(SBI_EXT_RFENCE_REMOTE_FENCE_I,
-		     hart_mask, 0, 0, 0, 0);
+	return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_FENCE_I,
+			    hart_mask, 0, 0, 0, 0);
 }
 EXPORT_SYMBOL(sbi_remote_fence_i);
 
@@ -391,14 +391,14 @@ EXPORT_SYMBOL(sbi_remote_fence_i);
  * @start: Start of the virtual address
  * @size: Total size of the virtual address range.
  *
- * Return: None
+ * Return: 0 on success, appropriate linux error code otherwise.
  */
-void sbi_remote_sfence_vma(const unsigned long *hart_mask,
+int sbi_remote_sfence_vma(const unsigned long *hart_mask,
 			   unsigned long start,
 			   unsigned long size)
 {
-	__sbi_rfence(SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
-		     hart_mask, start, size, 0, 0);
+	return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
+			    hart_mask, start, size, 0, 0);
 }
 EXPORT_SYMBOL(sbi_remote_sfence_vma);
 
@@ -411,15 +411,15 @@ EXPORT_SYMBOL(sbi_remote_sfence_vma);
  * @size: Total size of the virtual address range.
  * @asid: The value of address space identifier (ASID).
  *
- * Return: None
+ * Return: 0 on success, appropriate linux error code otherwise.
  */
-void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
+int sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
 				unsigned long start,
 				unsigned long size,
 				unsigned long asid)
 {
-	__sbi_rfence(SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
-		     hart_mask, start, size, asid, 0);
+	return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
+			    hart_mask, start, size, asid, 0);
 }
 EXPORT_SYMBOL(sbi_remote_sfence_vma_asid);
 
-- 
2.25.1

