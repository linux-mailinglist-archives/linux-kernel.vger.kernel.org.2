Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F764015F7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 07:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239201AbhIFFaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 01:30:09 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:55763 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239252AbhIFF36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 01:29:58 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210906052850epoutp02c80fd1d24651ff0bc824507a08e08aeb~iJHwd3q9n2173521735epoutp020
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 05:28:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210906052850epoutp02c80fd1d24651ff0bc824507a08e08aeb~iJHwd3q9n2173521735epoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1630906130;
        bh=D1wTegPjbU7mKHWfbuO1/C5CIjKOS5X8nr9yieL2Z/w=;
        h=From:To:Cc:Subject:Date:References:From;
        b=g3Vc9g6wXEfwMq2+44pja7AP4E3HWEjx4Mz++7aXMCUV+cCaNlYTmk3MDk/CuE50s
         zUVECB1cxjtkQjJ4XPhOWhLPlFPNIhBc2m423LS7KnxUFWbKO1ndQuFxm0Sw/BoGs/
         LzUYjByXTrM87P3Q/G7qQ3nRAxPwCqSDZ+pV/NC8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210906052850epcas1p20f5afc3467058d8ae474fc73de85651b~iJHwEu0jD1356213562epcas1p2z;
        Mon,  6 Sep 2021 05:28:50 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.250]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4H2xlM4wmQz4x9QN; Mon,  6 Sep
        2021 05:28:47 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.FD.09910.F07A5316; Mon,  6 Sep 2021 14:28:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210906052847epcas1p1f53f1ad04ad785d53f64eef150969c34~iJHtV_x-00442304423epcas1p1g;
        Mon,  6 Sep 2021 05:28:47 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210906052847epsmtrp17c3f0d87cc230c17c7f062556db23fe4~iJHtVMqeJ0795807958epsmtrp1W;
        Mon,  6 Sep 2021 05:28:47 +0000 (GMT)
X-AuditID: b6c32a35-1c13ba80000026b6-68-6135a70fa485
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.8D.08750.F07A5316; Mon,  6 Sep 2021 14:28:47 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.100.104]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210906052846epsmtip1661e666b58c56aba4833cb1e1958c120~iJHtHPkVB2097020970epsmtip1B;
        Mon,  6 Sep 2021 05:28:46 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     minchan@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ytk.lee@samsung.com, jaewon31.kim@gmail.com,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH] zram_drv: allow reclaim on bio_alloc
