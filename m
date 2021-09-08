Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D40C4031FC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 02:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344253AbhIHAx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 20:53:29 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:44325 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343915AbhIHAx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 20:53:28 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210908005219epoutp0481fe779850293dceba141b7024ad89f2~iso5VGRAe1900219002epoutp04f
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 00:52:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210908005219epoutp0481fe779850293dceba141b7024ad89f2~iso5VGRAe1900219002epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1631062339;
        bh=h1xgIL9sEU5cIOMNug/NaL9+VZxdcy24/62ZSvoPVLE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=KJlNpY6dvXzHn+8kviZAY1Gu5ezKIVjgdLQfP7gg/miu2HiiJxOxVrwXp9lMD/mDo
         VVE+v8HSdLsQ+pIcJN3PWh2syjTg8yifKdlX1z1bcuVCpsNnVzQQq2iiIBlSG1/iEB
         IOSWHl3PaIkvTQ7b1k1Qzd67fbOjYtckKIUff//I=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210908005218epcas1p2756c28d3e58c8bf5ff1e43abd0001f0e~iso4qdMtR1557115571epcas1p2v;
        Wed,  8 Sep 2021 00:52:18 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.241]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4H43WM39kkz4x9QJ; Wed,  8 Sep
        2021 00:52:15 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.32.09752.C3908316; Wed,  8 Sep 2021 09:52:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210908005211epcas1p49238a827ca0c829bb056ba57c995e750~isoySS2h50622606226epcas1p4P;
        Wed,  8 Sep 2021 00:52:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210908005211epsmtrp130ade4a50e0701fad2571a0c1d6c75ee~isoyRg9LP0707907079epsmtrp1X;
        Wed,  8 Sep 2021 00:52:11 +0000 (GMT)
X-AuditID: b6c32a39-6a7ff70000002618-42-6138093c3099
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.A6.09091.B3908316; Wed,  8 Sep 2021 09:52:11 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.100.104]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210908005211epsmtip28f96c42c2cf46e190ee10d7eff25b925~isoyAnLoh1599515995epsmtip26;
        Wed,  8 Sep 2021 00:52:11 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     minchan@kernel.org, hch@infradead.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ytk.lee@samsung.com, jaewon31.kim@gmail.com,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH v2] zram_drv: allow reclaim on bio_alloc
