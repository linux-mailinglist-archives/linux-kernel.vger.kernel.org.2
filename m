Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9AF3A6DEE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 20:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbhFNSGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 14:06:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234656AbhFNSGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 14:06:51 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15EI3MiZ005622;
        Mon, 14 Jun 2021 14:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=U8VkOul3kf5I10Jf+wN1qQWE0VKiC12yPJN6UWiJ8Jc=;
 b=k/281E/WU05fmF7Rm1j4XETflYRSntLAkU/FKydBA4624If4Ry/Sph9QvmkAsHHVJ/ip
 bRili8t0rX1F9NlfccFfxDKBgBRn5C8CbBL/qVwBVHay2iWaK9ZNHvkxstI8afwoyWkj
 LNHMtkSE5O+v+Sini7XlnFUxh+f0WdmCP9wsxQGKT7UX9WeBjbm7lFZVEvEML5A2f1al
 yxkmB0hfKacMssgaSq4MNMXmus+7b7+DevUYFEClgQ+J/Yjem/5Bpo3htm+R9eRbq/QN
 SYw5yRGWqpb225uFT998IM2JwRLuz+kT2tAqHKYVDkmcjSLMpGrlswyTrad0v46coeN9 Fw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 396bax99ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 14:03:57 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15EHxs8S018291;
        Mon, 14 Jun 2021 18:03:55 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 395c3t8c41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 18:03:55 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15EI3qFI28115286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 18:03:52 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC5B911C052;
        Mon, 14 Jun 2021 18:03:52 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7A3E11C050;
        Mon, 14 Jun 2021 18:03:49 +0000 (GMT)
Received: from naverao1-tp.in.ibm.com (unknown [9.85.73.215])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jun 2021 18:03:49 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anton Blanchard <anton@ozlabs.org>
Subject: [PATCH 2/2] trace/kprobe: Remove limit on kretprobe maxactive
Date:   Mon, 14 Jun 2021 23:33:29 +0530
Message-Id: <a751a0617a2c06e7e233f2c98ccabe8b94a8076d.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mYqy4wIQyVDYgD5lqWDY7dBebx9lf_vT
X-Proofpoint-ORIG-GUID: mYqy4wIQyVDYgD5lqWDY7dBebx9lf_vT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-14_12:2021-06-14,2021-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=999 bulkscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106140110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently limit maxactive for a kretprobe to 4096 when registering
the same through tracefs. The comment indicates that this is done so as
to keep list traversal reasonable. However, we don't ever iterate over
all kretprobe_instance structures. The core kprobes infrastructure also
imposes no such limitation.

Remove the limit from the tracefs interface. This limit is easy to hit
on large cpu machines when tracing functions that can sleep.

Reported-by: Anton Blanchard <anton@ozlabs.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 kernel/trace/trace_kprobe.c                               | 8 --------
 kernel/trace/trace_probe.h                                | 1 -
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc          | 1 -
 .../selftests/ftrace/test.d/kprobe/kretprobe_maxactive.tc | 3 ---
 4 files changed, 13 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 0475e2a6d0825e..b3e214980eed3d 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -21,7 +21,6 @@
 #include "trace_probe_tmpl.h"
 
 #define KPROBE_EVENT_SYSTEM "kprobes"
-#define KRETPROBE_MAXACTIVE_MAX 4096
 
 /* Kprobe early definition from command line */
 static char kprobe_boot_events_buf[COMMAND_LINE_SIZE] __initdata;
@@ -786,13 +785,6 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 			trace_probe_log_err(1, BAD_MAXACT);
 			goto parse_error;
 		}
-		/* kretprobes instances are iterated over via a list. The
-		 * maximum should stay reasonable.
-		 */
-		if (maxactive > KRETPROBE_MAXACTIVE_MAX) {
-			trace_probe_log_err(1, MAXACT_TOO_BIG);
-			goto parse_error;
-		}
 	}
 
 	/* try to parse an address. if that fails, try to read the
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 227d518e5ba521..e331017dc086ed 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -389,7 +389,6 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(BAD_UPROBE_OFFS,	"Invalid uprobe offset"),		\
 	C(MAXACT_NO_KPROBE,	"Maxactive is not for kprobe"),		\
 	C(BAD_MAXACT,		"Invalid maxactive number"),		\
-	C(MAXACT_TOO_BIG,	"Maxactive is too big"),		\
 	C(BAD_PROBE_ADDR,	"Invalid probed address or symbol"),	\
 	C(BAD_RETPROBE,		"Retprobe address must be an function entry"), \
 	C(BAD_ADDR_SUFFIX,	"Invalid probed address suffix"), \
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index fa928b431555ca..be3360a258bae8 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -10,7 +10,6 @@ check_error() { # command-with-error-pos-by-^
 if grep -q 'r\[maxactive\]' README; then
 check_error 'p^100 vfs_read'		# MAXACT_NO_KPROBE
 check_error 'r^1a111 vfs_read'		# BAD_MAXACT
-check_error 'r^100000 vfs_read'		# MAXACT_TOO_BIG
 fi
 
 check_error 'p ^non_exist_func'		# BAD_PROBE_ADDR (enoent)
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_maxactive.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_maxactive.tc
index 4f0b268c12332a..f57c95bfc5ed5a 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_maxactive.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_maxactive.tc
@@ -6,9 +6,6 @@
 # Test if we successfully reject unknown messages
 if echo 'a:myprobeaccept inet_csk_accept' > kprobe_events; then false; else true; fi
 
-# Test if we successfully reject too big maxactive
-if echo 'r1000000:myprobeaccept inet_csk_accept' > kprobe_events; then false; else true; fi
-
 # Test if we successfully reject unparsable numbers for maxactive
 if echo 'r10fuzz:myprobeaccept inet_csk_accept' > kprobe_events; then false; else true; fi
 
-- 
2.31.1

