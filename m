Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AB03B5946
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 08:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhF1Gw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 02:52:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229998AbhF1Gw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 02:52:28 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15S6Y7JZ082407;
        Mon, 28 Jun 2021 02:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=YfTpPSnEFYMdsQI3j/o0XCkg0sjH3kJiXSpVsYxwZ8g=;
 b=Tzz+putoyZz7ijPWlifXNMsD4jIViJ2dCMAVdsBkdpF43IDQ9yeBAp8Hf2PfgGbp2Prj
 vddCdht+ndJW8McBtyGv21HGQ4XPwpEIoZFvxs6ncBU0UAd4aXoheFVkMrdVAsl3jBQe
 +tWdUug6KfEGit7eiSn7u89oUQyjo9pm1y+Jqmoj5yhqFKOdC4a3kPCgyPXaaK8ccozV
 7tC5ay8t78MAa64bTZQI4z5LuiGl9AuBpDVdjiqsUlhYPlxj9KbDI3tHhcQdzZUb3IPd
 cVeb2PI5ETo8NxHCujbsyQ9FCSuzL6+60g6PPgoLEd28rNDwJJMbGTHDSWmuIGlFV5td hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39f8cash1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 02:49:53 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15S6ZwDf090070;
        Mon, 28 Jun 2021 02:49:52 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39f8cash1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 02:49:52 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15S6npG0014555;
        Mon, 28 Jun 2021 06:49:51 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 39duv8gm7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 06:49:50 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15S6mHdZ20054334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 06:48:17 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0B4868122;
        Mon, 28 Jun 2021 06:49:46 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0F8D680FE;
        Mon, 28 Jun 2021 06:49:38 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.85.15])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jun 2021 06:49:38 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     maddy@linux.vnet.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, pc@us.ibm.com, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, mpe@ellerman.id.au, ravi.bangoria@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        rnsastry@linux.ibm.com
Subject: [PATCH v2] perf vendor events power10: Adds 24x7 nest metric events for power10 platform
Date:   Mon, 28 Jun 2021 12:19:35 +0530
Message-Id: <20210628064935.163465-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: B5A4YHOfiZKh3rF1XqoP_9jQRFeGlQc2
X-Proofpoint-GUID: kYo2FN1AzmCcv6FXQXyJXSGH4FCALRPX
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_05:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106280045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds 24x7 nest metric events for POWER10.

Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 .../arch/powerpc/power10/nest_metrics.json    | 424 ++++++++++++++++++
 1 file changed, 424 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power10/nest_metrics.json

---
Changelog:
v1 -> v2
- Removed "BriefDescription" field as its value was same as "MetricName"
  field as suggested by Paul A. Clarke
