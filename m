Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE763DA450
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237940AbhG2NaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:30:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33006 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237790AbhG2N3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:29:34 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TD7LHq193859;
        Thu, 29 Jul 2021 09:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=dZ1MtAeicVg1mTid4GtdqXebtmlJQChudOYPbJLtSIg=;
 b=lCgRDzKClK7dhqK004lyG8N22SmxfsMwhxfTKqNiWnpH2CxLXJFp1v5fuqthcKOOtzPS
 QRk+aeth1lT1Np3YK5PkeCcEJLC7+AQkhC9wKD+9+zN7ge5Ex66Lmv1OOwBHdIDWoFj3
 lJj2Ucjqv8wDGHigvQ4y8zdEu8nUwg1MXskoyhsFyR5vMBMYGt+oqXBU4S953PDxWLDz
 uEqdnR8JXBkPQH2XDkEfI240cKrWbAUE2+omxZ1vkWy5fflLj0FvR7w9cbhgQZTbfQ6h
 djEcWZB1AiXkE5ziiVBjAX8Bcw4/LihWu8YAHsDmVn/4Etdib2XPDnDfCWsUxi9VkH5j Kg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a3vmn17rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 09:29:26 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16TDJ2NO011084;
        Thu, 29 Jul 2021 13:29:25 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3a235khr0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 13:29:24 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16TDTLEX31392076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 13:29:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9497152054;
        Thu, 29 Jul 2021 13:29:21 +0000 (GMT)
Received: from localhost (unknown [9.171.66.47])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 35B2952057;
        Thu, 29 Jul 2021 13:29:21 +0000 (GMT)
Date:   Thu, 29 Jul 2021 15:29:19 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] s390/boot: fix zstd build for -march=z900
Message-ID: <patch-1.thread-f0f589.git-f0f58936888f.your-ad-here.call-01627564869-ext-2765@work.hours>
References: <202107280146.D9p1EaKo-lkp@intel.com>
 <cover.thread-f0f589.your-ad-here.call-01627564869-ext-2765@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-f0f589.your-ad-here.call-01627564869-ext-2765@work.hours>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VG1C6MCQsoKKsqmOuU8JeYH7ZCCN5q58
X-Proofpoint-ORIG-GUID: VG1C6MCQsoKKsqmOuU8JeYH7ZCCN5q58
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_10:2021-07-29,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107290084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zstd decompression uses __builtin_clz() which fails back to __clzdi2()
when the kernel is built for older hardware like z900. This leads to
build failures like the following:
s390x-11.1.0-ld: /devel/src/kernel/arch/s390/boot/compressed/../../../../lib/zstd/bitstream.h:148: undefined reference to `__clzdi2'

Fix that by optionally including lib/clz_ctz.c into the decompressor.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 7b034d9c1b08 ("s390/boot: add zstd support")
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/s390/boot/compressed/Makefile  | 1 +
 arch/s390/boot/compressed/clz_ctz.c | 2 ++
 2 files changed, 3 insertions(+)
 create mode 100644 arch/s390/boot/compressed/clz_ctz.c

diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
index 660c799d875d..e30d3fdbbc78 100644
--- a/arch/s390/boot/compressed/Makefile
+++ b/arch/s390/boot/compressed/Makefile
@@ -11,6 +11,7 @@ UBSAN_SANITIZE := n
 KASAN_SANITIZE := n
 
 obj-y	:= $(if $(CONFIG_KERNEL_UNCOMPRESSED),,decompressor.o) info.o
+obj-$(CONFIG_KERNEL_ZSTD) += clz_ctz.o
 obj-all := $(obj-y) piggy.o syms.o
 targets	:= vmlinux.lds vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2
 targets += vmlinux.bin.xz vmlinux.bin.lzma vmlinux.bin.lzo vmlinux.bin.lz4
diff --git a/arch/s390/boot/compressed/clz_ctz.c b/arch/s390/boot/compressed/clz_ctz.c
new file mode 100644
index 000000000000..c3ebf248596b
--- /dev/null
+++ b/arch/s390/boot/compressed/clz_ctz.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "../../../../lib/clz_ctz.c"
-- 
2.25.4