Date:   Mon,  6 Sep 2021 14:29:26 +0900
Message-Id: <20210906052926.6007-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCKsWRmVeSWpSXmKPExsWy7bCmri7/ctNEg0OztS3mrF/DZtG9eSaj
        Re/7V0wWl3fNYbO4t+Y/q8Wyr+/ZLR6v53Zg99g56y67x6ZVnWwemz5NYvc4MeM3i0ffllWM
        Hp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl
        5gCdoqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCvQK07MLS7NS9fLSy2xMjQw
        MDIFKkzIzljedpSx4BZbxcUTjUwNjBdYuxg5OCQETCQ23bbpYuTiEBLYwSixs+sJE4TziVFi
        85szzBDOZ0aJ5lsT2bsYOcE6Fl3ZyQqR2MUo8bH7ECOE84NR4kZzEyNIFZuAtsT7BZNYQWwR
        AUOJlR8+g81lFuhilHjw4SALSEJYwFTiyts2sAYWAVWJaVNmM4PYvAI2Ev+fP2CCWCcvsXrD
        AbA7JAQ2sUvMOPeXFSLhIjF75VoWCFtY4tXxLVD3SUm87G+DsuslOq73skM0NzBK7H5wkRHi
        bXuJ95csQExmAU2J9bv0IcoVJXb+ngt2D7MAn8S7rz3QQOKV6GgTgihRk2h59hXqAhmJv/+e
        QdkeEkuONYGdLyQQK7FwyzLmCYyysxAWLGBkXMUollpQnJueWmxYYAiPpeT83E2M4OSlZbqD
        ceLbD3qHGJk4GA8xSnAwK4nwRjsbJQrxpiRWVqUW5ccXleakFh9iNAWG10RmKdHkfGD6zCuJ
        NzSxNDAxMzKxMLY0NlMS52V8JZMoJJCeWJKanZpakFoE08fEwSnVwMQ3o+BoIrP2TIPpNo/P
        lzWfrLbevluBlXeOJkPk9/xndm8fcF7c+u7aFYe3Lx8J/uJ8sF+ML9z3eq6Rv+a38ABuk9Mx
        rEwz8y3fH74c2j6h9ax3fP2RDate7babu6DxlVyNksrtvnZ/pk3d6sXzvtyaZMEbb+04tVFK
        wX51sVcNu1zMoTXq95mkfN2YTjupNSr4X1Q+8SPBzMT3j0LxV5GepuJ+swB5dmERvZL+P5lf
        FKN9k45aiUsUchtcZ5t+RSu+9L4p47mMctkvPZsfLDmvF3ydkaf0aISfYlz87nz2Lco7PTc7
        fPGfLLlxW8s/aYWZBbZtW+bOrAxKYCv423jxB59Q04lC60/KF+YrsRRnJBpqMRcVJwIAjxD8
        cOcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkluLIzCtJLcpLzFFi42LZdlhJTpd/uWmiwaEPbBZz1q9hs+jePJPR
        ovf9KyaLy7vmsFncW/Of1WLZ1/fsFo/Xczuwe+ycdZfdY9OqTjaPTZ8msXucmPGbxaNvyypG
        j8+b5ALYorhsUlJzMstSi/TtErgylrcdZSy4xVZx8UQjUwPjBdYuRk4OCQETiUVXdoLZQgI7
        GCVeXGCEiMtIvDn/lKWLkQPIFpY4fLgYouQbo8SP1XEgNpuAtsT7BZPAWkUEjCW6Xl5n6mLk
        4mAWmMAosXLZJxaQhLCAqcSVt21gM1kEVCWmTZnNDGLzCthI/H/+gAlil7zE6g0HmCcw8ixg
        ZFjFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcSlpaOxj3rPqgd4iRiYPxEKMEB7OS
        CG+0s1GiEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUx2
        /MzWP4U9My7a+bWb/9lTf0/7U1e53WlOt+I/gtbes+Y09m6c+jFx45SOVqHzbxW/2v6f0L/n
        SeYBj0mRjXfS/0+2+nrSOLJ478P133WfasiH8XgW8FYYv1UTVeSpkq/aa2NV9kP+l++7nWGi
        S1ImfZ6XWsGkcO7yY5nnX2NrJJJDhW5Ondj1Y7ZjiGo5X13OKdlspsVCjFmdx/zlbzx/eNiw
        6WzG8cbtAvwsUlr3YnZ2N4fs+iCTxdjO8GtxWEJwef9GnTT1ojU9G4pW3BdxF1mQNS2j6hDf
        l5NnBW3fhSp758c0F0i/3JRzf/PJb3Py4v2Yr+xw38f6ZFdBW36a1/Ywlhlf2NYnLz0cpMRS
        nJFoqMVcVJwIAJa9TMKUAgAA
X-CMS-MailID: 20210906052847epcas1p1f53f1ad04ad785d53f64eef150969c34
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210906052847epcas1p1f53f1ad04ad785d53f64eef150969c34
References: <CGME20210906052847epcas1p1f53f1ad04ad785d53f64eef150969c34@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The read_from_bdev_async is not called on atomic context. So GFP_NOIO is
available rather than GFP_ATOMIC. If there were reclaimable pages with
GFP_NOIO, we can avoid allocation failure and page fault failure.

Reported-by: Yong-Taek Lee <ytk.lee@samsung.com>
Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fcaf2750f68f..53be528a39a2 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -587,7 +587,7 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
 {
 	struct bio *bio;
 
-	bio = bio_alloc(GFP_ATOMIC, 1);
+	bio = bio_alloc(GFP_NOIO|__GFP_HIGHMEM, 1);
 	if (!bio)
 		return -ENOMEM;
 
-- 
2.17.1

