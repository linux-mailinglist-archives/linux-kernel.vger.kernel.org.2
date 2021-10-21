Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E517435A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 07:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhJUF4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 01:56:42 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:12885 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhJUF4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 01:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634795667; x=1666331667;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q3mpxRSHzrDPKyloa5GWTPOdXQqLdle7eJyKX/839WU=;
  b=DdpvqnCuhRO55xhD+zmOWM7HJTIm51T9/sjWdt7dWPVxPPf9uwhwLQJC
   FEyyV7LyCKRglF0TsdXgZsXJ/hgD44x1/6RPxj4AiEk9c8iEj69enLop8
   7RHhHNlIXLDl/Lilf7sCtkVZqZGxRLff4mgMfth1JMjmqttbOsU82laXf
   bSCqAV+PQtumw75/4TZw2/9bXM6kA3WlufpeORMX8Y7Vd8Re+k1NLdAxp
   iWSINnZI8XmylAzi1FD0pFlPQhOK8DnvGiYpQr+pfDeWi7I85+TnVE7xN
   4kJ023xzoKmcD119ZtxObprpEfp1s8mqoNvJBPaeyghowsTIa+lmZypJ9
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,168,1631548800"; 
   d="scan'208";a="184423953"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2021 13:54:26 +0800
IronPort-SDR: 8mQDDFfMrRqOZrJygwOglguP3Z2xPrwlldpl335uDkfGsXSNSW/UiNxo/rkx4mWjEumdqnJPof
 cN/aJAM7TCeZCBG8ElRMvSB4bys7fCfTvLC+OJsOhbWanSgQvs4+uiXMuFvlLhk70bQ3q62hY0
 j1kkCiQtEHKxsQnv8xrzUnYOoUh7Wc3BnJmAPV5Ybsh+LtLaMuKrUb8N+UU9QSjED5O6vNnUy7
 h+s/uJYYEpSHKiHvGor2qvciCR7K0AJ+QDKkykvG0++i+Wlb1oIf6tpxbKA1DqTHB7weXjY8/F
 ybkFcvkWuxfy4CUOhy/eQlco
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 22:30:02 -0700
IronPort-SDR: p2v1+B1PM6FGUp5xzLj1Wuqvzrk1M9TKW1tKbyhX8nHsQ9M0qPhMoICaM8cvBt80GgkBUvkrve
 pfWkIGbLUx0szE04lh7/Sv7ThlTHDtqBmU0vb3d11xN4YxwGiFLSYgOYvuXlY8mYbuKRdSkoox
 R/zQaW4+4TsVtWQjlj/hMmKnPPwIveo46B0P+y9+DIJetdPzcLiQu7Grv5LOMTw0Nr8t57p05Z
 S1hydn2mDYpLZXx7ePEK3ytRspyd3UHJy+XbJBGTxMkYbCI3WREXudAS8K/8lSqVgCThm63Inv
 6nk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 22:54:26 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HZcB93CNWz1SGYR
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 22:54:25 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1634795664;
         x=1637387665; bh=Q3mpxRSHzrDPKyloa5GWTPOdXQqLdle7eJyKX/839WU=; b=
        lcrlDiLmW9BHOhtdpPzzy0cNjiPXcAxlHVj9O6VBwXebt5zem7gqR7zWX+p0nEv3
        DhjW4/NgK6mqWFsmDLFBj5AxH4S3Oo1wiLtgb8i7zqPn/N87zsV8/qPsCIeP990o
        8WvEOGKAbUum/Jwh6pm4KK20Mk11JbKtVLMpvTvkAtcB6V41/rcdfh04dRnqgM42
        +Y+eDGYk6YaWsKnx9+VOcVkDkR+F6CPXre7o0djjV1bJx2z0skt5hs5iPJRn4dvj
        AtsRl9pFFZoeD1R/0HY9bCbj0W36OvW1/6n/KxCGgrDxX6djhFh41dnJc9e2s/7z
        OS/xq3rtuHYEviCQ0TI/bA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RwaxRtOOMtIX for <linux-kernel@vger.kernel.org>;
        Wed, 20 Oct 2021 22:54:24 -0700 (PDT)
Received: from toolbox.wdc.com (unknown [10.225.165.39])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HZcB50gLmz1Rwt5;
        Wed, 20 Oct 2021 22:54:20 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     alistair23@gmail.com, arnd@arndb.de,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2] uapi: futex: Add a futex syscall
Date:   Thu, 21 Oct 2021 15:54:08 +1000
Message-Id: <20211021055408.4006408-1-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

