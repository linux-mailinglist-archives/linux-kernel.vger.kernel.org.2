Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4DD44D467
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhKKJyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:54:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232570AbhKKJyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:54:18 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AB9hsIP010326;
        Thu, 11 Nov 2021 09:50:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=xxd1gYnGnuLUzdYjZpHEdzhiOxRoDQl3TblHLAxYn0w=;
 b=pk+01Nx2owzE+rr8I+sp+hRiWrP8AvTWl3qNLrQhaFGM3JMRrIw+Mdan+PpSno1MEH7a
 nGX9W5QkYLwxPUKbpJXXJFmW70tadvgYHy+GvR4BD2bnH5ryl2Vwc6oBuAT6vJ0jKXzd
 gU3wWQgogDLR8N89WLYot/QntO6DwtlsRs7EVVKWJYONnmP5EBpSPSHZZNY/l9ak8PvJ
 qBYmTf57v3o27PB2nTW+RA+Q0zhqZSMg3q/JcuNo3b6bJS8/CsUqb1gu5fu7+oXVJAAP
 /q9d0XRG5QemiMQPIZxXWY30kOtrJhdemmF2R8BghU8fTlziWookuwq9J4L51F2HMScd LA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c90t4r337-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Nov 2021 09:50:30 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AB9jDJk016101;
        Thu, 11 Nov 2021 09:50:30 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c90t4r32h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Nov 2021 09:50:30 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AB9mpgj016615;
        Thu, 11 Nov 2021 09:50:27 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3c5gyk3vrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Nov 2021 09:50:27 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AB9hfF559965944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Nov 2021 09:43:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A14E74C040;
        Thu, 11 Nov 2021 09:50:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77A224C05A;
        Thu, 11 Nov 2021 09:50:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.11.147])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Nov 2021 09:50:21 +0000 (GMT)
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     thuth@redhat.com, frankja@linux.ibm.com, borntraeger@de.ibm.com,
        Ulrich.Weigand@de.ibm.com, heiko.carstens@de.ibm.com,
        david@redhat.com, ultrachin@163.com, akpm@linux-foundation.org,
        vbabka@suse.cz, brookxu.cn@gmail.com, xiaoggchen@tencent.com,
        linuszeng@tencent.com, yihuilu@tencent.com, mhocko@suse.com,
        daniel.m.jordan@oracle.com, axboe@kernel.dk, legion@kernel.org,
        peterz@infradead.org, aarcange@redhat.com, christian@brauner.io,
        ebiederm@xmission.com, tglx@linutronix.de
Subject: [RFC v1 3/4] mm: wire up the process_mmput_async syscall
Date:   Thu, 11 Nov 2021 10:50:07 +0100
Message-Id: <20211111095008.264412-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211111095008.264412-1-imbrenda@linux.ibm.com>
References: <20211111095008.264412-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _hl2XRplxyqsMBE5ybW60qxgt44LFywM
X-Proofpoint-GUID: w8Uuk7VwYqRZto6iYF5TCI0Em3wLqK1f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_02,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=829 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111110056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up the process_mmput_async syscall.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl      | 2 ++
 arch/arm/tools/syscall.tbl                  | 1 +
 arch/arm64/include/asm/unistd.h             | 2 +-
 arch/arm64/include/asm/unistd32.h           | 2 ++
 arch/ia64/kernel/syscalls/syscall.tbl       | 2 ++
 arch/m68k/kernel/syscalls/syscall.tbl       | 2 ++
 arch/microblaze/kernel/syscalls/syscall.tbl | 2 ++
 arch/mips/kernel/syscalls/syscall_n32.tbl   | 2 ++
 arch/mips/kernel/syscalls/syscall_n64.tbl   | 2 ++
 arch/mips/kernel/syscalls/syscall_o32.tbl   | 2 ++
 arch/parisc/kernel/syscalls/syscall.tbl     | 2 ++
 arch/powerpc/kernel/syscalls/syscall.tbl    | 2 ++
 arch/s390/kernel/syscalls/syscall.tbl       | 2 ++
 arch/sh/kernel/syscalls/syscall.tbl         | 2 ++
 arch/sparc/kernel/syscalls/syscall.tbl      | 2 ++
 arch/x86/entry/syscalls/syscall_32.tbl      | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl      | 1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     | 2 ++
 include/linux/syscalls.h                    | 1 +
 include/uapi/asm-generic/unistd.h           | 5 ++++-
 kernel/sys_ni.c                             | 1 +
 21 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index e4a041cd5715..2ec84b67534e 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -488,3 +488,5 @@
 556	common	landlock_restrict_self		sys_landlock_restrict_self
 # 557 reserved for memfd_secret
 558	common	process_mrelease		sys_process_mrelease
+# 559 reserved for futex_waitv
+560	common	process_mmput_async		sys_process_mmput_async
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 543100151f2b..8aee1a20f4d5 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -463,3 +463,4 @@
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
 449	common	futex_waitv			sys_futex_waitv
