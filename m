Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B436376453
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 13:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237021AbhEGLKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 07:10:51 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:35963 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbhEGLKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 07:10:39 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210507110937epoutp02df36ec6345669317731b9587015f1efe~8xEeDxFsS2295622956epoutp022
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 11:09:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210507110937epoutp02df36ec6345669317731b9587015f1efe~8xEeDxFsS2295622956epoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1620385777;
        bh=tRpPkArbZBpkXQslb2SD9zz4SzVnlk8bxz+PJZpLwdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CSsg7AJsYie9F1Di3lq5e8nSGUBI6P18S2JIT03xKBUvLL+TE6lrN8cLd/GFiHGgZ
         z4OtkjK/Gp7jgAyNNlcqAjdF60ym83KufDbGVayb0Ao5MvOPRoZ2fvU4lWCHP8H6OA
         VpoC8Rpa2kXxTzS+NWLsE781OZu/UTVuPjmcHwI0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210507110930epcas1p3e031cd2b64bfe9b96f180b0b92b808f1~8xEYETTld0782507825epcas1p3D;
        Fri,  7 May 2021 11:09:30 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Fc74m30y5z4x9Py; Fri,  7 May
        2021 11:09:28 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.F9.09824.8EF15906; Fri,  7 May 2021 20:09:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210507110917epcas1p4a2d7ebd7e2fd8cc630fdf627ad73a003~8xELtmSCw1027110271epcas1p4G;
        Fri,  7 May 2021 11:09:17 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210507110917epsmtrp1ed73e90da2b3f5b2601f7805e12fb1ab~8xELtBbMk2530025300epsmtrp1Z;
        Fri,  7 May 2021 11:09:17 +0000 (GMT)
X-AuditID: b6c32a37-061ff70000002660-ae-60951fe86a1b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.DD.08163.DDF15906; Fri,  7 May 2021 20:09:17 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.223]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210507110917epsmtip2699113aa02a776d90d6c2d666c8aacf1~8xELgQ6hL2356423564epsmtip2a;
        Fri,  7 May 2021 11:09:17 +0000 (GMT)
From:   Seung-Woo Kim <sw0312.kim@samsung.com>
To:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, chao@kernel.org,
        sw0312.kim@samsung.com
Subject: [RESEND][PATCH 2/2] mkfs.f2fs: fix memory leak in not enough
 segments error path
