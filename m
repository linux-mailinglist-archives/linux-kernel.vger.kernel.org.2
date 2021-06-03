Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08EF5399BE8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 09:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFCHtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 03:49:25 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:14456 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhFCHtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 03:49:24 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210603074739epoutp022b8272063ba30b6a638405f02252feb6~FAu1P53ZG1309613096epoutp02m
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 07:47:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210603074739epoutp022b8272063ba30b6a638405f02252feb6~FAu1P53ZG1309613096epoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1622706459;
        bh=a4ac+4M78wqsm+nnuN+UzpsShE5xrjHPpltpyIZazLQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=e3s/ftzdMArxr5Uty3B63DZm9e25aAkiR0+HW/JOkgVH2OQx3Ehn0s1oEwygNTVPC
         gS6S0t0ZII6T9TDZR6orwyTKn2MTraDUnFMOw6IPZHjNYaTKhIJ8unbdhqRtkPEQjp
         lXxPZpm7DB43iQJxqw7TdDYpyjYoYXU+bFkd7siw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210603074738epcas1p2ac10db6ddb98942288bd9ed8c3b474b4~FAu00Sbtf2276122761epcas1p2D;
        Thu,  3 Jun 2021 07:47:38 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.162]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4FwdKP3mWNz4x9Pv; Thu,  3 Jun
        2021 07:47:37 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.E2.09701.91988B06; Thu,  3 Jun 2021 16:47:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210603074737epcas1p4578329b14ee6d5cec7fbb002e014f7c2~FAuzf-WzC0485104851epcas1p4t;
        Thu,  3 Jun 2021 07:47:37 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210603074737epsmtrp1dccbdb4027364345aad64eb867b09c90~FAuzfVicx1750517505epsmtrp1s;
        Thu,  3 Jun 2021 07:47:37 +0000 (GMT)
