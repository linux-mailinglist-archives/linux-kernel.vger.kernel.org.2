Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE5D42D20C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 07:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhJNF6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 01:58:01 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:17325 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhJNF57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 01:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634190954; x=1665726954;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+HCVwpWd7xwx2tp3UxxXqvcw+GKWRQ+CHp15VqQlxB0=;
  b=oyxGlnX8T2PEVgWnKBAc5wYyCFExCHwafakQjo7jS8jugh8zumSYf25W
   vhN7dark64y4JqP45otB/Iqk6p9REjaC1LJpD0xAhjZtAcPbtAVxsnFSr
   L3rgdDudYdKVW1LKqrkrXe1n7E1QqOZ7wQemVZdncoDlcV0utfcxHVKzD
   Hrc7/lapSOFqMXIrDAbecOLGPDJIwWCg4H+CFMTJVdWEyvyXMO/uYZ/Gs
   yCyZY12vM0sHo1RDWYvCSTDn0BA9luIInfGhIwHa++zGs5OifOtQJ1aS5
   eAkC0NGQJ7wyZw8ExhPxm2Ba80YVTVI3e70uUqRDwXkMFREJb4lkrH5iM
   w==;
X-IronPort-AV: E=Sophos;i="5.85,371,1624291200"; 
   d="scan'208";a="286671349"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2021 13:55:54 +0800
IronPort-SDR: mh+T0uhbf2ti05Ic7bLpqmK0A/Qy+5dXhJUT4Ku6kEx7wP5viZY4K/QaA5eY0pFK/EHy9yDGxn
 oav/AimyMvwyJwjBo8T3l/AndZoXdWSnKJmbyup7n2wieXqwpHF34/BpVS7qHMp63r4rdUnZIu
 +HvRWasnyw2QAXU8n5OmJXg3PFMNemBIEGAvP7t5dwYcD2AnWD4U6cpgKxbGV14zjaVKKPAXCj
 UmAp2cxl+mpyjahNj/6voSvh55A7AUJZ56mEonlMAxeOgVACNgu+Tlg5yE2dbKhGrNkMuTzEkR
 vpaokJQsUhJfxHcJ3M8hUhqo
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 22:30:07 -0700
IronPort-SDR: vOcyM1+lGhz04qIfOpNW9ixQsSNb0nKnS+DWN5jKV15LKaU2LwMOk0w7QlTlu7Hsn3xpuH4QZO
 m7N3/iDPFV+jwe9QefDVUakvFTcY6C61CcX+kgIMchU3QT7EtCgB+Hh9eYnFXvMrpSlek5S0jj
 fDqDdXQ6HRTyMVDOGC0+tThZhkugdcbRM8ZSOoIT8OxZBlbp1zynTx4Zo3zxFIF+9OXf24UhVc
 Nhri5LgIcfvCIoEtCAbMKsfQP0B2DID9TL4x9b0++Rtim6JhbEs2GYYJ966Ksvi1ly/6zDokVh
 eDU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 22:55:55 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HVJY54npHz1RvmH
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 22:55:53 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1634190952;
         x=1636782953; bh=+HCVwpWd7xwx2tp3UxxXqvcw+GKWRQ+CHp15VqQlxB0=; b=
        Oa6NANX0VpnF6AbmrgxFK0kHGtaTzTxcrWrKW24+VVua0fH4L3BZDdWiXlEuYqe/
        ns4hM03IV66LoYvee3A21+SmPpnEnuug0mhkrI7P52PX7pbgZDcT3IPCtOCGX4gk
        YhAAlfziW59SJ50+5RsJ4QLtTCCN6rhaef4RWuUVPv4+mFq928hwo1O0f++AeVIH
        05q5m7g6k4S7RW05jZcHvYnd7nN8ZHiVz3RFqOGNhq89j2LJXTe9I5go7o4JGvao
        lxZ+/9Tjjg+e+SptyYi4pyTMFBsqRM/i8sTGfq8rvkidA2J+kP0Pe3sQlB1qK803
        55C6MxoOmKRIyVPA7s8lOQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qKT9l_JhXUFp for <linux-kernel@vger.kernel.org>;
        Wed, 13 Oct 2021 22:55:52 -0700 (PDT)
