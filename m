Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B64404475
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 06:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350113AbhIIE1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 00:27:16 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:40079 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhIIE1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 00:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631161566; x=1662697566;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uTJ4YViqTBigsFNPfbDCcZNwNeuUciwbhlEYLs8SL54=;
  b=h2lM2fDUzXQ46GEq9RJptorSbJeTsQ+hJH2WhqBC3nHlDOxaXehpfbZ3
   ddYuqQlRZwb4gJDZRVp0mUzHKJ/ULS2M9Ni747QWv8m1mTDV459w3qUz7
   imPWX5sMYPL6nckXL9H9GcxE6HRfdCqPb3Ucovz/7yE8eahNheLdACpl6
   Dhnsn3xm0r4gdb8SMsvA+vtP8RssEh+EcGxdzeqU+uEApoutmsFFj4Gxn
   C/alk6N+b2R85gfdCgUtsWdRRlNRz085WqPGAAfUXNS7onpUvhHShzpWn
   nQKcOerY661N3HLfwln0ViHu0jDLxrd3od7pMYIymCOBcxLcNuHeXD8/0
   g==;
X-IronPort-AV: E=Sophos;i="5.85,279,1624291200"; 
   d="scan'208";a="184327829"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2021 12:26:04 +0800
IronPort-SDR: P6c0lxLFGQox2WXZn6HyoMrfHoSoQe4PtRJLLFh3xfkbo4NyW4qCCRloNwUkU4cwnVzOVq+Udc
 Q6lGGXZHFo6G0Y4G28/fEvErIi0m2m4tjen0cXbPqCk1wPJkrygVODYyAeETIInydC2YiuMISM
 D+qtIsyDRYff8QNQTvyjBAq+pC740yGDVV6Ff58+jOmp/ARHyXdXS6jxj3jAvXQEO6iQSDqEQ5
 QJC0JJQF1+DjOObUXhwb3pQ34xSJgpk6YFyYFzN0AQ5pvx1+WGHOj//nsUPwCk7b0+eqc9lt67
 2jZt2Ljc3rXy9o4OWN9zyOez
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 21:02:36 -0700
IronPort-SDR: cu+FIalqu2Vs89/VDl7hARhswrGVxPgEO1kdYZWkVbLBdoPzTyR2jbykS8xMlJ0izFBArnFrs0
 b0vrLpOvnSc4opRBvoIOWeNA/JdCQdGRzDCgYiZJ7tCZLktHoWo5YTCy2IhPXkdScqUandAWGF
 mNDEDKJewk1snuJ432Lg+o4Rg6OXOprOOmXRHn/raKisEYDCDW30T+uSran5hP270rpCG0SnXP
 WaR2iPZXxW558J9iszGpPQriJT8McyNwLJvBmmrDtbOWl9uOboTV4OUyVCjJtp7jMtaADXesFI
 DfM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 21:26:01 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4H4mCX50yXz1RvmJ
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 21:26:00 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1631161560;
         x=1633753561; bh=uTJ4YViqTBigsFNPfbDCcZNwNeuUciwbhlEYLs8SL54=; b=
        mVDC65s1mtlUa3zeFnC3SdKgS4EZo5AXwLCmb+tT5FqI4VLj7Fsm200/ZqLpr0FR
        rZFBcWL5BHfRoEjrPLjyniEV4Hqr5FlKazrcntVhuwLGnJXM3muUWJYUrazAxCee
        ByZ8vTOrLZBnplWG05M97Fv04tvUlWloIkIbI7PvkOeCgsH3FTsQokUHqkQ94iEV
        6b/+iFVIbSo9zJhSNzOegTWyH8Cxa5FS3lsn4VvRxK38FD6sx5xn17dwmz6V5CNA
        Qd60H3Ax3axx2SloglCTYzTH68lX1TAU+ZDsfgnmh8Y/f306lfR5MU7VEU9m9t4n
        +vnCUE9hXW6kaKKl6mHrDg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wuf71uBXU22v for <linux-kernel@vger.kernel.org>;
        Wed,  8 Sep 2021 21:26:00 -0700 (PDT)
Received: from toolbox.alistair23.me (unknown [10.225.165.20])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4H4mCL597Fz1RvlP;
        Wed,  8 Sep 2021 21:25:50 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, alistair23@gmail.com,
        namhyung@kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        acme@kernel.org, dave@stgolabs.net, dvhart@infradead.org,
        peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        atish.patra@wdc.com, arnd@arndb.de,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH] perf bench: Add support for 32-bit systems with 64-bit time_t
Date:   Thu,  9 Sep 2021 14:25:43 +1000
Message-Id: <20210909042543.1982893-1-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

Some 32-bit architectures (such are 32-bit RISC-V) only have a 64-bit
time_t and as such don't have the SYS_futex syscall. This patch will
allow us to use the SYS_futex_time64 syscall on those platforms.

This patch does not attempt to gracefully allow 32-bit architectures
with both SYS_futex and SYS_futex_time64 to support a 64-bit time_t.
This patch only applies to 32-bit architectures with a 64-bit time_t.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tools/perf/bench/futex.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index b3853aac3021..912342d7f594 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -27,6 +27,17 @@ struct bench_futex_parameters {
 	unsigned int nrequeue;
 };
=20
+/**
+ * Some newer 32-bit architectures (such as RISC-V 32-bit) don't have
+ * the SYS_futex syscall and instead only have the SYS_futex_time64 call=
.
+ * Let's ensure that those still compile and run by just using the
+ * SYS_futex_time64 syscall. On these systems `struct timespec` will use=
 a
+ * 64-bit time_t so the SYS_futex_time64 call will work.
+ */
+#if !defined(SYS_futex) && defined(SYS_futex_time64)
+ #define SYS_futex SYS_futex_time64
+#endif
+
 /**
  * futex() - SYS_futex syscall wrapper
  * @uaddr:	address of first futex
--=20
2.31.1

