Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1095F39B43C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 09:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhFDHre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 03:47:34 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7105 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFDHrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 03:47:33 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FxF9b4nNPzYqm8;
        Fri,  4 Jun 2021 15:42:59 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 15:45:43 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 15:45:43 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] lib/mpi: Fix spelling mistakes
Date:   Fri, 4 Jun 2021 15:44:01 +0800
Message-ID: <20210604074401.12198-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some spelling mistakes in comments:
flaged ==> flagged
bufer ==> buffer
multipler ==> multiplier
MULTIPLER ==> MULTIPLIER
leaset ==> least
chnage ==> change

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/mpi.h | 4 ++--
 lib/mpi/longlong.h  | 4 ++--
 lib/mpi/mpicoder.c  | 6 +++---
 lib/mpi/mpiutil.c   | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/mpi.h b/include/linux/mpi.h
index 3e5358f4de2f..eb0d1c1db208 100644
--- a/include/linux/mpi.h
+++ b/include/linux/mpi.h
@@ -200,7 +200,7 @@ struct mpi_ec_ctx {
 	unsigned int nbits;            /* Number of bits.  */
 
 	/* Domain parameters.  Note that they may not all be set and if set
-	 * the MPIs may be flaged as constant.
+	 * the MPIs may be flagged as constant.
 	 */
 	MPI p;         /* Prime specifying the field GF(p).  */
 	MPI a;         /* First coefficient of the Weierstrass equation.  */
@@ -267,7 +267,7 @@ int mpi_ec_curve_point(MPI_POINT point, struct mpi_ec_ctx *ctx);
 /**
  * mpi_get_size() - returns max size required to store the number
  *
- * @a:	A multi precision integer for which we want to allocate a bufer
+ * @a:	A multi precision integer for which we want to allocate a buffer
  *
  * Return: size required to store the number
  */
diff --git a/lib/mpi/longlong.h b/lib/mpi/longlong.h
index afbd99987cf8..b6fa1d08fb55 100644
--- a/lib/mpi/longlong.h
+++ b/lib/mpi/longlong.h
@@ -48,8 +48,8 @@
 
 /* Define auxiliary asm macros.
  *
- * 1) umul_ppmm(high_prod, low_prod, multipler, multiplicand) multiplies two
- * UWtype integers MULTIPLER and MULTIPLICAND, and generates a two UWtype
+ * 1) umul_ppmm(high_prod, low_prod, multiplier, multiplicand) multiplies two
+ * UWtype integers MULTIPLIER and MULTIPLICAND, and generates a two UWtype
  * word product in HIGH_PROD and LOW_PROD.
  *
  * 2) __umulsidi3(a,b) multiplies two UWtype integers A and B, and returns a
diff --git a/lib/mpi/mpicoder.c b/lib/mpi/mpicoder.c
index 7ea225b2204f..39c4c6731094 100644
--- a/lib/mpi/mpicoder.c
+++ b/lib/mpi/mpicoder.c
@@ -234,11 +234,11 @@ static int count_lzeros(MPI a)
 }
 
 /**
- * mpi_read_buffer() - read MPI to a bufer provided by user (msb first)
+ * mpi_read_buffer() - read MPI to a buffer provided by user (msb first)
  *
  * @a:		a multi precision integer
- * @buf:	bufer to which the output will be written to. Needs to be at
- *		leaset mpi_get_size(a) long.
+ * @buf:	buffer to which the output will be written to. Needs to be at
+ *		least mpi_get_size(a) long.
  * @buf_len:	size of the buf.
  * @nbytes:	receives the actual length of the data written on success and
  *		the data to-be-written on -EOVERFLOW in case buf_len was too
diff --git a/lib/mpi/mpiutil.c b/lib/mpi/mpiutil.c
index 3c63710c20c6..9a75ca3f7edf 100644
--- a/lib/mpi/mpiutil.c
+++ b/lib/mpi/mpiutil.c
@@ -80,7 +80,7 @@ EXPORT_SYMBOL_GPL(mpi_const);
 /****************
  * Note:  It was a bad idea to use the number of limbs to allocate
  *	  because on a alpha the limbs are large but we normally need
- *	  integers of n bits - So we should chnage this to bits (or bytes).
+ *	  integers of n bits - So we should change this to bits (or bytes).
  *
  *	  But mpi_alloc is used in a lot of places :-)
  */
-- 
2.25.1


