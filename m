Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169EF4355FA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 00:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhJTWmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 18:42:21 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:46066 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhJTWmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 18:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634769606; x=1666305606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t4IGyendo4BsqYlBXcz6RY1/SabKmba0GonLcqIFhF0=;
  b=N9Qa4BHHeK1CffRCfLfg8GG8XQyny/IITgGCZQiKuGKpBNEA55ZdQQ/L
   d8RkXiYOtpPzwwWHQWRlUF7tP3LUd6Rg/IrmNdUunv+IbnIFG1AJYzQWa
   9gC3QY9c8XiKDWujoml94MILNok97G1EnXQxSfTM5Reiezywk5BQoXfqX
   rwJKLr/GwwVR841e+EeaPtNudwduGF2kqv6AX6Rrhfwcfy6DxHEAWCB2I
   Ku3ZJvnQoTUJ8oea20VUhugOs0k9zBkMubjGeDhPzwrZakiWmNHDogqCA
   OjOA+L/++WhlVo1ddUvRSF1LD+KUQRkLUIkbeFIKIENjPLzb48IjXUCtR
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,168,1631548800"; 
   d="scan'208";a="184393902"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2021 06:40:06 +0800
IronPort-SDR: 4BhCeh4J32HhaCJ8prdYyML3evLdNwGnrsLQQiBIrDD6wOq4Rr1pVwLd2vRiEdABtQb6gLp9rY
 t3AueaUGazyWNR0FDvFjIGMpjQGzHY7URG3TDGxJJO0aL5kUbTOnetk66n3TlfcDqhjluUKMAn
 QzIZ8FCJtni6c0Eo8M/HZgfaoi4Gh2T9XFEcyTtYETaSvDdehfBdNPbc0SwMyBoSDAUshjPiuv
 84R7wyccICFSCtYUsY1LeyxuV8fUWjhs5HKFH4ye0CsjL1haqqyfOzbdazKEatZG/TU9wtZQ6I
 dMlUDYbtQ/abiEb1bmlREK+D
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 15:14:09 -0700
IronPort-SDR: KsefI9vO9PhxHDrcm4Lg5rMwf9XGba2ao0Y9Q5/frag8PiYfd5eqLZcZSuzoqq35umOdHDKV/l
 AYgx4coXPTU7Ac8SNtGpJAV9Wv4C+qaP8AD8wi12IJpBAHO+k+g5BMlKQ7bKl7t6DmeluP4/Yz
 wILXV08g5N7gur8CYG3IybZ47qaSZkZSg3XGHc3i57kWZ8tj6dqYLipuJNpt73L3z/rO5G67Ht
 ZdOYLRXg/9SrNEnz1ebuPPccZ4UHxX96jVxIajjJtATD0g+qZvna/o8xDTOVduiNbBLWlJoXAK
 Y2w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 15:40:06 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HZQY10228z1RwtP
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 15:40:04 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1634769603; x=1637361604; bh=t4IGyendo4BsqYlBXc
        z6RY1/SabKmba0GonLcqIFhF0=; b=IC/mJaTEU70L5dB8tUNlENk+i9mh/z73si
        G5Hk1o5pXrPGRsLuA2znC3W7qrC94oZ0YAdhWjifFf9msVzgbiDVeEHc5xXbQDSQ
        SvKEYWeNx1FOGAVCb2Zv21sreHjClw+lAtNmTnFq0MXfL7/YAJdQVJl811Wc4oz9
        N4MI+v8RgwDm/bkChzSPJ5Q+QYRdX0373Oob/QQ5IKti+izWUy2QBdgJ7oUZ+MSm
        l5LIcfhlY8u1wA9/pI1CvFQZx8Z3ey5bnrhwOWuPOwcZ8Hr0scUCaM+TqmFyMTv4
        w/ZV4UYRsL0GiQUv4+z0I1HSln5IZzdGYbGwOzhEoxrtigmaqbuA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8a4c0clGxIQl for <linux-kernel@vger.kernel.org>;
        Wed, 20 Oct 2021 15:40:03 -0700 (PDT)
