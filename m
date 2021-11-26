Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A0545E7AF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 07:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358718AbhKZGIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 01:08:05 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:5907 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358734AbhKZGGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 01:06:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637906572; x=1669442572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zqk+jHl+OGQOsKByrp4sFB5aR55ftrVPzVlhJ9AS07c=;
  b=b7z9BxQoX/7CA5BB+UTrSx8L4PzzPUHrufFibQSTg1ku+FU2CtzLXj7j
   VcDjF+Me4D85vTbHtVoB0gbAekwsLQ++poIDxse5IJ9L9+R7pwH6LZPbH
   vm67csn+LVL06BdmUQXSFkgAOLtZRp1JFtCF/uAZwQfTAbMGvWDtfu/Xt
   Yw5bpziVsqRgrTmydPtMpDF3Je7sY4oN/OzEgtKv0Yx8BkzLo6n2WeVfN
   4WMZDoTs9qeVHqd9HdgyFB8agmnVcM33mRRm9ZvhlM0Ufwg2EZlWDcUpe
   JAsjQNvMlFU+8H+OwRA6hTLiblKca9tsxX2zmUDNY6iTso/dZrjHaBwyp
   A==;
X-IronPort-AV: E=Sophos;i="5.87,263,1631548800"; 
   d="scan'208";a="290649456"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2021 14:01:09 +0800
IronPort-SDR: lbzQM9R0FESbPUOSEWco7y2rnqDRGSfgNVBvTdi5exkeAUgwaAN4QA6b6hPRkMk/y+lCtLi+mi
 sCiG2kRjXPgvrI4+5qRIQOLCSdnXcD94MI0IOJByUylYdyU0Q9qRFBm4WahsZbRYLIy5A1jczT
 sZXpi4f4T9M3QJh4n25/exqwD5hhFAAiuVvut3NOGqVMwKWnoP5fwEp/mlVYUGuWc2I4HFu5JQ
 bhkDxabfv/O3A1Lde5fRT+Z2oOK5XN+eGa2uhsbB9iYcQdnSRJhfQtMSfcHXXy5XTSgNu1iAWF
 TCB79nzw2WDTfnTpx6ER8qtA
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 21:34:27 -0800
IronPort-SDR: rNEQjIUCUFFJ2Qq3heBxXWK/aB8v8AFYgqfKxlDOzHwELmbJr53QdDijul84TolsPWLqZGsGZN
 p/PzdvY0WzMZwLZwk48WqIsr2EIL4tRV9MPnjWJJzyKCiVfK7jvwKCLzpVBnjp8lxDIbPq0fRK
 9mt4o5fRfWD4qHtrxeiwv+C6ThmnnA/ZAzV8hdo380xj4D7QcGEHKTIuP/fApVYsYKnlw51bQg
 voagKhLyxC3G64rYNuYFuuWngjWu4yECwLES/5OhG0CqyZ5+5gl2sYL5DdnSyRyR0lrBeuEqLg
 UmM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 22:01:09 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J0kdJ2gshz1RtVl
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 22:01:08 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1637906467; x=1640498468; bh=zqk+jHl+OGQOsKByrp
        4sFB5aR55ftrVPzVlhJ9AS07c=; b=EL73Ac6N55b0h61bCYruLeyW3KTlUIY6pc
        FxhNSErfXXALeHReJ2ux5HJkdy4UPPxapugnfDRBANXj2jysUMCJRnneMw6cxjg1
        WGUKEKFyoW5G2FaMcWIxAaAbJcD5ZjNWx/Qi++E+vZkwBr3X9e4W8i18N3SUsS82
        7ECNu8nnbuNkqgUmp0utissFKgavJBHMNcCf4fhED5COe+ICGP408nKOHh93XteQ
        ns/kFv9TTxX4wDr8S9Dfw+Pb4GoEWNuCXvXzfc4YhaZnL8K6wHW6YbVTIoc6umD9
        N44mRK3OZy0sCdcDZ24L7AGk8fvsvQGoBTH4cUdhb40da0ggUUXg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id y9GESQPCcmD7 for <linux-kernel@vger.kernel.org>;
        Thu, 25 Nov 2021 22:01:07 -0800 (PST)
Received: from toolbox.wdc.com (unknown [10.225.165.62])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J0kd74xYPz1RtVm;
        Thu, 25 Nov 2021 22:00:59 -0800 (PST)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, arnd@arndb.de, namhyung@kernel.org,
        peterz@infradead.org, alistair23@gmail.com, jolsa@redhat.com,
        dave@stgolabs.net, mingo@redhat.com, dvhart@infradead.org,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 4/6] selftests: futex: Add support for 32-bit systems with 64-bit time_t
Date:   Fri, 26 Nov 2021 16:00:22 +1000
Message-Id: <20211126060024.3290177-4-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211126060024.3290177-1-alistair.francis@opensource.wdc.com>
References: <20211126060024.3290177-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

Using the new __kernel_futex_syscall*() functions let's add support for
32-bit systems with a 64-bit time_t. We can just direclty call the
publically exposed __kernel_futex_syscall_timeout() and
__kernel_futex_syscall_nr_requeue() functions to do this.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tools/testing/selftests/futex/functional/futex_requeue_pi.c | 2 +-
 tools/testing/selftests/futex/include/futextest.h           | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

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
index c786fffecb8a..1686f94667b1 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -21,6 +21,7 @@
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <linux/futex.h>
+#include <linux/futex_syscall.h>
=20
 typedef volatile u_int32_t futex_t;
 #define FUTEX_INITIALIZER 0
@@ -69,14 +70,14 @@ static inline int
 futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, struct t=
imespec *timeout,
 	      volatile u_int32_t *uaddr2, int val3, int opflags)
 {
-	return syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, va=
l3);
+	return __kernel_futex_syscall_timeout(uaddr, op | opflags, val, timeout=
, uaddr2, val3);
 }
=20
 static inline int
 futex_syscall_nr_requeue(volatile u_int32_t *uaddr, int op, u_int32_t va=
l, int nr_requeue,
 			 volatile u_int32_t *uaddr2, int val3, int opflags)
 {
-	return syscall(SYS_futex, uaddr, op | opflags, val, nr_requeue, uaddr2,=
 val3);
+	return __kernel_futex_syscall_nr_requeue(uaddr, op | opflags, val, nr_r=
equeue, uaddr2, val3);
 }
=20
 /**
--=20
2.31.1

