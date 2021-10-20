Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237E74355F8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 00:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhJTWmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 18:42:09 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:2900 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhJTWmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 18:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634769593; x=1666305593;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ANjv7oA9MTzC+HqX2lqEYQUduo9FaGOUFrImo55vutA=;
  b=EJRv30ezf5CdbqE74gl2TFpOcFmYYlbIkgTL8MKaCPcAYheipK3a9QzX
   jiD4y8Qv7UAjhaXMesctiKbEnqshC5QooDU6kF1EJsTqkMEygt8LQN+u/
   32qDanRr5GJn65B9g4j38sGF6uATDQ8qEl3KrYj/rpHzNudyKi2FagHn1
   AmOYYKVwHU6XESlGMYYNPfPeps/mxVvNWIKqL58jKV/h0ev+984C6nPVp
   LHcXsRNpfME3QNlzJjNg4ByA0LVLi2pfbEsEjZZHUvUwvgtgVD4u9mF0X
   ps5TqcuVujDdmWvifjKEEjLvThIcMoJ/vsRYiywpbTPNuE0QPbOjDVApF
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,168,1631548800"; 
   d="scan'208";a="287328433"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2021 06:39:52 +0800
IronPort-SDR: b6tIJeOIoN+8dw//KtjBy5HuZasD1chM2HZ9EU78h9opmoctac27GGxkSLQtjcawpvMhkh1M2M
 A2WzVuxbw6YLBUMaKcwnfLUbxxj0r187g6+GavmehVGU91elmm2nyCLgfLS6BwBMYO4scJ64as
 z3eT1SYWYFHwp38ERqteZHMV0SVwZa774ze2xPFknuYJPpOQfsEAdji3FI2xXiSiTChb3jZaVS
 YYcHzGfQhB/vRhsVBpmt+hSLNU9N24UzHykFZ29XhLlkFyAtS/6IOlPM+b6vUK4Z9zCminm+WT
 +5T/ek8rWyrxXH1OitQAK/YE
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 15:13:56 -0700
IronPort-SDR: 4QWFJHpPMqjA/lxIckyZyoicOMvSjvvVZ+vxaOVznykZTubXzxRHkX1zRKkTwVjhFWNWTlmkpx
 4XJS9WJrf3zgCvBTD+siSMTUPlTpxRQcspIC1odEV9kzvNyyaY3hFO6XIv8ShnvT8c0+SJgjJ3
 vSouB7jJB12L+MgRzrxZpC7gfZR55COZApRkqawlI8CZP2J89aYZvAusvrITcCGgRjdex5dEhs
 JViMI5DwaCfowG58utvtJadq26x+2QESjlhqs2oMAu4smARAbaUga3Iziz0lezH8EesqJSS9tm
 hyQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 15:39:53 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HZQXm2T4Hz1Rwrr
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 15:39:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1634769590;
         x=1637361591; bh=ANjv7oA9MTzC+HqX2lqEYQUduo9FaGOUFrImo55vutA=; b=
        ulcVS5l/sZ8+ndMGNDX3tauN+ZGWc3NLa+Ub9sJbs7GJTUK9BcoQY4D3d9iSCSFm
        Hh2iRnBrWxiiMYEhO2EOTslHiUdG5zSsLpin14mVxyF4mVYKJaCCjHBgTJfVy+SR
        WA/JA4i5amv5PZUh4DNbERv2vAHwdd6xi+xm9zLyf+BRGCKn2kppegl4/vmONvAi
        51vHNoWuRQpYgcRmmUHzk9t+NAF1gjAvMUE+O87y1LcJ2JJFFxUcSCmJXWzs0rIw
        M+hmqvB1km8Cs2fuHC0Hnyqak3D8MFoksxXK7TMsih6DAeYoevozft9+/vSu2xJ+
        1ArIFP5Z9FPnCGiarM21Tg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VCrnSItlvkZD for <linux-kernel@vger.kernel.org>;
        Wed, 20 Oct 2021 15:39:50 -0700 (PDT)
Received: from toolbox.wdc.com (unknown [10.225.165.39])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HZQXV2XHlz1RvlZ;
        Wed, 20 Oct 2021 15:39:37 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, alistair23@gmail.com,
        namhyung@kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        acme@kernel.org, dave@stgolabs.net, dvhart@infradead.org,
        peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        atish.patra@wdc.com, arnd@arndb.de,
        Alistair Francis <alistair.francis@wdc.com>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH v4 1/4] perf bench futex: Call the futex syscall from a function
Date:   Thu, 21 Oct 2021 08:39:17 +1000
Message-Id: <20211020223920.2810727-1-alistair.francis@opensource.wdc.com>
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
Acked-by: Davidlohr Bueso <dbueso@suse.de>
---
 tools/perf/bench/futex.h | 43 ++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index b3853aac3021c..b97a343e7ec66 100644
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
+futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, struct t=
imespec *timeout,
+	      volatile u_int32_t *uaddr2, int val3, int opflags)
+{
+	return syscall(SYS_futex, uaddr, op | opflags, val, ts32, uaddr2, val3)=
;
+}
+
+static inline int
+futex_syscall_nr_requeue(volatile u_int32_t *uaddr, int op, u_int32_t va=
l, int nr_requeue,
+			 volatile u_int32_t *uaddr2, int val3, int opflags)
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
@@ -97,8 +106,8 @@ static inline int
 futex_cmp_requeue(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2, in=
t nr_wake,
 		 int nr_requeue, int opflags)
 {
-	return futex(uaddr, FUTEX_CMP_REQUEUE, nr_wake, nr_requeue, uaddr2,
-		 val, opflags);
+	return futex_syscall_nr_requeue(uaddr, FUTEX_CMP_REQUEUE, nr_wake, nr_r=
equeue, uaddr2,
+					val, opflags);
 }
=20
 /**
@@ -113,8 +122,8 @@ static inline int
 futex_wait_requeue_pi(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2=
,
 		      struct timespec *timeout, int opflags)
 {
-	return futex(uaddr, FUTEX_WAIT_REQUEUE_PI, val, timeout, uaddr2, 0,
-		     opflags);
+	return futex_syscall(uaddr, FUTEX_WAIT_REQUEUE_PI, val, timeout, uaddr2=
, 0,
+			     opflags);
 }
=20
 /**
@@ -130,8 +139,8 @@ static inline int
 futex_cmp_requeue_pi(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2,
 		     int nr_requeue, int opflags)
 {
-	return futex(uaddr, FUTEX_CMP_REQUEUE_PI, 1, nr_requeue, uaddr2,
-		     val, opflags);
+	return futex_syscall_nr_requeue(uaddr, FUTEX_CMP_REQUEUE_PI, 1, nr_requ=
eue, uaddr2,
+					val, opflags);
 }
=20
 #endif /* _FUTEX_H */
--=20
2.31.1

