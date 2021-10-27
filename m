Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851EE43C134
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 06:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhJ0ESg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 00:18:36 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:46696 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhJ0ESf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 00:18:35 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20211027041608epoutp0353f33c36a933e40c77c8725b6861f7ba~xyB2EYoyU2976829768epoutp03v
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 04:16:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20211027041608epoutp0353f33c36a933e40c77c8725b6861f7ba~xyB2EYoyU2976829768epoutp03v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1635308168;
        bh=qND0lwGWyeVV7QLOM+2I7Bo6FL9swftlg2d5S7PJnqM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=QVPxLvpf9KsfCJhX3nLUYIdY90lklHtr8WnmNxQ/1wOi3br9aue3Xp+6sa1xPZAuN
         BGPa1681nHfdlyNn5txZDdYg/B3PEF8hlfboiUoS2WmLB59wUJVLrsYWki+cwkAJod
         8BmNxMMTC4Uvf4pboWPXYIfaPMgLouRA//L4kIII=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20211027041608epcas1p2a6f69e10cc6cfe70b2f14ab32a56977e~xyB10y9kW2533325333epcas1p2C;
        Wed, 27 Oct 2021 04:16:08 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.250]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4HfFjz0TxQz4x9Qd; Wed, 27 Oct
        2021 04:16:07 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.2C.09592.682D8716; Wed, 27 Oct 2021 13:16:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20211027041606epcas1p237acb5e258066f2298f3fee162baffe4~xyB0H6QHN2534425344epcas1p2z;
        Wed, 27 Oct 2021 04:16:06 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211027041606epsmtrp21f21eb3c9b89e918a67b1fcb57c404e3~xyB0HBcjY0120501205epsmtrp2C;
        Wed, 27 Oct 2021 04:16:06 +0000 (GMT)
X-AuditID: b6c32a39-3bdff70000002578-ab-6178d28611c2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.EC.08738.682D8716; Wed, 27 Oct 2021 13:16:06 +0900 (KST)
Received: from hj514.kim-office (unknown [10.253.100.146]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211027041606epsmtip11924605529c1d4e2dd45ee3c7a0489e7~xyBz7I9rA0459204592epsmtip1X;
        Wed, 27 Oct 2021 04:16:06 +0000 (GMT)
From:   Hyeong-Jun Kim <hj514.kim@samsung.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Hyeong-Jun Kim <hj514.kim@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] f2fs: compress: disallow disabling compress on non-empty
 compressed file
