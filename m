Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C055377EBC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 10:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhEJIzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 04:55:37 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:47373 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhEJIzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 04:55:32 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210510085425epoutp038adc91dd5446847ebd5b1f2ddd98f5e0~9qKRomMXQ0497504975epoutp03V
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 08:54:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210510085425epoutp038adc91dd5446847ebd5b1f2ddd98f5e0~9qKRomMXQ0497504975epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1620636865;
        bh=SUBr2y/PBEiI0e8ZSr77t9QwUjZM22om9idUT5ta3TI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=nR0xWC9Eaf4HOXD7tLBolf2soRDuCCnEGh3iN6dXwSGnVwyoV13DhAJBQHxt+FDS/
         Daliy/HV45tkxsdu1Pz/2qD/p7xaUIYeSjrfVO/3S0d+piqAO7JrqOZUWc0AwGJGrj
         UBWsA4r36i8eQHPYHEDCKUDoyu25kST9t8T+M/kg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210510085424epcas1p1a4340aebbe43ec69dd01fb663abbd399~9qKRYP6A31254212542epcas1p1C;
        Mon, 10 May 2021 08:54:24 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4FdvxW0NWHz4x9QB; Mon, 10 May
        2021 08:54:23 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A2.9C.09578.BB4F8906; Mon, 10 May 2021 17:54:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210510085419epcas1p1e16c3966fc1b7b9f28a797eaa588f3ba~9qKMEOlOX1251812518epcas1p1N;
        Mon, 10 May 2021 08:54:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210510085419epsmtrp178c2f5efc4a11bdcb494d79894b718e0~9qKMDViMF2318023180epsmtrp1L;
        Mon, 10 May 2021 08:54:19 +0000 (GMT)
X-AuditID: b6c32a35-fb9ff7000000256a-c2-6098f4bb01eb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.29.08163.AB4F8906; Mon, 10 May 2021 17:54:18 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.223]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210510085418epsmtip18770a669ad2a5bb2224ff185cb11b0a7~9qKL4jwOY0042400424epsmtip1f;
        Mon, 10 May 2021 08:54:18 +0000 (GMT)
From:   Seung-Woo Kim <sw0312.kim@samsung.com>
To:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, chao@kernel.org,
        sw0312.kim@samsung.com
Subject: [PATCH 1/2] fsck.f2fs: fix memory leak caused by
 fsck_chk_orphan_node()
