Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B44342900
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 00:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhCSXCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 19:02:07 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:9606 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhCSXBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 19:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616194893; x=1647730893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bvhD1o7QLbuyiQ3irecBTTVFAEPFjiti9Nt3mhTF4+w=;
  b=Sxzba0/YzOaeG03lS5EXbHRVQ+He3ftUVn/bhmna2k0ARMcCwcrjZc++
   8Tm6/FwraAM48OGiFdZU9hypmIvzPnJ3XvhwNfgZiWGsb19i9sfTJNWt3
   BOr09jqEqjau0VNjGrcxsqKAfvjJao8sUdxEfvR/sTv0EkJb0tMfDMbzD
   +NyDZaQsrxBGiF/JfkZfkfdG8YpnW9Atk8CGgX2SQMhlxo1gy3vYjdR1V
   MibKnziqm++uNu4NIw5uMkhk2agQm9p+uUVkxwPlxT2wpD6k+juqGOGJK
   rB+sdRLB2zoT505thLWJLhf5R7bF6/tcMnRuX6VlNnzbzvnlyR/oMWyv6
   Q==;
IronPort-SDR: GJYtJ2vdolPmpNcsD6h767QrKiGZ7wrniu/7BipnS6jP1mZYCSQIJzXQyY2Dtqb8dm/g8c7dpI
 JA/6xovXTGsIxYURVHozLmTf5q1xQgYGHfQ/t3qBtpFNPudIfqRNVewVtyFNHabqQkun2pPN32
 u27sL1UxS29nWVNy1red5gasbdnL3sMoqXb7trH3nLBI5m93BlKEpSNqSGF83/QF5r4r6nJt5F
 ZynUoqj3NUMVS2ONFSIhlRh14iI3NQ2VsP7zJuq1UqhPL1cSAvT0n+6YD6Xi9pgvO1eTokXvXD
 MF4=
X-IronPort-AV: E=Sophos;i="5.81,263,1610380800"; 
   d="scan'208";a="162584069"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2021 07:01:32 +0800
IronPort-SDR: elwGlxv7JyZF0ltvQU6Yg9t9DZS2WcsKG/GY77PMAAYiHK7qgNKrsmh9QzJzoYkWSFL9IN7gRk
 VmYtTghC+YpevecQmTR0RGcPxilDh2l0kb4Aw8njznNlkWwL6MfIh/NGZN2NgctaeVIFcI5ziF
 ULGFMTnuWL/5C3+WR76h8/+G8SRyivQ/lEByeO2jP/e5SQjZa5040hs399DEgmerPQf+H6R1tY
 jXdgdgU1ek+UR0yzAtlQKdU9fODyBqq5d3qxqCEv7LKVzgSNQVIbzxh5GU4doMeBhDPFoTjeYO
 eq1STEB8LsuAXA4RrP+S3zpd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 15:43:44 -0700
IronPort-SDR: a/RK+GO7gWzwO5+wEegWwV0E55vPwk0jaT865Ui5Ia9HugZOXXbuzQHyG5ClNQoLyY9ak/iR56
 +XaxxVT85yXeyaAKq9sINCFC5b/GHxNzJm+Jcf+2UZW0tV3sS2lCmrGRb/Wpyvt2bgQYrg7R9L
 kNhKf2gJT9Amlv/BCgzi7LGP5xZjAqOxEXnsHHbirJLcttqlQqKeCT1y6mF/+V5s8W+jrblwbD
 4d0UmGrkgNXhWALwHqCj3KzIk7AYvYIvUZ6hnJLvJxavA7265zMxueGZf03480Yd6ljxkxj7dm
 FGE=
