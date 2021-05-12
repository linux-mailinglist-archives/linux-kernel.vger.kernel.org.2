Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BB237EB9E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381535AbhELTef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:34:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50896 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237536AbhELRnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 13:43:40 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14CHXxNa060840;
        Wed, 12 May 2021 13:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=L1Ft5Omd2CLiJM0wtk4u1tDePf7r2ihE+7ASLO5TB1A=;
 b=H586JPlpOdpA2btQamx98b/VqbOldPLyIxZrXUPsRzqNhvLoME/3H/Wbmc3AwzrwmVdI
 iu8b8z4+WqixIxg9PQF9K5rrmedrGTqw4ObghgEip6ErMhJovj91mc0Ed6/W7Px2fdDq
 7mlkDmGqLXH7BkfdpcKs03tCdhOV3wISRh/yukMr6aN1T6rcase+MfCWF57nsPRCAUvK
 +xkKJDew3N/SurCZai2y9WYGPwAwKKnhUSHcLd8mm37ylqCUoFbjtYOBHPH86z92uAPO
 sD3BYdvlqxMlncoXFxwooEIXya1r7H7Az1Rlv8SULUtj5Bn6SudmBwQ9YWMHi7h9BU/l 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38gkcn0f2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 May 2021 13:42:19 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14CHZp3X069060;
        Wed, 12 May 2021 13:42:19 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38gkcn0f1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 May 2021 13:42:19 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14CHg35p026653;
        Wed, 12 May 2021 17:42:17 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 38dj98aba6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 May 2021 17:42:17 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14CHgFB345154782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 May 2021 17:42:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5174AAE053;
        Wed, 12 May 2021 17:42:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECA17AE045;
        Wed, 12 May 2021 17:42:14 +0000 (GMT)
Received: from localhost (unknown [9.171.5.155])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 12 May 2021 17:42:14 +0000 (GMT)
Date:   Wed, 12 May 2021 19:42:13 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] objtool/x86: Fix elf_add_alternative() endianness
Message-ID: <patch-2.thread-6c9df9.git-6c9df9a8098d.your-ad-here.call-01620841104-ext-2554@work.hours>
References: <cover.thread-6c9df9.your-ad-here.call-01620841104-ext-2554@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-6c9df9.your-ad-here.call-01620841104-ext-2554@work.hours>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m2RwJhQst7Cxy-qgG43Q7bLJ6w2IIVfQ
X-Proofpoint-ORIG-GUID: Xz_Q5ndX-iojBRNETZ1HMEZlszifw1MW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-12_09:2021-05-12,2021-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105120114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently x86 kernel cross-compiled on big endian system fails at boot with:
kernel BUG at arch/x86/kernel/alternative.c:258!

Corresponding bug condition look like the following:
BUG_ON(feature >= (NCAPINTS + NBUGINTS) * 32);

Fix that by converting alternative feature/cpuid to target endianness.

Fixes: 9bc0bb50727c ("objtool/x86: Rewrite retpoline thunk calls")
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 tools/objtool/arch/x86/decode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index cedf3ede7545..24295d39713b 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -19,6 +19,7 @@
 #include <objtool/elf.h>
 #include <objtool/arch.h>
 #include <objtool/warn.h>
+#include <objtool/endianness.h>
 #include <arch/elf.h>
 
 static int is_x86_64(const struct elf *elf)
@@ -725,7 +726,7 @@ static int elf_add_alternative(struct elf *elf,
 		return -1;
 	}
 
-	alt->cpuid = cpuid;
+	alt->cpuid = bswap_if_needed(cpuid);
 	alt->instrlen = orig_len;
 	alt->replacementlen = repl_len;
 
-- 
2.25.4
