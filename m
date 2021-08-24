Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AD03F589C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbhHXHBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:01:39 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:64520 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhHXHBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:01:32 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210824070047epoutp0355cc0fd9080d90d3c0392b51756d6540~eK-U8Fshf0387903879epoutp03R
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:00:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210824070047epoutp0355cc0fd9080d90d3c0392b51756d6540~eK-U8Fshf0387903879epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1629788447;
        bh=E134hzmZMQpeYeSKjqO+0gr3vCGL8A1TvXL8JKY6ios=;
        h=From:To:Cc:Subject:Date:References:From;
        b=SNNwYsIPaRtwmhuyHITTDAaXEbNcv6OCjvqRRdjuk8yzWr7Mfq0LJKezWMw4uvOn4
         +wUFCUw5dSWWNeso1WFP4nzSDSHC82THuiNYsBalX95dxl/jvEaic9XxbMhVry22cu
         ab6OMKrm0BZ+dF/BLtyfLl3u1j8m0/JYJjcWCrfU=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20210824070046epcas5p4863c62aa272408f58afee0198c0582a4~eK-TxCbtY3126331263epcas5p4X;
        Tue, 24 Aug 2021 07:00:46 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.E0.09897.E1994216; Tue, 24 Aug 2021 16:00:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210824063513epcas5p46ba8b375c3e32fab210640a28041efb6~eKpALHHQ63036830368epcas5p4X;
        Tue, 24 Aug 2021 06:35:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210824063513epsmtrp1aae0cfac95db6b18f1b3f92d69c46b00~eKpAKZLTP1674216742epsmtrp12;
        Tue, 24 Aug 2021 06:35:13 +0000 (GMT)
X-AuditID: b6c32a49-e89ff700000026a9-39-6124991ecf52
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.BE.09091.12394216; Tue, 24 Aug 2021 15:35:13 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210824063511epsmtip1229485d87ee256e6e33551e1cad5d3d1~eKo_qIPL73241332413epsmtip1J;
        Tue, 24 Aug 2021 06:35:11 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH 1/1] scripts/checkpatch.pl: remove warning for
 pritk_deferred also
