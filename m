Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9B642E5A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 02:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhJOBBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 21:01:46 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:17432 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhJOBBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 21:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634259581; x=1665795581;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8JFpecjHXcYkC+i4o+EU7JFbGNhc8aM0hmbgN604w7Y=;
  b=eyf1L6rh4vf7xsUaTHNfv1ZAiSQQZJtHwZJmPUZYy6xQTxpZ+qKNWTL/
   3Wk23P1aELlY37AEpXNNezMdLNH2qe6BGBl+Nr/LXK2ZJp4aV1PWE6QgF
   lMJod4TleVQd5uUvw36ECRWGaX3MrWLxkSR2XEpmN+wuo6MtSe/F6SDFo
   BDZTDRDCuY1T869g7piVcqLXlrmNv2WQdGlsein6a+rNisEbaVxwWyKt3
   4EnL02yYW6l0s5eMuT4RL8OAZ+LU16x8xJ7xwJrYUuuWVNOrFMC1atDN6
   GDIMssHFkt+XXVtj2o/ZF02Zq+2L5uPFS3fvUi1n7cVxExWLI09uHHimt
   g==;
X-IronPort-AV: E=Sophos;i="5.85,374,1624291200"; 
   d="scan'208";a="294632332"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2021 08:59:41 +0800
IronPort-SDR: JcDV9JH3UVRw7LwLwtOfRg1e7XfcOcj6r38lJtBbyLjKyTOTaX3VuBMwVslbO66+4v2M5Tf3bs
 AzgCNBOTreiA0n2a4So2sY4X4lJwArchBzdmfeArIlr4c5R6nmT9k+ry/o/BVpLifTdKtCffVh
 TXfobo6q5oqHbzfRDrJS98B5AZckESr8VXr6H36WMbkiFioCcj+2BzOPD5Kv0TmcmdOFQWWoZr
 Husy3nhpsxOMgP2q0p5oN0bBOjqfJSBNUIpdaHaMf5KoncVKn403MC233N0gwUk6w+eheqsB5g
 KhMu/8glR82Gra/c3A7g8nAX
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 17:33:51 -0700
IronPort-SDR: +m0qknXAcnQobyw4clInTVXdbOE7u3un/3Ac4/lXPxK7N3z2HVL7KFAAbrPd9c0CnXju2ktCvM
 aQnYegrusLovT1yS1tXtJz5tB2CLpA2OIRRMEBU98zwNxVJpKlbKH3R6PXkPFbcs8hB9aVqNP3
 fgJ8dRncouCnVUa01H8XPSW1PFLBP8lfYqFDKnkIjA6bza8IrO0pJIF1bjO2P7CP6RcwO5N4yu
 uLCfdE8tq0TTpeLzKfFITrBKnnrhexbHFIQehtRggDAc/llXJGYeN5v7DbResCMffnURKwHGT5
 NUc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 17:59:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HVnwq4HpMz1RvlC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 17:59:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1634259579;
         x=1636851580; bh=8JFpecjHXcYkC+i4o+EU7JFbGNhc8aM0hmbgN604w7Y=; b=
        r/WyyGuf8uEiD2lnz2Q3r3p5PbqS77bGtE9lOqjAZ2UQC76kXihztc2XQTo1JvmK
        GWXBEMtlXpsapBObO3x6co7YgXJBPUZeUJ9RMnG9WHohMXIetfqtk6Av75dvM9LF
        XgZL0QyJvXpEkjWOemuK6gidYujYQhe1lwWmDrPLWn+ZNw4tB9bYcvKDLsDssj5e
        dLmvpEI8hzuYeoVcPXYU97yZJy8kEVBTvRdaVQ7+JXeGtO7DgjQGPTUiOxz36G+T
        46LDB38wDAn1PnBZbgHpX0cWmuPzveTt9NFDF3cP5Mqn4WoLvmcGeQ5A5grLMFvN
        19dhlWjcAD3WISrU4CqtyQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sVw9CH8XuV1o for <linux-kernel@vger.kernel.org>;
        Thu, 14 Oct 2021 17:59:39 -0700 (PDT)
Received: from toolbox.alistair23.me (unknown [10.225.165.37])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HVnwl3kp8z1RvTg;
        Thu, 14 Oct 2021 17:59:34 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     alistair23@gmail.com, arnd@arndb.de,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH] uapi: futex: Add a futex syscall
Date:   Fri, 15 Oct 2021 10:59:23 +1000
Message-Id: <20211015005923.2659140-1-alistair.francis@opensource.wdc.com>
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
 include/uapi/linux/futex_syscall.h | 79 ++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 include/uapi/linux/futex_syscall.h

diff --git a/include/uapi/linux/futex_syscall.h b/include/uapi/linux/fute=
x_syscall.h
new file mode 100644
index 0000000000000..039d371346159
--- /dev/null
+++ b/include/uapi/linux/futex_syscall.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_FUTEX_SYSCALL_H
+#define _UAPI_LINUX_FUTEX_SYSCALL_H
+
+#include <errno.h>
+#include <linux/types.h>
+#include <linux/time_types.h>
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
+futex_syscall_timeout(volatile u_int32_t *uaddr, int op, u_int32_t val,
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
+		return syscall(__NR_futex, uaddr, op, val, ts32, uaddr2, val3);
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
+futex_syscall_nr_requeue(volatile u_int32_t *uaddr, int op, u_int32_t va=
l,
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

