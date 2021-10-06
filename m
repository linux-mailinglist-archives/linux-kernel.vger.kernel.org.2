Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7AA423FD0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238857AbhJFOKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:10:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238779AbhJFOKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:10:16 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196DWKK6023869;
        Wed, 6 Oct 2021 10:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4KWtlySNTnqXB8CFgnNbWgTinUBqt+TDSXQNhwqkcs0=;
 b=lSETY6R3bpYae7u8EHTsCLW8Maa80rm5bm9cK5rb0yVe9XxEEPh45vtyOFio+yy54ubn
 a+acOuMKNZNEGCkGqQ+gswdYSSSBXsOenwPQNNWZidJ8frTKABoBrLYI83jVnoqJgoEA
 lt1eQWSooBU3lqdt1UQpfMLnFvVi54DOlbeXo7yPA2vOVE9IY7l4+DknlUM7ljPbpr8z
 SjB2AVVrmfnziPjBdxuYKC9pNAEe+n5iwcAmfpzxo6MQp1M3Qb4MxeP52Cr9zqb6NBcc
 iObOu2Rp054PqhqZpOdcn5Md69Gc9JsHW8x/NNwm5n4ywymprN2/ZsswoDDqaLu8L2p7 TA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bhcs68ypn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 10:07:44 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 196E1mC2005878;
        Wed, 6 Oct 2021 10:07:44 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bhcs68ynn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 10:07:44 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 196DwkIg015390;
        Wed, 6 Oct 2021 14:07:41 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3bef2b6akg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 14:07:40 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 196E2Ggn53936608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Oct 2021 14:02:16 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07F62A4060;
        Wed,  6 Oct 2021 14:07:36 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5B74A4064;
        Wed,  6 Oct 2021 14:07:27 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.124.20])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Oct 2021 14:07:27 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, ak@linux.intel.com
Cc:     linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        yao.jin@linux.intel.com, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, kan.liang@linux.intel.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        paulus@samba.org, kjain@linux.ibm.com
Subject: [PATCH v3 1/4] perf: Add comment about current state of PERF_MEM_LVL_* namespace and remove an extra line
Date:   Wed,  6 Oct 2021 19:36:51 +0530
Message-Id: <20211006140654.298352-2-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211006140654.298352-1-kjain@linux.ibm.com>
References: <20211006140654.298352-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3agWfNwfHDGrZ5vzxMJ208teVhN4Y2-g
X-Proofpoint-ORIG-GUID: NiEWR37CB5qrM2xu2pQ3Dbmz3dUchZRx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_03,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a comment about PERF_MEM_LVL_* namespace being depricated
to some extent in favour of added PERF_MEM_{LVLNUM_,REMOTE_,SNOOPX_}
fields.

Remove an extra line present in perf_mem__lvl_scnprintf function.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 include/uapi/linux/perf_event.h       | 8 +++++++-
 tools/include/uapi/linux/perf_event.h | 8 +++++++-
 tools/perf/util/mem-events.c          | 1 -
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index f92880a15645..e1701e9c7858 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1241,7 +1241,13 @@ union perf_mem_data_src {
 #define PERF_MEM_OP_EXEC	0x10 /* code (execution) */
 #define PERF_MEM_OP_SHIFT	0
 
-/* memory hierarchy (memory level, hit or miss) */
+/*
+ * PERF_MEM_LVL_* namespace being depricated to some extent in the
+ * favour of newer composite PERF_MEM_{LVLNUM_,REMOTE_,SNOOPX_} fields.
+ * Supporting this namespace inorder to not break defined ABIs.
+ *
+ * memory hierarchy (memory level, hit or miss)
+ */
 #define PERF_MEM_LVL_NA		0x01  /* not available */
 #define PERF_MEM_LVL_HIT	0x02  /* hit level */
 #define PERF_MEM_LVL_MISS	0x04  /* miss level  */
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index f92880a15645..e1701e9c7858 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1241,7 +1241,13 @@ union perf_mem_data_src {
 #define PERF_MEM_OP_EXEC	0x10 /* code (execution) */
 #define PERF_MEM_OP_SHIFT	0
 
-/* memory hierarchy (memory level, hit or miss) */
+/*
+ * PERF_MEM_LVL_* namespace being depricated to some extent in the
+ * favour of newer composite PERF_MEM_{LVLNUM_,REMOTE_,SNOOPX_} fields.
+ * Supporting this namespace inorder to not break defined ABIs.
+ *
+ * memory hierarchy (memory level, hit or miss)
+ */
 #define PERF_MEM_LVL_NA		0x01  /* not available */
 #define PERF_MEM_LVL_HIT	0x02  /* hit level */
 #define PERF_MEM_LVL_MISS	0x04  /* miss level  */
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index f0e75df72b80..ff7289e28192 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -320,7 +320,6 @@ int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 	/* already taken care of */
 	m &= ~(PERF_MEM_LVL_HIT|PERF_MEM_LVL_MISS);
 
-
 	if (mem_info && mem_info->data_src.mem_remote) {
 		strcat(out, "Remote ");
 		l += 7;
-- 
2.26.2

