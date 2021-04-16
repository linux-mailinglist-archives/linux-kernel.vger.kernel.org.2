Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153A2361A02
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 08:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbhDPGs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 02:48:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234935AbhDPGs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 02:48:28 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13G6YOFq001426;
        Fri, 16 Apr 2021 02:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=A6nVmjQztZTvcChu+qifanzMSg+rHEqZrtD8ahIx2BY=;
 b=fLzlOiZVy+jmmi38pu+IZQNXXLUwDSzXNRweWEILUvt+49CUGX/nX4Ahb1NboAREtbnM
 S3RQZtrLQgjytC/wWRPwcmBTzs64xJGDfe4XknrmhAEnn2YEKI4nUBPepl0kaBR97OPq
 vZdqtYH29USMEF4eKNCZGzk70MhW1ZyizwJfDImwJlv6FoGPl45nqBkqgcmAMK18cVU3
 mQ26qrBd3sDo2p5qmQ4ee2MmdeSLZiBjSKJRhHri1eZtqLp+h1pkYkJCBJ9RZx40ZqXG
 X71IS+sTXsK2a9r2OVkjaW1z1kdlEhHO14OS22VMan9dqzrtFgZqOesWyyEPIM3LvbpW aw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37xsvafxpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 02:48:00 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13G6YJKY017251;
        Fri, 16 Apr 2021 06:47:54 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 37u39hm9vg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 06:47:54 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13G6lT9e23265582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 06:47:29 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A96CD5204F;
        Fri, 16 Apr 2021 06:47:51 +0000 (GMT)
Received: from sjain014.ibmuc.com (unknown [9.85.105.90])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4214A52054;
        Fri, 16 Apr 2021 06:47:50 +0000 (GMT)
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     hbathini@linux.ibm.com, mahesh@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/kdump: fix kdump kernel hangup issue with hot add CPUs
Date:   Fri, 16 Apr 2021 12:17:49 +0530
Message-Id: <20210416064749.657585-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: D5go4RQXS4qo2nu0SP-jqzA_A6IV_OuG
X-Proofpoint-GUID: D5go4RQXS4qo2nu0SP-jqzA_A6IV_OuG
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_11:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104160049
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the kexec_file_load system call when system crashes on the hot add
CPU the capture kernel hangs and failed to collect the vmcore.

 Kernel panic - not syncing: sysrq triggered crash
 CPU: 24 PID: 6065 Comm: echo Kdump: loaded Not tainted 5.12.0-rc5upstream #54
 Call Trace:
 [c0000000e590fac0] [c0000000007b2400] dump_stack+0xc4/0x114 (unreliable)
 [c0000000e590fb00] [c000000000145290] panic+0x16c/0x41c
 [c0000000e590fba0] [c0000000008892e0] sysrq_handle_crash+0x30/0x40
 [c0000000e590fc00] [c000000000889cdc] __handle_sysrq+0xcc/0x1f0
 [c0000000e590fca0] [c00000000088a538] write_sysrq_trigger+0xd8/0x178
 [c0000000e590fce0] [c0000000005e9b7c] proc_reg_write+0x10c/0x1b0
 [c0000000e590fd10] [c0000000004f26d0] vfs_write+0xf0/0x330
 [c0000000e590fd60] [c0000000004f2aec] ksys_write+0x7c/0x140
 [c0000000e590fdb0] [c000000000031ee0] system_call_exception+0x150/0x290
 [c0000000e590fe10] [c00000000000ca5c] system_call_common+0xec/0x278
 --- interrupt: c00 at 0x7fff905b9664
 NIP:  00007fff905b9664 LR: 00007fff905320c4 CTR: 0000000000000000
 REGS: c0000000e590fe80 TRAP: 0c00   Not tainted  (5.12.0-rc5upstream)
 MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 28000242
       XER: 00000000
 IRQMASK: 0
 GPR00: 0000000000000004 00007ffff5fedf30 00007fff906a7300 0000000000000001
 GPR04: 000001002a7355b0 0000000000000002 0000000000000001 00007ffff5fef616
 GPR08: 0000000000000001 0000000000000000 0000000000000000 0000000000000000
 GPR12: 0000000000000000 00007fff9073a160 0000000000000000 0000000000000000
 GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
 GPR20: 0000000000000000 00007fff906a4ee0 0000000000000002 0000000000000001
 GPR24: 00007fff906a0898 0000000000000000 0000000000000002 000001002a7355b0
 GPR28: 0000000000000002 00007fff906a1790 000001002a7355b0 0000000000000002
 NIP [00007fff905b9664] 0x7fff905b9664
 LR [00007fff905320c4] 0x7fff905320c4
 --- interrupt: c00

When a system crashes on a CPU the same CPU is used to boot the capture
kernel. On the capture kernel boot path, there is a check that ensures
that the boot CPU must be present in the fdt passed to it and if not it
calls the BUG function that leads to system hang. We do see the capture
kernel hang when we crash on hot added CPUs because the capture kernel
fdt does not have the information of newly added CPUs, here is why.

