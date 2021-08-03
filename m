Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521703DE3E1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 03:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbhHCBM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 21:12:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233575AbhHCBMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 21:12:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9520560FA0;
        Tue,  3 Aug 2021 01:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627953164;
        bh=7iM0o8i7IXhADmeTNf1T0a4Y5xkOFyr9BlbacP7nCAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+w1MEJC7iZC8o5B9Vnz3cW3l77UEm0eLhyuIM6O3Okse3gi9a3SBPWveD7eYFYrb
         ljn3g+qs6GuJ/k3Sgug8voxN07+rVVkM6h9FziM55RJnjbhb5KG2MFhDhReiFVE8La
         Lfd0Y6VFLQCthLJwg8JX19DFxjtQD3yud7inxQFnoTg6d8gnvBqstEJyQ3Esj/xmgV
         TLgNF/EKmSf+R30kNgTda27imD5tlpt2RMfTiylSj1t9iILSqkwxNbfbb7lIkrEyfr
         pNSIRDUqiB/u5XRhhj4O5sjEs4mEzpMlfhzhDwe7ZJe13DnYS7t2HjnTHPetICrWf2
         2gt7vvA8Xpdew==
From:   guoren@kernel.org
To:     anup.patel@wdc.com, atish.patra@wdc.com, palmerdabbelt@google.com,
        tglx@linutronix.de, maz@kernel.org, guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 2/2] riscv: Improve status in cpu sections of device-tree for cpuhotplug usage
Date:   Tue,  3 Aug 2021 09:12:03 +0800
Message-Id: <1627953123-24248-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627953123-24248-1-git-send-email-guoren@kernel.org>
References: <1627953123-24248-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

If we define cpu sections with first okay & second fail:
        cpus {
                #address-cells = <1>;
                #size-cells = <0>;
                timebase-frequency = <3000000>;
                cpu@0 {
                        device_type = "cpu";
                        reg = <0>;
                        status = "okay";
			...
                };
                cpu@1 {
                        device_type = "cpu";
                        reg = <1>;
                        status = "fail";
			...
                };
        };

Currently, we only get cpu0 without cpu1 in the shell:
$ ls /sys/bus/cpu/devices/
cpu0

But it should be cpu0 online and cpu1 offline, then we could let
cpu1 online later by shell. This patch fixup the problem and let
us could make cpu1 online in the shell later after system boot:

$ ls /sys/bus/cpu/devices/
cpu0 cpu1
$ cat /sys/bus/cpu/devices/cpu0/online
1
$ cat /sys/bus/cpu/devices/cpu1/online
0

$ echo 224 > /sys/bus/cpu/devices/cpu1/hotplug/target
(cat /sys/devices/system/cpu/hotplug/states "224: online")
$ cat /sys/bus/cpu/devices/cpu1/online
1

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/kernel/cpu.c     |  5 -----
 arch/riscv/kernel/smpboot.c | 11 +++++++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 6d59e69..14f63fd 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -27,11 +27,6 @@ int riscv_of_processor_hartid(struct device_node *node)
 		return -ENODEV;
 	}
 
-	if (!of_device_is_available(node)) {
-		pr_info("CPU with hartid=%d is not available\n", hart);
-		return -ENODEV;
-	}
-
 	if (of_property_read_string(node, "riscv,isa", &isa)) {
 		pr_warn("CPU with hartid=%d has no \"riscv,isa\" property\n", hart);
 		return -ENODEV;
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index bd82375..c3b620b 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -37,6 +37,7 @@
 #include "head.h"
 
 static DECLARE_COMPLETION(cpu_running);
+static struct cpumask cpu_delay_available_mask = { CPU_BITS_NONE };
 
 void __init smp_prepare_boot_cpu(void)
 {
@@ -99,6 +100,11 @@ void __init setup_smp(void)
 			break;
 		}
 
+		if (!of_device_is_available(dn))
+			pr_info("CPU with hartid=%d is not available\n", hart);
+		else
+			cpumask_set_cpu(cpuid, &cpu_delay_available_mask);
+
 		cpuid_to_hartid_map(cpuid) = hart;
 		early_map_cpu_to_node(cpuid, of_node_to_nid(dn));
 		cpuid++;
@@ -131,6 +137,11 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 	int ret = 0;
 	tidle->thread_info.cpu = cpu;
 
+	if (!cpumask_test_cpu(cpu, &cpu_delay_available_mask)) {
+		cpumask_set_cpu(cpu, &cpu_delay_available_mask);
+		return -EIO;
+	}
+
 	ret = start_secondary_cpu(cpu, tidle);
 	if (!ret) {
 		wait_for_completion_timeout(&cpu_running,
-- 
2.7.4

