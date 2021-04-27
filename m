Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C556436CAF4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 20:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237442AbhD0SOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:14:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24400 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230219AbhD0SOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:14:35 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13RI5CAV122961;
        Tue, 27 Apr 2021 14:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=R9zm+f5RhKa+r4dIyYopvlIibbS74PqJvmjjiHrXeww=;
 b=nJf5057ZefrLwRC4UormFO/CI33hX5n27rtZVXlRTaQ6RTWvLnPj0bk5M+PonNjP1BJ9
 zcQ7R8e/OxnqprXfIjgdDyCcvvDsOLloYWJQTF+wbY1HIevszo9TYdrql+qjOwE60Rr9
 ITwvh/zUcdryPnS/FJ3qWOVYLHPSXoHQxcRIf6FHHiaGSdiews67QeGXIMhX7eifEqXf
 SLvJx55CIeSb/KvZgN1zfe/8P6LZOyselB9m95LZ2o30ULjOkBJ5Itiwm+A87xF5uy/P
 s9bBgTuo27rrm0feIyTVAHLJadoG9nfwHWwP0tixopf9RGhD/lQRU+ccSKrdmNQvTIwa Xw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 386hjcnp39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 14:13:15 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13RIDDfb006026;
        Tue, 27 Apr 2021 18:13:13 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 384gjxrsnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 18:13:13 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13RID9tY36307440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Apr 2021 18:13:09 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39CACAE053;
        Tue, 27 Apr 2021 18:13:09 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDB20AE051;
        Tue, 27 Apr 2021 18:13:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.169.209])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Apr 2021 18:13:08 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Cc:     nathanl@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH] pseries/drmem: update LMBs after LPM
Date:   Tue, 27 Apr 2021 20:13:08 +0200
Message-Id: <20210427181308.17640-1-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Tdwrs3m2w6nrHWhSjUY0257SShcRYiF-
X-Proofpoint-GUID: Tdwrs3m2w6nrHWhSjUY0257SShcRYiF-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-27_10:2021-04-27,2021-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104270122
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

Cc: Tyrel Datwyler <tyreld@linux.ibm.com>
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

Change since V1:
 - Take Tyrel's idea to rely on OF_RECONFIG_UPDATE_PROPERTY instead of
 introducing a new hook mechanism.
---
 arch/powerpc/include/asm/drmem.h              |  1 +
 arch/powerpc/mm/drmem.c                       | 35 +++++++++++++++++++
 .../platforms/pseries/hotplug-memory.c        |  4 +++
 3 files changed, 40 insertions(+)

diff --git a/arch/powerpc/include/asm/drmem.h b/arch/powerpc/include/asm/drmem.h
index bf2402fed3e0..4265d5e95c2c 100644
--- a/arch/powerpc/include/asm/drmem.h
+++ b/arch/powerpc/include/asm/drmem.h
@@ -111,6 +111,7 @@ int drmem_update_dt(void);
 int __init
 walk_drmem_lmbs_early(unsigned long node, void *data,
 		      int (*func)(struct drmem_lmb *, const __be32 **, void *));
+void drmem_update_lmbs(struct property *prop);
 #endif
 
 static inline void invalidate_lmb_associativity_index(struct drmem_lmb *lmb)
diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
index 9af3832c9d8d..f0a6633132af 100644
--- a/arch/powerpc/mm/drmem.c
+++ b/arch/powerpc/mm/drmem.c
@@ -307,6 +307,41 @@ int __init walk_drmem_lmbs_early(unsigned long node, void *data,
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
+void drmem_update_lmbs(struct property *prop)
+{
+	if (!strcmp(prop->name, "ibm,dynamic-memory"))
+		__walk_drmem_v1_lmbs(prop->value, NULL, NULL, update_lmb);
+	else if (!strcmp(prop->name, "ibm,dynamic-memory-v2"))
+		__walk_drmem_v2_lmbs(prop->value, NULL, NULL, update_lmb);
+}
 #endif
 
 static int init_drmem_lmb_size(struct device_node *dn)
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 8377f1f7c78e..8aabaafc484b 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -949,6 +949,10 @@ static int pseries_memory_notifier(struct notifier_block *nb,
 	case OF_RECONFIG_DETACH_NODE:
 		err = pseries_remove_mem_node(rd->dn);
 		break;
+	case OF_RECONFIG_UPDATE_PROPERTY:
+		if (!strcmp(rd->dn->full_name,
+			    "ibm,dynamic-reconfiguration-memory"))
+			drmem_update_lmbs(rd->prop);
 	}
 	return notifier_from_errno(err);
 }
-- 
2.31.1

