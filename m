Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E978C3051B8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhA0FIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 00:08:09 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:28186 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238406AbhA0EQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 23:16:07 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210127041524epoutp031bea663a44cf7a6a8fba8e6f7ce7c586~d_6Qjr8EW3159331593epoutp030
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 04:15:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210127041524epoutp031bea663a44cf7a6a8fba8e6f7ce7c586~d_6Qjr8EW3159331593epoutp030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611720924;
        bh=Y8aJiRSGEeDMH8i++If4hXnSlgw4orlR0qNeQcGyICQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=fADqJqwlg393v/7ZARLKKdQEelaReOjTtcWNETV+edsNHJfL6n0jvbSN37ZmjhjUi
         AlGRM+19BvtxRpEAcY3te+PAUgd4XMLpZSZLp2bN2kDQbH1HBVz5nhCQZblufoNN4D
         3ymv49ZJBGPlCYF0PWpHrHXMeDhM9OupmkJVc71s=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210127041523epcas1p278a99e2c8459babca51ff030c8161af1~d_6P-GXFN2594925949epcas1p2y;
        Wed, 27 Jan 2021 04:15:23 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DQVd36btLz4x9Q2; Wed, 27 Jan
        2021 04:15:19 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.4B.10463.1D8E0106; Wed, 27 Jan 2021 13:15:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210127041512epcas1p1306df0339fd2ffffec43cca6b0475a88~d_6GQFpXH1093210932epcas1p15;
        Wed, 27 Jan 2021 04:15:12 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210127041512epsmtrp1c121d3106369e40dc269d52f63859e0f~d_6GPQ9BX2187921879epsmtrp1U;
        Wed, 27 Jan 2021 04:15:12 +0000 (GMT)
X-AuditID: b6c32a38-efbff700000028df-50-6010e8d17275
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.30.08745.0D8E0106; Wed, 27 Jan 2021 13:15:12 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.223]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210127041512epsmtip25dcfa6d973d293dff38fe1bed9c0afb9~d_6GABNT-0653506535epsmtip2U;
        Wed, 27 Jan 2021 04:15:12 +0000 (GMT)
From:   Seung-Woo Kim <sw0312.kim@samsung.com>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, ardb@kernel.org, jcmvbkbc@gmail.com,
        olof@lixom.net, sw0312.kim@samsung.com, jh80.chung@samsung.com
