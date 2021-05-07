Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF7E37642D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 13:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbhEGLBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 07:01:45 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:16865 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhEGLBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 07:01:43 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210507110041epoutp03c247ba02afef7d367643c867f60fa5a1~8w8rN254I0334903349epoutp03F
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 11:00:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210507110041epoutp03c247ba02afef7d367643c867f60fa5a1~8w8rN254I0334903349epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1620385241;
        bh=tRpPkArbZBpkXQslb2SD9zz4SzVnlk8bxz+PJZpLwdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hnQmt6i9gg5I6U0MGmQ9fJV6eDFvUMEJH9rPSgOcLp2mbB/6j8U6lpDgUdyRHmRrA
         uBjcJWMamGavzFDZNaTWFeqTDHoAlW32YmZ+aTTN1Nj9KpgtyYPdJcWzgKDc5ojYWs
         h/SxGWVp6/EWWsEH9JDZWTbYj/IiF3VKqRntj0Js=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210507110041epcas1p2c0fad718b4a69d44f9f95f3c132d0fe0~8w8q2rgxw2478824788epcas1p24;
        Fri,  7 May 2021 11:00:41 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Fc6tZ666Gz4x9Q2; Fri,  7 May
        2021 11:00:38 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.48.09736.6DD15906; Fri,  7 May 2021 20:00:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210507110037epcas1p2da2c78057f68167196bf68cd35604bad~8w8nadNM82235622356epcas1p2D;
        Fri,  7 May 2021 11:00:37 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210507110037epsmtrp24b662a129fcaad3f390b30418208dfbb~8w8nZnkdD2429324293epsmtrp2g;
        Fri,  7 May 2021 11:00:37 +0000 (GMT)
X-AuditID: b6c32a39-8efff70000002608-a4-60951dd620d8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.8D.08163.5DD15906; Fri,  7 May 2021 20:00:37 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.223]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210507110037epsmtip1903587f5b7ff04da9bc31cbd1c2e0e14~8w8nKPjJV0653706537epsmtip1D;
        Fri,  7 May 2021 11:00:37 +0000 (GMT)
From:   Seung-Woo Kim <sw0312.kim@samsung.com>
To:     aegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, chao@kernel.org,
        sw0312.kim@samsung.com
Subject: [PATCH 2/2] mkfs.f2fs: fix memory leak in not enough segments error
 path
