Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0653C459860
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 00:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhKVX0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 18:26:16 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:44520 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhKVX0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 18:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637623386; x=1669159386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cW6tKnHnT46fju5wQk23yzM0+ePdggRMpkOpnMzhj4U=;
  b=Ru3a6yFhO78HTsxTTDELk3jtTeKhyAp1Wuz04iCCWDhF/MLaUCOc728v
   YxF8sqerB+PorTLITLDY4VMqVhIRqVCRZ57qKuWrQxjrw6+pBtosDaJ/T
   hHevRhTutUVOoJAgg6wUKoHIiGh8kSkGphJFyuZ0P5Tktomg6RAZ6771L
   PKbJUmO/Op4eufvFscv6palyH5hHWkbvbYbdPG9A5v+uXxHUYIQCBtpV9
   Ovr5Go0rk9MITd73eo/LGEzlNp2v0ZwKc8dvIppXMTh0gbG5v5nKT1wDv
   86uVlKSt4Y0Ipbf6Nl4ghXu9MKqWmH6uk94CgmpLQta2ECjpN46BJ5rqs
   g==;
X-IronPort-AV: E=Sophos;i="5.87,255,1631548800"; 
   d="scan'208";a="191158521"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Nov 2021 07:23:06 +0800
IronPort-SDR: 0A7ydrRzE/b6b0S1ErYI+MZENgr0JuPnQqmVyq2A5Io69mD8ldB2PqNgc9+Uftn6tqZavzB0Ij
 U2rPTB+VuBfsMFqKRzVq7D8Aqib0cA/QDkr9+2vHfC8kl9qCTMDZ+mEZ7dAhrEfP+hxzywFg11
 TINKNnItqmyZSl+kZi7n/LEIJ6t0UG3mkLFcqzdrcZr3S5S6/UGB4f4w6/i5RLjoISnqp1oTvL
 7Ov+acgfr235rT1JV3T77/q3qd8c1CBS5DyxR+ZS9RO8bQGlRmeRu7WOMJxQFx/CHwH12f6xMV
 i20amV9kz5B20VnXjLxwWOGw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 14:58:02 -0800
IronPort-SDR: xqBgfMKfJuv1UOcq35R9brO1GTSPeF9bssDTXyylV1FwEj4CKT39OAWhMUCtLvixNGcH9xllrw
 IvduYiOv1Re0DTZfyQxHA9Ld5SSUqSshtv9ede3lkq8P2xai7pzOVhGC8vJ/QRwpbV3Bz/xzQH
 dpfBvwuTXUF23tsZTPVZEys5TvkqC7+gTXg71VePBaIKNcHzxG9TycDROD6xwyAV9IpVjeM9Sd
 Hm5+fEq51K68cuK5iiCdGsX/gEkwdvRrp0jJC2rT/ewMD6d/CAcMs7OFU6c0qA0355WtC1VqGY
 b0g=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 15:23:08 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HyjxQ6KGpz1RtW3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 15:23:06 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1637623385; x=1640215386; bh=cW6tKnHnT46fju5wQk
        23yzM0+ePdggRMpkOpnMzhj4U=; b=OVmVNDlRcCmsB50kGHheqayKTOkbh0YKmU
        rUFwReqsy750zw78a/CjaaI2w8hTXAfHMTCWVQqqn6l3uijWUVV6T+6yRWG7pI6X
        e93Dlx2lPIFb+Tw1MgD+p1TnRHMllnilQW0WLKmThFg/NHNZ1YLd8XYnI1XnG0lU
        pRTx4rZL80kkC1YSiN9BP2Ld7sO77WM6kUNei9PSHZhrKMUR23fOBATHkAZxouJ2
        SJqfI8MmbSiV1Aaod5WIzkFGvXEEmt3TPtQYFPfb1KWtGvjRo4ZKnk3VS9PS+Skp
        QoFYh+xevkHlac2fvHKcVjhkeMb0EoHm2gSLaHTTUbyMdO3+Q3yA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mGZ_UtUgH_fY for <linux-kernel@vger.kernel.org>;
        Mon, 22 Nov 2021 15:23:05 -0800 (PST)
Received: from toolbox.alistair23.me (unknown [10.225.165.60])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HyjxD2k8Cz1RtVn;
        Mon, 22 Nov 2021 15:22:55 -0800 (PST)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     mark.rutland@arm.com, atish.patra@wdc.com,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        tglx@linutronix.de, namhyung@kernel.org, dave@stgolabs.net,
        arnd@arndb.de, linux-kernel@vger.kernel.org, jolsa@redhat.com,
        acme@kernel.org, alistair23@gmail.com, dvhart@infradead.org,
        mingo@redhat.com, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 2/2] selftests: futex: Add support for 32-bit systems with 64-bit time_t
Date:   Tue, 23 Nov 2021 09:22:36 +1000
Message-Id: <20211122232236.119533-2-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211122232236.119533-1-alistair.francis@opensource.wdc.com>
References: <20211122232236.119533-1-alistair.francis@opensource.wdc.com>
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
index 1ee5518ee6b7..d3673996fed4 100644
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
index c786fffecb8a..b303d0d492ff 100644
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

