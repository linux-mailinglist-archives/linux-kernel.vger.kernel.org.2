Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E3C3B92D9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 16:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbhGAOIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 10:08:51 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:24547 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbhGAOIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 10:08:49 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210701140617epoutp017e21a2422fc1d4cb44afeb78810f0f98~Nr9a6pPed0116601166epoutp01d
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 14:06:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210701140617epoutp017e21a2422fc1d4cb44afeb78810f0f98~Nr9a6pPed0116601166epoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625148377;
        bh=C6nCjIM9xJ1StW0PX3KFLqc+Hv2Ypnn4LHXI1YI5WfM=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=fDDHvI2XqCQj5Q+AbFxpPs41axAalc93/YEyj2n5RtZNhPjBM+CW14VVlXPDxwM9R
         NzxBb9P6riuWNoChgUIsxp22hNYB9avLTdWtGVxPDtJRBd5rR6Ruc1PY/Oa+T8wcyb
         jO9hqnjP+gXCxYWwONuc836e88yuJkao5XYgPbgw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210701140616epcas1p3c0706669e96acada88ed79a64d9c979e~Nr9Z5-Xq-1071910719epcas1p3z;
        Thu,  1 Jul 2021 14:06:16 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.166]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4GG0PM1QSLz4x9Pr; Thu,  1 Jul
        2021 14:06:15 +0000 (GMT)
X-AuditID: b6c32a35-45dff700000026e0-ab-60ddcbd6f1da
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.7F.09952.6DBCDD06; Thu,  1 Jul 2021 23:06:15 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] of: of_reserved_mem: match memblock_free with
Reply-To: ohoono.kwon@samsung.com
Sender: =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>
From:   =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>,
        "ohkwon1043@gmail.com" <ohkwon1043@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210701140614epcms1p384c7e681cd9cd08a2b836474c167c549@epcms1p3>
Date:   Thu, 01 Jul 2021 23:06:14 +0900
X-CMS-MailID: 20210701140614epcms1p384c7e681cd9cd08a2b836474c167c549
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmru7103cTDPonM1vMP3KO1WLmm/9s
        Fve/HmW0uLxrDpvF3v2+Frt+rmC2aN17hN2B3WPnrLvsHptWdbJ53Lm2h82jb8sqRo/Pm+QC
        WKNybDJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOArlBS
        KEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFBgaFOgVJ+YWl+al6yXn51oZGhgYmQJV
        JuRkLG5bwVywibti/rNu5gbGbZxdjJwcEgImEp1z2pm6GLk4hAR2MEp0Lmhi6WLk4OAVEJT4
        u0MYpEZYwE5i6ablTCBhIQFFiW2n3SDCVhLT+v4xgdhsAhYSz9f+ZAWxRQSSJHasnMIIMpJZ
        YAqTxObGY6wQu3glZrQ/ZYGwpSW2L9/KCGGLStxc/ZYdxn5/bD5UXESi9d5ZZghbUOLBz91Q
        cUmJm213WUAWSAj0M0rcX9cC5UxglFjyZBIbRJW5xLMNLWBTeQV8JVb8Xg1mswioSjx/egbq
        IheJPR3/wKYyC8hLbH87hxnkS2YBTYn1u/QhShQldv6eC1XCJ/Huaw/cMzvmPQEHigTQyGW/
        PWD+6pt+GeoCD4nvDWvBtgoJBErMfLKNeQKj/CxE6M5CsncWwt4FjMyrGMVSC4pz01OLDQsM
        kSN0EyM4FWqZ7mCc+PaD3iFGJg7GQ4wSHMxKIrwTpt9NEOJNSaysSi3Kjy8qzUktPsRoCvTx
        RGYp0eR8YDLOK4k3NDUyNja2MDEzNzM1VhLn3cl2KEFIID2xJDU7NbUgtQimj4mDU6qB6V7i
        9BiLhYu7Swwd50jcX/izSPZO3h/JS4ynNh6uebW3P6qU6cyVIKeUNR4vq7SucQScOqQzrTRh
        vlFM8+KctLNqbw9sfPtjHmfhlNtu9xovh53pVCud+jZh179lIS/PJV19lXLq/oGS4+ssjYt1
        L31weGN9rtF2l1VcnrBjiW3add141fzjxTd+X/Q9/OV2Eg+LudC1vV9aT90zzBMPnro2obDu
        8O536wR7uTNtk5eES5TzRsS9sv1g29b63ctPdtFeO9aFbREvXt8y3d7Rz6fKkrG/LEDsle46
        V88zyWGb2DSmPXxT4PK1TbJ21oSkP9tEHTtUtR7wWbEe6SiYr7J/TuBHNl/LNzH3DIvnK7EU
        ZyQaajEXFScCABy/DWEOBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210701140328epcms1p85149318b6c18fa18b3c7c8e966c14db0
References: <CGME20210701140328epcms1p85149318b6c18fa18b3c7c8e966c14db0@epcms1p3>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When __reserved_mem_init_node called from fdt_init_reserved_mem fails,
we try to undo __reserved_mem_alloc_size to prevent memory leak.
'commit d0b8ed47e83a ("of: reserved_mem: fix reserve memory leak")'

Meanwhile, __reserved_mem_alloc_size calls
early_init_dt_alloc_reserved_memory_arch to allocate memory,
which calls
1) memblock_remove when rmem is declared nomap,
2) memblock_reserve, otherwise.

static int __init early_init_dt_alloc_reserved_memory_arch(
...
	if (nomap)
		return memblock_remove(base, size);

	return memblock_reserve(base, size);
}

Therefore the proper undo-logic should be as follows:
1) memblock_add when rmem is declared nomap,
2) memblock_free, otherwise.

Match the undo functions for readability.

Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
---
 drivers/of/of_reserved_mem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 15e2417974d6..2279e1b55d1d 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -273,9 +273,10 @@ void __init fdt_init_reserved_mem(void)
 			if (err != 0 && err != -ENOENT) {
 				pr_info("node %s compatible matching fail\n",
 					rmem->name);
-				memblock_free(rmem->base, rmem->size);
 				if (nomap)
 					memblock_add(rmem->base, rmem->size);
+				else
+					memblock_free(rmem->base, rmem->size);
 			}
 		}
 	}
-- 
2.17.1