Date:   Wed, 27 Oct 2021 13:16:00 +0900
Message-Id: <20211027041600.115847-1-hj514.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmrm7bpYpEg+f3LCxOTz3LZDG94yCb
        xZP1s5gtLi1yt7i8aw6bxZZ/R1gd2Dw2repk89i94DOTR9+WVYwenzfJBbBEZdtkpCampBYp
        pOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAO1WUihLzCkFCgUkFhcr
        6dvZFOWXlqQqZOQXl9gqpRak5BSYFegVJ+YWl+al6+WlllgZGhgYmQIVJmRn3F15l7XgHEdF
        23SdBsZZ7F2MnBwSAiYSz1ZvZupi5OIQEtjBKNH37gmU84lR4njHPjYI5zOjxL3z24AcDrCW
        xqZYiPguRokdx19AdbxnlGhe9IkZZC6bgI7Eh1krGUFsEQF7ic/fr7OA2MwCsxkl7h/NBbGF
        BeIkWh9fYAWxWQRUJW5/+QHWyytgLdH0aDMzxH3yEjMvfWeHiAtKnJz5BGqOvETz1tnMIIsl
        BHaxS3w5fpYFosFF4vWGDVC2sMSr41ugHpWS+PxuLxuEXS9x/MonVojmFkaJx0tfMUK8Zi/x
        /pIFiMksoCmxfpc+RLmixM7fcxkh9vJJvPvawwpRzSvR0SYEUaIssfnuYajpkhJPF/1lhLA9
        JM4/ugN2gZBArMSS/nnsExjlZyH5ZhaSb2YhLF7AyLyKUSy1oDg3PbXYsMAUHqfJ+bmbGMGp
        T8tyB+P0tx/0DjEycTAeYpTgYFYS4b08rzxRiDclsbIqtSg/vqg0J7X4EKMpMHwnMkuJJucD
        k29eSbyhiaWBiZmRiYWxpbGZkjjvF7nCRCGB9MSS1OzU1ILUIpg+Jg5OqQYmAUN5gYORIXJv
        lqWINjVPFlpfExGqc+Faj1fmjagp3FuVo9Y2ryg0Of/24+bDJg+cz/n03N/SrTnbk3XP6cp1
        z30W3JywU3Hzo6z9G5e9+smV13n7scTqQv6ki4UMOqJ6D9+sXrOmO/nvW8/vho8iZDhmfMk+
        OzXrHENVVc5BwTkr2JZaWXxpy+i/kf1jU9CNxy0ZZy4/0zfcxGpx82XBXd34FQoLExWzb5/W
        4OldMZvRenfPGrP3H8VbRRJKty501rv1y/3ZtxVv3DnqorZvCWkInfNdb8Wimp3/7k2RWHjT
        dp3hzqeM8eutm7aduTLnza6F2+J5fx/+KZt96c2NaOZmLvG7AYV771btiu3c8EuJpTgj0VCL
        uag4EQBwNecfBgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrILMWRmVeSWpSXmKPExsWy7bCSnG7bpYpEg5dr1C1OTz3LZDG94yCb
        xZP1s5gtLi1yt7i8aw6bxZZ/R1gd2Dw2repk89i94DOTR9+WVYwenzfJBbBEcdmkpOZklqUW
        6dslcGXcXXmXteAcR0XbdJ0GxlnsXYwcHBICJhKNTbFdjFwcQgI7GCX+rOhghIhLSsxbXw5h
        CkscPlwMUfKWUeLkwp1AJZwcbAI6Eh9mrQSzRQQcJX69XsQKUsQsMJdR4mJ3EytIQlggRmLm
        0VdgRSwCqhK3v/xgBrF5Bawlmh5tBrMlBOQlZl76zg4RF5Q4OfMJC4jNDBRv3jqbeQIj3ywk
        qVlIUgsYmVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgSHopbWDsY9qz7oHWJk4mA8
        xCjBwawkwnt5XnmiEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJM
        HJxSDUzpB4rClq1bde9insx66wtcNh9k4z4+4ZLa8X7ejT98uoGlDNtZH2y3+BPi2bPyyI9g
        3uD31/LU1q5bw3Rso8gz8YUHt1T3WKXks3ELmJd6fYoVLzq4yJ/tglvR0Vvt6+JvF4tvlZLZ
        Xfi93nEB96sKB+OIbs7ygu/skhwpOn+05s71zX39T8Q/k1F71dG1B4qZJsqe3TyhYr2V/3qX
        gOPL+J6VCR/iMDR82vIzg0kg4tz70kdMEladMfUfvp39y2ngybhkDffLbX3HPxifuFfDEtGd
        2DjvewHrcbG2tMD+G1/cFznkFXVMEJNernswMD72WhjPSQ7+b92r74X7/Wc3l1pc3b/M8beM
        SX5ztRJLcUaioRZzUXEiAMF3vd60AgAA
X-CMS-MailID: 20211027041606epcas1p237acb5e258066f2298f3fee162baffe4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211027041606epcas1p237acb5e258066f2298f3fee162baffe4
References: <CGME20211027041606epcas1p237acb5e258066f2298f3fee162baffe4@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compresse file and normal file has differ in i_addr addressing,
specifically addrs per inode/block. So, we will face data loss, if we
disable the compression flag on non-empty files. Therefore we should
disallow not only enabling but disabling the compression flag on
non-empty files.

---
v2:
 - check F2FS_HAS_BLOCKS() instead of i_size

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Hyeong-Jun Kim <hj514.kim@samsung.com>
---
 fs/f2fs/f2fs.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b8e8f8c716b0..23b437dc7d65 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4177,8 +4177,7 @@ static inline bool f2fs_disable_compressed_file(struct inode *inode)
 
 	if (!f2fs_compressed_file(inode))
 		return true;
-	if (S_ISREG(inode->i_mode) &&
-		(get_dirty_pages(inode) || atomic_read(&fi->i_compr_blocks)))
+	if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
 		return false;
 
 	fi->i_flags &= ~F2FS_COMPR_FL;
-- 
2.25.1