Date:   Fri,  7 May 2021 20:03:42 +0900
Message-Id: <20210507110342.29566-2-sw0312.kim@samsung.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20210507110342.29566-1-sw0312.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmge412akJBj826Vhc+LmRyeL01LNM
        FpcWuVtc3jWHzWLG5JdsDqwem1Z1snnsXvCZyaNvyypGj8+b5AJYorJtMlITU1KLFFLzkvNT
        MvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4DWKimUJeaUAoUCEouLlfTtbIry
        S0tSFTLyi0tslVILUnIKLAv0ihNzi0vz0vWS83OtDA0MjEyBChOyM/YfvMJYsIWtYva1XawN
        jGtZuxg5OSQETCTafx5l7mLk4hAS2MEocXr5NnaQhJDAJ0aJmXutIBKfGSU2n9rDDtOx5NdG
        FojELkaJ10++QbV/YZRo+fiHCaSKTUBHYv+S32A7RARsJZbvPwbUzcHBLOApsWBSBEhYWCBY
        YsPEGWBDWQRUJbZ3zGYDsXkFrCWu31sMtUxe4sKGW2BjOAVsJGbPWgZVIyhxcuYTFhCbGaim
        eetssBskBC6xS8x/cIwZotlF4tLMfVCDhCVeHd8CZUtJfH63lw2ioZlRYumSXywQTg+jxJxF
        t6EhYyyxf+lkJoirNSXW79KHCCtK7Pw9lxFiM5/Eu689rCAlEgK8Eh1tQhAlKhI7j05igwhL
        SczaEAwR9pD40PMeGlb9jBJ9j1awTWBUmIXkn1lI/pmFsHgBI/MqRrHUguLc9NRiwwJT5Bje
        xAhOhlqWOxinv/2gd4iRiYPxEKMEB7OSCO/pRZMThHhTEiurUovy44tKc1KLDzGaAkN7IrOU
        aHI+MB3nlcQbmhoZGxtbmBiamRoaKonzpjtXJwgJpCeWpGanphakFsH0MXFwSjUwSV64NZ3N
        Irtu3RxBUZbM6HYJdaGPrHvrf7zJWzvJL2TP7HT+ovrbO3M13i6MDqqwsT7Ha/PZj7v9XINR
        YJIw080ku036c39HzpR+1flgn2nm5xuljTuedl2Yd3tvcVK54roaHjuhg+xJXG2topJZl7pe
        Z/R9DN4qMW2zQFHEriYrZzbTm9OtEtM//crdKpURF2C1ci2z5r76ZJ0vc9gfdkxjnvD+c2LW
        mf+RIQy/77pIH3ZNPP/9vsT+vrK1LJIXM1yvNG2sv8etrqq7fPrhRanJXxOaLy63qIt64H5J
        9E3ZM2aG/JUtnrO3TVn9ns0st0Tfd/Imrim793FZmL7Zb1xq80LlpONnVcEPoqpKLMUZiYZa
        zEXFiQDV8EU/DwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSnO5V2akJBmcuK1lc+LmRyeL01LNM
        FpcWuVtc3jWHzWLG5JdsDqwem1Z1snnsXvCZyaNvyypGj8+b5AJYorhsUlJzMstSi/TtErgy
        9h+8wliwha1i9rVdrA2Ma1m7GDk5JARMJJb82sjSxcjFISSwg1Hi/sN5zBAJKYm537YzdjFy
        ANnCEocPF0PUfGKUOP/vABNIDZuAjsT+Jb/BBokI2Et83fyXEcRmFvCVmPZ0JRuILSwQKHHm
        4GGwehYBVYntHbPB4rwC1hLX7y1mh9glL3Fhwy2wOZwCNhKzZy0DqxECqjna280OUS8ocXLm
        ExaI+fISzVtnM09gFJiFJDULSWoBI9MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzg
        oNXS2sG4Z9UHvUOMTByMhxglOJiVRHhPL5qcIMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJ
        eCGB9MSS1OzU1ILUIpgsEwenVAOTXt3+uGTzlI4PayKfPej+9LzivGEE+6VGjq41PTWZxof2
        WssH7vyy/7jv3q/S19YXZId6tpULyQQsm/HA55aO85e4HT6lLE9ev3GPeBvWzcVjmjz9mqT0
        hV3q0mnmSvMl++LLExSmpW61envLuV5mRcldlz/z9CVnbDv5mkFFjuf9DXERYX+Tcx9OcV2/
        qdCu4J56kndvzCpO61f9J8z8L+Vta0yqbzPs+BmyIWytYEeg4Ku9nqduLrjLErXFeN3XHMdP
        D3TD76Zbm5r8+ug+O1jjza1dtq1v8t8++ZHs9Fxvw4pr279e5tVlX7Yw2kP7Y31f/TdRHdno
        zeKc2v/mP/8szJtfYRzvYP7Y54QSS3FGoqEWc1FxIgCYZSjByQIAAA==
X-CMS-MailID: 20210507110037epcas1p2da2c78057f68167196bf68cd35604bad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210507110037epcas1p2da2c78057f68167196bf68cd35604bad
References: <20210507110342.29566-1-sw0312.kim@samsung.com>
        <CGME20210507110037epcas1p2da2c78057f68167196bf68cd35604bad@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In not enough segements error path of f2fs_write_check_point_pack(),
cp_payload is not freed. Fix the error path.

Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
 mkfs/f2fs_format.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 3f1fa32a407a..fbecb05b3302 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -723,7 +723,7 @@ static int f2fs_write_check_point_pack(void)
 
 	if (f2fs_get_usable_segments(sb) <= get_cp(overprov_segment_count)) {
 		MSG(0, "\tError: Not enough segments to create F2FS Volume\n");
-		goto free_nat_bits;
+		goto free_cp_payload;
 	}
 	MSG(0, "Info: Overprovision ratio = %.3lf%%\n", c.overprovision);
 	MSG(0, "Info: Overprovision segments = %u (GC reserved = %u)\n",
-- 
2.19.2

