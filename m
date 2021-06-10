Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580ED3A28A0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFJJq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:46:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229895AbhFJJqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:46:55 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15A9XcqQ114272;
        Thu, 10 Jun 2021 05:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=f9KSn0OK7lmxObfPsaPKUYTLBPWHeDf1j4FYQO0jMoo=;
 b=ocyeH7PvboA2v8nz8n/G/lltWV8s6Pc04wHkBWNYlQHnH6uJU712W6sjKz5ASxtaMi0a
 MI8DJ3/u3ZzBF28aZEXmYIss5N+MwZW2KFJ46LkHxbtGDaJAcOokQHKsfFhIkKHUemXF
 IKnAESW6vdz1xauhTeD0LF8IvGoVwgNmgOV3lL+LGPRTOH2qUu+APzlBZcaZrF3SSZ70
 kmOYwZvoIZGBH+WBEh1hbuXZfGFCIyMGD5jgP+c6eaaQGW/DYl5N85Gh2U9WxEo38OXv
 VcK6wOE/NXIGUc8L3lrKeMNsLB8LcfpJ93YDMXUSPLb/iB6EHgRTVfsHgWRu4XM3tGB3 ag== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 393g3y0fv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 05:44:58 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15A9iui1024934;
        Thu, 10 Jun 2021 09:44:56 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 392e798jb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 09:44:56 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15A9irEV28049862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 09:44:53 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E5734C046;
        Thu, 10 Jun 2021 09:44:53 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FC3B4C040;
        Thu, 10 Jun 2021 09:44:51 +0000 (GMT)
Received: from naverao1-tp.in.ibm.com (unknown [9.85.115.173])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Jun 2021 09:44:50 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     <linux-kernel@vger.kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH] tools/perf probe: Print a hint if adding a probe fails
Date:   Thu, 10 Jun 2021 15:14:42 +0530
Message-Id: <20210610094442.1602714-1-naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WW-ZiUoUVEdnndFPnjPYJV6sqJmYIdta
X-Proofpoint-ORIG-GUID: WW-ZiUoUVEdnndFPnjPYJV6sqJmYIdta
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-10_05:2021-06-10,2021-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106100062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a probe can fail in a few scenarios. perf already checks for the
address in the kprobe blacklist. However, the address could still be a
jump label, or have a BUG_ON(). In such cases, it isn't always evident
why adding the probe failed. Add a hint so that the user knows how to
proceed.

Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/perf/builtin-probe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 6b150756677014..ff9f3fdce600dd 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -352,8 +352,11 @@ static int perf_add_probe_events(struct perf_probe_event *pevs, int npevs)
 	}
 
 	ret = apply_perf_probe_events(pevs, npevs);
-	if (ret < 0)
+	if (ret < 0) {
+		pr_info("Hint: Check dmesg to understand reason for probe failure.\n"
+			"      Consider probing at the next/previous instruction.\n");
 		goto out_cleanup;
+	}
 
 	for (i = k = 0; i < npevs; i++)
 		k += pevs[i].ntevs;

base-commit: 0808b3d5b7514dc856178dbc509929329bbf301d
-- 
2.31.1