- Added Tested-by tag.
---
diff --git a/tools/perf/pmu-events/arch/powerpc/power10/nest_metrics.json b/tools/perf/pmu-events/arch/powerpc/power10/nest_metrics.json
new file mode 100644
index 000000000000..8ba3e81c9808
--- /dev/null
+++ b/tools/perf/pmu-events/arch/powerpc/power10/nest_metrics.json
@@ -0,0 +1,424 @@
+[
+    {
+      "MetricName": "VEC_GROUP_PUMP_RETRY_RATIO_P01",
+      "MetricExpr": "(hv_24x7@PM_PB_RTY_VG_PUMP01\\,chip\\=?@ / hv_24x7@PM_PB_VG_PUMP01\\,chip\\=?@) * 100",
+      "ScaleUnit": "1%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "VEC_GROUP_PUMP_RETRY_RATIO_P23",
+      "MetricExpr": "(hv_24x7@PM_PB_RTY_VG_PUMP23\\,chip\\=?@ / hv_24x7@PM_PB_VG_PUMP23\\,chip\\=?@) * 100",
+      "ScaleUnit": "1%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "LOCAL_NODE_PUMP_RETRY_RATIO_P01",
+      "MetricExpr": "(hv_24x7@PM_PB_RTY_LNS_PUMP01\\,chip\\=?@ / hv_24x7@PM_PB_LNS_PUMP01\\,chip\\=?@) * 100",
+      "ScaleUnit": "1%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "LOCAL_NODE_PUMP_RETRY_RATIO_P23",
+      "MetricExpr": "(hv_24x7@PM_PB_RTY_LNS_PUMP23\\,chip\\=?@ / hv_24x7@PM_PB_LNS_PUMP23\\,chip\\=?@) * 100",
+      "ScaleUnit": "1%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "GROUP_PUMP_RETRY_RATIO_P01",
+      "MetricExpr": "(hv_24x7@PM_PB_RTY_GROUP_PUMP01\\,chip\\=?@ / hv_24x7@PM_PB_GROUP_PUMP01\\,chip\\=?@) * 100",
+      "ScaleUnit": "1%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "GROUP_PUMP_RETRY_RATIO_P23",
+      "MetricExpr": "(hv_24x7@PM_PB_RTY_GROUP_PUMP23\\,chip\\=?@ / hv_24x7@PM_PB_GROUP_PUMP23\\,chip\\=?@) * 100",
+      "ScaleUnit": "1%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_GROUP_PUMPS_P01",
+      "MetricExpr": "(hv_24x7@PM_PB_GROUP_PUMP01\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
+      "ScaleUnit": "4",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_GROUP_PUMPS_P23",
+      "MetricExpr": "(hv_24x7@PM_PB_GROUP_PUMP23\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
+      "ScaleUnit": "4",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_GROUP_PUMPS_RETRIES_P01",
+      "MetricExpr": "(hv_24x7@PM_PB_RTY_GROUP_PUMP01\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
+      "ScaleUnit": "4",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_GROUP_PUMPS_RETRIES_P23",
+      "MetricExpr": "(hv_24x7@PM_PB_RTY_GROUP_PUMP23\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
+      "ScaleUnit": "4",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "REMOTE_NODE_PUMPS_RETRIES_RATIO_P01",
+      "MetricExpr": "(hv_24x7@PM_PB_RTY_RNS_PUMP01\\,chip\\=?@ / hv_24x7@PM_PB_RNS_PUMP01\\,chip\\=?@) * 100",
+      "ScaleUnit": "1%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "REMOTE_NODE_PUMPS_RETRIES_RATIO_P23",
+      "MetricExpr": "(hv_24x7@PM_PB_RTY_RNS_PUMP23\\,chip\\=?@ / hv_24x7@PM_PB_RNS_PUMP23\\,chip\\=?@) * 100",
+      "ScaleUnit": "1%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_VECTOR_GROUP_PUMPS_P01",
+      "MetricExpr": "(hv_24x7@PM_PB_VG_PUMP01\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
+      "ScaleUnit": "4",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_VECTOR_GROUP_PUMPS_P23",
+      "MetricExpr": "(hv_24x7@PM_PB_VG_PUMP23\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
+      "ScaleUnit": "4",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_LOCAL_NODE_PUMPS_P01",
+      "MetricExpr": "(hv_24x7@PM_PB_LNS_PUMP01\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
+      "ScaleUnit": "4",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_LOCAL_NODE_PUMPS_P23",
+      "MetricExpr": "(hv_24x7@PM_PB_LNS_PUMP23\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
+      "ScaleUnit": "4",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_VECTOR_GROUP_PUMPS_RETRIES_P01",
+      "MetricExpr": "(hv_24x7@PM_PB_RTY_VG_PUMP01\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
+      "ScaleUnit": "4",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_VECTOR_GROUP_PUMPS_RETRIES_P23",
+      "MetricExpr": "(hv_24x7@PM_PB_RTY_VG_PUMP23\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
+      "ScaleUnit": "4",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_LOCAL_NODE_PUMPS_RETRIES_P01",
+      "MetricExpr": "(hv_24x7@PM_PB_RTY_LNS_PUMP01\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
+      "ScaleUnit": "4",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_LOCAL_NODE_PUMPS_RETRIES_P23",
+      "MetricExpr": "(hv_24x7@PM_PB_RTY_LNS_PUMP23\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
+      "ScaleUnit": "4",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_REMOTE_NODE_PUMPS_P01",
+      "MetricExpr": "(hv_24x7@PM_PB_RNS_PUMP01\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
+      "ScaleUnit": "4",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_REMOTE_NODE_PUMPS_P23",
+      "MetricExpr": "(hv_24x7@PM_PB_RNS_PUMP23\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
+      "ScaleUnit": "4",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_NEAR_NODE_PUMPS_P01",
+      "MetricExpr": "(hv_24x7@PM_PB_NNS_PUMP01\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
+      "ScaleUnit": "4",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_NEAR_NODE_PUMPS_P23",
+      "MetricExpr": "(hv_24x7@PM_PB_NNS_PUMP23\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
+      "ScaleUnit": "4",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_INT_PB_BW",
+      "MetricExpr": "(hv_24x7@PM_PB_INT_DATA_XFER\\,chip\\=?@)",
+      "ScaleUnit": "2.09MB",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "XLINK0_OUT_TOTAL_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_XLINK0_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_XLINK0_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_XLINK0_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK0_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "XLINK1_OUT_TOTAL_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_XLINK1_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_XLINK1_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_XLINK1_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK1_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "XLINK2_OUT_TOTAL_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_XLINK2_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_XLINK2_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_XLINK2_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK2_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "XLINK3_OUT_TOTAL_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_XLINK3_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_XLINK3_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_XLINK3_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK3_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "XLINK4_OUT_TOTAL_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_XLINK4_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_XLINK4_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_XLINK4_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK4_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "XLINK5_OUT_TOTAL_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_XLINK5_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_XLINK5_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_XLINK5_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK5_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "XLINK6_OUT_TOTAL_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_XLINK6_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_XLINK6_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_XLINK6_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK6_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "XLINK7_OUT_TOTAL_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_XLINK7_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_XLINK7_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_XLINK7_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK7_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "XLINK0_OUT_DATA_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_XLINK0_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_XLINK0_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_XLINK0_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK0_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1.063%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "XLINK1_OUT_DATA_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_XLINK1_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_XLINK1_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_XLINK1_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK1_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1.063%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "XLINK2_OUT_DATA_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_XLINK2_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_XLINK2_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_XLINK2_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK2_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1.063%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "XLINK3_OUT_DATA_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_XLINK3_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_XLINK3_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_XLINK3_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK3_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1.063%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "XLINK4_OUT_DATA_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_XLINK4_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_XLINK4_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_XLINK4_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK4_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1.063%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "XLINK5_OUT_DATA_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_XLINK5_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_XLINK5_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_XLINK5_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK5_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1.063%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "XLINK6_OUT_DATA_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_XLINK6_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_XLINK6_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_XLINK6_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK6_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1.063%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "XLINK7_OUT_DATA_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_XLINK7_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_XLINK7_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_XLINK7_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK7_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1.063%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "ALINK0_OUT_TOTAL_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_ALINK0_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_ALINK0_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_ALINK0_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK0_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "ALINK1_OUT_TOTAL_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_ALINK1_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_ALINK1_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_ALINK1_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK1_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "ALINK2_OUT_TOTAL_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_ALINK2_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_ALINK2_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_ALINK2_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK2_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "ALINK3_OUT_TOTAL_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_ALINK3_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_ALINK3_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_ALINK3_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK3_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "ALINK4_OUT_TOTAL_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_ALINK4_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_ALINK4_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_ALINK4_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK4_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "ALINK5_OUT_TOTAL_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_ALINK5_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_ALINK5_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_ALINK5_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK5_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "ALINK6_OUT_TOTAL_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_ALINK6_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_ALINK6_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_ALINK6_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK6_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "ALINK7_OUT_TOTAL_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_ALINK7_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_ALINK7_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_ALINK7_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK7_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "ALINK0_OUT_DATA_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_ALINK0_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_ALINK0_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_ALINK0_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK0_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1.063%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "ALINK1_OUT_DATA_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_ALINK1_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_ALINK1_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_ALINK1_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK1_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1.063%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "ALINK2_OUT_DATA_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_ALINK2_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_ALINK2_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_ALINK2_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK2_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1.063%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "ALINK3_OUT_DATA_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_ALINK3_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_ALINK3_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_ALINK3_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK3_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1.063%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "ALINK4_OUT_DATA_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_ALINK4_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_ALINK4_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_ALINK4_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK4_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1.063%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "ALINK5_OUT_DATA_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_ALINK5_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_ALINK5_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_ALINK5_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK5_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1.063%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "ALINK6_OUT_DATA_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_ALINK6_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_ALINK6_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_ALINK6_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK6_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1.063%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "ALINK7_OUT_DATA_UTILIZATION",
+      "MetricExpr": "((hv_24x7@PM_ALINK7_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_ALINK7_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_ALINK7_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK7_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
+      "ScaleUnit": "1.063%",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_DATA_BANDWIDTH_TRANSFERRED_OVER_PB_PCI1",
+      "MetricExpr": "(hv_24x7@PM_PCI1_32B_INOUT\\,chip\\=?@)",
+      "ScaleUnit": "3.28e-2MB",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_DATA_BANDWIDTH_TRANSFERRED_OVER_PB_PCI0",
+      "MetricExpr": "(hv_24x7@PM_PCI0_32B_INOUT\\,chip\\=?@)",
+      "ScaleUnit": "3.28e-2MB",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_MCS_READ_BW_MC0_CHAN01",
+      "MetricExpr": "(hv_24x7@PM_MCS_128B_RD_DATA_BLOCKS_MC0_CHAN01\\,chip\\=?@)",
+      "ScaleUnit": "5.24e-1MB",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_MCS_READ_BW_MC1_CHAN01",
+      "MetricExpr": "(hv_24x7@PM_MCS_128B_RD_DATA_BLOCKS_MC1_CHAN01\\,chip\\=?@)",
+      "ScaleUnit": "5.24e-1MB",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_MCS_READ_BW_MC2_CHAN01",
+      "MetricExpr": "(hv_24x7@PM_MCS_128B_RD_DATA_BLOCKS_MC2_CHAN01\\,chip\\=?@)",
+      "ScaleUnit": "5.24e-1MB",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_MCS_READ_BW_MC3_CHAN01",
+      "MetricExpr": "(hv_24x7@PM_MCS_128B_RD_DATA_BLOCKS_MC3_CHAN01\\,chip\\=?@)",
+      "ScaleUnit": "5.24e-1MB",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_MCS_WRITE_BW_MC0_CHAN01",
+      "MetricExpr": "(hv_24x7@PM_MCS_64B_WR_DATA_BLOCKS_MC0_CHAN01\\,chip\\=?@)",
+      "ScaleUnit": "2.6e-1MB",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_MCS_WRITE_BW_MC1_CHAN01",
+      "MetricExpr": "(hv_24x7@PM_MCS_64B_WR_DATA_BLOCKS_MC1_CHAN01\\,chip\\=?@)",
+      "ScaleUnit": "2.6e-1MB",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_MCS_WRITE_BW_MC2_CHAN01",
+      "MetricExpr": "(hv_24x7@PM_MCS_64B_WR_DATA_BLOCKS_MC2_CHAN01\\,chip\\=?@)",
+      "ScaleUnit": "2.6e-1MB",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "TOTAL_MCS_WRITE_BW_MC3_CHAN01",
+      "MetricExpr": "(hv_24x7@PM_MCS_64B_WR_DATA_BLOCKS_MC3_CHAN01\\,chip\\=?@)",
+      "ScaleUnit": "2.6e-1MB",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "Memory_RD_BW_Chip",
+      "MetricExpr": "(hv_24x7@PM_MCS_128B_RD_DATA_BLOCKS_MC0_CHAN01\\,chip\\=?@ + hv_24x7@PM_MCS_128B_RD_DATA_BLOCKS_MC1_CHAN01\\,chip\\=?@ + hv_24x7@PM_MCS_128B_RD_DATA_BLOCKS_MC2_CHAN01\\,chip\\=?@ + hv_24x7@PM_MCS_128B_RD_DATA_BLOCKS_MC3_CHAN01\\,chip\\=?@)",
+      "MetricGroup": "Memory_BW",
+      "ScaleUnit": "5.24e-1MB",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "Memory_WR_BW_Chip",
+      "MetricExpr": "(hv_24x7@PM_MCS_64B_WR_DATA_BLOCKS_MC0_CHAN01\\,chip\\=?@ + hv_24x7@PM_MCS_64B_WR_DATA_BLOCKS_MC1_CHAN01\\,chip\\=?@ + hv_24x7@PM_MCS_64B_WR_DATA_BLOCKS_MC2_CHAN01\\,chip\\=?@ + hv_24x7@PM_MCS_64B_WR_DATA_BLOCKS_MC3_CHAN01\\,chip\\=?@ )",
+      "MetricGroup": "Memory_BW",
+      "ScaleUnit": "2.6e-1MB",
+      "AggregationMode": "PerChip"
+    },
+    {
+      "MetricName": "PowerBUS_Frequency",
+      "MetricExpr": "(hv_24x7@PM_PAU_CYC\\,chip\\=?@ )",
+      "ScaleUnit": "2.56e-7GHz",
+      "AggregationMode": "PerChip"
+    }
+]
-- 
2.31.1

