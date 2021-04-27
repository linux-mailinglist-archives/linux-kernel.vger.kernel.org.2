Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806A436C834
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 17:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbhD0PCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 11:02:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2448 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235303AbhD0PCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 11:02:52 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13REWuPG070833;
        Tue, 27 Apr 2021 11:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=7AIAcyYnWEJi7Z3VOfsx+EQVI73ZeD/NdfRxJANGigQ=;
 b=Gy6P1cdBjkv3PHislalDQGb6idPUbRMzTaTTDE1BahciDNEKOSZ7ETSxyBTfD3fMsFWe
 q9Uhk5sIXMVev+UN9BPes3kSRvsuzAfT8F/8lDKG9xqkNLVUOGcSy0dmKzBTztzYPv7E
 A4tNAdxJ8PBuGC36uEug0o2Jl4NqJ1SULJccLcIbuw0VyCRzLT3nWO2jZfUw2T58rKW/
 hl54n0s+TnCotLpH2pYQ6FhQT0mOOmOiv3TpUa0jZTFIq593P6VmNajSrGDf+wEAq3pL
 4BK772CD+O8K2DCtQny/SE4i/ROH6zlPbo8Td9O1miLYPERXjH0l+CxKWngR55daHtS7 EQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 386m6fsg0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 11:01:19 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13REuq29030499;
        Tue, 27 Apr 2021 15:01:17 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 384ay80svj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 15:01:17 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13RF1Eot31785464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Apr 2021 15:01:14 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 472D052063;
        Tue, 27 Apr 2021 15:01:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.169.209])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 063E85204E;
        Tue, 27 Apr 2021 15:01:13 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Cc:     nathanl@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] pseries/drmem: update LMBs after LPM
Date:   Tue, 27 Apr 2021 17:01:13 +0200
Message-Id: <20210427150113.14368-1-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rZHl04XFvZIupWr2AHC99T0xd0xMwhkm
X-Proofpoint-ORIG-GUID: rZHl04XFvZIupWr2AHC99T0xd0xMwhkm
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-27_08:2021-04-27,2021-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104270105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a LPM, the device tree node ibm,dynamic-reconfiguration-memory may be
updated by the hypervisor in the case the NUMA topology of the LPAR's
memory is updated.

This is caught by the kernel, but the memory's node is updated because
there is no way to move a memory block between nodes.

If later a memory block is added or removed, drmem_update_dt() is called
and it is overwriting the DT node to match the added or removed LMB. But
the LMB's associativity node has not been updated after the DT node update
and thus the node is overwritten by the Linux's topology instead of the
hypervisor one.

Introduce a hook called when the ibm,dynamic-reconfiguration-memory node is
updated to force an update of the LMB's associativity.

Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 arch/powerpc/include/asm/drmem.h          |  1 +
 arch/powerpc/mm/drmem.c                   | 48 +++++++++++++++++++++++
 arch/powerpc/platforms/pseries/mobility.c |  9 +++++
 3 files changed, 58 insertions(+)

diff --git a/arch/powerpc/include/asm/drmem.h b/arch/powerpc/include/asm/drmem.h
index bf2402fed3e0..55c2c25085b0 100644
--- a/arch/powerpc/include/asm/drmem.h
+++ b/arch/powerpc/include/asm/drmem.h
@@ -111,6 +111,7 @@ int drmem_update_dt(void);
 int __init
 walk_drmem_lmbs_early(unsigned long node, void *data,
 		      int (*func)(struct drmem_lmb *, const __be32 **, void *));
+void drmem_update_lmbs(void);
 #endif
 
 static inline void invalidate_lmb_associativity_index(struct drmem_lmb *lmb)
diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
index 9af3832c9d8d..46074bdfdb3c 100644
--- a/arch/powerpc/mm/drmem.c
+++ b/arch/powerpc/mm/drmem.c
@@ -307,6 +307,54 @@ int __init walk_drmem_lmbs_early(unsigned long node, void *data,
 	return ret;
 }
 
+/*
+ * Update the LMB associativity index.
+ */
+static int update_lmb(struct drmem_lmb *updated_lmb,
+		      __maybe_unused const __be32 **usm,
+		      __maybe_unused void *data)
+{
+	struct drmem_lmb *lmb;
+
+	/*
+	 * Brut force there may be better way to fetch the LMB
+	 */
+	for_each_drmem_lmb(lmb) {
+		if (lmb->drc_index != updated_lmb->drc_index)
+			continue;
+
+		lmb->aa_index = updated_lmb->aa_index;
+		break;
+	}
+	return 0;
+}
+
+/*
+ * Update the LMB associativity index.
+ *
+ * This needs to be called when the hypervisor is updating the
+ * dynamic-reconfiguration-memory node property.
+ */
+void drmem_update_lmbs(void)
+{
+	struct device_node *node;
+	const __be32 *prop;
+
+	node = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+	if (!node)
+		return;
+
+	prop = of_get_property(node, "ibm,dynamic-memory", NULL);
+	if (prop) {
+		__walk_drmem_v1_lmbs(prop, NULL, NULL, update_lmb);
+	} else {
+		prop = of_get_property(node, "ibm,dynamic-memory-v2", NULL);
+		if (prop)
+			__walk_drmem_v2_lmbs(prop, NULL, NULL, update_lmb);
+	}
+
+	of_node_put(node);
+}
 #endif
 
 static int init_drmem_lmb_size(struct device_node *dn)
diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index ea4d6a660e0d..c68eccc6e8df 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -25,6 +25,7 @@
 
 #include <asm/machdep.h>
 #include <asm/rtas.h>
+#include <asm/drmem.h>
 #include "pseries.h"
 #include "../../kernel/cacheinfo.h"
 
@@ -237,6 +238,7 @@ int pseries_devicetree_update(s32 scope)
 	__be32 *data;
 	int update_nodes_token;
 	int rc;
+	bool drmem_updated = false;
 
 	update_nodes_token = rtas_token("ibm,update-nodes");
 	if (update_nodes_token == RTAS_UNKNOWN_SERVICE)
@@ -271,6 +273,10 @@ int pseries_devicetree_update(s32 scope)
 					continue;
 				}
 
+				if (!strcmp(np->full_name,
+					    "ibm,dynamic-reconfiguration-memory"))
+					drmem_updated = true;
+
 				switch (action) {
 				case DELETE_DT_NODE:
 					delete_dt_node(np);
@@ -293,6 +299,9 @@ int pseries_devicetree_update(s32 scope)
 	} while (rc == 1);
 
 	kfree(rtas_buf);
+
+	if (drmem_updated)
+		drmem_update_lmbs();
 	return rc;
 }
 
-- 
2.31.1

