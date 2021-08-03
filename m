Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D3C3DEAB5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbhHCKRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:17:42 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:16930 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbhHCKRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:17:41 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210803101729epoutp0491c9c9c749cd7d226281ed75308346e1~XxIErR5IB2228722287epoutp04i
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 10:17:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210803101729epoutp0491c9c9c749cd7d226281ed75308346e1~XxIErR5IB2228722287epoutp04i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1627985849;
        bh=Pz14cy8nzznFI/F+SJ3lMWu3jOf+dw4UrbmQOOsf9m0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Nb0wkJDAhRboUPq/Fxjqbh+Jwjip2jQ5CQJl+784OyU0dI3U9ftU4bxMKYUqyUU94
         ppO1TF8kH87QSp3ZY34H5pFwwdGv6gs9MVnRh6EaTucwaxemgNPbvksek09Pn26P5b
         qrImDrtHfgPTzaiXVtUpDhaAXxqq9Qek3Qe82r+M=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210803101728epcas1p387845c4a6687b18128f5c1111c98342f~XxID84_Fm1389813898epcas1p34;
        Tue,  3 Aug 2021 10:17:28 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.161]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Gf9m749B2z4x9Pp; Tue,  3 Aug
        2021 10:17:27 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.85.09952.7B719016; Tue,  3 Aug 2021 19:17:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210803101726epcas1p257df1a6ab948c39304f4246a95d039c3~XxICcIlXm1823818238epcas1p2u;
        Tue,  3 Aug 2021 10:17:26 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210803101726epsmtrp1f196b6b5cbccab018a1aafacad201690~XxICayDk41225712257epsmtrp1o;
        Tue,  3 Aug 2021 10:17:26 +0000 (GMT)
X-AuditID: b6c32a35-447ff700000026e0-d7-610917b7bb8b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3A.CD.08289.6B719016; Tue,  3 Aug 2021 19:17:26 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.78]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210803101726epsmtip2e7e23676e29d563e1721242b879e10c5~XxICPE5r50835608356epsmtip2U;
        Tue,  3 Aug 2021 10:17:26 +0000 (GMT)
