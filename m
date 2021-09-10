Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E4C406681
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 06:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhIJEce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 00:32:34 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:15358 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhIJEcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 00:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631248282; x=1662784282;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9y8Ut/ugz/WF4xLl6QXyYdgaBuD43Adc9tbqyoQdLNk=;
  b=gOAbixSAyrp/1vhnwwdRKi+MGXjUP2BOsxmsBtbIh1kx0qf2RpQPdf1v
   bwGzasdLWaOyp/6HWltygig6Ca8bN35pvQKYoJ3a7KGVxazsX7l5AH5w1
   Disr7lQKuyqOBPd44hQjm/bqSBL+8HCqKtGmf3d7XWdhNyNH39Y25JPqE
   lq9g/2aZ9nxi1yKKzEO2i8KI7yZ1KqAPE/y1WAfNHPt9YsWiG25pR2lT1
   Ag2lk5HbNV5zn18oO7tW0Ipd/obQgDr7R+m87vfKDo6HT6yjQ4GVH4SD4
   mzAKuXNH0nCS4WTh++gAJNuwAZjtVq2c/+94hL94OF3DYfAWokkwziDLm
   g==;
X-IronPort-AV: E=Sophos;i="5.85,282,1624291200"; 
   d="scan'208";a="291265869"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2021 12:31:21 +0800
IronPort-SDR: Gxc1X78IEiQEe0d/UN7QPCjH/F8I8bwgtNqXMXuA981/hAtBWD7c2ROaPR42YuTxqUDBpHZGEd
 2GMYDyplTvLbJRtjB1fUs4k7Fltf2oCWqNXQNR945d08Dgy3u3+IvBYzNuGdZwnLuhYMx49/wD
 hDKUCqijE/ysozA7wpGQEwU1W1ROW8d/+k8bkZk3KoK/EZDF+gE5cWoS47bD1P6ThefIOdn+UC
 Jf8v2wxm8AiU79fDY2DuzX9oLZb6+45IzQILjulVeS+3y7kMV5vfQgET2YcqD1m06TJwktPFzJ
 nVolZGosdXM1kG0n3QkKgtYC
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 21:07:55 -0700
IronPort-SDR: 7HW60lW4ZU78GdISn/q4rDuN6Q4g27e4TeZIEpXUrGAgmGYXd1ASpBq5rOlrl/MiMFQB+1H/Ki
 wc1P3XAGLDaC/dbmuQAVI/02YlLBVuAuVmuG99T0nkt+uZTeLqN1DwThNDGFmxz+9HeI0USL/M
 4yBuMKTv6FzXOyANwxcWqES0jHqUTD3sITJ2Fifg3qunn2qK8CNmNFv63n4BiB7h6FoU86d5cL
 OMvGsLybQ4ZurBBYX6q/H/aikYSxxLyMH62gxZ6Sj1UDFdvA1yOLLJ184VQUPyGp2XALEEznXV
 rUI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 21:31:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4H5NHF0wT5z1Rwrr
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 21:31:21 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1631248279;
         x=1633840280; bh=9y8Ut/ugz/WF4xLl6QXyYdgaBuD43Adc9tbqyoQdLNk=; b=
        bBMIbvz14DHa0x6eL9m6Tt+YE3RI/ROgO1axqtzuNrJoLOHQFV+TZ2ItXs8coZ1v
        Wm7UqWAGjN5DQA7i+kgjdVxJd9Ikt85+yVN5AcqnQ64Gx2O3mOxi58/U7NX6FgE9
        7iRB6YSz4fcxf2SC25fa3PeEPdDFJp86nI8MXnRVsz7ct3u/67pwprTokvfx1RBA
        qWHZJNipLpjGizzyqXgwMwZfLrIghCNfMaraspYrj0vIlRpyLb6AYaJjyxQOo8kV
        xbC6GwanZfpI4VtCQLA8VOHyefrkj3XuWtfsTv2pVH+1cw9pNls9CF34i0oOSH2Q
        a3634pb3wHR/Zoi6QuW14Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5uc5uiS-41Vo for <linux-kernel@vger.kernel.org>;
        Thu,  9 Sep 2021 21:31:19 -0700 (PDT)
Received: from toolbox.alistair23.me (unknown [10.225.165.20])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4H5NH20krvz1RvlR;
        Thu,  9 Sep 2021 21:31:09 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, alistair23@gmail.com,
        namhyung@kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        acme@kernel.org, dave@stgolabs.net, dvhart@infradead.org,
        peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        atish.patra@wdc.com, arnd@arndb.de,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 1/2] perf benchmark: Call the futex syscall from a function
Date:   Fri, 10 Sep 2021 14:31:01 +1000
Message-Id: <20210910043102.3616198-1-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

In preparation for a more complex futex() function let's convert the
current macro into two functions. We need two functions to avoid
compiler failures as the macro is overloaded.

This will allow us to include pre-processor conditionals in the futex
syscall functions.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tools/perf/bench/futex.h | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index b3853aac3021c..f80a4759ee79b 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -28,7 +28,7 @@ struct bench_futex_parameters {
 };
