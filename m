Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACB342E59C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 02:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhJOA7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 20:59:05 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:28268 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbhJOA7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 20:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634259418; x=1665795418;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ajpxWkM2yIP2H9kH+vUXn+hMY436patQvCZapiF30NE=;
  b=I42je7QfTE7nSJyny4ghvNos/fVoPMp7kbuHnGx9MfTgFgqoSWEO8q0d
   nv7SD+E9KrRiIK+UhqfQ/bI83sOVTf3aK7cmns3xBOrqVO5EfRluzJ/52
   THGbu+y90vBFJZPfkvHoKaK5bZzjffWQJBUSo4vPV0guFixv5IRpHLJWj
   44nmGDwizrTiPQ5rCL3BxGTDb2UV+3EMN+hvyDdt2Vq9PqJebCqGmvdK3
   Rgkf5Ac7iEBHUeszSFChooaBZwhqiI81geSB9K/oJ2kOW0z5ojas00yrS
   z4CDYet9XMlE66rboABS80160y7xkePu7/RSObK+GRxxcHQ0ZSRW4RXO8
   g==;
X-IronPort-AV: E=Sophos;i="5.85,374,1624291200"; 
   d="scan'208";a="187671283"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2021 08:56:57 +0800
IronPort-SDR: hnPJiM0Axx5D4dswZ7GazVVOHppcI7FNmG+xhIl9vXSf0GGJf7EUoluRHH0H5imtSzu5Je/i24
 qbIgWTUPxDSRihqwOYcfPZEGLYB3XMjHU0TN4sqFpWQjWYJBvK55CmujizY3sGkEGLb8vYsqr4
 jZ1iQTS5I8oftPxlLnMgeFWCfRhLvCa8O7P+lkHoctifsdRmPRq2wNLGLg5FP0n0zjnt1CzA1Q
 1Lz3dOR23oZXA3UAbnyYovg4TLZsjwWaZMPrsfrS7AMVSxWhiLjltoeC0YdOJwrPM9s8p+ocEg
 n5+pH9z8ZVk5ec5uSIcmMkIl
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 17:31:09 -0700
IronPort-SDR: i9Ccjf/CIibbawX0UybWhFpWMs/P9nvzu8SeC+kNfEhnqEy+UTwk7QTwtcWaVcALLObh60/V6T
 RnFuPjgOjCBg03dO7xQBXWBhUt3kBR+xcOIghjcDiMgoV1tX66f4CRbNm5ySQwrQoCAVUo3KDt
 pfQZ5dtTKEtgruYI6t6ESMuDCnzGoumagT0BhhsOf6Fh9RiMKIzlrj0brTYTfdLb9o8EgtLHRD
 7zKEFEuaNfUmMWf4PChPQedit5bEon1OoDAPsZoN7yBcHfvBxoa0ZEoW788+i5vZDRGbc37ZTZ
 CGU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 17:56:57 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HVnsj230Wz1RvmL
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 17:56:57 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1634259416;
         x=1636851417; bh=ajpxWkM2yIP2H9kH+vUXn+hMY436patQvCZapiF30NE=; b=
        ZEH/bLcY/8miP7Yw2wNjprA79S3EHGCRVhsulSOfMaaqf4s3N8NE+brYEXo9QSTH
        wmdUVXSk0O0cMyHRKJ49B5Mt6YT7SCsPzHRklNckyi/clcEov+UsXbVLvP/K6waE
        r0a3PaOmYfxk5IqMVp8iVN0pPQpc3/zx8GosFFalEkNO75btX/iOuxubWSodkrRi
        HpfCcOCI0cS5YufAbHgs1JOqAC13FRjBYpTlqBc2THmjOLZ5zq3hEqFJtkesPGGY
        /MwR9Xp/nQ1oPGoLItv5eZvGCxXox76AST2jgVfB04QVCxQLlU/4fTvb8HU+p0mm
        41l+ZxOzhYVrOIT83y7Baw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mGpsQCZOd6as for <linux-kernel@vger.kernel.org>;
        Thu, 14 Oct 2021 17:56:56 -0700 (PDT)
Received: from toolbox.alistair23.me (unknown [10.225.165.37])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HVnsS4Xfgz1RvTg;
        Thu, 14 Oct 2021 17:56:43 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, alistair23@gmail.com,
        namhyung@kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        acme@kernel.org, dave@stgolabs.net, dvhart@infradead.org,
        peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        atish.patra@wdc.com, arnd@arndb.de,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 1/2] perf bench futex: Use a 64-bit time_t
Date:   Fri, 15 Oct 2021 10:56:33 +1000
Message-Id: <20211015005634.2658470-1-alistair.francis@opensource.wdc.com>
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
 tools/perf/bench/futex.h | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index b3853aac3021c..b9665d43d2988 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -12,6 +12,7 @@
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <linux/futex.h>
+#include <linux/time_types.h>
=20
 struct bench_futex_parameters {
 	bool silent;
@@ -27,12 +28,14 @@ struct bench_futex_parameters {
 	unsigned int nrequeue;
 };
=20
+#define timespec64 __kernel_timespec
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
@@ -47,15 +50,26 @@ struct bench_futex_parameters {
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
+#if __BITS_PER_LONG =3D=3D 64
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
@@ -74,7 +88,7 @@ futex_wake(u_int32_t *uaddr, int nr_wake, int opflags)
  * futex_lock_pi() - block on uaddr as a PI mutex
  */
 static inline int
-futex_lock_pi(u_int32_t *uaddr, struct timespec *timeout, int opflags)
+futex_lock_pi(u_int32_t *uaddr, struct timespec64 *timeout, int opflags)
 {
 	return futex(uaddr, FUTEX_LOCK_PI, 0, timeout, NULL, 0, opflags);
 }
@@ -111,7 +125,7 @@ futex_cmp_requeue(u_int32_t *uaddr, u_int32_t val, u_=
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