Date:   Mon, 10 May 2021 17:57:25 +0900
Message-Id: <20210510085726.12663-1-sw0312.kim@samsung.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsWy7bCmnu7uLzMSDF5+ULc4PfUsk8WT9bOY
        LS4tcre4vGsOm8WMyS/ZHFg9Nq3qZPPYveAzk0ffllWMHp83yQWwRGXbZKQmpqQWKaTmJeen
        ZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gCtVVIoS8wpBQoFJBYXK+nb2RTl
        l5akKmTkF5fYKqUWpOQUWBboFSfmFpfmpesl5+daGRoYGJkCFSZkZ+w/XF4wi61iyrK/rA2M
        b1i6GDk4JARMJA4dz+9i5OIQEtjBKHH+11YmCOcTo8T/bZ/YIZzPjBI/P/1m7mLkBOuYOOEn
        C0RiF6PEi+232UESQgJfGCWOrisBsdkEdCT2L/nNCmKLCNhJzLhwjA1kHbOAp8SCSREgYWGB
        IImrU/Ywg4RZBFQljtxUBTF5BawlFqxQh9gkL3Fhwy2wIbwCghInZz5hAbGZgeLNW2czg1wg
        IbCNXWL6zp2MEA0uEjNu7WKHsIUlXh3fAmVLSbzsb2OHaGhmlFi65BcLhNPDKDFn0W1WiCpj
        if1LJzNB3KkpsX6XPkRYUWLn77mMEJv5JN597WGFhByvREebEESJisTOo5PYIMJSErM2BEOE
        PSTaz05jBAkLCcRK3DkmPIFRfhaSb2Yh+WYWwtoFjMyrGMVSC4pz01OLDQsMkeNzEyM40WmZ
        7mCc+PaD3iFGJg7GQ4wSHMxKIryiHdMShHhTEiurUovy44tKc1KLDzGaAkN3IrOUaHI+MNXm
        lcQbmhoZGxtbmBiamRoaKonzpjtXJwgJpCeWpGanphakFsH0MXFwSjUw1ZZ8uiE9Z8/H3p86
        i2Uerrv15r3/0bMP5Hnv8iRd3mORq8v8ZcGxhWpbF+5f1ujmeLGR1+9OzYmPN6aGV31SfDFh
        6qmAst1PGW55PLbzjtd+UWXWV3LmndojsTcMFrXbtv6Mua2741TcpFu1JXWPOmbXx1iyBi51
        W/Q2pt/0xQHVXXKeZ2I4XP/4rV3sZfT1+s05NxIeXfjrOPNtU84xzbONN7ad/3TjArdOpqbO
        Dqu6luaZOhqWU7s61zq83h18rPLEjmMOJqZdQvHMAkZdHavuPVyk+rTBfkrdJZM9O/dZBobM
        XSwgrlI4t3xDYeNptu7ba0yOeau9iY/78Iy5MvvHK5vULfLOBlflOGftWKrEUpyRaKjFXFSc
        CADJRsgU/QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsWy7bCSnO6uLzMSDC51WVucnnqWyeLJ+lnM
        FpcWuVtc3jWHzWLG5JdsDqwem1Z1snnsXvCZyaNvyypGj8+b5AJYorhsUlJzMstSi/TtErgy
        9h8uL5jFVjFl2V/WBsY3LF2MnBwSAiYSEyf8BLK5OIQEdjBKXPv+lhkiISUx99t2xi5GDiBb
        WOLw4WKImk+MEge/rgCrYRPQkdi/5DcriC0i4CCxYtsWsKHMAr4S056uZAOxhQUCJF7dusAM
        ModFQFXiyE1VEJNXwFpiwQp1iE3yEhc23AKbwisgKHFy5hOoKfISzVtnM09g5JuFJDULSWoB
        I9MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzg8NPS2sG4Z9UHvUOMTByMhxglOJiV
        RHhFO6YlCPGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cAk
        xtoa1PHj361Jh67e/Oj4wDvybDtTIzePysdiqbRXQpsOH/GYpnHrfIKGpas2k2pv5ucmE6ml
        js6XVmdG9c+86nN7Hst779PhN1l6bNkWz75ydlnDvCPsNs2Rq7eayziInTyvxrox6+Cit4Hn
        3x9hrovdfiUmM+vWs798n7K5Eh/XORrdv/olKnNL0gq+w6Yd01vEuUM7mla+Nujos9h1WIur
        0r7uVNGce8+2qv5cdeLcuvYfWjOKy/ZPiLcPOZlukc7mESPDdsn1m97Ee1IeW7LSEtZfaZZY
        sGnyE23H6v+9lpsbVU7pzW285zr5eMYnLrG//qd8uwSkbmYHZQtOk37Nwv1zx31biZZ9vxKU
        WIozEg21mIuKEwEo6UxyrgIAAA==
X-CMS-MailID: 20210510085419epcas1p1e16c3966fc1b7b9f28a797eaa588f3ba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210510085419epcas1p1e16c3966fc1b7b9f28a797eaa588f3ba
References: <CGME20210510085419epcas1p1e16c3966fc1b7b9f28a797eaa588f3ba@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With invalid node info from fsck_chk_orphan_node(), orphan_blk
and new_blk are not freed. Fix memory leak in the path.

Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
 fsck/fsck.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index e52672032d2c..6019775dcb2d 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1780,8 +1780,11 @@ int fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 			if (c.preen_mode == PREEN_MODE_1 && !c.fix_on) {
 				get_node_info(sbi, ino, &ni);
 				if (!IS_VALID_NID(sbi, ino) ||
-						!IS_VALID_BLK_ADDR(sbi, ni.blk_addr))
+				    !IS_VALID_BLK_ADDR(sbi, ni.blk_addr)) {
+					free(orphan_blk);
+					free(new_blk);
 					return -EINVAL;
+				}
 
 				continue;
 			}
-- 
2.19.2

