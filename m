Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D593388E95
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353537AbhESNEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:04:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23342 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1353519AbhESNEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:04:44 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14JD35ZR135768;
        Wed, 19 May 2021 09:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=fX9frhQzkkfEH/h1tf5QRl43K8q8oYBl25gAiUC1CrQ=;
 b=GlNU70Tanqfb2wJoVkRUuYxJP5mqpZB3+ZLIdvYlepcCTimFWcjztY54j2ah2nVBSmoe
 7sKirHVzbxhTOoTz3e+vkt0hWLPcWOgpu8g4tSv5qzEBYk6lqqDmyuIaaeKelribp6vP
 DXoS0pz4q5C5BFBKprsghB6YC26P2PYbra2pSK3yD52ClKPJYOrwGlxyd9aEjm7f2kwL
 Nn8PYwurfOBk+5kQFWpgClrcIJkSjX5kotoC6Tj0CbGoqgjGpZlyXYy6hcC3ELVneNfv
 z6qeC+s6U0ROQyCQrGWbl077Qoc0c+/dNd4oxCBAgSpxPhs5/T8w41K5b5AZTkkmmdGV XA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38n2891y37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 09:03:17 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14JD3G5s136974;
        Wed, 19 May 2021 09:03:16 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38n2891y22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 09:03:16 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14JClXY7015873;
        Wed, 19 May 2021 13:03:14 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 38j5x8a4ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 13:03:14 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14JD3C4v34144610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 13:03:12 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 861E54204B;
        Wed, 19 May 2021 13:03:12 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C2D64203F;
        Wed, 19 May 2021 13:03:12 +0000 (GMT)
Received: from localhost (unknown [9.171.63.142])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 19 May 2021 13:03:12 +0000 (GMT)
Date:   Wed, 19 May 2021 15:03:08 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] compiler.h: Avoid using inline asm operand modifiers
Message-ID: <patch-1.thread-1a26be.git-930d1b44844a.your-ad-here.call-01621428935-ext-2104@work.hours>
References: <cover.thread-1a26be.your-ad-here.call-01621428935-ext-2104@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-1a26be.your-ad-here.call-01621428935-ext-2104@work.hours>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PJvSAxgaaeYkP2S28a6hpDBeGbvAXCLk
X-Proofpoint-ORIG-GUID: 2n4rF-J7JlyM2SzEHa7XzYUduE0wdx0h
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_05:2021-05-19,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The expansion of annotate_reachable/annotate_unreachable on s390 will
result in a compiler error if the __COUNTER__ value is high enough.
For example with "i" (154) the "%c0" operand of annotate_reachable
will be expanded to -102:

        -102:
        .pushsection .discard.reachable
        .long -102b - .
        .popsection

This is a quirk of the gcc backend for s390, it interprets the %c0
as a signed byte value. Avoid using operand modifiers in this case
by simply converting __COUNTER__ to string, with the same result,
but in an arch assembler independent way.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 include/linux/compiler.h | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index df5b405e6305..77047904cf70 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -115,18 +115,24 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  * The __COUNTER__ based labels are a hack to make each instance of the macros
  * unique, to convince GCC not to merge duplicate inline asm statements.
  */
-#define annotate_reachable() ({						\
-	asm volatile("%c0:\n\t"						\
+#define __stringify_label(n) #n
+
+#define __annotate_reachable(c) ({					\
+	asm volatile(__stringify_label(c) ":\n\t"			\
 		     ".pushsection .discard.reachable\n\t"		\
-		     ".long %c0b - .\n\t"				\
-		     ".popsection\n\t" : : "i" (__COUNTER__));		\
+		     ".long " __stringify_label(c) "b - .\n\t"		\
+		     ".popsection\n\t");				\
 })
-#define annotate_unreachable() ({					\
-	asm volatile("%c0:\n\t"						\
+#define annotate_reachable() __annotate_reachable(__COUNTER__)
+
+#define __annotate_unreachable(c) ({					\
+	asm volatile(__stringify_label(c) ":\n\t"			\
 		     ".pushsection .discard.unreachable\n\t"		\
-		     ".long %c0b - .\n\t"				\
-		     ".popsection\n\t" : : "i" (__COUNTER__));		\
+		     ".long " __stringify_label(c) "b - .\n\t"		\
+		     ".popsection\n\t");				\
 })
+#define annotate_unreachable() __annotate_unreachable(__COUNTER__)
+
 #define ASM_UNREACHABLE							\
 	"999:\n\t"							\
 	".pushsection .discard.unreachable\n\t"				\
-- 
2.25.4