Date:   Tue, 24 Aug 2021 12:05:00 +0530
Message-Id: <1629786900-4644-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsWy7bCmpq7cTJVEgy2v2Swu7k61+LBWw2L9
        wmXMFrPvP2axuLxrDptFy9F2FovD89tYLA6dnMvowOExq6GXzWPnrLvsHl9WXWP26NuyitHj
        8ya5ANYoLpuU1JzMstQifbsEroxX81vZCt6yV7T83srawHiMrYuRk0NCwETiS2MvYxcjF4eQ
        wG5GiZ7lF5ghnE+MEpf7j7GAVAkJfGOU6D9rAtPxaes0FoiivYwSC29sZoNwvgC1H9sONpdN
        QE9i1a49YN0iAlESXcvOgu1gFuhilFi9ZzszSEJYIERi1a83YA0sAqoSl3pbwRp4Bdwkbl1s
        YoVYJydx81wn2E0SAuvYJb782MgMkXCReL30DhOELSzx6vgWdghbSuJlfxs7REM3o8TMOZeh
        ulczSmx6cR1qrL3E6+YGoG4OoJs0Jdbv0ocIy0pMPbUObCizAJ9E7+8nUAt4JXbMg7FVJVpu
        boAaIy3x+eNHFpAxEgIeEseWhYKYQgKxEs/exE5glJ2FMH8BI+MqRsnUguLc9NRi0wLDvNRy
        veLE3OLSvHS95PzcTYzgBKDluYPx7oMPeocYmTgYDzFKcDArifD+ZVJOFOJNSaysSi3Kjy8q
        zUktPsQozcGiJM6r+0omUUggPbEkNTs1tSC1CCbLxMEp1cDEyrTk4jGbrbXPHrcJbdhg/d5W
        L6yU8RLTJ+E7Bjt/bpSZfqf8zM3CpRWl5pEBe4OuzBVJrW/7yBc0ufLLPOc5vjKsXktTGPND
        fllm1ZqZarjc+fC138hoxqQlogEeEtd+hd5//91d5KtX4T3pr2qCfz2OFz2Mn71qci1PSM1i
        67qdOn92cQWv+7IniE1eOmBihcf5IrvnO7w+G/052LvPYxHf+ofvA3/55XbkLkuaFrqFwe19
        2Z2XjOsFcvuYyk9vuF+Zdby35MBr7WcGU05s1fjy2HdJjsD5jrZVr6p8nxVrPo1hFbW4c775
        dt/Ttm+2kj8qjjFn6kU+v1M0P5+vJCg2d6VS8601ecytc7mVWIozEg21mIuKEwEyhXhvbwMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmluLIzCtJLcpLzFFi42LZdlhJTldxskqiwamPnBYXd6dafFirYbF+
        4TJmi9n3H7NYXN41h82i5Wg7i8Xh+W0sFodOzmV04PCY1dDL5rFz1l12jy+rrjF79G1Zxejx
        eZNcAGsUl01Kak5mWWqRvl0CV8ar+a1sBW/ZK1p+b2VtYDzG1sXIySEhYCLxaes0li5GLg4h
        gd2MEl07NrNAJKQlfv57D2ULS6z895wdougTo8T2yasYQRJsAnoSq3btASsSEYiTmHx0CTNI
        EbNAH6PEwg8TmUASwgJBEgefN4A1sAioSlzqbQVr4BVwk7h1sYkVYoOcxM1zncwTGHkWMDKs
        YpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIDictzR2M21d90DvEyMTBeIhRgoNZSYT3
        L5NyohBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MPN7Z
        4grskep5Qmy6M7qtr8XpXzt62cT5uP6+TbbepeemLvjyccrSTb9ui+jI5uSVLLLbdzr5C/Pj
        BxrMj2+LhGtMmvVUi3G2YsWVnHf2b1y/TdOb59IUv0ZG5n13xt4Hqm0/DyUlzZvQLvItbbp4
        3qadrzQj992pulugzuHLx91554y9TYSmRcVho6e7gk99cklRnOH5yqG5XPECF7/fKXetHVFN
        xUElYQvzjudam/MpPStvbJ18/7Umd9KKIsamvP3hO3S+B7T+3JNcZ5X4pOJI2dO4HyEGjfP4
        3WsE/8odZlGXDP5gXBnO9Mb1eH/eNDbNH00qp7Vr2x74bIwVdUkytov36gpl7O/sUWIpzkg0
        1GIuKk4EAFlLREyWAgAA
X-CMS-MailID: 20210824063513epcas5p46ba8b375c3e32fab210640a28041efb6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210824063513epcas5p46ba8b375c3e32fab210640a28041efb6
References: <CGME20210824063513epcas5p46ba8b375c3e32fab210640a28041efb6@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

printk_deferred also supossed to get loglevel, but checkpatch.pl
returns warning for same.

WARNING: Possible unnecessary KERN_ALERT
+printk_deferred(KERN_ALERT "checking deferred\n");

total: 0 errors, 1 warnings, 20 lines checked

Thus removing warning for printk_deferred also.

Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 161ce7fe5d1e..e3bea0d36c10 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6252,7 +6252,7 @@ sub process {
 		}
 
 # check for logging functions with KERN_<LEVEL>
-		if ($line !~ /printk(?:_ratelimited|_once)?\s*\(/ &&
+		if ($line !~ /printk(?:_ratelimited|_once|_deferred)?\s*\(/ &&
 		    $line =~ /\b$logFunctions\s*\(.*\b(KERN_[A-Z]+)\b/) {
 			my $level = $1;
 			if (WARN("UNNECESSARY_KERN_LEVEL",
-- 
2.17.1

