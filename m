Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0548406682
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 06:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhIJEcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 00:32:46 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:56463 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhIJEco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 00:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631248294; x=1662784294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p/2CzwtH3Y/xDgZQCRcik/tdTEiXPRTNOFUZ/p2XQrg=;
  b=lPJMy/PLPLfxZMnxvFhSQqmaJXyS1lLcmDr8YsKF1taUOFwD05/tFAFC
   kYe6W03ApVQTVj+2BerE76wprlYFU7aWgtfjdzQThCjsSfcf69FQgQjbR
   zzN0GB9CsqQDY1Ult/Sf+pegeTdx+joUynsUPAPfKnMvWaiBC4ix2x9eS
   V6h0DPn5GhEU8ZT35foVvTxHiCpV285hyElOl830SbnJJR+kGGfBpQwS3
   3QJhAszXDVU5+uX8bC8WlrgpuLkfH0AvDpHrg5YzFMhKBuUUF7yFlAZX2
   SpalAtMzy9otgWVAOrq/G894ESFvCodaJguKmx+QrplR9lP7Grb8cz9ww
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,282,1624291200"; 
   d="scan'208";a="180182540"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2021 12:31:31 +0800
IronPort-SDR: XR6tseZ9KPfvwmOVTCKJMpC6Hca0bG8UKMMtBM8DCu77tTyt3kJCZjFgpVsEt0y3qsMFAuyxB+
 TFSP5aYQr467Th3m/42iaMGaAI5tp3dfVMecuD4c+h5BfO+jOWG8xAUnfUltKH/NFhQ8jCwE1/
 bW+a2WY9C7x7APq0SUzNtc0FcbX7pIhLIKn3rPkiKNqXjihfz/5mwW5ekhBZgvXcKok7sPKYT1
 FEr802J+VcdqrQIw7fIX4qb7qb5nDsD0SxyJmwD0AAhbf+8G+gflrn1NzT0fE1TmsnQKxQ5N0I
 cra0E77q2MZqn9113M09LDRp
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 21:06:26 -0700
IronPort-SDR: IxmNl1uIt4AtQ/z1CYngkhdNHMNXkf91ky94avUy4B9ZaRSABv0rU9oL5jJK70HKwdrbKmu7lY
 UCMdYAHq8lCe1+USGYK6EwHDVKcn1mEtex6wE6m42HwqUCVFs16xkigCaNb7cz3XhYn+XbmfqM
 BoDCiLI0rl9wuYKG4Xh1W42S0pnbN9vGBfaogkQrPzV+xtQcW3vi7r0J/4bSN9NBrCaQkFkisT
 J5FwxYozzSbn3UZQiA00IeRKWb8+WfHuHZRPi2tKYrWZd0E0o3B+YvTH14fZNhWCDJhE1Iexsa
 PUA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 21:31:31 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4H5NHQ3f21z1RvlZ
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 21:31:30 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1631248289; x=1633840290; bh=p/2CzwtH3Y/xDgZQCR
        cik/tdTEiXPRTNOFUZ/p2XQrg=; b=XbSP56r1ZzmSQBEeQQVA1qtDRI5maIEM3t
        uapGwaqHmxNNJuZc2jFIbE5gyvH3iy+xTSwb5ye5QojAaJ3eUE2GWwl9bwnMW7ur
        URuxPyVDW5ZtCU88mH3dWTjgePiYxQiuS9tfuIpkG8c3/JnTZm9xN5rlZh/3pKyj
        yUaV9lUpkiRtSN0YOFdA3bhKHMx9JtffYEHMIO0IPqJH5vix24gSpDWSZ15WirUm
        lN3Lxq9myz6fTH2ON53nqgSpb08OCpPwyvU/z8Zuwkueiw2T+vtLzeO/tj3dCV3Y
        ZENFS4ygx+rw7pUaFpnk9NMfT3Q+srrtQyATjNc66sGJwmcA8n1Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id F_6INjuom4Xw for <linux-kernel@vger.kernel.org>;
        Thu,  9 Sep 2021 21:31:29 -0700 (PDT)
Received: from toolbox.alistair23.me (unknown [10.225.165.20])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4H5NHD38bsz1RvlX;
        Thu,  9 Sep 2021 21:31:19 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, alistair23@gmail.com,
        namhyung@kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        acme@kernel.org, dave@stgolabs.net, dvhart@infradead.org,
        peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        atish.patra@wdc.com, arnd@arndb.de,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 2/2] perf bench: Add support for 32-bit systems with 64-bit time_t
Date:   Fri, 10 Sep 2021 14:31:02 +1000
Message-Id: <20210910043102.3616198-2-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210910043102.3616198-1-alistair.francis@opensource.wdc.com>
References: <20210910043102.3616198-1-alistair.francis@opensource.wdc.com>
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
 tools/perf/bench/futex.h | 43 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index f80a4759ee79b..09c5596726c60 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -27,6 +27,12 @@ struct bench_futex_parameters {
 	unsigned int nrequeue;
 };
=20
+/* A version of 'struct timespec' with 32-bit time_t and nanoseconds.  *=
/
+struct __timespec32 {
+	__kernel_long_t tv_sec;
+	__kernel_long_t tv_nsec;
+};
+
 /**
  * futex_syscall() - SYS_futex syscall wrapper
  * @uaddr:	address of first futex
@@ -49,14 +55,49 @@ static inline int
 futex_syscall(u_int32_t *uaddr, int op, u_int32_t val, struct timespec *=
timeout,
 	u_int32_t *uaddr2, int val3, int opflags)
 {
-	return syscall(SYS_futex, uaddr, op | opflags, val, ts32, uaddr2, val3)=
;
+#if defined(SYS_futex_time64)
+	if (sizeof(*timeout) !=3D sizeof(struct __timespec32)) {
+		int ret =3D  syscall(SYS_futex_time64, uaddr, op | opflags, val, timeo=
ut,
+				   uaddr2, val3);
+	if (ret =3D=3D 0 || errno !=3D ENOSYS)
+		return ret;
+	}
+#endif
+
+#if defined(SYS_futex)
+	if (sizeof(*timeout) =3D=3D sizeof(struct __timespec32))
+		return syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, v=
al3);
+
+	if (timeout && timeout->tv_sec =3D=3D (long)timeout->tv_sec) {
+		struct __timespec32 ts32;
+
+		ts32.tv_sec =3D (__kernel_long_t) timeout->tv_sec;
+		ts32.tv_nsec =3D (__kernel_long_t) timeout->tv_nsec;
+
+		return syscall(SYS_futex, uaddr, op | opflags, val, ts32, uaddr2, val3=
);
+	} else if (!timeout) {
+		return syscall(SYS_futex, uaddr, op | opflags, val, NULL, uaddr2, val3=
);
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
+#if defined(SYS_futex_time64)
+	int ret =3D  syscall(SYS_futex_time64, uaddr, op | opflags, val, nr_req=
ueue,
+			   uaddr2, val3);
+	if (ret =3D=3D 0 || errno !=3D ENOSYS)
+		return ret;
+#endif
+
+#if defined(SYS_futex)
 	return syscall(SYS_futex, uaddr, op | opflags, val, nr_requeue, uaddr2,=
 val3);
+#endif
 }
=20
 /**
--=20
2.31.1

