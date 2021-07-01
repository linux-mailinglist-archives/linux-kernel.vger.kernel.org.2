Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7715A3B92FC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 16:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbhGAOOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 10:14:14 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:31109 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbhGAOOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 10:14:12 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210701141140epoutp048cd911cdef519692e58a32ac1f7968ef~NsCINyb3W2024020240epoutp04T
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 14:11:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210701141140epoutp048cd911cdef519692e58a32ac1f7968ef~NsCINyb3W2024020240epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625148700;
        bh=C6nCjIM9xJ1StW0PX3KFLqc+Hv2Ypnn4LHXI1YI5WfM=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=uiXuqigrpkJHe7zkZs6qJHI6UbNqP52dnv1MCHqLLUk2f0lFib6Ces2U0srJcZ99A
         mR92/RBp3AuRUwrYPXzt6myIjVKdfDgYm65TLzFuje1MSyB6Y9FXgsxHPWbhZT1IEt
         IelScvUO/ubD+rJzYU8U2zAVBe/jEnzWAFccIkms=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210701141139epcas1p334b3c29d4d866c93f4a5b87fbd149ae0~NsCHKjo2i1986619866epcas1p3W;
        Thu,  1 Jul 2021 14:11:39 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.164]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4GG0WZ5sZCz4x9Pv; Thu,  1 Jul
        2021 14:11:38 +0000 (GMT)
X-AuditID: b6c32a39-857ff70000002572-12-60ddcd1a552c
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.20.09586.A1DCDD06; Thu,  1 Jul 2021 23:11:38 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] of: of_reserved_mem: match memblock_free with
 memblock_reserve
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
Message-ID: <20210701141137epcms1p8e36d33056f5ad5351f5fe1fb35238e58@epcms1p8>
Date:   Thu, 01 Jul 2021 23:11:37 +0900
X-CMS-MailID: 20210701141137epcms1p8e36d33056f5ad5351f5fe1fb35238e58
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmnq7U2bsJBvve6VjMP3KO1WLmm/9s
        Fve/HmW0uLxrDpvF3v2+Frt+rmC2aN17hN2B3WPnrLvsHptWdbJ53Lm2h82jb8sqRo/Pm+QC
        WKNybDJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOArlBS
        KEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFBgaFOgVJ+YWl+al6yXn51oZGhgYmQJV
        JuRkLG5bwVywibti/rNu5gbGbZxdjJwcEgImEn2r5zCC2EICOxglls4q7WLk4OAVEJT4u0MY
        JCwsECixZ8kxRpCwkICixLbTbhBhK4lpff+YQGw2AQuJ52t/soLYIgJJEjtWTgEq5+JgFpjC
        JLG58RgrxCpeiRntT1kgbGmJ7cu3MkLYohI3V79lh7HfH5sPFReRaL13lhnCFpR48HM3VFxS
        4mbbXRaQBRIC/YwS99e1QDkTGCWWPJnEBlFlLvFsQwvYVF4BX4ktd36BncoioCqx5U031CQX
        iYN9U8FqmAXkJba/ncMM8iWzgKbE+l36ECWKEjt/z2WEKOGTePe1B+6ZHfOeMIGUSwCNXPbb
        A+avvumXoS7wkPjesJYdErSBEre2z2KewCg/CxG6s5DsnYWwdwEj8ypGsdSC4tz01GLDAlPk
        +NzECE6EWpY7GKe//aB3iJGJg/EQowQHs5II74TpdxOEeFMSK6tSi/Lji0pzUosPMZoCfTyR
        WUo0OR+YivNK4g1NjYyNjS1MzMzNTI2VxHl3sh1KEBJITyxJzU5NLUgtgulj4uCUamBS89vb
        ItLf8/bjFrX9K1zT/i9orbqpNMXizAcewekBTWkyTBJbFXT+84sm1syoZT/4yKrog1nOOU52
        hwuNnvmPzhTn77fJMbLIdjjl+s/uRnXW/+xfTJW2KWtZvB4vz73s/+vLh6lSK6/tOanW//Xx
        /kgBn5TPz9W0g7/OWMty+M2XLNFLk6T+3ueXVxE9xnzu9Nwq9QU5CzrmPb989NfKwMjqtfu5
        3AyaTC//ZLms7DJNbE9eb9Obi7onQ0v8yziDlj9TiBZe9S7iyveVEpqqBTPSPp6M648XtOP8
        eqbv9r7X/R4f7DgFptj0zjvIeHoOU2VCqOqvYM4i5tqK+ccyXCQlE5Q2F6xl0Qy4W6jEUpyR
        aKjFXFScCABhFvCWDQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210701140328epcms1p85149318b6c18fa18b3c7c8e966c14db0
References: <CGME20210701140328epcms1p85149318b6c18fa18b3c7c8e966c14db0@epcms1p8>
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
