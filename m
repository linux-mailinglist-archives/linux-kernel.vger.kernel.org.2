Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D82369B82
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 22:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhDWUrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 16:47:15 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58816 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbhDWUrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 16:47:13 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210423204635euoutp02874ee1c3a609c42860040ac15bab8545~4l6PVvwKM3195531955euoutp02N
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 20:46:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210423204635euoutp02874ee1c3a609c42860040ac15bab8545~4l6PVvwKM3195531955euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1619210796;
        bh=MV1mRG4BKFdOMValOTDfhZayzXXJHdWLha0V/QcWJ3U=;
        h=From:To:Cc:Subject:Date:References:From;
        b=LNFXwbiusJCWCp2pGZu7SduT/u6smC5XrFsPexDQIeLJs4gLmpVnSQeKaadk4OVCB
         fJJ1D3RwBrw1AZcjB4cp+SWwqEf6YYdK5+Mt4NUP8D9D5kgDls9utuHIOFyR12jhTj
         CwZ1iBS5I/8+N1SxeQBolPya31j4rbEGUwT1cKLk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210423204634eucas1p1f93e8016028ee121931b60ea3da0f367~4l6OUa05B0175301753eucas1p1B;
        Fri, 23 Apr 2021 20:46:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 1C.C1.09452.A2233806; Fri, 23
        Apr 2021 21:46:34 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210423204633eucas1p2f5178b2cb85dc63e780b81deebf0700f~4l6NXL5c00621106211eucas1p21;
        Fri, 23 Apr 2021 20:46:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210423204633eusmtrp29c19c0a7a17115f80ea5813c6e77a060~4l6NWjx7D2289222892eusmtrp2g;
        Fri, 23 Apr 2021 20:46:33 +0000 (GMT)
X-AuditID: cbfec7f2-ab7ff700000024ec-eb-6083322a7980
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 88.1F.08705.92233806; Fri, 23
        Apr 2021 21:46:33 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210423204633eusmtip1e51ab6a9949b734d63c83841f956b6e8~4l6M-YpHW2824828248eusmtip1z;
        Fri, 23 Apr 2021 20:46:33 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH] extcon: max8997: Add missing modalias string