Received: from toolbox.wdc.com (unknown [10.225.165.36])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HVJXs25dqz1RvTg;
        Wed, 13 Oct 2021 22:55:40 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, alistair23@gmail.com,
        namhyung@kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        acme@kernel.org, dave@stgolabs.net, dvhart@infradead.org,
        peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        atish.patra@wdc.com, arnd@arndb.de,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 1/2] perf bench futex: Use a 64-bit time_t
Date:   Thu, 14 Oct 2021 15:55:26 +1000
Message-Id: <20211014055527.1238645-1-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

Convert tools/perf to only use a 64-bit time_t. On 64-bit architectures
this isn't a functional change. On 32-bit architectures we now only
perform 64-bit time_t syscalls (__NR_futex_time64) and use a struct
timespec64.

This won't work on kernels before 5.1, but as perf is tied to the kernel
that's ok.

This allows us to build perf for 32-bit architectures with 64-bit time_t
like RISC-V 32-bit.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tools/perf/bench/futex.h | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index b3853aac3021c..c1ca75657c32e 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -27,12 +27,17 @@ struct bench_futex_parameters {
 	unsigned int nrequeue;
 };
=20
+struct timespec64 {
+	long long tv_sec;       /* seconds */
+	long long tv_nsec;      /* nanoseconds */
+};
+
 /**
  * futex() - SYS_futex syscall wrapper
  * @uaddr:	address of first futex
  * @op:		futex op code
  * @val:	typically expected value of uaddr, but varies by op
- * @timeout:	typically an absolute struct timespec (except where noted
+ * @timeout:	typically an absolute struct timespec64 (except where noted
  *		otherwise). Overloaded by some ops
  * @uaddr2:	address of second futex for some ops
  * @val3:	varies by op
@@ -47,15 +52,26 @@ struct bench_futex_parameters {
  * These argument descriptions are the defaults for all
  * like-named arguments in the following wrappers except where noted bel=
ow.
  */
-#define futex(uaddr, op, val, timeout, uaddr2, val3, opflags) \
-	syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
+/**
+ * We only support 64-bit time_t for the timeout.
+ * On 64-bit architectures we can use __NR_futex
+ * On 32-bit architectures we use __NR_futex_time64. This only works on =
kernel
+ * versions 5.1+.
+ */
+#if __BITS_PER_LONG =3D=3D 64 || defined(__i386__)
+# define futex(uaddr, op, val, timeout, uaddr2, val3, opflags) \
+	syscall(__NR_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
+#else
+# define futex(uaddr, op, val, timeout, uaddr2, val3, opflags) \
+	syscall(__NR_futex_time64, uaddr, op | opflags, val, timeout, uaddr2, v=
al3)
+#endif
=20
 /**
  * futex_wait() - block on uaddr with optional timeout
  * @timeout:	relative timeout
  */
 static inline int
-futex_wait(u_int32_t *uaddr, u_int32_t val, struct timespec *timeout, in=
t opflags)
+futex_wait(u_int32_t *uaddr, u_int32_t val, struct timespec64 *timeout, =
int opflags)
 {
 	return futex(uaddr, FUTEX_WAIT, val, timeout, NULL, 0, opflags);
 }
@@ -74,7 +90,7 @@ futex_wake(u_int32_t *uaddr, int nr_wake, int opflags)
  * futex_lock_pi() - block on uaddr as a PI mutex
  */
 static inline int
-futex_lock_pi(u_int32_t *uaddr, struct timespec *timeout, int opflags)
+futex_lock_pi(u_int32_t *uaddr, struct timespec64 *timeout, int opflags)
 {
 	return futex(uaddr, FUTEX_LOCK_PI, 0, timeout, NULL, 0, opflags);
 }
@@ -111,7 +127,7 @@ futex_cmp_requeue(u_int32_t *uaddr, u_int32_t val, u_=
int32_t *uaddr2, int nr_wak
  */
 static inline int
 futex_wait_requeue_pi(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2=
,
-		      struct timespec *timeout, int opflags)
+		      struct timespec64 *timeout, int opflags)
 {
 	return futex(uaddr, FUTEX_WAIT_REQUEUE_PI, val, timeout, uaddr2, 0,
 		     opflags);
--=20
2.31.1

