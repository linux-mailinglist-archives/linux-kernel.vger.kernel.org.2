Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BAF3C9564
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 03:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhGOBD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 21:03:29 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:26478 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhGOBD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 21:03:28 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210715010034epoutp02389f3e62a4687b3b5a7278477507bbd0~R0RZNmY8n2763727637epoutp02f
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 01:00:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210715010034epoutp02389f3e62a4687b3b5a7278477507bbd0~R0RZNmY8n2763727637epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626310834;
        bh=eCkJLbUlCesVIBnOdS/rl+lgILw2qdsiEpfkvsU1IE0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=oXTSrDPeK0K0mUvygu+AqCSQiB7vYUYlHVE1DViv3mHfReX5fgqNfkdxaCyFn5N4W
         aJMft7gfEGVqHfCY8RbsJOTN120We35/u2+Uf0/aQ4PNCwkhzuO/vtKzl37XafCdyX
         19bpStZJHiIoMhTRx27a5/v5s5GHfYnZrMgsyieA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210715010028epcas1p4ae5355431a3e6298c5d1e7699780a1f1~R0RT6tSqI3143131431epcas1p4E;
        Thu, 15 Jul 2021 01:00:28 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.164]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4GQGJC6HHqz4x9Q1; Thu, 15 Jul
        2021 01:00:27 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.3B.10119.AA88FE06; Thu, 15 Jul 2021 10:00:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210715010024epcas1p20a9780de11ed702ed0b3ba0e2b494196~R0RPy_XIA0392403924epcas1p2p;
        Thu, 15 Jul 2021 01:00:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210715010024epsmtrp2cfdebfcd92702d5189fa206d9bb79f0e~R0RPyEkoI1856318563epsmtrp2D;
        Thu, 15 Jul 2021 01:00:24 +0000 (GMT)
X-AuditID: b6c32a38-97bff70000002787-64-60ef88aa1858
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.9A.08394.7A88FE06; Thu, 15 Jul 2021 10:00:23 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.101.104]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210715010023epsmtip10d87091771e5156225961f908a898a4c~R0RPjTWPo0149901499epsmtip1T;
        Thu, 15 Jul 2021 01:00:23 +0000 (GMT)