From:   Ohhoon Kwon <ohoono.kwon@samsung.com>
To:     robh+dt@kernel.org, frowand.list@gmail.com
Cc:     ohoono.kwon@samsung.com, ohkwon1043@gmail.com, nathan@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] of: fdt: do not update local variable after use
Date:   Tue,  3 Aug 2021 19:13:09 +0900
Message-Id: <20210803101309.904-1-ohoono.kwon@samsung.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmru52cc5Egxd/5C3mHznHajHzzX82
        i8u75rBZtK98ymaxd7+vxa6fK5gtWvceYXdg99g56y67x6ZVnWwefVtWMXp83iQXwBKVY5OR
        mpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdICSQlliTilQ
        KCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8DQoECvODG3uDQvXS85P9fK0MDAyBSoMiEnY8b+
        vewFHWwVH5ZfY29gPMTSxcjJISFgIvHk3hvWLkYuDiGBHYwSz2/vZQNJCAl8YpRY9sAJIvGZ
        UeL3ug3MMB37NhxmgkjsYpTYu7MNqh2oo2NBNztIFZuAtsT+3hNgHSICehJ770xhASliFmhg
        lDi2bQMjSEJYwEHif8cTsCIWAVWJ5fcvMYHYvAJWErd+PmeHWCcvcWrZQai4oMTJmU/ADmcG
        ijdvnc0MMlRC4BS7xI0pi9ggGlwklr9dCfWdsMSr41ugBklJvOxvY4do6GeUONS3nRXCmcAo
        sb6rESjDAeTYS7y/ZAFiMgtoSqzfpQ/Rqyix8/dcRojFfBLvvvawQlTzSnS0CUGYqhLLfntA
        VEtL9E2/DHWNh8SsNX2skCCNldizcgrzBEb5WUi+mYXkm1kIexcwMq9iFEstKM5NTy02LDBE
        jtVNjOBUqGW6g3Hi2w96hxiZOBgPMUpwMCuJ8Ibe4EgU4k1JrKxKLcqPLyrNSS0+xGgKDN+J
        zFKiyfnAZJxXEm9oamRsbGxhYmZuZmqsJM77LfZrgpBAemJJanZqakFqEUwfEwenVANT5cH1
        U6ScGhlcF6/b2JDB8OjeriPz2yT9zhfddLI56/67d8mTJ+6TEg/MkQ53OicfdM/OZ/L09tak
        Kh/3/u99r+4XqXVztM6x8vJ5dveAQdNtL6uPjfm9+9SKHSZzsTbGBu54Pj+v/f5F65O5r27b
        Lvuot9PB4UdD8pdZt54qX3dleizjLlM080pPS+Cie0wf0lRtL3X3aU3anMtsP+fbpyUruTW/
        vNLfdk3caNK1+qXHPHq0RCInXBVfkLH64glRIUVXkf3Xnrx6tGPB6qXXlHc+7udR4nv3Xupn
        +sKDf+ZwuTwP3m7L5irNw+VXf+jfjInp7+eznio+m/W71kNdqrVJ4ChHyxHX+96zDM4eU2Ip
        zkg01GIuKk4EAKZe/nUOBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSvO42cc5Eg+l/TC3mHznHajHzzX82
        i8u75rBZtK98ymaxd7+vxa6fK5gtWvceYXdg99g56y67x6ZVnWwefVtWMXp83iQXwBLFZZOS
        mpNZllqkb5fAlTFj/172gg62ig/Lr7E3MB5i6WLk5JAQMJHYt+EwE4gtJLCDUeLOFTGIuLTE
        0xe7gGo4gGxhicOHi7sYuYBKPjBKfNl+nx2khk1AW2J/7wlmEFtEwECipekzK0gRs0Abo8TU
        /9fAEsICDhL/O56A2SwCqhLL718CW8YrYCVx6+dzdohl8hKnlh2EigtKnJz5BOw4ZqB489bZ
        zBMY+WYhSc1CklrAyLSKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4MLW0djDuWfVB
        7xAjEwfjIUYJDmYlEd7QGxyJQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5N
        LUgtgskycXBKNTDN7eg/wrKcc/tNwWe8Ri92dwe379wkqJd89+DEA5H3o54yBL/pvroj80HP
        34LSR/y3Vu0pDrojsun3Gc2Fyg9WLDytW3ngz7trtpM27kjv7JU+rG3zN9h3t9GBQg3DI2fu
        30w++0A+9EsZu9uc6QsP/tPOt0zPn7j1TvqDjsnrr3qxJ55iWnpeZH/NDHa+KVMmmN9jmh4j
        MGO+0ff5ZkcDvq+5rV716s6/rYcTX0Xpbg+rX6K0eNrhl361n5uNhb03fnRLD9oaeEv/cVRz
        Zm7V1NtHJuawcs+Q2JM/s7Nf70rZVfU9m5+yqZ95/f7Bxn2dy5/JCBS0fT4t1tjXZ7Z/2sMl
        ryw/taxgaLrO3n/kkpsSS3FGoqEWc1FxIgDWJfU5uwIAAA==
X-CMS-MailID: 20210803101726epcas1p257df1a6ab948c39304f4246a95d039c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210803101726epcas1p257df1a6ab948c39304f4246a95d039c3
References: <CGME20210803101726epcas1p257df1a6ab948c39304f4246a95d039c3@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the below warning:
drivers/of/fdt.c:196:4: warning: Value stored to 'pprev' is never read
[clang-analyzer-deadcode.DeadStores]
             pprev      = &pp->next;
             ^            ~~~~~~~~~

Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
---
 drivers/of/fdt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index bd35ba56aa96..5dc0b0310d7c 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -193,7 +193,6 @@ static void populate_properties(const void *blob,
 			pp->length = len;
 			pp->value  = pp + 1;
 			*pprev     = pp;
-			pprev      = &pp->next;
 			memcpy(pp->value, ps, len - 1);
 			((char *)pp->value)[len - 1] = 0;
 			pr_debug("fixed up name for %s -> %s\n",
-- 
2.32.0