When we prepare fdt for capture kernel we copy most of the content from
the fdt passed to the primary kernel including cpus node data. The fdt
passed to the primary kernel is also referred to as initial_boot_params.
In case we hot add a CPU the initial_boot_params do not get updated with
the new CPU information. Although we do re-run the kdump service to update
the kdump on cpu hot-add event but as the capture kernel fdt is prepared
from the initial_boot_params it lacks the CPUs node for hot added CPUs.

To ensure that the capture kernel fdt has the latest CPUs information we
update the entire cpus and its subnode data in capture kernel fdt whenever
kdump service is reloaded on CPU hotplug event. The hot added CPU data is
extracted from of_root device node and update in the capture kernel while
adding additional nodes and properties needed for capture kernel.

Fixes: 6ecd0163d360 ("powerpc/kexec_file: Add appropriate regions for memory reserve map")

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/kexec/file_load_64.c | 100 ++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 02b9e4d0dc40..63a30f1ddc2c 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -960,6 +960,99 @@ unsigned int kexec_fdt_totalsize_ppc64(struct kimage *image)
 	return fdt_size;
 }
 
+/**
+ * add_node_prop - Read property from device node structure and add
+ *			them to fdt.
+ * @fdt:		Flattened device tree of the kernel
+ * @node_offset:	offset of the node to add a property at
+ * np:			device node pointer
+ *
+ * Returns 0 on success, negative errno on error.
+ */
+int add_node_prop(void *fdt, int node_offset, const struct device_node *np)
+{
+	int ret = 0;
+	struct property *pp;
+	unsigned long flags;
+
+	if (!np)
+		return -EINVAL;
+
+	raw_spin_lock_irqsave(&devtree_lock, flags);
+	for (pp = np->properties; pp; pp = pp->next) {
+		ret = fdt_setprop(fdt, node_offset, pp->name,
+				  pp->value, pp->length);
+		if (ret < 0) {
+			pr_err("Unable to add %s property: %s\n",
+				pp->name, fdt_strerror(ret));
+			goto out;
+		}
+	}
+out:
+	raw_spin_unlock_irqrestore(&devtree_lock, flags);
+	return ret;
+}
+
+/**
+ * update_cpus_node - Update cpus node of flattened device-tree using of_root
+ *			device node.
+ * @fdt:		Flattened device tree of the kernel.
+ *
+ * Returns 0 on success, negative errno on error.
+ */
+int update_cpus_node(void *fdt)
+{
+	struct device_node *cpus_node, *dn;
+	int cpus_offset, cpus_subnode_off, ret = 0;
+
+	cpus_offset = fdt_path_offset(fdt, "/cpus");
+	if (cpus_offset == -FDT_ERR_NOTFOUND || cpus_offset > 0) {
+		if (cpus_offset > 0) {
+			ret = fdt_del_node(fdt, cpus_offset);
+			if (ret < 0) {
+				pr_err("Error deleting /cpus node: %s\n",
+				       fdt_strerror(ret));
+				return -EINVAL;
+			}
+		}
+
+		/* Add cpus node to fdt */
+		cpus_offset = fdt_add_subnode(fdt, fdt_path_offset(fdt, "/"),
+					      "cpus");
+		if (cpus_offset < 0) {
+			pr_err("Error creating /cpus node: %s\n",
+			       fdt_strerror(cpus_offset));
+			return -EINVAL;
+		}
+
+		/* Add cpus node properties */
+		cpus_node = of_find_node_by_path("/cpus");
+		ret = add_node_prop(fdt, cpus_offset, cpus_node);
+		if (ret < 0)
+			return ret;
+
+		/* Loop through all subnodes of cpus and add them to fdt */
+		for_each_node_by_type(dn, "cpu") {
+			cpus_subnode_off = fdt_add_subnode(fdt,
+							   cpus_offset,
+							   dn->full_name);
+			if (cpus_subnode_off < 0) {
+				pr_err("Unable to add %s subnode: %s\n",
+				       dn->full_name, fdt_strerror(cpus_subnode_off));
+				return cpus_subnode_off;
+			}
+			ret = add_node_prop(fdt, cpus_subnode_off, dn);
+			if (ret < 0)
+				return ret;
+		}
+	} else if (cpus_offset < 0) {
+		pr_err("Malformed device tree: error reading /cpus node: %s\n",
+		       fdt_strerror(cpus_offset));
+	}
+
+	return ret;
+}
+
 /**
  * setup_new_fdt_ppc64 - Update the flattend device-tree of the kernel
  *                       being loaded.
@@ -1020,6 +1113,13 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
 		}
 	}
 
+	/* Update cpus nodes information to account hotplug CPUs. */
+	if (image->type == KEXEC_TYPE_CRASH) {
+		ret =  update_cpus_node(fdt);
+		if (ret < 0)
+			return ret;
+	}
+
 	/* Update memory reserve map */
 	ret = get_reserved_memory_ranges(&rmem);
 	if (ret)
-- 
2.26.3