This commit adds two futex syscall wrappers that are exposed to
userspace.

Neither the kernel or glibc currently expose a futex wrapper, so
userspace is left performing raw syscalls. This has mostly been becuase
the overloading of one of the arguments makes it impossible to provide a
single type safe function.

Until recently the single syscall has worked fine. With the introduction
of a 64-bit time_t futex call on 32-bit architectures, this has become
more complex. The logic of handling the two possible futex syscalls is
complex and often implemented incorrectly.

This patch adds two futux syscall functions that correctly handle the
time_t complexity for userspace.

This idea is based on previous discussions: https://lkml.org/lkml/2021/9/=
21/143

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/uapi/linux/futex_syscall.h | 81 ++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 include/uapi/linux/futex_syscall.h

diff --git a/include/uapi/linux/futex_syscall.h b/include/uapi/linux/fute=
x_syscall.h
new file mode 100644
index 0000000000000..f84a0c68baf78
--- /dev/null
+++ b/include/uapi/linux/futex_syscall.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_FUTEX_SYSCALL_H
+#define _UAPI_LINUX_FUTEX_SYSCALL_H
+
+#include <asm/unistd.h>
+#include <errno.h>
+#include <linux/types.h>
+#include <linux/time_types.h>
+#include <sys/syscall.h>
+
+/**
+ * futex_syscall_timeout() - __NR_futex/__NR_futex_time64 syscall wrappe=
r
+ * @uaddr:  address of first futex
+ * @op:   futex op code
+ * @val:  typically expected value of uaddr, but varies by op
+ * @timeout:  an absolute struct timespec
+ * @uaddr2: address of second futex for some ops
+ * @val3: varies by op
+ */
+static inline int
+__kernel_futex_syscall_timeout(volatile u_int32_t *uaddr, int op, u_int3=
2_t val,
+		      struct timespec *timeout, volatile u_int32_t *uaddr2, int val3)
+{
+#if defined(__NR_futex_time64)
+	if (sizeof(*timeout) !=3D sizeof(struct __kernel_old_timespec)) {
+		int ret =3D  syscall(__NR_futex_time64, uaddr, op, val, timeout, uaddr=
2, val3);
+
+		if (ret =3D=3D 0 || errno !=3D ENOSYS)
+			return ret;
+	}
+#endif
+
+#if defined(__NR_futex)
+	if (sizeof(*timeout) =3D=3D sizeof(struct __kernel_old_timespec))
+		return syscall(__NR_futex, uaddr, op, val, timeout, uaddr2, val3);
+
+	if (timeout && timeout->tv_sec =3D=3D (long)timeout->tv_sec) {
+		struct __kernel_old_timespec ts32;
+
+		ts32.tv_sec =3D (__kernel_long_t) timeout->tv_sec;
+		ts32.tv_nsec =3D (__kernel_long_t) timeout->tv_nsec;
+
+		return syscall(__NR_futex, uaddr, op, val, &ts32, uaddr2, val3);
+	} else if (!timeout) {
+		return syscall(__NR_futex, uaddr, op, val, NULL, uaddr2, val3);
+	}
+#endif
+
+	errno =3D ENOSYS;
+	return -1;
+}
+
+/**
+ * futex_syscall_nr_requeue() - __NR_futex/__NR_futex_time64 syscall wra=
pper
+ * @uaddr:  address of first futex
+ * @op:   futex op code
+ * @val:  typically expected value of uaddr, but varies by op
+ * @nr_requeue:  an op specific meaning
+ * @uaddr2: address of second futex for some ops
+ * @val3: varies by op
+ */
+static inline int
+__kernel_futex_syscall_nr_requeue(volatile u_int32_t *uaddr, int op, u_i=
nt32_t val,
+			 u_int32_t nr_requeue, volatile u_int32_t *uaddr2, int val3)
+{
+#if defined(__NR_futex_time64)
+	int ret =3D  syscall(__NR_futex_time64, uaddr, op, val, nr_requeue, uad=
dr2, val3);
+
+	if (ret =3D=3D 0 || errno !=3D ENOSYS)
+		return ret;
+#endif
+
+#if defined(__NR_futex)
+	return syscall(__NR_futex, uaddr, op, val, nr_requeue, uaddr2, val3);
+#endif
+
+	errno =3D ENOSYS;
+	return -1;
+}
+
+#endif /* _UAPI_LINUX_FUTEX_SYSCALL_H */
--=20
2.31.1