+450	common	process_mmput_async		sys_process_mmput_async
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 6bdb5f5db438..4e65da3445c7 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		450
+#define __NR_compat_syscalls		451
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 41ea1195e44b..e3b75a2896d2 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -905,6 +905,8 @@ __SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
 __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
 #define __NR_futex_waitv 449
 __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
+#define __NR_process_mmput_async 450
+__SYSCALL(__NR_process_mmput_async, sys_process_mmput_async)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 6fea1844fb95..c1e454342e94 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -369,3 +369,5 @@
 446	common	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
+# 449 reserved for futex_waitv
+450	common	process_mmput_async		sys_process_mmput_async
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 7976dff8f879..b89bcb3b50d0 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -448,3 +448,5 @@
 446	common	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
+# 449 reserved for futex_waitv
+450	common	process_mmput_async		sys_process_mmput_async
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 6b0e11362bd2..cf4df3a9f95d 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -454,3 +454,5 @@
 446	common	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
+# 449 reserved for futex_waitv
+450	common	process_mmput_async		sys_process_mmput_async
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 70e32de2bcaa..6374c2acc370 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -387,3 +387,5 @@
 446	n32	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	n32	process_mrelease		sys_process_mrelease
+# 449 reserved for futex_waitv
+450	common	process_mmput_async		sys_process_mmput_async
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 1ca7bc337932..f7d336bcdcad 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -363,3 +363,5 @@
 446	n64	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	n64	process_mrelease		sys_process_mrelease
+# 449 reserved for futex_waitv
+450	common	process_mmput_async		sys_process_mmput_async
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index a61c35edaa74..1b4572b4c0f4 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -436,3 +436,5 @@
 446	o32	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	o32	process_mrelease		sys_process_mrelease
+# 449 reserved for futex_waitv
+450	common	process_mmput_async		sys_process_mmput_async
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index bf751e0732b7..58fca00dd2c4 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -446,3 +446,5 @@
 446	common	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
+# 449 reserved for futex_waitv
+450	common	process_mmput_async		sys_process_mmput_async
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 7bef917cc84e..9c62f9ca307f 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -528,3 +528,5 @@
 446	common	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
+# 449 reserved for futex_waitv
+450	common	process_mmput_async		sys_process_mmput_async
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index df5261e5cfe1..aa6b50367a8b 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -451,3 +451,5 @@
 446  common	landlock_restrict_self	sys_landlock_restrict_self	sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448  common	process_mrelease	sys_process_mrelease		sys_process_mrelease
+# 449 reserved for futex_waitv
+450  common	process_mmput_async	sys_process_mmput_async		sys_process_mmput_async
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 208f131659c5..372122390fa2 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -451,3 +451,5 @@
 446	common	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
+# 449 reserved for futex_waitv
+450	common	process_mmput_async		sys_process_mmput_async
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index c37764dc764d..5c1448ead433 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -494,3 +494,5 @@
 446	common	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
+# 449 reserved for futex_waitv
+450	common	process_mmput_async		sys_process_mmput_async
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 7e25543693de..ad034bc349ec 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -454,3 +454,4 @@
 447	i386	memfd_secret		sys_memfd_secret
 448	i386	process_mrelease	sys_process_mrelease
 449	i386	futex_waitv		sys_futex_waitv
+450	i386	process_mmput_async	sys_process_mmput_async
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index fe8f8dd157b4..df659c967932 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -371,6 +371,7 @@
 447	common	memfd_secret		sys_memfd_secret
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
+450	common	process_mmput_async	sys_process_mmput_async
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 104b327f8ac9..7534f2969af6 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -419,3 +419,5 @@
 446	common	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
 448	common	process_mrelease		sys_process_mrelease
+# 449 reserved for futex_waitv
+450	common	process_mmput_async		sys_process_mmput_async
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 528a478dbda8..e416f6f8a4b8 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -920,6 +920,7 @@ asmlinkage long sys_mincore(unsigned long start, size_t len,
 asmlinkage long sys_madvise(unsigned long start, size_t len, int behavior);
 asmlinkage long sys_process_madvise(int pidfd, const struct iovec __user *vec,
 			size_t vlen, int behavior, unsigned int flags);
+asmlinkage long sys_process_mmput_async(int pidfd, unsigned int flags);
 asmlinkage long sys_process_mrelease(int pidfd, unsigned int flags);
 asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
 			unsigned long prot, unsigned long pgoff,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 4557a8b6086f..bf6b9c3e4957 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -883,8 +883,11 @@ __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
 #define __NR_futex_waitv 449
 __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 
+#define __NR_process_mmput_async 450
+__SYSCALL(__NR_process_mmput_async, sys_process_mmput_async)
+
 #undef __NR_syscalls
-#define __NR_syscalls 450
+#define __NR_syscalls 451
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index d1944258cfc0..0b69802a3d62 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -290,6 +290,7 @@ COND_SYSCALL(munlockall);
 COND_SYSCALL(mincore);
 COND_SYSCALL(madvise);
 COND_SYSCALL(process_madvise);
+COND_SYSCALL(process_mmput_async);
 COND_SYSCALL(process_mrelease);
 COND_SYSCALL(remap_file_pages);
 COND_SYSCALL(mbind);
-- 
2.31.1

