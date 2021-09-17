Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B773440F1F0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 08:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244994AbhIQGMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 02:12:42 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:25066 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242449AbhIQGMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 02:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631859071; x=1663395071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2XzaRZS9DB+vo3EW82fkFoK8YHkr9HzLbMoUY86sntU=;
  b=HMJX2mWXjojUzs9nI/VDn2VOfiYmfvzz1Z0jwFnM8APHMvKkPYnqYtN8
   jWYQpOrHXfmfQp+uutfJLdi8gGFaTpiAVDkxdCIbKEu4cOpwMHmgBcpfZ
   FZFQOpgxOXjdXk9c2GSuMR0DUqcWgwAMmF128CUFcQu5Gxzv6IKW5fw8g
   RoMasKlE/AyaLe8dWqs2Ksa4yaUthNfh3pbktCQWjEsW48OnqTrK6/8LI
   BP2N1zegyotOY1Du7wlUkiMc7lvXTujwTJdgsroRyzZLn8hwmFh4XpyKI
   zmVNPftTj6+Eson/whjJ6zKJlQJpSYEk9IOG9Ktp+/a0wpLPoSL7dEPSC
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,300,1624291200"; 
   d="scan'208";a="179316005"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2021 14:11:11 +0800
IronPort-SDR: jbc3YIYhksgc4mMUFZGO6jksMhU6WamoVJPNHLZ3naD5cloOdG1T0mGzWW4aiF5ex88ag6gT7k
 7m+ZZCEHQf/RcPNB8V1j6Ug2/407tKrVEdY38E5c4huwZ2W4Q7dyTJ03HUh3sV+xMmrb+WwAfT
 7xFPlbifNezGVR3XqDjuAyPy3i0V81Ww+y8jv+LDNLfy9Z6TSZBc+IZ+4iMxyXXAW+99F24AhC
 c1JyMLRdtaakXgpI6RkiccpijQwm2U0mHW63KOfMDZWGLiVd+FkuI8n671TIMpMPd622OgnAft
 7FUd25gn1RRLximOEFG92W7P
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 22:47:31 -0700
IronPort-SDR: zy4AlFyAWutkvHWAfv4WjdZdDZYEq2joV8ZUcacSx2QERzSjICVk3yMUH8WX+iaZE8CW9y929u
 GnFco3eYClcD9EKoaBlEDqwBKiFcGIig8ORY55CYzdeg7BZkY+txWV2ureD8Qb+2OQ1hCcenCI
 0SX/C/uSXHUrWgfTwbXZcnHVeix2fqUh0Shh/OaRfSoitPFIww04XUkp5hv7eZgxm+OkLCpxfw
 rAYOgZgavG5FqDiV0k/UhO5gQAwROFajm9KL0xGvmsqUYOgAgvxN+nwWwa/M3KrnQOQh3g66uS
 R5w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 23:11:12 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4H9k9C4NCDz1Rvlx
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 23:11:11 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1631859070; x=1634451071; bh=2XzaRZS9DB+vo3EW82
        fkFoK8YHkr9HzLbMoUY86sntU=; b=O+ZCjSVCArB8qXWbzuP3xwIcPXjm2N/jYl
        /JCj9NfTbC6R7os0Aawxi+pihTWL8rxwAJH/+HOCJT25dD/vVs0AxrRUlG3nVyln
        lY1xExn5R33tew9X+vv0KKmf1w5lsaqkildfSfHbom6d6VC/qWlaPphiVEtBTT7A
        JWhbV/gMDFEF3n454dyUgWTAL40VZl7M4lDwHNmT8xLc4oEMcmTaC9hE8OC5OXod
        Mf35S2zUzL4blkvyQzYxhjl0klkx1je2wMUMvQIbsbk26sHNibtY6hOnTvjknkoF
        gCkTeVAr6u9oWmdSZ8a0w9ExFH8rE7BTBdLJTyZuzrpL71EhKgYA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HrrXFJEsDymr for <linux-kernel@vger.kernel.org>;
        Thu, 16 Sep 2021 23:11:10 -0700 (PDT)
Received: from toolbox.alistair23.me (unknown [10.225.165.23])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4H9k912H01z1RvmH;
        Thu, 16 Sep 2021 23:11:00 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, alistair23@gmail.com,
        namhyung@kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        acme@kernel.org, dave@stgolabs.net, dvhart@infradead.org,
        peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        atish.patra@wdc.com, arnd@arndb.de,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 2/2] perf bench: Add support for 32-bit systems with 64-bit time_t
Date:   Fri, 17 Sep 2021 16:10:40 +1000
Message-Id: <20210917061040.2270822-2-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210917061040.2270822-1-alistair.francis@opensource.wdc.com>
References: <20210917061040.2270822-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

Some 32-bit architectures (such are 32-bit RISC-V) only have a 64-bit
time_t and as such don't have the SYS_futex syscall. This patch will
allow us to use the SYS_futex_time64 syscall on those platforms.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tools/perf/bench/futex.h | 42 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index f80a4759ee79b..e88b531bed855 100644
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
@@ -28,7 +29,7 @@ struct bench_futex_parameters {
 };
=20
 /**
- * futex_syscall() - SYS_futex syscall wrapper
+ * futex_syscall() - __NR_futex syscall wrapper
  * @uaddr:	address of first futex
  * @op:		futex op code
  * @val:	typically expected value of uaddr, but varies by op
@@ -49,14 +50,49 @@ static inline int
 futex_syscall(u_int32_t *uaddr, int op, u_int32_t val, struct timespec *=
timeout,
 	u_int32_t *uaddr2, int val3, int opflags)
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
 futex_syscall_nr_requeue(u_int32_t *uaddr, int op, u_int32_t val, int nr=
_requeue,
 	u_int32_t *uaddr2, int val3, int opflags)
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

