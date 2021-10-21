Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC846435B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 09:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhJUHZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 03:25:28 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:45704 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhJUHZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 03:25:26 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20211021072309epoutp029bb8feb4f654b4e968602dd521ef7901~v_taYoTNM1696716967epoutp02X
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 07:23:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20211021072309epoutp029bb8feb4f654b4e968602dd521ef7901~v_taYoTNM1696716967epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1634800989;
        bh=fQMeki86KGgZxK/qJExZiPJv1LoaTJCLXDgYtva1RNg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=uMIktenRWIK2RpMQ0Yvv2ralUZxMJtzyDgomhRKOKosdJURz9DYEA18blmi7egIwD
         tQr68eAotrApzI23CZs7UWcs4BVzoa0UN2GbMptsmKWTICEb4oUboVUSkIJqfCn7VR
         Cy5qIBULh1X1hU/VCs2Ayxfyas1k1IFfMovUwC1o=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20211021072308epcas1p439244ecb82abfd5f0f72024a65905915~v_tZ-EQwI2922329223epcas1p4l;
        Thu, 21 Oct 2021 07:23:08 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.249]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4HZf8W5ZyWz4x9Qk; Thu, 21 Oct
        2021 07:23:07 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.B2.10331.B5511716; Thu, 21 Oct 2021 16:23:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20211021072307epcas1p4aa4388c13e71a66e3e1d5f7ee68b5a7f~v_tYgW0693205132051epcas1p41;
        Thu, 21 Oct 2021 07:23:07 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211021072307epsmtrp28133e4a038bf03176ef2e39e9d66eaeb~v_tYfoxIB1112511125epsmtrp2j;
        Thu, 21 Oct 2021 07:23:07 +0000 (GMT)
X-AuditID: b6c32a38-c99ff7000000285b-a5-6171155b5130
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.83.08738.B5511716; Thu, 21 Oct 2021 16:23:07 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.109]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211021072307epsmtip29a0f90c92a2cdc3739c81af80d877f60~v_tYS7EwQ2251622516epsmtip23;
        Thu, 21 Oct 2021 07:23:07 +0000 (GMT)
From:   Manjong Lee <mj0123.lee@samsung.com>
To:     mj0123.lee@samsung.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        nanich.lee@samsung.com, yt0928.kim@samsung.com,
        junho89.kim@samsung.com, jisoo2146.oh@samsung.com
