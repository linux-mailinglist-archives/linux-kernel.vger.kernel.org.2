Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8AB41A907
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 08:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbhI1GlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 02:41:14 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:11933 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238893AbhI1GlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 02:41:06 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210928063921epoutp033996eb9f34f3b5265baa777df365e1d5~o6Rm8NzWr1462914629epoutp03I
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:39:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210928063921epoutp033996eb9f34f3b5265baa777df365e1d5~o6Rm8NzWr1462914629epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1632811161;
        bh=ec/cnE/B9m6a4wLi6h6bXa6hyK8Qh1NGtayht6ko26w=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=gN/LUOrgBTiW7tX+8rt6gSfEQoLYRqhdV7c7iY5ikDWU1njg4XYtZoylFQNh/7g6o
         q/e449o+28LmltBGKd+GbIZth+BHJzNo34Qk7ryYtl9nvTnayMoerLxrxotV92Kttq
         /IacTTxKnx7e7LyOTOC86upY+pkJfgwKglpYQy8c=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20210928063920epcas2p327a44b24703f1c1d4a19595e55d55174~o6RmL42BB0294202942epcas2p3j;
        Tue, 28 Sep 2021 06:39:20 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.188]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4HJVGb5k5Bz4x9QY; Tue, 28 Sep
        2021 06:39:19 +0000 (GMT)
X-AuditID: b6c32a46-63bff70000002658-c9-6152b8976e4e
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.BF.09816.798B2516; Tue, 28 Sep 2021 15:39:19 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] block-map: added error handling for bio_copy_kern()
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210928063919epcms2p12ef0dfc94e6756f7bf85945522720e8f@epcms2p1>
Date:   Tue, 28 Sep 2021 15:39:19 +0900
X-CMS-MailID: 20210928063919epcms2p12ef0dfc94e6756f7bf85945522720e8f
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmue70HUGJBs8WiVisvtvPZvHykKZF
        b/9WNou9t7QtLu+aw+bA6nH5bKlH35ZVjB6fN8kFMEfl2GSkJqakFimk5iXnp2TmpdsqeQfH
        O8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA7VNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX
        2CqlFqTkFBgaFugVJ+YWl+al6yXn51oZGhgYmQJVJuRk3Jt1g63gOl/Fpme5DYyXuLoYOTgk
        BEwktryo7WLk4hAS2MEosWJ/KytInFdAUOLvDmEQU1jARWJDY14XIydQiZLEuTWzGCHCBhK3
        es1BwmwCehI/l8xgA5kiIrCcUeLw+puMIAkJAV6JGe1PWSBsaYnty7dCxTUkfizrZYawRSVu
        rn7LDmO/PzYfqkZEovXeWagaQYkHP3dDxSUlGidMg5pZLnF1+RwWkMUSAh2MEpeX3IRK6Etc
        69gIZvMK+EpsenKNFcRmEVCVOPL6PhNEjYvE5lm7wBYwC8hLbH87hxnkMWYBTYn1u/QhoaMs
        ceQWC8wrDRt/s6OzmQX4JDoO/4WL75j3hAmiVU1iUZMRRFhG4uvh+VAlHhILv31gmcCoOAsR
        zLOQnDAL4YQFjMyrGMVSC4pz01OLjQqMkON1EyM42Wm57WCc8vaD3iFGJg7GQ4wSHMxKIrzB
        LP6JQrwpiZVVqUX58UWlOanFhxhNgZ6fyCwlmpwPTLd5JfGGpkZmZgaWphamZkYWSuK8c/85
        JQoJpCeWpGanphakFsH0MXFwSjUw8ba5KhVMZFaJiyhqWxnimPxqd2rhnC/eD48wc0g8m8i+
        t/yljsXb7oeHNZf3Gq/iP3uu2Ujz3b4UXWuXLe7B+/9sKE7fErFu3/JpFuGPwts2sr1N/xhe
        3Rr0QO9WsMK/w9J14V/jX3VzskpNfeAqknpqS+ncuw6nfOSe/5Fp+RN6z9p5XteGa03hXxsl
        xA7PlbRVtWc2uLjmUnLxT9mUDE/XGZ/Fls4++pnTxK1XW9LC9iLP7a0bf3+wsDrq+7xuzvmk
        3DIWjTNfttrKOHQeD+o+MfNRs1as2bS10rudm+dxSP765zP/XWWU7DWrhKVLO7NfFIVdEIlW
        POOhpDrR+crDvPN606cuWedztUFdiaU4I9FQi7moOBEAmXP1EP8DAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210928063420epcms2p8f0cad25e1b820169755962ff4555d3ac
References: <CGME20210928063420epcms2p8f0cad25e1b820169755962ff4555d3ac@epcms2p1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When new pages are allocated to bio through alloc_page() in
bio_copy_kern(), the pages must be freed in error handling after that.

There is little chance of an error occurring in blk_rq_append_bio(), but
in the code flow, pages additionally allocated to bio must be released.

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 block/blk-map.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 4526adde0156..584369a7837f 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -628,6 +628,7 @@ int blk_rq_map_kern(struct request_queue *q, struct request *rq, void *kbuf,
        int reading = rq_data_dir(rq) == READ;
        unsigned long addr = (unsigned long) kbuf;
        struct bio *bio;
+       int do_copy = 0;
        int ret;

        if (len > (queue_max_hw_sectors(q) << 9))
@@ -635,8 +636,9 @@ int blk_rq_map_kern(struct request_queue *q, struct request *rq, void *kbuf,
        if (!len || !kbuf)
                return -EINVAL;

-       if (!blk_rq_aligned(q, addr, len) || object_is_on_stack(kbuf) ||
-           blk_queue_may_bounce(q))
+       do_copy = !blk_rq_aligned(q, addr, len) || object_is_on_stack(kbuf) ||
+               blk_queue_may_bounce(q);
+       if (do_copy)
                bio = bio_copy_kern(q, kbuf, len, gfp_mask, reading);
        else
                bio = bio_map_kern(q, kbuf, len, gfp_mask);
@@ -648,8 +650,11 @@ int blk_rq_map_kern(struct request_queue *q, struct request *rq, void *kbuf,
        bio->bi_opf |= req_op(rq);

        ret = blk_rq_append_bio(rq, bio);
-       if (unlikely(ret))
+       if (unlikely(ret)) {
+               if (do_copy)
+                       bio_free_pages(bio);
                bio_put(bio);
+       }
        return ret;
 }
 EXPORT_SYMBOL(blk_rq_map_kern);
--
2.25.1
