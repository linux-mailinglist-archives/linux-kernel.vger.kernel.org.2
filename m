Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02965388E96
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353551AbhESNEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:04:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18426 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1353522AbhESNEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:04:45 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14JCYBlF174725;
        Wed, 19 May 2021 09:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Bye5/QniodtXW6xYCVVzbJ1fGPnRgHTjLSGU4xaiM3Y=;
 b=Bk0ph4cYqA4Uv/ok9cQbqnU2nqhljtyKs8FjEDN/vQgdxizXy03Ddxok0PFG8ZQX0b5B
 6xjMfYAp723kMsUwcIt3M6yJ/351Pn4ljfquXrnFXQzlDHoe1LjZyitV649EosB8KwPS
 fdgW2TKwI5i5D+4EPR+BTJGosxD0v3hWRyBAU7txncrurv078Lkc1cQ9N0k+9KOKbrzW
 1lOlgZ/DQDF86Z9E3qqVMBqpvZxHnkixD47MS5j2wThO+vcDjFFfjubc53QhgC+OXLPe
 X7FmJVCbRoMPsK+Tm1lGyvCqmy4gVeYa84u4SwX6hTmJ2Rp1p8iLmCglwkLSrS/WYuGv Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38n2aq9rw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 09:03:20 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14JCYcui175949;
        Wed, 19 May 2021 09:03:19 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38n2aq9rvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 09:03:19 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14JCnrX7006953;
        Wed, 19 May 2021 13:03:17 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 38m1gv0htf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 13:03:17 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14JD2lY433423762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 13:02:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E9E842041;
        Wed, 19 May 2021 13:03:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCE2E4203F;
        Wed, 19 May 2021 13:03:14 +0000 (GMT)
Received: from localhost (unknown [9.171.63.142])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 19 May 2021 13:03:14 +0000 (GMT)
Date:   Wed, 19 May 2021 15:03:13 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] instrumentation.h: Avoid using inline asm operand
 modifiers
Message-ID: <patch-2.thread-1a26be.git-1a26be80cb18.your-ad-here.call-01621428935-ext-2104@work.hours>
References: <cover.thread-1a26be.your-ad-here.call-01621428935-ext-2104@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-1a26be.your-ad-here.call-01621428935-ext-2104@work.hours>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gBtgN-4g-b53kk4lWiEhC57jwvVKaLWm
X-Proofpoint-ORIG-GUID: mTpJqCpw1xZnBBKkIPF-KTTjezxFRvnT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_05:2021-05-19,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The expansion of instrumentation_begin/instrumentation_end on s390 will
result in a compiler error if the __COUNTER__ value is high enough.
For example with "i" (154) the "%c0" operand of annotate_reachable
will be expanded to -102:

        -102:
        .pushsection .discard.instr_begin
        .long -102b - .
        .popsection

This is a quirk of the gcc backend for s390, it interprets the %c0
as a signed byte value. Avoid using operand modifiers in this case
by simply converting __COUNTER__ to string, with the same result,
but in an arch assembler independent way.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 include/linux/instrumentation.h | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/linux/instrumentation.h b/include/linux/instrumentation.h
index 93e2ad67fc10..fa2cd8c63dcc 100644
--- a/include/linux/instrumentation.h
+++ b/include/linux/instrumentation.h
@@ -4,13 +4,16 @@
 
 #if defined(CONFIG_DEBUG_ENTRY) && defined(CONFIG_STACK_VALIDATION)
 
+#include <linux/stringify.h>
+
 /* Begin/end of an instrumentation safe region */
-#define instrumentation_begin() ({					\
-	asm volatile("%c0: nop\n\t"						\
+#define __instrumentation_begin(c) ({					\
+	asm volatile(__stringify(c) ": nop\n\t"				\
 		     ".pushsection .discard.instr_begin\n\t"		\
-		     ".long %c0b - .\n\t"				\
-		     ".popsection\n\t" : : "i" (__COUNTER__));		\
+		     ".long " __stringify(c) "b - .\n\t"		\
+		     ".popsection\n\t");				\
 })
+#define instrumentation_begin() __instrumentation_begin(__COUNTER__)
 
 /*
  * Because instrumentation_{begin,end}() can nest, objtool validation considers
@@ -43,12 +46,13 @@
  * To avoid this, have _end() be a NOP instruction, this ensures it will be
  * part of the condition block and does not escape.
  */
-#define instrumentation_end() ({					\
-	asm volatile("%c0: nop\n\t"					\
+#define __instrumentation_end(c) ({					\
+	asm volatile(__stringify(c) ": nop\n\t"				\
 		     ".pushsection .discard.instr_end\n\t"		\
-		     ".long %c0b - .\n\t"				\
-		     ".popsection\n\t" : : "i" (__COUNTER__));		\
+		     ".long " __stringify(c) "b - .\n\t"		\
+		     ".popsection\n\t");				\
 })
+#define instrumentation_end() __instrumentation_end(__COUNTER__)
 #else
 # define instrumentation_begin()	do { } while(0)
 # define instrumentation_end()		do { } while(0)
-- 
2.25.4