WDCIronportException: Internal
Received: from ind002560.ad.shared (HELO jedi-01.hgst.com) ([10.86.48.105])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Mar 2021 16:01:32 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Subject: [RFC 5/6] RISC-V: Add RISC-V SBI PMU extension definitions
Date:   Fri, 19 Mar 2021 16:01:05 -0700
Message-Id: <20210319230106.2186694-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210319230106.2186694-1-atish.patra@wdc.com>
References: <20210319230106.2186694-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds all the definitions defined by the SBI PMU extension.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/sbi.h | 80 ++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 99895d9c3bdd..01b261bc6b68 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -27,6 +27,7 @@ enum sbi_ext_id {
 	SBI_EXT_IPI = 0x735049,
 	SBI_EXT_RFENCE = 0x52464E43,
 	SBI_EXT_HSM = 0x48534D,
+	SBI_EXT_PMU = 0x504D55,
 };
 
 enum sbi_ext_base_fid {
@@ -70,6 +71,85 @@ enum sbi_hsm_hart_status {
 	SBI_HSM_HART_STATUS_STOP_PENDING,
 };
 
+
+enum sbi_ext_pmu_fid {
+	SBI_EXT_PMU_NUM_COUNTERS = 0,
+	SBI_EXT_PMU_COUNTER_GET_INFO,
+	SBI_EXT_PMU_COUNTER_CFG_MATCH,
+	SBI_EXT_PMU_COUNTER_FW_READ,
+	SBI_EXT_PMU_COUNTER_START,
+	SBI_EXT_PMU_COUNTER_STOP,
+};
+
+#define RISCV_PMU_RAW_EVENT_MASK 0x7FFFFFFF
+#define RISCV_PMU_RAW_EVENT_IDX 0x20000
+
+/* SBI PMU Hardware general events */
+enum sbi_pmu_hw_generic_events_t {
+	SBI_PMU_HW_NO_EVENT = 0,
+	SBI_PMU_HW_CPU_CYCLES,
+	SBI_PMU_HW_INSTRUCTIONS,
+	SBI_PMU_HW_CACHE_REFERENCES,
+	SBI_PMU_HW_CACHE_MISSES,
+	SBI_PMU_HW_BRANCH_INSTRUCTIONS,
+	SBI_PMU_HW_BRANCH_MISSES,
+	SBI_PMU_HW_BUS_CYCLES,
+	SBI_PMU_HW_STALLED_CYCLES_FRONTEND,
+	SBI_PMU_HW_STALLED_CYCLES_BACKEND,
+	SBI_PMU_HW_REF_CPU_CYCLES,
+	SBI_PMU_HW_MISALIGNED_LOAD,
+	SBI_PMU_HW_MISALIGNED_STORE,
+
+	SBI_PMU_HW_GENERIC_MAX,
+};
+
+/**
+ * Special "firmware" events provided by the firmware, even if the hardware
+ * does not support performance events. These events are encoded as a raw
+ * event type in Linux kernel perf framework.
+ */
+enum sbi_pmu_fw_generic_events_t {
+	SBI_PMU_FW_MISALIGNED_LOAD	= 0,
+	SBI_PMU_FW_MISALIGNED_STORE	= 1,
+	SBI_PMU_FW_ACCESS_LOAD		= 2,
+	SBI_PMU_FW_ACCESS_STORE		= 3,
+	SBI_PMU_FW_ILLEGAL_INSN		= 4,
+	SBI_PMU_FW_SET_TIMER		= 5,
+	SBI_PMU_FW_IPI_SENT		= 6,
+	SBI_PMU_FW_IPI_RECVD		= 7,
+	SBI_PMU_FW_FENCE_I_SENT		= 8,
+	SBI_PMU_FW_FENCE_I_RECVD	= 9,
+	SBI_PMU_FW_SFENCE_VMA_SENT	= 10,
+	SBI_PMU_FW_SFENCE_VMA_RCVD	= 11,
+	SBI_PMU_FW_SFENCE_VMA_ASID_SENT	= 12,
+	SBI_PMU_FW_SFENCE_VMA_ASID_RCVD	= 13,
+
+	SBI_PMU_FW_HFENCE_GVMA_SENT	= 14,
+	SBI_PMU_FW_HFENCE_GVMA_RCVD	= 15,
+	SBI_PMU_FW_HFENCE_GVMA_VMID_SENT = 16,
+	SBI_PMU_FW_HFENCE_GVMA_VMID_RCVD = 17,
+
+	SBI_PMU_FW_HFENCE_VVMA_SENT	= 18,
+	SBI_PMU_FW_HFENCE_VVMA_RCVD	= 19,
+	SBI_PMU_FW_HFENCE_VVMA_ASID_SENT = 20,
+	SBI_PMU_FW_HFENCE_VVMA_ASID_RCVD = 21,
+	SBI_PMU_FW_MAX,
+};
+
+/* SBI PMU event types */
+enum sbi_pmu_event_type {
+	SBI_PMU_EVENT_TYPE_HW = 0x0,
+	SBI_PMU_EVENT_TYPE_CACHE = 0x1,
+	SBI_PMU_EVENT_TYPE_RAW = 0x2,
+	SBI_PMU_EVENT_TYPE_FW = 0xf,
+};
+
+/* SBI PMU event types */
+enum sbi_pmu_ctr_type {
+	SBI_PMU_CTR_TYPE_HW = 0x0,
+	SBI_PMU_CTR_TYPE_FW,
+};
+
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
 #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
-- 
2.25.1

