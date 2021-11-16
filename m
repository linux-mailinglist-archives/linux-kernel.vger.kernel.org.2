Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EFF453BB5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 22:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhKPVhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 16:37:17 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50102 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhKPVhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 16:37:16 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20211116213418euoutp023f5e3ef7615d35748b72507a588e2e63~4JF-MdrDn3076930769euoutp02I
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 21:34:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20211116213418euoutp023f5e3ef7615d35748b72507a588e2e63~4JF-MdrDn3076930769euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1637098458;
        bh=XieGAbqFy23Y21BUv7IS8XBEi2s44rhYR/2S0oVWSr8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=VGXgeEu7MCM5oywMGkuJi8bpqQ9ncUkTxV5SxLMTw1WaC1F4B2del16M8MdAk/x8+
         2feb30xZuTqA1L4gif8qaMqiusbQtaIqCNX94JAQ8CyxxKykgmjkOp5uwof/XXZ/tU
         UpVBvh4I2S0nX7/XuiEyxoGXfAsGdMddPaudF4HI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211116213418eucas1p1ab095759059a1af1c1dc3fb761716a95~4JF_8YZ1H0377703777eucas1p10;
        Tue, 16 Nov 2021 21:34:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 85.61.09887.9D324916; Tue, 16
        Nov 2021 21:34:17 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20211116213417eucas1p2a9679f03f7945f7c2bdfcba7a4e7c405~4JF_E_5UI0164701647eucas1p2D;
        Tue, 16 Nov 2021 21:34:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211116213417eusmtrp193c501c987c1c624da1a5679b3753672~4JF_EVpUb0986009860eusmtrp1R;
        Tue, 16 Nov 2021 21:34:17 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-41-619423d9af24
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AB.5C.09522.8D324916; Tue, 16
        Nov 2021 21:34:16 +0000 (GMT)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20211116213417eusmtip15ff5ae007a6c81e1f76096cefa31cff9~4JF95973P0369903699eusmtip1B;
        Tue, 16 Nov 2021 21:34:17 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] get_maintainer: look for configuration files in
 ./scripts