Subject: [PATCH 1/1] mm: bdi: Initialize bdi_min_ratio when bdi unregister
Date:   Fri, 22 Oct 2021 01:19:43 +0900
Message-Id: <20211021161942.5983-1-mj0123.lee@samsung.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTVzdatDDRYGKnmsWc9WvYLHqeNLFa
        fH1YbHF51xw2i3tr/rNaTN88h9ni2v0z7BbnTn5itZj32MFi/d6fbA5cHps+TWL3ODHjN4tH
        35ZVjB6fN8kFsERl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4
        BOi6ZeYAnaOkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAr0CtOzC0uzUvXy0st
        sTI0MDAyBSpMyM64NuU3e8FLjopjsxYzNTDOYe9i5OSQEDCRmLf9LJDNxSEksINRYvnymWwg
        CSGBT4wS+w4JQiQ+M0r8WrSYEabjw4e/zBCJXYwS0+YfZ4erWjl1PgtIFZuAlsTyZxfAdogI
        ZErMaXvPAlLELDCfUWLGl31MIAlhAS+J7pf/wcayCKhK9G+4wAxi8wpYSfT96WWDWCcvcWrZ
        QSaIuKDEyZlPwBYwA8Wbt84GO0NC4Ba7xNGFF6Duc5FYMv8MK4QtLPHq+BaoT6UkPr/bywbR
        0M0o0bnnAFR3D9BJP7qhqowlPn3+DDSJA2iFpsT6XfoQYUWJnb/nMkJs5pN497WHFaREQoBX
        oqNNCKJERWJ38ze4XW9eHYC6x0Oi8fUJVkigxkpcvPaNZQKj/Cwk/8xC8s8shMULGJlXMYql
        FhTnpqcWGxaYwOM1OT93EyM4UWpZ7GCc+/aD3iFGJg7GQ4wSHMxKIry7K/IThXhTEiurUovy
        44tKc1KLDzGaAkN4IrOUaHI+MFXnlcQbmlgamJgZmVgYWxqbKYnzSopmJwoJpCeWpGanphak
        FsH0MXFwSjUwJRfE9HZcff+up/uU0rHSGcvTCrzTS75LBIss8Xy8d2vG6bAYmfal9/2Yp+Xv
        EZr0zzje/9mEv0HeCw/4O/X2P+GTe2IcJ3am/vFruX//K7Lfz+RY1r1H+puQ15f4uaZ+kQ+e
        /OUvtZxm1jnp3alAH57QA98msK0+piXS/pOj2zG74G76unfv50++H7nI/2aDW65LVecfsVk7
        Ih+sntm4cUfnQ3/jDa/twzR+Bt1RPp3mtu7QAq4GL7eKe59ub1y5xqgrZu+9LRvrDO4XNO8w
        sGNttzq1JO6skDZf5jITWwcZ8yx2tddr+9QFXpyMdzNbtWuy7b7dbafDHfkqfbNrp0mrB3O/
        n+/44sDLB/J8SizFGYmGWsxFxYkABBY9cR0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWy7bCSvG60aGGiwfmJAhZz1q9hs+h50sRq
        8fVhscXlXXPYLO6t+c9qMX3zHGaLa/fPsFucO/mJ1WLeYweL9Xt/sjlweWz6NInd48SM3ywe
        fVtWMXp83iQXwBLFZZOSmpNZllqkb5fAlXFtym/2gpccFcdmLWZqYJzD3sXIySEhYCLx4cNf
        5i5GLg4hgR2MEmtvXmGGSEhJzFvbwNbFyAFkC0scPlwMUfORUeLu7rdMIDVsAloSy59dABsk
        IpArcXnLHbBBzAJLGSUedhxjBEkIC3hJdL/8D2azCKhK9G+4ALaAV8BKou9PLxvEMnmJU8sO
        MkHEBSVOznzCAmIzA8Wbt85mnsDINwtJahaS1AJGplWMkqkFxbnpucWGBUZ5qeV6xYm5xaV5
        6XrJ+bmbGMFhq6W1g3HPqg96hxiZOBgPMUpwMCuJ8O6uyE8U4k1JrKxKLcqPLyrNSS0+xCjN
        waIkznuh62S8kEB6YklqdmpqQWoRTJaJg1Oqgans7xWmaW9Psmgfu/416czazJXdt6bJrpJd
        ZtMiZn1/3ruN4qb/H5oJPGFJ0lgvqRews59feY9K43rFq6kMbm+MtTy3VilMiTI4yHvg6SFv
        QYXS0vnOWq+qem84sC5NeT095+xx7pn5q/z0ljwVzrB9r2d1eNL3FwyBnQe+MqRO+cETujFK
        +EuQmm7MscOygsk6wRO+qN11rbL2Xi/dlFBuGlZVEf8rbPmzbw9/PtY3SuQs33Vrn5e0SW8N
        L5Pvmac8k/XWaDUyPtt4Mv6x6A2XIvHu0/e6k8/l+R6LDDaTPy6tcO7QCifN2d9mxBVcOiYs
        PH2+yE2byu2rrs9alC7De/tQq+ur7TH/PeRzM5VYijMSDbWYi4oTAdYA1czKAgAA
X-CMS-MailID: 20211021072307epcas1p4aa4388c13e71a66e3e1d5f7ee68b5a7f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211021072307epcas1p4aa4388c13e71a66e3e1d5f7ee68b5a7f
References: <CGME20211021072307epcas1p4aa4388c13e71a66e3e1d5f7ee68b5a7f@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize min_ratio if it is set when bdi unregister.
It can prevent problems that may occur when bdi is removed
without resetting min_ratio.

For example.
1) insert external sdcard
2) set external sdcard's min_ratio 70
3) remove external sdcard without setting min_ratio 0
4) insert external sdcard
5) set external sdcard's min_ratio 70 << error occur(can't set)

Because when sdcard is removed, bdi_min_ratio value will remain.
Currently, the only way to reset bdi_ min_ratio is to reboot.

Signed-off-by: Manjong Lee <mj0123.lee@samsung.com>
---
 mm/backing-dev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 4a9d4e27d0d9..ca53807be188 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -947,6 +947,11 @@ void bdi_unregister(struct backing_dev_info *bdi)
 	wb_shutdown(&bdi->wb);
 	cgwb_bdi_unregister(bdi);
 
+	/* if min ratio doesn't 0, it has to set 0 before unregister */
+	if (bdi->min_ratio) {
+		bdi_set_min_ratio(bdi, 0);
+	}
+
 	if (bdi->dev) {
 		bdi_debug_unregister(bdi);
 		device_unregister(bdi->dev);
-- 
2.32.0

