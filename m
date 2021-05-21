Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A7A38C005
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 08:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbhEUGvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 02:51:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36324 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234263AbhEUGv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 02:51:26 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14L6X1hK012561;
        Fri, 21 May 2021 02:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ymDeylJangw7nOX6G6aeGJhUy89KTLxX3webakQi5Vc=;
 b=Ds2yJKDfDasO+7mfQ6bzaBDEq6vVwrN+cq2eD2hUcb5vLNLmmUTd9qb0hpClBGkFcR8a
 4L8aiYYG0u53hmExr8Zx6dF6iB1XZrPALncqOzJd6i3EqSuA6RxlR/C1+M4hdonW7qF2
 vNqC0XoTuxREQhgO3d+8JS/cfx0CEke8cZgCKD2vtNnNsWDJn4E8/FwbD7jYn3Q9+gze
 RDkR4BqCtJhZ9V1R5Nwwrbp5jrru1b8eQeZ/8xXWmqqgFEnXPiVg1iWyHSjxoJDOCCuJ
 RgFieOSUfYVPCqnHzUjz0Tx9JZetdLpvjJal3hwj26vX6tGpLt2dcxMPzVymu4QC6fJt 4g== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38p7dg0rhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 02:49:29 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14L6ln2W022117;
        Fri, 21 May 2021 06:49:27 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 38m19ss210-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 06:49:27 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14L6nOZv18940194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 06:49:25 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D599542041;
        Fri, 21 May 2021 06:49:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50C514203F;
        Fri, 21 May 2021 06:49:22 +0000 (GMT)
Received: from naverao1-tp.in.ibm.com (unknown [9.85.72.15])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 May 2021 06:49:22 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Suchanek <msuchanek@suse.de>,
        Torsten Duwe <duwe@suse.de>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 5/6] powerpc/stacktrace: Include ftraced function in arch_stack_walk_reliable()
Date:   Fri, 21 May 2021 12:18:40 +0530
Message-Id: <6f899750554d6ac257eed2a7e0f8a641ca8df97a.1621577151.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1621577151.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1621577151.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IArA6xMsx5DVGqJM5eUCAcU3Ota5Ms-h
X-Proofpoint-ORIG-GUID: IArA6xMsx5DVGqJM5eUCAcU3Ota5Ms-h
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-21_03:2021-05-20,2021-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210043
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With -mprofile-kernel and ppc32, the function tracer is invoked before a
function sets up its own stackframe. This results in the traced function
not appearing in stack traces. Fix this by checking for ftrace entry and
including the traced function in the stack trace.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
While I don't think we expect to see ftrace show up in the trace for a 
non-running task, I think it is good to cover this scenario. I also 
think it is ok to consider such traces to be reliable. But, I'm not sure 
of the implications w.r.t livepatching.

- Naveen


 arch/powerpc/kernel/stacktrace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index 1deb1bf331ddbd..1e1be297c5d6c7 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -160,6 +160,10 @@ int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry,
 
 		if (!consume_entry(cookie, ip))
 			return -EINVAL;
+
+		ip = ftrace_get_traced_func_if_no_stackframe(ip, stack);
+		if (ip && !consume_entry(cookie, ip))
+			return -EINVAL;
 	}
 	return 0;
 }
-- 
2.30.2

