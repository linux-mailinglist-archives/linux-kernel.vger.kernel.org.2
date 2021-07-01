Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A33E3B92B8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 16:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbhGAOGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 10:06:05 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:28163 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbhGAOGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 10:06:02 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210701140330epoutp0465e4b1d6c01343be4e547b6afaec9021~Nr6-eyppo1381413814epoutp04q
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 14:03:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210701140330epoutp0465e4b1d6c01343be4e547b6afaec9021~Nr6-eyppo1381413814epoutp04q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625148210;
        bh=E1aaxR8FfUi3vlMZNGnaBp5eQ1CM10Z3mqMC5JAz3Cc=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=ODDJbCkB42qiJP/sbRJmIJFXqxAHlgTxqJvql1lR33bf222eWDNrJ9QGWSuxTaVuO
         PeI0Kp4y3Sunig0oJEk91g58YnG2e+2sMykML5YepS/YWR+m8V6whXq1xDgRZfEK9e
         Nu75Ypsj/AfuP++/AmYHhWfY28kS501Wn2usVycU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210701140329epcas1p35fd7d39293d17eaa8737b9353ce846a9~Nr6_7__Md1305613056epcas1p3c;
        Thu,  1 Jul 2021 14:03:29 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.160]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4GG0L86Q6Mz4x9Pt; Thu,  1 Jul
        2021 14:03:28 +0000 (GMT)
X-AuditID: b6c32a37-0c7ff700000024fc-91-60ddcb3082d2
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.F4.09468.03BCDD06; Thu,  1 Jul 2021 23:03:28 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] of: base: remove unnecessary for loop
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
Message-ID: <20210701140328epcms1p85149318b6c18fa18b3c7c8e966c14db0@epcms1p8>
Date:   Thu, 01 Jul 2021 23:03:28 +0900
X-CMS-MailID: 20210701140328epcms1p85149318b6c18fa18b3c7c8e966c14db0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmnq7B6bsJBu8361rMP3KO1WLmm/9s
        Fve/HmW0uLxrDpvF3v2+Frt+rmC2aN17hN2B3WPnrLvsHptWdbJ53Lm2h82jb8sqRo/Pm+QC
        WKNybDJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOArlBS
        KEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFBgaFOgVJ+YWl+al6yXn51oZGhgYmQJV
        JuRkHL/7hbXgK2fF4yvPWRoYj7N3MXJySAiYSOza1M7axcjFISSwg1HiyvbLjF2MHBy8AoIS
        f3cIg9QIC5hJLJ39kx0kLCSgKLHttBtE2EpiWt8/JhCbTcBC4vnan6wgtohAksSOlVMYQUYy
        C0xhktjceIwVYhevxIz2pywQtrTE9uVbGSFsUYmbq9+yw9jvj82HiotItN47ywxhC0o8+Lkb
        Ki4pcbPtLgvIAgmBfkaJ++taoJwJjBJLnkxig6gyl3i2oQVsKq+Ar8TtSYfBTmURUJWYc/IC
        1EUuElc6N4HVMwvIS2x/O4cZ5EtmAU2J9bv0IUoUJXb+nssIUcIn8e5rD9wzO+Y9YQIplwAa
        uey3B8xffdMvQ13gIfG9YS3YBUICgRK3ts9insAoPwsRurOQ7J2FsHcBI/MqRrHUguLc9NRi
        wwJj5AjdxAhOhVrmOxinvf2gd4iRiYPxEKMEB7OSCO+E6XcThHhTEiurUovy44tKc1KLDzGa
        An08kVlKNDkfmIzzSuINTY2MjY0tTMzMzUyNlcR5d7IdShASSE8sSc1OTS1ILYLpY+LglGpg
        6uVfOP3Kqd3yEhOv9vd+cHlZVe4p6Bteu/b9Y28+L7dFN9ab/k46Pmv6PdGVQt1Ze3r6ApbX
        XtyY+N32XKGmrPrECF61Kt9Fi7MT72/7u8vRr+XJ1m8fcnvnbbiypTKrf+v3Ram31x5+qsOj
        O2/CTI4GicDuHUvmHm65YxKzukb505Gq1InL1zA++8P6NCAi7JnkQRX1q5VrVs3RucK8fLFX
        8+OLbGIFnawKz/Pro7s+eQsHb+bd87ibYc02ZbEJe0sbt0089XKb0cUk+4xVPHavzV7KXck2
        l9rWftHL+saECPZi6Uqf0ua8TY/O6Uys2PSXMTV+tuDKNV/zir0OKJr6eXg2/Nc+ckkpqa4h
        XYmlOCPRUIu5qDgRANNZz4cOBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210701140328epcms1p85149318b6c18fa18b3c7c8e966c14db0
References: <CGME20210701140328epcms1p85149318b6c18fa18b3c7c8e966c14db0@epcms1p8>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __of_get_next_child function, loop iteration for getting next node is
unnecessary.

for loop is already checking if next is NULL or not, and
of_node_get(next) always returns next itself.

Therefore checking return value in the if clause always evaluates to
true, and thus it always breaks out from for loop in the first iteration.

Remove the unnecessary for loop for readability.

I tested the code as below, and it showed that BUG was never called.

-       for (; next; next = next->sibling)
+       for (; next; next = next->sibling) {
                if (of_node_get(next))
                        break;
+               BUG();
+       }

Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
---
 drivers/of/base.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 48e941f99558..ca60988ef428 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -708,9 +708,7 @@ static struct device_node *__of_get_next_child(const struct device_node *node,
 		return NULL;
 
 	next = prev ? prev->sibling : node->child;
-	for (; next; next = next->sibling)
-		if (of_node_get(next))
-			break;
+	of_node_get(next);
 	of_node_put(prev);
 	return next;
 }
-- 
2.17.1