=20
 /**
- * futex() - SYS_futex syscall wrapper
+ * futex_syscall() - SYS_futex syscall wrapper
  * @uaddr:	address of first futex
  * @op:		futex op code
  * @val:	typically expected value of uaddr, but varies by op
@@ -38,17 +38,26 @@ struct bench_futex_parameters {
  * @val3:	varies by op
  * @opflags:	flags to be bitwise OR'd with op, such as FUTEX_PRIVATE_FLA=
G
  *
- * futex() is used by all the following futex op wrappers. It can also b=
e
+ * futex_syscall() is used by all the following futex op wrappers. It ca=
n also be
  * used for misuse and abuse testing. Generally, the specific op wrapper=
s
- * should be used instead. It is a macro instead of an static inline fun=
ction as
- * some of the types over overloaded (timeout is used for nr_requeue for
- * example).
+ * should be used instead.
  *
  * These argument descriptions are the defaults for all
  * like-named arguments in the following wrappers except where noted bel=
ow.
  */
-#define futex(uaddr, op, val, timeout, uaddr2, val3, opflags) \
-	syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
+static inline int
+futex_syscall(u_int32_t *uaddr, int op, u_int32_t val, struct timespec *=
timeout,
+	u_int32_t *uaddr2, int val3, int opflags)
+{
+	return syscall(SYS_futex, uaddr, op | opflags, val, ts32, uaddr2, val3)=
;
+}
+
+static inline int
+futex_syscall_nr_requeue(u_int32_t *uaddr, int op, u_int32_t val, int nr=
_requeue,
+	u_int32_t *uaddr2, int val3, int opflags)
+{
+	return syscall(SYS_futex, uaddr, op | opflags, val, nr_requeue, uaddr2,=
 val3);
+}
=20
 /**
  * futex_wait() - block on uaddr with optional timeout
@@ -57,7 +66,7 @@ struct bench_futex_parameters {
 static inline int
 futex_wait(u_int32_t *uaddr, u_int32_t val, struct timespec *timeout, in=
t opflags)
 {
-	return futex(uaddr, FUTEX_WAIT, val, timeout, NULL, 0, opflags);
+	return futex_syscall(uaddr, FUTEX_WAIT, val, timeout, NULL, 0, opflags)=
;
 }
=20
 /**
@@ -67,7 +76,7 @@ futex_wait(u_int32_t *uaddr, u_int32_t val, struct time=
spec *timeout, int opflag
 static inline int
 futex_wake(u_int32_t *uaddr, int nr_wake, int opflags)
 {
-	return futex(uaddr, FUTEX_WAKE, nr_wake, NULL, NULL, 0, opflags);
+	return futex_syscall(uaddr, FUTEX_WAKE, nr_wake, NULL, NULL, 0, opflags=
);
 }
=20
 /**
@@ -76,7 +85,7 @@ futex_wake(u_int32_t *uaddr, int nr_wake, int opflags)
 static inline int
 futex_lock_pi(u_int32_t *uaddr, struct timespec *timeout, int opflags)
 {
-	return futex(uaddr, FUTEX_LOCK_PI, 0, timeout, NULL, 0, opflags);
+	return futex_syscall(uaddr, FUTEX_LOCK_PI, 0, timeout, NULL, 0, opflags=
);
 }
=20
 /**
@@ -85,7 +94,7 @@ futex_lock_pi(u_int32_t *uaddr, struct timespec *timeou=
t, int opflags)
 static inline int
 futex_unlock_pi(u_int32_t *uaddr, int opflags)
 {
-	return futex(uaddr, FUTEX_UNLOCK_PI, 0, NULL, NULL, 0, opflags);
+	return futex_syscall(uaddr, FUTEX_UNLOCK_PI, 0, NULL, NULL, 0, opflags)=
;
 }
=20
 /**
@@ -97,7 +106,7 @@ static inline int
 futex_cmp_requeue(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2, in=
t nr_wake,
 		 int nr_requeue, int opflags)
 {
-	return futex(uaddr, FUTEX_CMP_REQUEUE, nr_wake, nr_requeue, uaddr2,
+	return futex_syscall_nr_requeue(uaddr, FUTEX_CMP_REQUEUE, nr_wake, nr_r=
equeue, uaddr2,
 		 val, opflags);
 }
=20
@@ -113,7 +122,7 @@ static inline int
 futex_wait_requeue_pi(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2=
,
 		      struct timespec *timeout, int opflags)
 {
-	return futex(uaddr, FUTEX_WAIT_REQUEUE_PI, val, timeout, uaddr2, 0,
+	return futex_syscall(uaddr, FUTEX_WAIT_REQUEUE_PI, val, timeout, uaddr2=
, 0,
 		     opflags);
 }
=20
@@ -130,7 +139,7 @@ static inline int
 futex_cmp_requeue_pi(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2,
 		     int nr_requeue, int opflags)
 {
-	return futex(uaddr, FUTEX_CMP_REQUEUE_PI, 1, nr_requeue, uaddr2,
+	return futex_syscall_nr_requeue(uaddr, FUTEX_CMP_REQUEUE_PI, 1, nr_requ=
eue, uaddr2,
 		     val, opflags);
 }
=20
--=20
2.31.1