From:   JeongHyeon Lee <jhs2.lee@samsung.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        JeongHyeon Lee <jhs2.lee@samsung.com>
Subject: [PATCH] mm/vmscan: Removed useless space for intent
Date:   Thu, 15 Jul 2021 09:54:23 +0900
Message-Id: <1626310463-31705-1-git-send-email-jhs2.lee@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7bCmvu6qjvcJBh9ajS3mrF/DZnHp/h1W
        i8u75rBZ3Fvzn9WBxWPTp0nsHidm/Gbx6NuyitHj8ya5AJaoHJuM1MSU1CKF1Lzk/JTMvHRb
        Je/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoJVKCmWJOaVAoYDE4mIlfTubovzSklSF
        jPziElul1IKUnAJDgwK94sTc4tK8dL3k/FwrQwMDI1OgyoScjGnzF7MWbGSu2PGuj7mB8RZT
        FyMnh4SAicTqRT8ZQWwhgR2MErd/xXYxcgHZnxglrjU+ZoFwvjFKPH71FsjhAOu4OD8NIr6X
        UaLrwE0miO4vjBJnpiaC2GwC2hK3Wzaxg9giArISU/+eZwGxmQViJeb+62IGsYUFbCQubb/I
        CmKzCKhKrDp3jA1kPq+Ai8TTlgCI4+Qkbp7rZAbZJSEwmV3i2vUfjBAJF4l1k+azQtjCEq+O
        b2GHsKUkPr/bywbR0M0ocf/8azaIxARGid4eJogH7CXeX7IAMZkFNCXW79KHqFCU2Pl7LiPE
        mXwS7772sEJU80p0tAlBlChJrPh3jQXClpDYcLibDaLEQ+LK2zRIIMRKfF11n2kCo+wshPkL
        GBlXMYqlFhTnpqcWGxaYIEfQJkZwEtKy2ME49+0HvUOMTByMhxglOJiVRHiXGr1NEOJNSays
        Si3Kjy8qzUktPsRoCgyticxSosn5wDSYVxJvaGpkbGxsYWJmbmZqrCTOu5PtUIKQQHpiSWp2
        ampBahFMHxMHp1QDU49qnN75rmOPnQR/f8gQL+HNeeC11Lrv7ukHbPYTDE8YOJ+o9fA4db76
        zYd5JSs9ZukmH5t01k98i9sL1zKlqoLP4YvfTLcwUZ+et7BFZ9q85eZms5v7a6SrPu9NaHU8
        pTk/xUYuJmKJcHUDE3t+lNfrxy6pmacvuxlkiuYdzp1otyuw0p3Nq4pF/Oq0rc2FN/ctPFc/
        Q7wiYOn5my9zvJTUzq1NSzwmbh8UlzSTb2X0q0j/RZ0s20WjHCK6fznuefqW95We5T23Q2e4
        l1TPibXhrjw/eWJB9sIN30LnP47L6z+4fJXU2zXC6aur35346t/PMflQy26HtVM0e1gl0w72
        NV9v016WY/LiRnmnEktxRqKhFnNRcSIA95VWJ8sDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBJMWRmVeSWpSXmKPExsWy7bCSnO7yjvcJBkemWFjMWb+GzeLS/Tus
        Fpd3zWGzuLfmP6sDi8emT5PYPU7M+M3i0bdlFaPH501yASxRXDYpqTmZZalF+nYJXBnT5i9m
        LdjIXLHjXR9zA+Mtpi5GDg4JAROJi/PTuhi5OIQEdjNKrPv7lbmLkRMoLiGxYdNadogaYYnD
        h4shaj4xSvTNX8EOUsMmoC1xu2UTmC0iICsx9e95FhCbWSBeYuvi/WwgtrCAjcSl7RdZQWwW
        AVWJVeeOsYHM5BVwkXjaEgCxSk7i5rlO5gmMPAsYGVYxSqYWFOem5xYbFhjmpZbrFSfmFpfm
        pesl5+duYgQHhpbmDsbtqz7oHWJk4mA8xCjBwawkwrvU6G2CEG9KYmVValF+fFFpTmrxIUZp
        DhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUzuTpl2Yc+XHL7kcKX6UszdmUcbduVFXJ7N
        lfpvq3VBWcZpD8OQafr9J+6daTwuOXX/+9UL/abyfL3xQFJrt+38o34aeVnpzAYHv04pmh75
        70j7bJtzl3NCbiza/YlLx2YTu6eNTJ+bSYrAHoOUtAweIXUeP+XsbuUDzTKPXEV42tK49FvX
        lPKeSC/qOSrze9Id588r12+ITXqT/3bVd03Znpq8xf8O9dzucT6eMTfh89dNV3ds+MIm4OR3
        k336PfNpwU/+sjfsOL0x6VrO5I6pwQdbisU7XdI0Fl/Jeml39Bz/g+jw2YHPD9zUY9mw/qPB
        cuVE4Vi3JbZs8ZO1pV6vlwtP/HzvpefM1Yd2bAhUYinOSDTUYi4qTgQA9TwCZXsCAAA=
X-CMS-MailID: 20210715010024epcas1p20a9780de11ed702ed0b3ba0e2b494196
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210715010024epcas1p20a9780de11ed702ed0b3ba0e2b494196
References: <CGME20210715010024epcas1p20a9780de11ed702ed0b3ba0e2b494196@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: JeongHyeon Lee <jhs2.lee@samsung.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4620df6..89768ef 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4318,7 +4318,7 @@ static int __init kswapd_init(void)
 
 	swap_setup();
 	for_each_node_state(nid, N_MEMORY)
- 		kswapd_run(nid);
+		kswapd_run(nid);
 	return 0;
 }
 
-- 
2.7.4

