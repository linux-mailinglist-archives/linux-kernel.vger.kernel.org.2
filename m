Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561E044BE14
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 10:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhKJJyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 04:54:22 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14733 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhKJJyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 04:54:20 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Hq0Rw3Q8kzZd0T;
        Wed, 10 Nov 2021 17:49:16 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 10 Nov 2021 17:51:29 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500015.china.huawei.com
 (7.185.36.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 10 Nov
 2021 17:51:28 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
        <sudeep.holla@arm.com>, <peterz@infradead.org>,
        <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <weiyongjun1@huawei.com>
Subject: [PATCH] arch_topology: Fix missing clear cluster_cpumask in remove_cpu_topology()
Date:   Wed, 10 Nov 2021 17:58:56 +0800
Message-ID: <20211110095856.469360-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When testing cpu online and offline, warning happened like this:

[  146.746743] WARNING: CPU: 92 PID: 974 at kernel/sched/topology.c:2215 build_sched_domains+0x81c/0x11b0
[  146.749988] CPU: 92 PID: 974 Comm: kworker/92:2 Not tainted 5.15.0 #9
[  146.750402] Hardware name: Huawei TaiShan 2280 V2/BC82AMDDA, BIOS 1.79 08/21/2021
[  146.751213] Workqueue: events cpuset_hotplug_workfn
[  146.751629] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  146.752048] pc : build_sched_domains+0x81c/0x11b0
[  146.752461] lr : build_sched_domains+0x414/0x11b0
[  146.752860] sp : ffff800040a83a80
[  146.753247] x29: ffff800040a83a80 x28: ffff20801f13a980 x27: ffff20800448ae00
[  146.753644] x26: ffff800012a858e8 x25: ffff800012ea48c0 x24: 0000000000000000
[  146.754039] x23: ffff800010ab7d60 x22: ffff800012f03758 x21: 000000000000005f
[  146.754427] x20: 000000000000005c x19: ffff004080012840 x18: ffffffffffffffff
[  146.754814] x17: 3661613030303230 x16: 30303078303a3239 x15: ffff800011f92b48
[  146.755197] x14: ffff20be3f95cef6 x13: 2e6e69616d6f642d x12: 6465686373204c4c
[  146.755578] x11: ffff20bf7fc83a00 x10: 0000000000000040 x9 : 0000000000000000
[  146.755957] x8 : 0000000000000002 x7 : ffffffffe0000000 x6 : 0000000000000002
[  146.756334] x5 : 0000000090000000 x4 : 00000000f0000000 x3 : 0000000000000001
[  146.756705] x2 : 0000000000000080 x1 : ffff800012f03860 x0 : 0000000000000001
[  146.757070] Call trace:
[  146.757421]  build_sched_domains+0x81c/0x11b0
[  146.757771]  partition_sched_domains_locked+0x57c/0x978
[  146.758118]  rebuild_sched_domains_locked+0x44c/0x7f0
[  146.758460]  rebuild_sched_domains+0x2c/0x48
[  146.758791]  cpuset_hotplug_workfn+0x3fc/0x888
[  146.759114]  process_one_work+0x1f4/0x480
[  146.759429]  worker_thread+0x48/0x460
[  146.759734]  kthread+0x158/0x168
[  146.760030]  ret_from_fork+0x10/0x20
[  146.760318] ---[ end trace 82c44aad6900e81a ]---

For some architectures like risc-v and arm64 which use common code
clear_cpu_topology() in shutting down CPUx, When CONFIG_SCHED_CLUSTER
is set, cluster_sibling in cpu_topology of each sibling adjacent
to CPUx is missed clearing, this causes checking failed in
topology_span_sane() and rebuilding topology failure at end when CPU online.

Different sibling's cluster_sibling in cpu_topology[] when CPU92 offline
(CPU 92, 93, 94, 95 are in one cluster):

Before revision:
CPU                 [92]      [93]      [94]      [95]
cluster_sibling     [92]     [92-95]   [92-95]   [92-95]

After revision:
CPU                 [92]      [93]      [94]      [95]
cluster_sibling     [92]     [93-95]   [93-95]   [93-95]

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 drivers/base/arch_topology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 981e72a3dafb..ff16a36a908b 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -677,6 +677,8 @@ void remove_cpu_topology(unsigned int cpu)
 		cpumask_clear_cpu(cpu, topology_core_cpumask(sibling));
 	for_each_cpu(sibling, topology_sibling_cpumask(cpu))
 		cpumask_clear_cpu(cpu, topology_sibling_cpumask(sibling));
+	for_each_cpu(sibling, topology_cluster_cpumask(cpu))
+		cpumask_clear_cpu(cpu, topology_cluster_cpumask(sibling));
 	for_each_cpu(sibling, topology_llc_cpumask(cpu))
 		cpumask_clear_cpu(cpu, topology_llc_cpumask(sibling));
 
-- 
2.25.1