Date:   Fri, 23 Apr 2021 22:46:24 +0200
Message-Id: <20210423204624.10398-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsWy7djP87paRs0JBhO6DSyuf3nOanF51xw2
        i7VH7rJb3G5cwebA4tG3ZRWjx+dNcgFMUVw2Kak5mWWpRfp2CVwZE9dtZyo4ylax/c4slgbG
        W6xdjJwcEgImEnt/TAWyuTiEBFYwSrS/38YC4XxhlLh6fRE7hPOZUaJ37zy4ltWb/0FVLWeU
        OL32AkLLywXrmECq2AQMJbredrGB2CICChKbe5+BLWEWaGCUmHrgKjNIQljAVuLqzwdgY1kE
        VCXub/sF1swLFN8y5wsbxDp5idUbDjCDNEsIXGKXmHz/IwtEwkWi48Z2JghbWOLV8S3sELaM
        xP+d85kgGpoZJR6eW8sO4fQwSlxumsEIUWUtcefcL6AVHEA3aUqs36UPYkoIOEpcumMDYfJJ
        3HgrCFLMDGRO2jadGSLMK9HRJgQxQ01i1vF1cFsPXrjEDGF7SJzpuAV2pZBArMTt119ZJzDK
        zUJYtYCRcRWjeGppcW56arFhXmq5XnFibnFpXrpecn7uJkZgTJ/+d/zTDsa5rz7qHWJk4mA8
        xCjBwawkwut1tDFBiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+q2WvihQTSE0tSs1NTC1KLYLJM
        HJxSDUyGl5a96tbfPUdbRpqX8WTt1/zXVidXfvl673xl0ttDs/v+y04yzzvy50n5ocTnB0IT
        Tux00um/G7zY/rBxW1KKq8WtG5qr17ClTM3wKe/MS9+yef3d6m2HF9r0x/Y/Xej5jO3ivS0t
        gb/V1jTr3lt5WGvh4k01jiffyxlalb/+7u6jLXiu8865MGGGooY8n0uLfzPfklc097+wQX6f
        VehB07jJ4VtvRRyZx9bwppXNIXHej35O7YJ7k/ZOSpGddfxsTpTWtO/TF+dlhExUCb15jO3m
        95n3O2U6gt43+SYU5VnOPX2wd/0z/nkHXiz9dWP2Z10t/aSlL5bOtNj+skr03JdU09NL/xvP
        ick2Dm7crMRSnJFoqMVcVJwIACArlIxYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsVy+t/xu7qaRs0JBn8vaVtc//Kc1eLyrjls
        FmuP3GW3uN24gs2BxaNvyypGj8+b5AKYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyN
        zWOtjEyV9O1sUlJzMstSi/TtEvQyJq7bzlRwlK1i+51ZLA2Mt1i7GDk5JARMJFZv/sfSxcjF
        ISSwlFGi+eImFoiEjMTJaQ1QRcISf651sUEUfWKUuPDqJlgRm4ChRNdbkAQnh4iAgsTm3mes
        IEXMAk2MEj8fN4AlhAVsJa7+fAA2iUVAVeL+tl9MIDYvUHzLnC9sEBvkJVZvOMA8gZFnASPD
        KkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMBQ2nbs5+YdjPNefdQ7xMjEwXiIUYKDWUmE1+to
        Y4IQb0piZVVqUX58UWlOavEhRlOgfROZpUST84HBnFcSb2hmYGpoYmZpYGppZqwkzrt17pp4
        IYH0xJLU7NTUgtQimD4mDk6pBqZGH2eWuIJtjhlt8fef/5zm1HW/5+W3DAbVqIVxG9c6LEr6
        WD21PsPt+w2Hu2wblcvEvdbMePTt4zH/Q+fTPz3cNPHonZLyg5FvOt70V5scajdccvvrzELD
        /KClrML3nCvnWG0NnjhzwZE1XtXduyOTJ3yV6xZJt77cKfjs6+bA70t2znWWtMu/FBleffF8
        qPK9l10f7eUvChWVHOdsjbns+aly1ftbTIu3uHJZiNZxTvzk1dYpfMiFLXXB5tsRtkvCZPg+
        ut18dW3StUwxLqXp+x2Oi6cdc8xrXThbQXrz+tiAMzfF11w2cU1xWtL0as+pKXKLWRK7A2P8
        zyxXmRsck3N5C1eCSchxlv9MYf+UWIozEg21mIuKEwHKicPbrgIAAA==
X-CMS-MailID: 20210423204633eucas1p2f5178b2cb85dc63e780b81deebf0700f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210423204633eucas1p2f5178b2cb85dc63e780b81deebf0700f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210423204633eucas1p2f5178b2cb85dc63e780b81deebf0700f
References: <CGME20210423204633eucas1p2f5178b2cb85dc63e780b81deebf0700f@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform device driver name is "max8997-muic", so advertise it
properly in the modalias string. This fixes automated module loading when
this driver is compiled as a module.

Fixes: b76668ba8a77 ("Extcon: add MAX8997 extcon driver")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/extcon/extcon-max8997.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
index e1408075ef7d..633597a6081a 100644
--- a/drivers/extcon/extcon-max8997.c
+++ b/drivers/extcon/extcon-max8997.c
@@ -788,3 +788,4 @@ module_platform_driver(max8997_muic_driver);
 MODULE_DESCRIPTION("Maxim MAX8997 Extcon driver");
 MODULE_AUTHOR("Donggeun Kim <dg77.kim@samsung.com>");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:max8997-muic");
-- 
2.17.1