Received: from toolbox.wdc.com (unknown [10.225.165.39])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HZQXl5j5vz1RvmF;
        Wed, 20 Oct 2021 15:39:51 -0700 (PDT)
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
Subject: [PATCH v4 2/4] perf bench futex: Add support for 32-bit systems with 64-bit time_t
Date:   Thu, 21 Oct 2021 08:39:18 +1000
Message-Id: <20211020223920.2810727-2-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211020223920.2810727-1-alistair.francis@opensource.wdc.com>
References: <20211020223920.2810727-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

Some 32-bit architectures (such are 32-bit RISC-V) only have a 64-bit
time_t and as such don't have the SYS_futex syscall. This patch will
allow us to use the SYS_futex_time64 syscall on those platforms.

This also converts the futex calls to be y2038 safe (when built for a
5.1+ kernel).

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
---
 tools/perf/bench/futex.h | 43 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index b97a343e7ec66..6a7dd86871eb8 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -8,10 +8,12 @@
 #ifndef _FUTEX_H
 #define _FUTEX_H
=20
+#include <errno.h>
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <linux/futex.h>
+#include <linux/time_types.h>
=20
 struct bench_futex_parameters {
 	bool silent;
@@ -28,7 +30,7 @@ struct bench_futex_parameters {
 };
=20
 /**
- * futex_syscall() - SYS_futex syscall wrapper
+ * futex_syscall() - __NR_futex syscall wrapper
  * @uaddr:	address of first futex
  * @op:		futex op code
  * @val:	typically expected value of uaddr, but varies by op
@@ -49,14 +51,49 @@ static inline int
 futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, struct t=
imespec *timeout,
 	      volatile u_int32_t *uaddr2, int val3, int opflags)
 {
-	return syscall(SYS_futex, uaddr, op | opflags, val, ts32, uaddr2, val3)=
;
+#if defined(__NR_futex_time64)
+	if (sizeof(*timeout) !=3D sizeof(struct __kernel_old_timespec)) {
+		int ret =3D  syscall(__NR_futex_time64, uaddr, op | opflags, val, time=
out,
+				   uaddr2, val3);
+	if (ret =3D=3D 0 || errno !=3D ENOSYS)
+		return ret;
+	}
+#endif
+
+#if defined(__NR_futex)
+	if (sizeof(*timeout) =3D=3D sizeof(struct __kernel_old_timespec))
+		return syscall(__NR_futex, uaddr, op | opflags, val, timeout, uaddr2, =
val3);
+
+	if (timeout && timeout->tv_sec =3D=3D (long)timeout->tv_sec) {
+		struct __kernel_old_timespec ts32;
+
+		ts32.tv_sec =3D (__kernel_long_t) timeout->tv_sec;
+		ts32.tv_nsec =3D (__kernel_long_t) timeout->tv_nsec;
+
+		return syscall(__NR_futex, uaddr, op | opflags, val, ts32, uaddr2, val=
3);
+	} else if (!timeout) {
+		return syscall(__NR_futex, uaddr, op | opflags, val, NULL, uaddr2, val=
3);
+	}
+#endif
+
+	errno =3D ENOSYS;
+	return -1;
 }
=20
 static inline int
 futex_syscall_nr_requeue(volatile u_int32_t *uaddr, int op, u_int32_t va=
l, int nr_requeue,
 			 volatile u_int32_t *uaddr2, int val3, int opflags)
 {
-	return syscall(SYS_futex, uaddr, op | opflags, val, nr_requeue, uaddr2,=
 val3);
+#if defined(__NR_futex_time64)
+	int ret =3D  syscall(__NR_futex_time64, uaddr, op | opflags, val, nr_re=
queue,
+			   uaddr2, val3);
+	if (ret =3D=3D 0 || errno !=3D ENOSYS)
+		return ret;
+#endif
+
+#if defined(__NR_futex)
+	return syscall(__NR_futex, uaddr, op | opflags, val, nr_requeue, uaddr2=
, val3);
+#endif
 }
=20
 /**
--=20
2.31.1

