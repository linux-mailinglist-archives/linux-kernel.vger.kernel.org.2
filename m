Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E703CBAE8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 19:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhGPRHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 13:07:39 -0400
Received: from mout.gmx.net ([212.227.15.19]:44465 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230189AbhGPRHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 13:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626455042;
        bh=LrJqnGLr+yAUvufNYQHvar5369au8NY8/oDzo4u3xto=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=K+y98mCjTJ8KAgzUqyhQ5AQ+jQhVg0sjlNVDSVP92/+eYGfksmUWgRTY9c5a5MdVJ
         S+qUSEp9vxQ7HsTnmi9+6tiYbuTMbk0ZnnekPzKPt7XZwI1Du0stZ4gktmfAuBqAgJ
         W5plVohP2+fl5fI1sSTxuF0HbChnTTL2i+eLnb7Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MybGh-1lCAcJ2iDN-00yypb; Fri, 16 Jul 2021 19:04:02 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     Len Baker <len.baker@gmx.com>,
        "dean.yang_cp" <yangdianqing@yulong.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARC: unwind: Use struct_size helper instead of open-coded arithmetic
Date:   Fri, 16 Jul 2021 19:03:44 +0200
Message-Id: <20210716170344.9150-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5SAJCQgoPecLOvlAQgDwaVANDA8DxUuLHfyrrkaNw0SbTdjcubb
 +3mVWWXnnrtaFn7YSpUqf7imH3OMpztog3bq8Qy2lKTgdiSIV36wx9kxNZzrF/WEpZCwRem
 eVgdflOQ30ghuVax+8LcnoW3M8I4JnPvkIEJO0p8Z3mI2/tM0cKFcrNmBiC7F2zbFOmIPDW
 q6lobTxcgJROUUt2IFdPw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SC8PvHkTL40=:C/LEBcfPB3naggULrZzMY6
 tB4o6Aar3L6Ue9SkGXhHHsLoiY4vCT3+sGmeEhldXnTcpBhlG5EmwQWitHimb8lHk7EMuwTJj
 EftnhQ4gxUY9ztuLrr9N9leasXYQkvwmZs1sn5l73j8OFaa126xTansgurv4IxaKa0ujzyoae
 8nVtg8j8fmOCrs9dRXsAmUumDZOhucRRw04m3rFhJm4B4xm5xWsn2VB5LeFzN6OHOHlNlzlNV
 nFLKQgOGLBO+S5SKqr0t3rtP3oKfGwjwd1+lflesx5HY1yikHTWriibs2jU2/FJXK7j/R31xy
 5vB4+jZ5Mqig5Ah9Mfz10yP0updphb3KvYk3Ydhs3Y8/6ASvAUxsb/vt1dU9h7eHknFAzNmVO
 oMvYvCQd2kQmUp+5eJnRuf2aHnQ+CtBQP8TtvEB7cyjaa6cWYxwsnWYpKThTglVGWs+lpQMy7
 ATTa6mEY6+p/+2XSzTWW1S7m44RKTb/BOmiHh5VeKOV6XOya2UIkb5NC2roZwMs0NVx/tFHfV
 gOd46lp7X/cfgxd2FBn2tMiHlHLzESp9z0AoYhuWKwOIDxoRmRdDmHc5kN7kmGtULfWiJMpws
 cskp4iPIiHCEK8T/x8nhhVm46ev5EnZxgWzcg0w1illfnjTAJFoGqUtq+DyLdw2Q8pIFlWNmz
 Vu9mX9ncFOE55wEcomOy2XlPqP+xQ4XNz6bjUePMRJJYOgljTmIddFJEGtT8nrtqx+46oF0tp
 2gIFXvkhWryCTUDCOv3F4XO6MiE9R98+G6IjaAeej0UYwaSw9bb+2rLfMGXn5fCBqkactuTXC
 eIeomvR/QeH2S1TN6nNUNuEoU3AWNDFCsIku59GePnb9Q6LsuLHL8StMfKbw4lPYZ5PaTq1D6
 OiJl0tgfm9l4aUq9MI7b6r9KHZgiQHsGtO5gwrHn6/4tFFcf87H7YLzTy3ReOIBYUo0SuXp+J
 y0bGSGFG1fXFhDfBjWI+jH+RVODIg5DnRiBjglBzNNIcWoSrV8eNzKgwXUrgvfr421eFhSTp4
 NEazAMD1rli2aYGltK66FBjcu1jKjFNz2IB2AC9Sb5AbGzssJ54HIgUpC7V1M1WmVPYTSXIT3
 po0P4lz9oTG4v8NNnmgdY0G53IlweTgfS4w
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dynamic size calculations (especially multiplication) should not be
performed in memory allocator function arguments due to the risk of them
overflowing. This could lead to values wrapping around and a smaller
allocation being made than the caller was expecting. Using those
allocations could lead to linear overflows of heap memory and other
misbehaviors.

To avoid this scenario, use the struct_size helper.

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 arch/arc/kernel/unwind.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
index 47bab67f8649..af18052b86a7 100644
=2D-- a/arch/arc/kernel/unwind.c
+++ b/arch/arc/kernel/unwind.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/module.h>
 #include <linux/memblock.h>
+#include <linux/overflow.h>
 #include <linux/sort.h>
 #include <linux/slab.h>
 #include <linux/stop_machine.h>
@@ -312,9 +313,7 @@ static void init_unwind_hdr(struct unwind_table *table=
,
 	if (tableSize || !n)
 		goto ret_err;

-	hdrSize =3D 4 + sizeof(unsigned long) + sizeof(unsigned int)
-	    + 2 * n * sizeof(unsigned long);
-
+	hdrSize =3D struct_size(header, table, n);
 	header =3D alloc(hdrSize);
 	if (!header)
 		goto ret_err;
=2D-
2.25.1