Date:   Tue, 16 Nov 2021 22:34:01 +0100
Message-Id: <20211116213403.820336-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42LZduznOd2bylMSDeZetrCYs34Nm8Xs+49Z
        LG4eWsFocXnXHDaLtUfusjuwepyY8ZvF48uqa8wefVtWMXp83iQXwBLFZZOSmpNZllqkb5fA
        lfFw5nqWgj3sFfs2bmNpYJzK1sXIySEhYCLR2DSBpYuRi0NIYAWjxJWTvVDOF0aJRw962UGq
        hAQ+M0rMOVkL0/Hh2gWoouWMEof3HmKGcJ4zStw4/w1sLpuAo0T/0hOsILaIgI/Esz3X2UCK
        mAX6GCV+z97IDJIQFgiQWD5pOdAoDg4WAVWJ/jZ1kDCvgI3E7zufGCG2yUu0XZ/OCBEXlDg5
        8wkLiM0voCWxpuk6mM0MVNO8dTbYERICKzkkrk+YxAzR7CKx8f8zqEeFJV4d38IOYctInJ7c
        A7ZXQqBeYvIkM4jeHkaJbXN+sEDUWEvcOfeLDaSGWUBTYv0ufYhyR4mGO3YQJp/EjbeCEBfw
        SUzaNp0ZIswr0dEmBDFDRWJd/x6oeVISva9WQD3lIbHm5ne2CYyKs5D8NQvJL7MQ1i5gZF7F
        KJ5aWpybnlpslJdarlecmFtcmpeul5yfu4kRmEhO/zv+ZQfj8lcf9Q4xMnEwHmKU4GBWEuFN
        qZqcKMSbklhZlVqUH19UmpNafIhRmoNFSZxX5E9DopBAemJJanZqakFqEUyWiYNTqoFJaeED
        88ftITraMuoHxFddfSO+vJFj95ca3jPFq49tyjDaPDPvl9TCf9Mj/z8I2tfNW/MwIXhDwuPo
        Ch/B1DkHvDykgzYGKR/YXSFyuP3bPjmRxyzHu1+9aa5w8f2Wxsw3Qyfkxd7QT0kqkgfPTXtf
        t83VdePZKCm2LM3/TX2cJa/nX325/MV636Dz9l+S9syObj5c4TzvFtvO2TP9OFO0qp70npqn
        ImE++2Lg0/vtXW9vFV8pnndo4bmZFxMEf9pu3XrAKW9/TMnjHUJaLGnvd/0xvZsW0uG777ZK
        +NVTvVeqTiupfhcKM5nu+oNBT4F5ccMzodO3Gbykb1q9euAae33ZgTXnfJpM3n0tyH8fo8RS
        nJFoqMVcVJwIAG+D7TWTAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsVy+t/xu7o3lKckGsw9bWUxZ/0aNovZ9x+z
        WNw8tILR4vKuOWwWa4/cZXdg9Tgx4zeLx5dV15g9+rasYvT4vEkugCVKz6Yov7QkVSEjv7jE
        Vina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+PhzPUsBXvYK/Zt3MbSwDiV
        rYuRk0NCwETiw7ULLF2MXBxCAksZJZbeP87UxcgBlJCSWDk3HaJGWOLPtS42iJqnjBLXWiGa
        2QQcJfqXnmAFsUUE/CQ2zLnNBFLELNDHKPF79kZmkIQwUGLS9husIENZBFQl+tvUQcK8AjYS
        v+98YoRYIC/Rdn06I0RcUOLkzCcsIOXMAuoS6+cJgYT5BbQk1jRdZwGxmYHKm7fOZp7AKDAL
        SccshI5ZSKoWMDKvYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIyEbcd+bt7BOO/VR71DjEwc
        jIcYJTiYlUR4U6omJwrxpiRWVqUW5ccXleakFh9iNAV6YCKzlGhyPjAW80riDc0MTA1NzCwN
        TC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamKwWNBy7UXj6Qszsp4zLZ53a7ti1MZrz
        VjWDTOJxxVn39cP1iuTPOr27s/GQStybHUdk7Nfdut3Q9Pqut1nHg/fFh/ii12eGBSzhe814
        2iR73j7he4eVGnTqP27sUdU5GJl3Y3+SR56VnrS4XyUfu7Z7cI0S9/7zjaafU+pn6sjo5cY2
        /Ky9dnpxZPsUA0Vp6fPr/ncxMfnXHCmtYdy0/vnifWJT1padDalx/stVV9O45cnUP5ncIidW
        da+ZtrTbolSwy1KvzvO8cdOXpYeim96ryQqxZYZUvFoYzhZwTZPTUYr5R6r1na6T5Q87V7J5
        nAu/vS9H/4FR3JXgMj29W5PrWX9UBP6/9IhJhnenEktxRqKhFnNRcSIA3GCTIQ0DAAA=
X-CMS-MailID: 20211116213417eucas1p2a9679f03f7945f7c2bdfcba7a4e7c405
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20211116213417eucas1p2a9679f03f7945f7c2bdfcba7a4e7c405
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20211116213417eucas1p2a9679f03f7945f7c2bdfcba7a4e7c405
References: <CGME20211116213417eucas1p2a9679f03f7945f7c2bdfcba7a4e7c405@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change ".scripts" to "./scripts" as described in commit bcde44ed7d2a
("scripts/get_maintainer.pl: use .get_maintainer.conf from . then $HOME
then scripts").

Enumerate paths to search directly in an array instead of joining and
splitting.

Fixes: bcde44ed7d2a ("scripts/get_maintainer.pl: use .get_maintainer.conf from . then $HOME then scripts").
Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 scripts/get_maintainer.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 2075db0c08b8..ff10c2878522 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -1478,7 +1478,7 @@ sub which {
 sub which_conf {
     my ($conf) = @_;
 
-    foreach my $path (split(/:/, ".:$ENV{HOME}:.scripts")) {
+    foreach my $path (".", "$ENV{HOME}", "./scripts") {
 	if (-e "$path/$conf") {
 	    return "$path/$conf";
 	}
-- 
2.30.2

