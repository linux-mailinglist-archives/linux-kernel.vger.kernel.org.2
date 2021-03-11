Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A2433736B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 14:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhCKNH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 08:07:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233409AbhCKNHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 08:07:51 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12BD57KP033641;
        Thu, 11 Mar 2021 08:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=7jMLVhi1GdPdsfAvUXdObOOVsADcwbXZhqOHc6KAeLU=;
 b=eI8lJuQj5kSphsCbqh7MoJJV3XUZJ+KjV6T6ZSdRUhRKS2+FAYhbfAtbGtC7M1Mpr30Z
 KY8aoteGGEuZBahcn0fJ4SV/X4ETYnMv987CVpbuYeKF3PnBg4Ipwoh9GKoX7xMaUVZv
 3AvFDS0G+Yl/cxxYi/aCNGGu6LxCsOKWixt/I5d/FbbPXqaYbJwn0Z4XojQVf67TQWT9
 jIsQ2kHxXfUMXREZ35n+5KKUEeJKC3P4JO27naYyoBNuQjMGg05eX3oMR1FhdQYcm67B
 zVPg1/jxT47wI2jfV5jw06tlUT882KBg/qf+xPm9fP7AjdboVTlqDKI86Y2brI/jVjEv CA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3774kxnf2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 08:07:50 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12BD3dSr011528;
        Thu, 11 Mar 2021 13:07:47 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3768urswae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 13:07:47 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12BD7iEO65798600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 13:07:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE5F6A4054;
        Thu, 11 Mar 2021 13:07:44 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90D1DA405B;
        Thu, 11 Mar 2021 13:07:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Mar 2021 13:07:44 +0000 (GMT)
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
To:     akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, oberpar@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gcov: fail build on gcov_info size mismatch
Date:   Thu, 11 Mar 2021 14:03:28 +0100
Message-Id: <20210311130328.2859337-1-oberpar@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-11_04:2021-03-10,2021-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1011 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103110070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcov kernel profiling works by emulating parts of GCC's libgcov in the
kernel, including a definition of struct gcov_info used by profiling
code to handle coverage data. The original definition of this data type
is not available outside of GCC's source tree, and when it changes with
new GCC versions the result may be hard-to-debug kernel failures [1].

This patch adds a compile-time check to ensure that the kernel's version
of struct gcov_info has the same length as the one used by GCC as
determined by looking at GCC's assembler output. This check should help
reduce the number of run-time failures when using gcov kernel support
with new GCC versions that include updates to struct gcov_info.

Tested with various GCC versions between 4.9 and 10, and also Clang 11.

[1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1891288

Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
---
 kernel/gcov/Makefile       |  9 +++++++++
 kernel/gcov/gcc_4_7.c      |  3 +++
 kernel/gcov/geninfosize.sh | 19 +++++++++++++++++++
 3 files changed, 31 insertions(+)
 create mode 100755 kernel/gcov/geninfosize.sh

diff --git a/kernel/gcov/Makefile b/kernel/gcov/Makefile
index 16f8ecc7d882..1cbeb0de944e 100644
--- a/kernel/gcov/Makefile
+++ b/kernel/gcov/Makefile
@@ -1,6 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
 ccflags-y := -DSRCTREE='"$(srctree)"' -DOBJTREE='"$(objtree)"'
 
+ifeq ($(CONFIG_CC_IS_GCC),y)
+  GCOV_INFO_SIZE := $(shell $(srctree)/$(src)/geninfosize.sh)
+  ifneq ($(GCOV_INFO_SIZE),)
+    ccflags-y += -DGCC_GCOV_INFO_SIZE=$(GCOV_INFO_SIZE)
+  else
+    $(error Could not determine size of GCC's struct gcov_info)
+  endif
+endif
+
 obj-y := base.o fs.o
 obj-$(CONFIG_CC_IS_GCC) += gcc_base.o gcc_4_7.o
 obj-$(CONFIG_CC_IS_CLANG) += clang.o
diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
index c53408a00d0b..fce003cfc790 100644
--- a/kernel/gcov/gcc_4_7.c
+++ b/kernel/gcov/gcc_4_7.c
@@ -94,6 +94,9 @@ struct gcov_info {
 	struct gcov_fn_info **functions;
 };
 
+_Static_assert(sizeof(struct gcov_info) == GCC_GCOV_INFO_SIZE,
+	       "struct gcov_info must be updated");
+
 /**
  * gcov_info_filename - return info filename
  * @info: profiling data set
diff --git a/kernel/gcov/geninfosize.sh b/kernel/gcov/geninfosize.sh
new file mode 100755
index 000000000000..c05f1374fcb3
--- /dev/null
+++ b/kernel/gcov/geninfosize.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Determine size of GCC's internal struct gcov_info. CC must be set correctly.
+#
+# Note: GCC adds an instance of its built-in version of struct gcov_info under
+#       the label .LPBX0 to assembler output when compiling with --coverage
+#
+
+echo "void fn(void) {}" | $CC -S --coverage -x c - -o - | \
+while read a b c ; do
+	# .size	.LPBX0, 112
+	if [ "$a" = ".size" -a "$b" = ".LPBX0," ] ; then
+		echo "$c"
+		break
+	fi
+done
+
+exit 0
-- 
2.25.1

