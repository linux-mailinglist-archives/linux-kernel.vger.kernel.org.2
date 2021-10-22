Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDF8436F6B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 03:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhJVBgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 21:36:38 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29109 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbhJVBgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 21:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634866460; x=1666402460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0jezQdAQdWhHmDMWZLYcoD4DYC4/yRryNOc0ZTLZ39I=;
  b=ricZtz7R8MiKWAp8dhrBBc3qj7DqFieTLzdn6vipjngs3KXpQApePvGD
   EfiSLXPkpDLaXQvI0Q3jGQSVUMLpPBRK+TC01jVKzKS6aE+MFnYQfUSpT
   GRYELHbx++B3ZkMJ+8hbT33eZF1s1hUfJSTA3bYD6Un+EmXtvXZ2aUoUZ
   3Hpj0KeLUSPzFW6bP6ppvfnPPUXr0bhoeBo8K+7V9uLMaYDbbOY8keyyK
   bAAGAJLktVjRGg+xV7yFs7IF1AU5iTsEm8stVTIkOQK+0bvLyd6wOGQ7N
   8aJ9hfY1EUTLmRj95XJS+wGs4jWt3EY7wHwVvWt1A/6CHV9YuDnNyytjM
   g==;
X-IronPort-AV: E=Sophos;i="5.87,171,1631548800"; 
   d="scan'208";a="188348022"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2021 09:34:19 +0800
IronPort-SDR: cYm95NQA5dzz6eBxWpkSoWYw1KYdp+Boyu9F6XIFpZQ93BQG2PjiogqNs4CfAb7NxHJArkj8CN
 TxF1jMFn5woAdbJb8wtge3A6ega2snDXF0v6LK9aMZT0liq8ee8BVMajdnY/jj0UCt+Ol2wQEK
 7x3IE0h1MJYPrE8RLfjLT+RhBX7eDpAiqLdtw4di579LhL1FEJ8OVPmepyqfl0AOE9paTN+bPc
 u3+xweJipggVXXLdD5Y/o+o+DuY+1NtrOHBAXupD0Q9ojOmP7K9uzXEwiADSJN8UI2G3Xvqeng
 h+CBBMvUnugG3MNXLHT2wBn7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 18:08:22 -0700
IronPort-SDR: eIRpkBwenBJ+BuNX884IzLl3cTagZnBiZHHGECn4ZHzrUPTqfUflTZRlg+SLxiI4tUsw+P03Aa
 l/DVwelWUZHKlLdb/tj3qfb9ZgsYWAMEDnc+RdO9880GiL0Az5VqGILW0ujJrVzCu/4aE6W9nv
 78Xymnx/4CU38Ue86SB0innDuDs+oJ3134Svat8uStMsnEPW0GmH8T2fYKsDbIHX/2nlDIlT9z
 b2cHsOrHkkgPvPIe1oJt6rpSdAHkh7qKl0xqr/EhuwBiAFJ4C1g3uUss1kxGeRlQDljaY+CCRd
 FeA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 18:34:19 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hb6MZ5XQgz1RvTm
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 18:34:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1634866457; x=1637458458; bh=0jezQdAQdWhHmDMWZL
        YcoD4DYC4/yRryNOc0ZTLZ39I=; b=srYgOZj35H5p9OIJQafrSjr8v7mCjz+hup
        H56NYdLtorEQPLbINDMzDLT4r+FJEn7KMI8jdsV4oo+l7Uuq/NISmJMLZODbwGk9
        S2Ha3vj8MPkrHvONyQlGO/ZxWJ6xyyf1Vq+xvot3DtCGsdZ2ap4+6uxcI4nWlcSY
        GJfNTGvXueh2A41SdyjIkRt89B1pHtcbW7AZ3vRroWby9RBF39mNDJv55D3N1PPc
        711XAvSiuygtbyeQwFqca6UDVI2SC/ZO1A6V6ySbbbkOElqONZXEbS36PSofpvde
        /BgQZKvoJxz/gZP5RdVHfHNqHQRFmaz3MYdrrxrVcIvlACCsrrYA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kPL4J5domxl6 for <linux-kernel@vger.kernel.org>;
        Thu, 21 Oct 2021 18:34:17 -0700 (PDT)
Received: from toolbox.wdc.com (unknown [10.225.165.39])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hb6MK10B0z1Rvlw;
        Thu, 21 Oct 2021 18:34:04 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     dvhart@infradead.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mingo@redhat.com, atish.patra@wdc.com,
        linux-kernel@vger.kernel.org, arnd@arndb.de, alistair23@gmail.com,
        mark.rutland@arm.com, acme@kernel.org, peterz@infradead.org,
        dave@stgolabs.net, Alistair Francis <alistair.francis@wdc.com>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH v5 2/4] perf bench futex: Add support for 32-bit systems with 64-bit time_t
Date:   Fri, 22 Oct 2021 11:33:41 +1000
Message-Id: <20211022013343.2262938-2-alistair.francis@opensource.wdc.com>
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
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
---
 tools/perf/bench/futex.h | 43 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index ebdc2b032afc1..6a7dd86871eb8 100644
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
 }
=20
 /**
--=20
2.31.1

