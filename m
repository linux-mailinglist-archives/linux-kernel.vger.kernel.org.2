Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A54422210
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhJEJWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:22:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233490AbhJEJWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:22:30 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1957aojb010394;
        Tue, 5 Oct 2021 05:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4enNdl2kR8LMd3UN5l3K5mtS1CQB7Mo+IxOA3PfIPWA=;
 b=M7YPzYEZFSRxu4pLEsYs1DYKjwjRslVZ3PjGOknXW5gfgyP4PAVL2z8A0KnwrncRDyjN
 EIQd10i0TNzInzv1KXx5nq0ts8Xx60I0paiIUo5UBm5K1dbvnrHDemnR98ohdDsMNyAy
 WbUJ5pjqdprwq9Bt5YixWiY+65Wo8Z10y2UtRUDNNRPe8a5pzZkIeG+K0llJItTp62Jd
 erWYYt80oryzR4zjqBSP85ysFoDgdFtHTSuMBPKjdFm4UOXkiVLGU+H6rXHIh6NLxMmR
 BpSQkw9jyDgmHE7vpzw6ZEdM2r/1VhYTNSEntgCJYQ1ujCHfEg7mx5AYv7aborXp1ATR bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bghr0k4td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 05:19:59 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1958xDGA021006;
        Tue, 5 Oct 2021 05:19:58 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bghr0k4t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 05:19:58 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1959DFv8025259;
        Tue, 5 Oct 2021 09:19:56 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 3bef29pbb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 09:19:56 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1959JpU239387440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Oct 2021 09:19:51 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5169BA406F;
        Tue,  5 Oct 2021 09:19:51 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19EBEA4080;
        Tue,  5 Oct 2021 09:19:44 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.64.84])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Oct 2021 09:19:43 +0000 (GMT)
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
Subject: [PATCH 4/4] powerpc/perf: Fix data source encodings for L2.1 and L3.1 accesses
Date:   Tue,  5 Oct 2021 14:48:37 +0530
Message-Id: <20211005091837.250044-4-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211005091837.250044-1-kjain@linux.ibm.com>
References: <20211005091837.250044-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IaifetT0ByICvxcnB09ZVfnIwt83bn2C
X-Proofpoint-GUID: qVhqqRJsv84Z3zLGOYD5D7sq9rG5DgoX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-04_05,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 mlxscore=0 clxscore=1015 adultscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050052
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the data source encodings to represent L2.1/L3.1(another core's
L2/L3 on the same chip) accesses properly for power10 and older
plaforms.

Add new macros(LEVEL/REM) which can be used to add mem_lvl_num and remote
field data inside perf_mem_data_src structure.

Result in power9 system with patch changes:

localhost:~/linux/tools/perf # ./perf mem report | grep Remote
     0.01%             1  236           Remote core, same chip L3 or L3 hit  [.] 0x0000000000002dd0                producer_consumer   [.] 0x00007fffadd4cc10        
anon               HitM          N/A                     No       N/A        0              0            
     0.01%             1  208           Remote core, same chip L3 or L3 hit  [.] 0x0000000000002dd0                producer_consumer   [.] 0x00007fff9dd33710        
anon               HitM          N/A                     No       N/A        0              0            
     0.00%             1  176           Remote core, same chip L3 or L3 hit  [.] 0x0000000000002dd0                producer_consumer   [.] 0x00007fff9b22c290        
anon               HitM          N/A                     No       N/A        0              0 

Fixes: 79e96f8f930d ("powerpc/perf: Export memory hierarchy info to user
space")
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 arch/powerpc/perf/isa207-common.c | 26 +++++++++++++++++++++-----
 arch/powerpc/perf/isa207-common.h |  2 ++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index f92bf5f6b74f..7ea873ab2e6f 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -238,11 +238,27 @@ static inline u64 isa207_find_source(u64 idx, u32 sub_idx)
 		ret |= P(SNOOP, HIT);
 		break;
 	case 5:
-		ret = PH(LVL, REM_CCE1);
-		if ((sub_idx == 0) || (sub_idx == 2) || (sub_idx == 4))
-			ret |= P(SNOOP, HIT);
-		else if ((sub_idx == 1) || (sub_idx == 3) || (sub_idx == 5))
-			ret |= P(SNOOP, HITM);
+		if (cpu_has_feature(CPU_FTR_ARCH_31)) {
+			ret = REM | P(HOPS, 0);
+
+			if (sub_idx == 0 || sub_idx == 4)
+				ret |= PH(LVL, L2) | LEVEL(L2) | P(SNOOP, HIT);
+			else if (sub_idx == 1 || sub_idx == 5)
+				ret |= PH(LVL, L2) | LEVEL(L2) | P(SNOOP, HITM);
+			else if (sub_idx == 2 || sub_idx == 6)
+				ret |= PH(LVL, L3) | LEVEL(L3) | P(SNOOP, HIT);
+			else if (sub_idx == 3 || sub_idx == 7)
+				ret |= PH(LVL, L3) | LEVEL(L3) | P(SNOOP, HITM);
+		} else {
+			if (sub_idx == 0)
+				ret = PH(LVL, L2) | LEVEL(L2) | REM | P(SNOOP, HIT) | P(HOPS, 0);
+			else if (sub_idx == 1)
+				ret = PH(LVL, L2) | LEVEL(L2) | REM | P(SNOOP, HITM) | P(HOPS, 0);
+			else if (sub_idx == 2 || sub_idx == 4)
+				ret = PH(LVL, L3) | LEVEL(L3) | REM | P(SNOOP, HIT) | P(HOPS, 0);
+			else if (sub_idx == 3 || sub_idx == 5)
+				ret = PH(LVL, L3) | LEVEL(L3) | REM | P(SNOOP, HITM) | P(HOPS, 0);
+		}
 		break;
 	case 6:
 		ret = PH(LVL, REM_CCE2);
diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-common.h
index 4a2cbc3dc047..ff122603989b 100644
--- a/arch/powerpc/perf/isa207-common.h
+++ b/arch/powerpc/perf/isa207-common.h
@@ -273,6 +273,8 @@
 #define P(a, b)				PERF_MEM_S(a, b)
 #define PH(a, b)			(P(LVL, HIT) | P(a, b))
 #define PM(a, b)			(P(LVL, MISS) | P(a, b))
+#define LEVEL(x)			P(LVLNUM, x)
+#define REM				P(REMOTE, REMOTE)
 
 int isa207_get_constraint(u64 event, unsigned long *maskp, unsigned long *valp, u64 event_config1);
 int isa207_compute_mmcr(u64 event[], int n_ev,
-- 
2.26.2