Date:   Fri,  7 May 2021 20:12:24 +0900
Message-Id: <20210507111224.29887-2-sw0312.kim@samsung.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20210507111224.29887-1-sw0312.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmnu4L+akJBv8fClmcnnqWyeLJ+lnM
        FpcWuVtc3jWHzWLG5JdsDqwem1Z1snnsXvCZyaNvyypGj8+b5AJYorJtMlITU1KLFFLzkvNT
        MvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4DWKimUJeaUAoUCEouLlfTtbIry
        S0tSFTLyi0tslVILUnIKLAv0ihNzi0vz0vWS83OtDA0MjEyBChOyM/YfvMJYsIWtYva1XawN
        jGtZuxg5OCQETCQOz6/pYuTiEBLYwSjxpOEbI4TziVHi5+Y57F2MnEDOZ0aJpw+lQWyQhtNH
        H7FAFO1ilFi66gwThPOFUeL0zyUsIFVsAjoS+5f8ZgWxRQTsJGZcOMYGso5ZwFNiwaQIkLCw
        QLTEqakn2EBsFgFViZWLpjCC2LwC1hIPLyxih1gmL3Fhwy2wMZwCNhJvNnxkhagRlDg58wnY
        Kmagmuats5lBbpAQOMcu0TR7NiNEs4vE5KPT2SBsYYlXx7dADZWSeNnfxg7R0Az0wZJfLBBO
        D6PEnEW3WSGqjCX2L53MBHG1psT6XfoQYUWJnb/nMkJs5pN497UHGo68Eh1tQhAlKhI7j05i
        gwhLSczaEAwR9pA4dmQuNHT7GSVuHpnGPIFRYRaSf2Yh+WcWwuIFjMyrGMVSC4pz01OLDQuM
        kSN4EyM4FWqZ72Cc9vaD3iFGJg7GQ4wSHMxKIrynF01OEOJNSaysSi3Kjy8qzUktPsRoCgzt
        icxSosn5wGScVxJvaGpkbGxsYWJoZmpoqCTOm+5cnSAkkJ5YkpqdmlqQWgTTx8TBKdXAdPPL
        zGzBb4VMzN9dJ3XrdhZfypzPeXiaRclJnf9dAg6f3hd/tlq8UGMNM6NvrftaP6V3df1vLulV
        sX6et+57TT6b8UHdxLc2v+bKyT7nVUtj2dzWeNPvwqZJx/x6VrCcVLyvKN6//Plb2/sXclh/
        ukScXhnwz2XZLf7nfruOZooflrmr1J0lcUTqk438hY76xe+ChA/r+Rv1e3w1m9ktuPvfqtbt
        Zp38nxcnZzU7z3nWMEnMtYi/5ebZOWxfziwPXbkpQLMrQM+hw5v5eZHMOuFoix9xkuGr0+J8
        D5arnNvVHTpV08Yws/hhkNzbXULR+VGcjcd97ZjYIg1+1i04JbWmuX1eGvv32J7ZFx8qsRRn
        JBpqMRcVJwIAXdRYrg4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSvO5d+akJBifXqFicnnqWyeLJ+lnM
        FpcWuVtc3jWHzWLG5JdsDqwem1Z1snnsXvCZyaNvyypGj8+b5AJYorhsUlJzMstSi/TtErgy
        9h+8wliwha1i9rVdrA2Ma1m7GDk5JARMJE4ffcTSxcjFISSwg1Fi/csLjBAJKYm537YD2RxA
        trDE4cPFEDWfGCVu9P1hB6lhE9CR2L/kN9ggEQEHiRXbtrCA2MwCvhLTnq5kA7GFBSIlGndN
        B4uzCKhKrFw0BWw+r4C1xMMLi9ghdslLXNhwC2wOp4CNxJsNH8FsIaCaG8t+s0PUC0qcnPkE
        ar68RPPW2cwTGAVmIUnNQpJawMi0ilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOGi1
        tHYw7ln1Qe8QIxMH4yFGCQ5mJRHe04smJwjxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5I
        ID2xJDU7NbUgtQgmy8TBKdXAJP76tN3v04VtGim6V06X+kryz76q01TTUPFTfJq2wwHxwJ9z
        ph2tYNDpUFqol/ajNS1KlSv38tyoZY+karZNYtHUct6i5rch1uzThZaFl79EW3bNjtgpKO28
        uo6jvGF3sRKX95xj73sX/6t3q1/o0XMsW7w97djelgVJrccvTDx3Y9vjLp3Lx/tj9uj5Nkge
        OxfkVte7wmEb99PnoT+fxn356jWT9U35xUp3Pcvc0n9zwpLDZC8ZlL7pzDzqlHWzYkpDZPZM
        jgfcZ1fKm3y4s9pyx3yGDTEml6e1eAd1uN/7ssrRYBUv+4Gag+0urN7xQRUGZetP3P82/VTW
        ojl1LU1c/888Cjy28G5HfvIOJZbijERDLeai4kQA9sIXO8kCAAA=
X-CMS-MailID: 20210507110917epcas1p4a2d7ebd7e2fd8cc630fdf627ad73a003
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210507110917epcas1p4a2d7ebd7e2fd8cc630fdf627ad73a003
References: <20210507111224.29887-1-sw0312.kim@samsung.com>
        <CGME20210507110917epcas1p4a2d7ebd7e2fd8cc630fdf627ad73a003@epcas1p4.samsung.com>
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