Subject: [RESEND][PATCH] ARM: mm: Free memblock from free_initrd_mem()
Date:   Wed, 27 Jan 2021 13:17:26 +0900
Message-Id: <20210127041727.11001-1-sw0312.kim@samsung.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmge7FFwIJBrtPKFjMWb+GzeLnl/eM
        Ft8eLmS0uPGrjdVi0+NrrBaXd81hszg0dS+jxanrn9ksjqzfzmQxY/JLNgcuj8vXLjJ77Jx1
        l91j06pONo8TM36zeGxeUu9x5UQTq0ffllWMHp83yQVwRGXbZKQmpqQWKaTmJeenZOal2yp5
        B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDdqKRQlphTChQKSCwuVtK3synKLy1JVcjI
        Ly6xVUotSMkpsCzQK07MLS7NS9dLzs+1MjQwMDIFKkzIzjjblVJwjL3i5/YelgbGDWxdjJwc
        EgImEo1NM5hAbCGBHYwSVz/wdjFyAdmfGCWmTn7EDuF8ZpR4cfkPO0xH/4ZTTBCJXYwSB47P
        YINo/8Io8aaRH8RmE9CR2L/kNyuILSJgL3Ht8SxmkAZmga2MEi3t/8ESwgJuErePrwFrZhFQ
        lTi86jPQVA4OXgFriaOXtCCWyUtc2HALrJxXQFDi5MwnLCA2M1C8eetssJkSAn/ZJb42nmaG
        aHCR2P5oCxOELSzx6vgWqKulJF72t0HZ1RLbJ/xkh2juYJToaW9kgUgYS+xfOhnsCGYBTYn1
        u/QhwooSO3/PZYRYzCfx7msPK0iJhACvREebEESJisTOo5PYIMJSErM2BEOEPST+PloCDd1Y
        iaUdi1kmMMrPQvLNLCTfzELYu4CReRWjWGpBcW56arFhgQlylG5iBCdSLYsdjHPfftA7xMjE
        wXiIUYKDWUmE972yQIIQb0piZVVqUX58UWlOavEhRlNg8E5klhJNzgem8rySeENTI2NjYwsT
        QzNTQ0Mlcd4kgwfxQgLpiSWp2ampBalFMH1MHJxSDUwGKmUB33x0edtundmS9+NQSIOp6GWJ
        l9dmMTxmEPP6veKnqtqhre7hwmz+3fk75ofdd7l9f7uszWbF5KZWRdE92154xqYl5xZWqvCa
        sLqKSptfuekb1TPP86f8vO1ZztFPfI/lyLLI/nsiVMPLEm/E4tXVtH9yx80gW1OVcs1vKSWC
        616WNFhsrf9yLn+V9LkDv/6tn+ed+WlS49qjL3eE1SiaZH+bF2v/Y92Le48UXIW3vPWq+zkv
        yvdq8MGKk1US3h/tU5ec+NG5JfJS7LsL5/pOSH30OFnsnPHm7jKFwwf+yH893KuvLysWe2dC
        TkfMrSxZHQtZ/Uef/2hnGG14XKq+0Vd9oY2XIGObthJLcUaioRZzUXEiAFtYNootBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSvO6FFwIJBlOvmFnMWb+GzeLnl/eM
        Ft8eLmS0uPGrjdVi0+NrrBaXd81hszg0dS+jxanrn9ksjqzfzmQxY/JLNgcuj8vXLjJ77Jx1
        l91j06pONo8TM36zeGxeUu9x5UQTq0ffllWMHp83yQVwRHHZpKTmZJalFunbJXBlnO1KKTjG
        XvFzew9LA+MGti5GTg4JAROJ/g2nmLoYuTiEBHYwSjR+P8IIkZCSmPttO5DNAWQLSxw+XAxR
        84lR4tqsKawgNWwCOhL7l/wGs0UEHCWO7OtkASliFtjPKHG+8SY7SEJYwE3i9vE1YNtYBFQl
        Dq/6zAQylFfAWuLoJS2IXfISFzbcApvDKyAocXLmExYQmxko3rx1NvMERr5ZSFKzkKQWMDKt
        YpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIDm4trR2Me1Z90DvEyMTBeIhRgoNZSYT3
        vbJAghBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MmfUd
        TFfW3FE31jQXXO+2+63aEinXvQtL97H58fNP6XzY1L2kefIe6fTjOq+ebSxQOtncFfbmudH7
        fbl7LK9ybej6tDGhXcXWZ/3b8oaDm66Er9vRv2Xpt7abZmISqbMr1Q7vazn8a1PYh7uvrCem
        sQhO/7JC11P/TmyqX4m7t6tI2ZqyVcs/TbfoffpnA89Dj0dTbir9z+N582/G6YPCx5LXuYSE
        i0e+yN4elM93UnGK4+frCSteLVH9ljTNJf9VUp3GHrdZGcvyHugKb7U+L7ujlVHcn3PCq/Wd
        s9YpWbGHxegHNWVevRizi+H16i1ynfpvV0wKs71naaB8woBD9+TrXS+djJVu/a8NuafZqcRS
        nJFoqMVcVJwIAGsLr4vdAgAA
X-CMS-MailID: 20210127041512epcas1p1306df0339fd2ffffec43cca6b0475a88
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210127041512epcas1p1306df0339fd2ffffec43cca6b0475a88
References: <CGME20210127041512epcas1p1306df0339fd2ffffec43cca6b0475a88@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even after free_initrd_mem(), memblock for initrd remains. Free
memblock for initrd from free_initrd_mem() line generic function.

Reported-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
 arch/arm/mm/init.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 828a256..f7db023 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -530,6 +530,13 @@ void free_initmem(void)
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
+#ifdef CONFIG_ARCH_KEEP_MEMBLOCK
+	unsigned long aligned_start = ALIGN_DOWN(start, PAGE_SIZE);
+	unsigned long aligned_end = ALIGN(end, PAGE_SIZE);
+
+	memblock_free(__pa(aligned_start), aligned_end - aligned_start);
+#endif
+
 	if (start == initrd_start)
 		start = round_down(start, PAGE_SIZE);
 	if (end == initrd_end)
-- 
1.7.4.1

