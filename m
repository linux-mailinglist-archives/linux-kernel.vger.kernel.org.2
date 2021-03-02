Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9784432A0C3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576539AbhCBEar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:30:47 -0500
Received: from spam01.hygon.cn ([110.188.70.11]:50244 "EHLO spam2.hygon.cn"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S241395AbhCBCGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 21:06:13 -0500
Received: from MK-DB.hygon.cn ([172.23.18.60])
        by spam2.hygon.cn with ESMTP id 12223Zwk080160;
        Tue, 2 Mar 2021 10:03:36 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-DB.hygon.cn with ESMTP id 12223U7D056161;
        Tue, 2 Mar 2021 10:03:30 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from ubuntu1604-2.higon.com (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Tue, 2 Mar 2021
 10:03:15 +0800
From:   Pu Wen <puwen@hygon.cn>
To:     <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <Yazen.Ghannam@amd.com>, <johnathan.smithinovic@gmx.at>,
        <rkitover@gmail.com>, Pu Wen <puwen@hygon.cn>
Subject: [PATCH] x86/cpu/hygon: Set __max_die_per_package on Hygon
Date:   Tue, 2 Mar 2021 10:02:17 +0800
Message-ID: <20210302020217.1827-1-puwen@hygon.cn>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex02.Hygon.cn (172.23.18.12) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam2.hygon.cn 12223Zwk080160
X-DNSRBL: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the maximum DIE per package variable on Hygon using the
nodes_per_socket value in order to do per-DIE manipulations
by driver such as powercap.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/kernel/cpu/hygon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index ae59115d18f9..0bd6c74e3ba1 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -215,12 +215,12 @@ static void bsp_init_hygon(struct cpuinfo_x86 *c)
 		u32 ecx;
 
 		ecx = cpuid_ecx(0x8000001e);
-		nodes_per_socket = ((ecx >> 8) & 7) + 1;
+		__max_die_per_package = nodes_per_socket = ((ecx >> 8) & 7) + 1;
 	} else if (boot_cpu_has(X86_FEATURE_NODEID_MSR)) {
 		u64 value;
 
 		rdmsrl(MSR_FAM10H_NODE_ID, value);
-		nodes_per_socket = ((value >> 3) & 7) + 1;
+		__max_die_per_package = nodes_per_socket = ((value >> 3) & 7) + 1;
 	}
 
 	if (!boot_cpu_has(X86_FEATURE_AMD_SSBD) &&
-- 
2.23.0

