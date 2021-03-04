Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4666632CCDD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 07:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbhCDGb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 01:31:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38988 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235205AbhCDGbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 01:31:25 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1246DimX136014;
        Thu, 4 Mar 2021 01:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Dij8OccllGGrXisgPNHTQID91WD5IUGjxG0idlr32BM=;
 b=rgY9heFxv/hrbrkfYH0iiiHoMaOzxt0Xf0zrNvkLBnJkP2N/jSKvEaOMrm5ax9FEu6n5
 X9Vt+7GF0RRrrO9VczbuDlbe04WQYV2Z/nN+e9foaaZ0UNvP6dGAtFISPgqlvhZIT7Uq
 V/6gu4hEuo6tmHUntHpbLJoChf/T05u5zaMhktlP5yLLWh0MqbSyjj2CnTM7Dn/WgEpZ
 05RO4JJmoRh9XZdJ35LtdAwlpVwXlHcTdtR+QUDUXbECxczjxVVsG9fj042nJ23Wfxbh
 3rgO82GjlGsh5xMsXUSnZ6wJZdzdisG/wZ1L9tQb1gD5yv6pNTxAQTcX4V7h4pSUgFMX Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 372m800f9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 01:30:42 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1246JtCE156690;
        Thu, 4 Mar 2021 01:30:42 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 372m800f88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 01:30:41 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1246InR4027524;
        Thu, 4 Mar 2021 06:30:39 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3712fmjf42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 06:30:39 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1246UbsN36831678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Mar 2021 06:30:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 422F952057;
        Thu,  4 Mar 2021 06:30:37 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.37.77])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6090B5205F;
        Thu,  4 Mar 2021 06:30:35 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@kernel.org
Cc:     ravi.bangoria@linux.ibm.com, jolsa@redhat.com, namhyung@kernel.org,
        atrajeev@linux.vnet.ibm.com, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf report: Fix -F for branch & mem modes
Date:   Thu,  4 Mar 2021 11:59:58 +0530
Message-Id: <20210304062958.85465-1-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_01:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103040025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf report fails to add valid additional fields with -F when
used with branch or mem modes. Fix it.

Before patch:

  $ ./perf record -b
  $ ./perf report -b -F +srcline_from --stdio
  Error:
  Invalid --fields key: `srcline_from'

After patch:

  $ ./perf report -b -F +srcline_from --stdio
  # Samples: 8K of event 'cycles'
  # Event count (approx.): 8784
  ...

Reported-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Fixes: aa6b3c99236b ("perf report: Make -F more strict like -s")
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/util/sort.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 0d5ad42812b9..552b590485bf 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -3140,7 +3140,7 @@ int output_field_add(struct perf_hpp_list *list, char *tok)
 		if (strncasecmp(tok, sd->name, strlen(tok)))
 			continue;
 
-		if (sort__mode != SORT_MODE__MEMORY)
+		if (sort__mode != SORT_MODE__BRANCH)
 			return -EINVAL;
 
 		return __sort_dimension__add_output(list, sd);
@@ -3152,7 +3152,7 @@ int output_field_add(struct perf_hpp_list *list, char *tok)
 		if (strncasecmp(tok, sd->name, strlen(tok)))
 			continue;
 
-		if (sort__mode != SORT_MODE__BRANCH)
+		if (sort__mode != SORT_MODE__MEMORY)
 			return -EINVAL;
 
 		return __sort_dimension__add_output(list, sd);
-- 
2.29.2

