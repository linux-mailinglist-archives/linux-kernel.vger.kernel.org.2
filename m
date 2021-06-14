Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D9E3A6DED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 20:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbhFNSGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 14:06:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40244 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233521AbhFNSGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 14:06:48 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15EI3XQc053980;
        Mon, 14 Jun 2021 14:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5KNJNUyCcJN0cQNyzgrWPEJC34g3Huz4QX45QiUE3og=;
 b=s0SYXt6XDLxGWY7trv96H21ZRK7hO5YNQfe5eBYoBRVoy7To7uoO7T4xvesghwp0VoqD
 KewNPCIPDuEvj34jDwwDBeUBxHci/tUXDu98G+m9Ud6o+HcCTmnRHcPZA9+7dD/ysRfh
 XMPgCKxSfTzGTqTSXR/NhpDKSUAqiVlJXedXwZ0eaTrxexENgJXt/BZnnDGWLYgLlDZt
 CZ7kCZjMoL8Kf7FX/vOIAEme4CxhlUcTjGUJp2RkbbPSQkCFIGA0mho4ACn00d3xFTf3
 Cq/fqxVyjQkQyS3/sHXRz5O91Hig7XzFKA+PSQWoCohShEfOLJAaE9AuzxZEsbir7UAW Aw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 396a0wkwk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 14:03:52 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15EHwnfl010843;
        Mon, 14 Jun 2021 18:03:50 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 394m6hs3hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 18:03:50 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15EI3mLr30605690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 18:03:48 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D01911C058;
        Mon, 14 Jun 2021 18:03:48 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15C8511C04A;
        Mon, 14 Jun 2021 18:03:45 +0000 (GMT)
Received: from naverao1-tp.in.ibm.com (unknown [9.85.73.215])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jun 2021 18:03:44 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anton Blanchard <anton@ozlabs.org>
Subject: [PATCH 1/2] trace/kprobe: Fix count of missed kretprobes in kprobe_profile
Date:   Mon, 14 Jun 2021 23:33:28 +0530
Message-Id: <2905f923966229953e6dc162b0a036853a420172.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Xv7BeUu8-eUUsARFCBBaxHnKTnZ7nxyY
X-Proofpoint-GUID: Xv7BeUu8-eUUsARFCBBaxHnKTnZ7nxyY
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-14_12:2021-06-14,2021-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a kretprobe, the miss count includes the number of times the probe
on function entry was missed, as well as the number of times we ran out
of kretprobe_instance structures due to maxactive being too low.

Fixes: cd7e7bd5e44718 ("tracing: Add kprobes event profiling interface")
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 kernel/trace/trace_kprobe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index ea6178cb5e334d..0475e2a6d0825e 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1192,7 +1192,8 @@ static int probes_profile_seq_show(struct seq_file *m, void *v)
 	seq_printf(m, "  %-44s %15lu %15lu\n",
 		   trace_probe_name(&tk->tp),
 		   trace_kprobe_nhit(tk),
-		   tk->rp.kp.nmissed);
+		   trace_kprobe_is_return(tk) ? tk->rp.kp.nmissed + tk->rp.nmissed
+					      : tk->rp.kp.nmissed);
 
 	return 0;
 }
-- 
2.31.1

