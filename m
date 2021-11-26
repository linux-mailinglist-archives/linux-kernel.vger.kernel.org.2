Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2255C45E7AA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 07:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358784AbhKZGGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 01:06:32 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:11664 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351980AbhKZGEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 01:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637906477; x=1669442477;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UHFYtRUpqo1Z8U1NRYz0VvF/MbTIc2c4ImiQa8RqQHA=;
  b=b5QlIwU6xzq9CvsMskJtsRK3oQZk9AFV4tngYWwZLv5ThWAyBbTwo/NU
   eTW00YNqeRtLkfJYcD8YxTxlstWjVeIgqxSUXr9TiT7oMi9VigvW0VsmO
   OkfKrneI8HznYH01tZUWANKk52xIfGzmtsYtStKMrShq13r1CqzKfzWeG
   hz4ngE7Zo3opS/8lB6cvOqcAef8E+rYfqtdI9/kXw4W+Y6JvBfwpvQs5S
   Luo2hsi6D6wZ4jXjlPWlu2LZSntqopfjkEzH8B2lEje+vtCg+Ws5vWoWS
   BwS95Q260qABQ0ygU6pS95veAcxF2zKPAouQQfcWejZzX9nWY/xQKOsrU
   A==;
X-IronPort-AV: E=Sophos;i="5.87,263,1631548800"; 
   d="scan'208";a="191493917"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2021 14:01:16 +0800
IronPort-SDR: Cao0PXDQ1eOSXWrxeoL34g5WmkZSL3kA6vOy1VlZBx2y0nkyCPAau9AB3SThu6bK+uujA4uYQg
 LSoP+/DKuapUrq+MfVQoL6+Hx+Of/pnSElbyv98Ge3hl2EiQ/8YKNtlIqxGXcNrbi5JDu4zYP9
 +3Vo8ngaKu4BfpFCXSLIPtLWV/N4hnYig1egibxJ6s7hTvJ4pLcf54x89XulYItDUCpMAmaZwO
 sF4POGmJ7rkZHmRK79fvQsKigTWt6BiwBdL72sw19FTIGjYxOKhUUtBerkDgnRm0rboQQLfR9k
 inysgPly0KK1UbtbO2yS7x6C
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 21:36:08 -0800
IronPort-SDR: KlYU4/KsJ300hnvGkPbRwa0ezZJfpXGwF27k4bUl6Km9zLi935nEL0xrDkckSp0xG6B0qe9I/T
 2Zt+a/SwO426mLLRrAZZEAyTBuOhq/7DyOxyA0oNQtLDZcTSg4cxGkPguCPWLfKtfHALu1BpR8
 P7EOQiaq9oAm+dTHLJr69/Q+JSo4vCrHJEv+JmMZcw7EIXjvEOMkko5cX3hwHQgR9iDvOYNXu3
 NFDmoTIW/WX52yfFy4MkOzYuBvaSJ3GcmTFecqzvIO/LRLO8N0d+qDbN1AbftRnTkmbgSGtPLE
 DZI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 22:01:17 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J0kdT11Qpz1RtVl
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 22:01:17 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1637906476; x=1640498477; bh=UHFYtRUpqo1Z8U1NRY
        z0VvF/MbTIc2c4ImiQa8RqQHA=; b=UM3s2tFc8rIj4gOSHiCA2kixJ06bmwMSZm
        nXp/xzAWpAlxvSmK/DRN5fHKOiHUtKZTJZTnbLSxMu8efaNrAv1g9NoDY8heiXV8
        zGhJfUk7qvuVCbb3J6cwARZRee3JhUbCmIa0waojGvwKjmIWpvl9X1Zb728ki1ZC
        dKeSYMSD50v4zg9KFdpcg4YuMY1EYhs2s2V/PlXJnaaDEBWEJzyeLj/Ri0ETBNJ6
        r+WpxXgQL8MQ8yEQAaRZ7VdvqJ9qW3OgX+7qX600On4BXtwLhlXw7hp9uNmSnYJH
        2ARVktXiqK9/sbDrx7G+Eb1sp2TRZB5HFge9YvgyG9Ha/8EsrMsQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id y73P6cc8KlrO for <linux-kernel@vger.kernel.org>;
        Thu, 25 Nov 2021 22:01:16 -0800 (PST)
Received: from toolbox.wdc.com (unknown [10.225.165.62])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J0kdJ2F6xz1RtVp;
        Thu, 25 Nov 2021 22:01:07 -0800 (PST)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, arnd@arndb.de, namhyung@kernel.org,
        peterz@infradead.org, alistair23@gmail.com, jolsa@redhat.com,
        dave@stgolabs.net, mingo@redhat.com, dvhart@infradead.org,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 5/6] uapi: futex: Add a futex waitv syscall
Date:   Fri, 26 Nov 2021 16:00:23 +1000
Message-Id: <20211126060024.3290177-5-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211126060024.3290177-1-alistair.francis@opensource.wdc.com>
References: <20211126060024.3290177-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

This commit adds a futex waitv syscall wrapper that is exposed to
userspace.

Neither the kernel or glibc currently expose a futex wrapper, so
userspace is left performing raw syscalls. As the futex_waitv syscall
always expects a 64-bit time_t this can be tricky for 32-bit systems to
get correct.

In order to avoid userspace incorrectly passing the wrong timeouts let's
expose a public helper function that ensures the kernel is passed the
correct timeout struct.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/uapi/linux/futex_syscall.h | 32 +++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/futex_syscall.h b/include/uapi/linux/fute=
x_syscall.h
index e0305c581142..98c550990833 100644
--- a/include/uapi/linux/futex_syscall.h
+++ b/include/uapi/linux/futex_syscall.h
@@ -9,12 +9,15 @@
 #ifndef _UAPI_LINUX_FUTEX_SYSCALL_H
 #define _UAPI_LINUX_FUTEX_SYSCALL_H
=20
-#include <asm/unistd.h>
+#include <unistd.h>
 #include <errno.h>
+#include <linux/futex.h>
 #include <linux/types.h>
 #include <linux/time_types.h>
 #include <stdint.h>
 #include <sys/syscall.h>
+#include <sys/types.h>
+#include <time.h>
=20
 /**
  * futex_syscall_timeout() - __NR_futex/__NR_futex_time64 syscall wrappe=
r
@@ -86,4 +89,31 @@ __kernel_futex_syscall_nr_requeue(volatile uint32_t *u=
addr, int op, uint32_t val
 	return -1;
 }
=20
+/**
+ * futex_waitv - Wait at multiple futexes, wake on any
+ * @waiters:    Array of waiters
+ * @nr_waiters: Length of waiters array
+ * @flags: Operation flags
+ * @timo:  Optional timeout for operation
+ */
+static inline int
+__kernel_futex_syscall_waitv(volatile struct futex_waitv *waiters, unsig=
ned long nr_waiters,
+			      unsigned long flags, struct timespec *timo, clockid_t clockid)
+{
+	/* futex_waitv expects a 64-bit time_t */
+	if (sizeof(*timo) =3D=3D sizeof(struct __kernel_timespec))
+		return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clo=
ckid);
+
+	/* If the caller supplied a 32-bit time_t, convert it to 64-bit */
+	if (timo) {
+		struct __kernel_timespec ts_new;
+
+		ts_new.tv_sec =3D timo->tv_sec;
+		ts_new.tv_nsec =3D timo->tv_nsec;
+
+		return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, &ts_new, =
clockid);
+	} else
+		return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, NULL, clo=
ckid);
+}
+
 #endif /* _UAPI_LINUX_FUTEX_SYSCALL_H */
--=20
2.31.1