X-AuditID: b6c32a36-631ff700000025e5-b0-60b88919d488
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.FB.08163.81988B06; Thu,  3 Jun 2021 16:47:37 +0900 (KST)
Received: from VDBS1328.vd.sec.samsung.net (unknown [168.219.243.40]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210603074736epsmtip27bb5251ea28a9b15a0dc66fb0b433135~FAuzTSANL1715617156epsmtip2x;
        Thu,  3 Jun 2021 07:47:36 +0000 (GMT)
From:   Jungseung Lee <js07.lee@samsung.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Jungseung Lee <js07.lee@samsung.com>
Subject: [PATCH] mm : Report which part of mem is being freed on initmem
 case
Date:   Thu,  3 Jun 2021 16:44:34 +0900
Message-Id: <1622706274-4533-1-git-send-email-js07.lee@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7bCmvq5k544EgzmnpC3mrF/DZvHo5m9W
        i8u75rBZ3Fvzn9WBxWPTp0nsHidm/Gbx6NuyitHj8ya5AJaoHJuM1MSU1CKF1Lzk/JTMvHRb
        Je/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoJVKCmWJOaVAoYDE4mIlfTubovzSklSF
        jPziElul1IKUnAJDgwK94sTc4tK8dL3k/FwrQwMDI1OgyoScjIU737MUHGer+DvzNFsD40rW
        LkZODgkBE4k1i38ydzFycQgJ7GCUaNwwnw3C+cQo0fzqFAtIlZDAZ0aJqdMSYTpm3zjCAlG0
        i1Fia88XVgjnF6PE6323GUGq2AS0JG783gS2Q0QgUaKpu5EZxGYW0JD4feAm2FRhAX+Jxw1v
        wWwWAVWJDaemMoHYvALOEst//GKG2CYncfNcJ9h9EgL97BIXN6+FSrhIzOr+wQ5hC0u8Or4F
        ypaSeNnfBmWXS6w71M4G0dzCKLHz60yohLHEu7cggziALtKUWL9LHyKsKLHz91xGiEP5JN59
        7WEFKZEQ4JXoaBOCKFGSePOghQXClpC48LgXGo4eEisWnWCDhFasxJE1DYwTGGVnISxYwMi4
        ilEstaA4Nz212LDACDmWNjGC05GW2Q7GSW8/6B1iZOJgPMQowcGsJMK7R21HghBvSmJlVWpR
        fnxRaU5q8SFGU2CATWSWEk3OBybEvJJ4Q1MjY2NjCxMzczNTYyVx3nTn6gQhgfTEktTs1NSC
        1CKYPiYOTqkGptmh25t3vpx5rMfW2zfjXAWfwZYLs4xEpZfJHZLnWqhxYs39b26BiW82S3Qu
        69338V/OSpO4GbNMU2b9WN2Z47Hc/Po9N/vqxUGaD/dlWP15Xu+te6OycEb2brVJm5NX/5bb
        cyqP02/6Sx9h9vrY6LCWO9Z/FrG2SXhInJy+PrPq6RdFZ2v28GtOyiaxj4+FHvE9vfKKdt7i
        G9o2fxZ/OhQcVh+dV7Fwxtx9TLFzJzXxzY1WVvpbckvs+MWUupV2Kw2YtJM1ElPj/djWNa65
        wfRjg4egmIlrkun8/UXfWuMc+UN2yvbYvpw26WLR1H3iqVuCp5QUuHtXPujZlBq6qPOW8aVJ
        6cXe1+LmnvC0V2Ipzkg01GIuKk4EAI/ojOnQAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFJMWRmVeSWpSXmKPExsWy7bCSvK5k544Eg2szmSzmrF/DZvHo5m9W
        i8u75rBZ3Fvzn9WBxWPTp0nsHidm/Gbx6NuyitHj8ya5AJYoLpuU1JzMstQifbsEroyFO9+z
        FBxnq/g78zRbA+NK1i5GTg4JAROJ2TeOsHQxcnEICexglDg9v4sJIiEh8WjnF6AEB5AtLHH4
        cDFEzQ9GiakvG8Ca2QS0JG783gRmiwgkS6x5sIkRxGYW0JD4feAmC4gtLOArMf3WIrCZLAKq
        EhtOTQWzeQWcJZb/+MUMsUtO4ua5TuYJjDwLGBlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXr
        JefnbmIEB4eW1g7GPas+6B1iZOJgPMQowcGsJMK7R21HghBvSmJlVWpRfnxRaU5q8SFGaQ4W
        JXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MO9N7PKziH9y8orvlXJritQ1Z1St5tq9daOsh
        WeHHM2XezWR7V4s11a84Xl760MojJuH5klNeWtw/8YtUGIujbjnnietGqk9FVMsjg78KvEhR
        4H4bebXcT+jk45mabx1izkpsLw69M3Ot25tTz26ETez5+yCwuaHRUULpn/uyfTqTRCY4VXAq
        ze/i+b9CZfUL5c4VtazsOd4rK3d/PLZ8yY1ZWo73Y28taBG7KXr2XsZ/0wMMq84pSR002Ou2
        /Ln7xK0Ppq+y2fX6n/zTXW6ei7hrdv55+lrIqfaERP9ET4VvJ3ZzX2/zux5YFON+6LW4t2dY
        uc32WzvzK3ZMfmx+8pNePceJI8t3xjxPfeOwT4mlOCPRUIu5qDgRABBBArx9AgAA
X-CMS-MailID: 20210603074737epcas1p4578329b14ee6d5cec7fbb002e014f7c2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210603074737epcas1p4578329b14ee6d5cec7fbb002e014f7c2
References: <CGME20210603074737epcas1p4578329b14ee6d5cec7fbb002e014f7c2@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the details for figuring out which parts of the kernel image
is being freed on initmem case.

Before:
   Freeing unused kernel memory: 1024K

After:
   Freeing unused kernel image (initmem) memory: 1024K

Signed-off-by: Jungseung Lee <js07.lee@samsung.com>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8631ddf..62f0901 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2426,7 +2426,7 @@ static inline unsigned long free_initmem_default(int poison)
 	extern char __init_begin[], __init_end[];
 
 	return free_reserved_area(&__init_begin, &__init_end,
-				  poison, "unused kernel");
+				  poison, "unused kernel image (initmem)");
 }
 
 static inline unsigned long get_num_physpages(void)
-- 
2.7.4