Date:   Wed,  8 Sep 2021 09:52:41 +0900
Message-Id: <20210908005241.28062-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7bCmga4Np0WiwYlFihZz1q9hszg9YRGT
        RffmmYwWve9fMVlc3jWHzeLemv+sFsu+vme3eLye24HDY+esu+wem1doeWxa1cnmsenTJHaP
        EzN+s3j0bVnF6PF5k1wAe1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5i
        bqqtkotPgK5bZg7QTUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScArMCveLE3OLS
        vHS9vNQSK0MDAyNToMKE7IwlDS9YCraxV8yZtY+lgXEWWxcjJ4eEgInErVPLWEBsIYEdjBIH
        ewW7GLmA7E+MEkdPzGWEcL4xSixs+skK0/Gq5xIbRGIvo8SmGSfYIZwfjBItDycwgVSxCWhL
        vF8wCaxDRMBF4sbdtcwgRcwCXYwSDz4cBFsoLGAhsfz4H7AGFgFVibPPZoDZvAK2Eqfub2eH
        WCcvsXrDAbBmCYFj7BJ3zjZBXe4isXbnTKgiYYlXx7dA2VISL/vboOx6iY7rvewQzQ2MErsf
        XAT6iAPIsZd4f8kCxGQW0JRYv0sfolxRYudvkJ85gcJ8Eu++9rBCVPNKdLQJQZSoSbQ8+woN
        CRmJv/+eQdkeEnPmNbBCwjFWYuHc06wTGGVnISxYwMi4ilEstaA4Nz212LDAFB5Lyfm5mxjB
        6UzLcgfj9Lcf9A4xMnEwHmKU4GBWEuH9a26WKMSbklhZlVqUH19UmpNafIjRFBheE5mlRJPz
        gQk1ryTe0MTSwMTMyMTC2NLYTEmcl/GVTKKQQHpiSWp2ampBahFMHxMHp1QDkzlT/u7vh2LC
        va/Idc3c9vRDTfL/mZufXM560Dzv1fV7siv6624a37iWVeny5KmZx2atBSpxheIPm64zbvOd
        8eDxj+d8L+J8m723yDDMTpAUORzqMLm7kr+XceG/p/+LPabMD8jc5HDhILOyvPfHK3WmR/xr
        g1gUHXb2/O9gesr+K3NXje//jJm35+RHBsXsZhRrcgsO+z3bNOuhCNveeUYeUc/O1zhWRGcE
        1zzL3RKhpbg4ImXOd002/SNJWXt+lLgvbpz2v7/LyHOy5ezH+ewiQhlx3Ltf3Ptv31fPduzV
        qXLDlGu5Qrf9mVS4f/ZNPH2j+HPyWyOH5467DYN5NF4zWIts+rjPgvX+jIVsSizFGYmGWsxF
        xYkA4orVdPADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmluLIzCtJLcpLzFFi42LZdlhJXtea0yLR4NgXbYs569ewWZyesIjJ
        onvzTEaL3vevmCwu75rDZnFvzX9Wi2Vf37NbPF7P7cDhsXPWXXaPzSu0PDat6mTz2PRpErvH
        iRm/WTz6tqxi9Pi8SS6APYrLJiU1J7MstUjfLoErY0nDC5aCbewVc2btY2lgnMXWxcjJISFg
        IvGq5xKQzcUhJLCbUWLCzX+sEAkZiTfnn7J0MXIA2cIShw8XQ9R8Y5R4MX0pWDObgLbE+wWT
        WEFqRAQ8JL53MILUMAtMYJRYuewTC0iNsICFxPLjf5hAbBYBVYmzz2aA2bwCthKn7m9nh9gl
        L7F6wwHmCYw8CxgZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBIeXluYOxu2rPugd
        YmTiYDzEKMHBrCTC+9fcLFGINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakF
        qUUwWSYOTqkGpp3iIqsehvjPP6T7tXKS6UvJHXFF6vc+77303TPqLLOoopTFF72ezSZruTu+
        N75RC2M7bRodceWm+Kks54nqJv6vDZNvz93Dz3vsnINNpKDQMhcbn6uylVw3bjt87uX/f5J5
        huu/W71eVjsM510um3Lsh9n8tUlzvpybzZRgdcQzyOp81gLh6A1/FA5qzCw94O79+fei4sMl
        3DXuCQ4Tz4ncuu+9jzX+wbLjtdIVz65r6vovEf3wQmzPxomTo/7xbZwZueJLn9G7bxaSjjud
        9W7crPlasmZvQM/Tv5Nm7pL9FaXyo9WkgSOhbdrODpUtfG/9m2ZULtkj16kcvr04c9fb9Xdb
        rqndfTTrzelzJVFKLMUZiYZazEXFiQCgafqongIAAA==
X-CMS-MailID: 20210908005211epcas1p49238a827ca0c829bb056ba57c995e750
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210908005211epcas1p49238a827ca0c829bb056ba57c995e750
References: <CGME20210908005211epcas1p49238a827ca0c829bb056ba57c995e750@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The read_from_bdev_async is not called on atomic context. So GFP_NOIO is
available rather than GFP_ATOMIC. If there were reclaimable pages with
GFP_NOIO, we can avoid allocation failure and page fault failure.

Reported-by: Yong-Taek Lee <ytk.lee@samsung.com>
Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
Acked-by: Minchan Kim <minchan@kernel.org>
---
v2: use GFP_NOIO only
v1: use GFP_NOIO | __GFP_HIGHMEM
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fcaf2750f68f..081e77d595d7 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -587,7 +587,7 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
 {
 	struct bio *bio;
 
-	bio = bio_alloc(GFP_ATOMIC, 1);
+	bio = bio_alloc(GFP_NOIO, 1);
 	if (!bio)
 		return -ENOMEM;
 
-- 
2.17.1

