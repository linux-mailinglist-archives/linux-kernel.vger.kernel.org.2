Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA560436F75
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 03:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhJVBhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 21:37:06 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29143 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbhJVBhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 21:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634866484; x=1666402484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uekV2slH9LXIzmi+5+Ec6CuXKwui2fjecjIGu1he6h0=;
  b=DN0svjiNV0ll+++TCJsmqkxIiitTdw097vGBpLlJHbZe3jGfYePXcqyU
   b9TEUoegWAPwa8Sa9WeCMs55EEwobYM6QzerTkd5risMEutZqYB8q+Nup
   7hQ52HHMIgFWgf+imQ5SDG0Poc9ljKfpgbWFqiyhylHQ4502OwHtHDdqX
   KzPRZeonSd2WDym5rquMlOMZ74vOV9iLY1A2u6oqKcxh18AYqzL+5h+hz
   ojEXo7uoqAqY0fJ6D1eVrylaVIErk+VtJADzyYXOWDCQl/5gE3tdPdWx3
   p6yXYWJr0igpfwxkv3mwuGcZRQ1dalfhC1Elm+ayCchSQUFSlhLLEEvJG
   w==;
X-IronPort-AV: E=Sophos;i="5.87,171,1631548800"; 
   d="scan'208";a="188348047"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2021 09:34:44 +0800
IronPort-SDR: 9XMX63jD5JaGg0Oc4bHRjHKHspkAz9wZT/bmqfUl7F8QHMitpo4PFZGLPtalP7Xt6ahR0fm0gc
 CRR4kPvbSGCIU/fC5WWLZoU/cODdzrao3p2yGlpJUfueEDs2SDr1tcGfgZYPuJ6Vo/KtzNSnWb
 +ZWITcgO+/HAQ1n95bBvrKKUxjHarg1om8T3ni7sMT5XOOnT0BZtfxCyeFsAyHc1NGcSvMCDDl
 Vi841K2ckfSwlDpZ/Rn3crio7mWxY2tXYAH1XSNmtuRKIbikkonTKdZYbQZcL/QtcYbpFZkisl
 EJxiCxQ+5QBzn0gbdkeS0gJz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 18:10:20 -0700
IronPort-SDR: 8OrQUxMnqae0UMImBu0y06vrkDK5wdiDefEccq6T3Rhby+0+gemS0iCnEuDNcTaJZFqBCwJ/j1
 ufW6FWwjYFOB6ZDKDg83iRWzq+xuUgrEZfvfNSc7rDIYv1AQXCEReNtGKQkKrSjge6Hey6k44W
 OeJuKrRVNR381GMTUls9xytOErTh87p/Xo6lSuuwwQIkJreyt71ZAb0spJf1HqTLvqvi5/sz4H
 TpKPD53VJDkzFLlH+CpGCER6SO5PT1NLzHfQWHmoD1/Se+hd1yQOneCLj8V2Cgti7RjtdTTqaU
 aa4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 18:34:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hb6N43NXdz1RwqK
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 18:34:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1634866483; x=1637458484; bh=uekV2slH9LXIzmi+5+
        Ec6CuXKwui2fjecjIGu1he6h0=; b=cciO0ud2x6Nw+4POPJ1cL9lSzePeHfI63x
        1Isa+oyimEZxe2hhBJcL0j6HM2pK1kT5xt/Mg4srhw51EZE4hzILtNPKqynDyzuP
        P5wlnS/FujMyJYNhGXxdPO8vLj+HcAF//IwK1aqtxbjRF6aQBg6bXxopWQsPrkpI
        yuNmpMSqlxXyfV6kdqC0Y75ni63ipH/ENlAByL3QTkRacEHzISTOA0UMjRBFB1pF
        1t1++muaDbwYjcOIh9v8E+18MnmsiPPefn2ShYi9mHcp+8j574z12ud1p1Mz67Go
        tu+uDYaPLpMSW4wMs6z3em7APPr2hfk+L7N7btOy4XkoDXAsTlPQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6SJGw845Lois for <linux-kernel@vger.kernel.org>;
        Thu, 21 Oct 2021 18:34:43 -0700 (PDT)
Received: from toolbox.wdc.com (unknown [10.225.165.39])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hb6Mq37m6z1RvlC;
        Thu, 21 Oct 2021 18:34:30 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     dvhart@infradead.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mingo@redhat.com, atish.patra@wdc.com,
        linux-kernel@vger.kernel.org, arnd@arndb.de, alistair23@gmail.com,
        mark.rutland@arm.com, acme@kernel.org, peterz@infradead.org,
        dave@stgolabs.net, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 4/4] selftests: futex: Add support for 32-bit systems with 64-bit time_t
Date:   Fri, 22 Oct 2021 11:33:43 +1000
Message-Id: <20211022013343.2262938-4-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211022013343.2262938-1-alistair.francis@opensource.wdc.com>
References: <20211022013343.2262938-1-alistair.francis@opensource.wdc.com>
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
---
 .../futex/functional/futex_requeue_pi.c       |  2 +-
 .../selftests/futex/include/futextest.h       | 44 ++++++++++++++++++-
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c =
b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
index 1ee5518ee6b7f..d3673996fed4e 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -294,7 +294,7 @@ int unit_test(int broadcast, long lock, int third_par=
ty_owner, long timeout_ns)
 		secs =3D (ts.tv_nsec + timeout_ns) / 1000000000;
 		ts.tv_nsec =3D ((int64_t)ts.tv_nsec + timeout_ns) % 1000000000;
 		ts.tv_sec +=3D secs;
-		info("ts.tv_sec  =3D %ld\n", ts.tv_sec);
+		info("ts.tv_sec  =3D %lld\n", ts.tv_sec);
 		info("ts.tv_nsec =3D %ld\n", ts.tv_nsec);
 		tsp =3D &ts;
 	}
diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/te=
sting/selftests/futex/include/futextest.h
index c786fffecb8a5..b303d0d492ff7 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -17,10 +17,12 @@
 #ifndef _FUTEXTEST_H
 #define _FUTEXTEST_H
=20
+#include <errno.h>
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <linux/futex.h>
+#include <linux/time_types.h>
=20
 typedef volatile u_int32_t futex_t;
 #define FUTEX_INITIALIZER 0
@@ -69,14 +71,52 @@ static inline int
 futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, struct t=
imespec *timeout,
 	      volatile u_int32_t *uaddr2, int val3, int opflags)
 {
-	return syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, va=
l3);
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
+
+	errno =3D ENOSYS;
+	return -1;
 }
=20
 /**
--=20
2.31.1

