Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6754415A3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 09:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhKAItZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 04:49:25 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:57653 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbhKAItX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 04:49:23 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20211101084649epoutp04c694ab14c5dce46dbab4609e9d8ff272~zX8mWWIb22176321763epoutp04z
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 08:46:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20211101084649epoutp04c694ab14c5dce46dbab4609e9d8ff272~zX8mWWIb22176321763epoutp04z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1635756409;
        bh=bdya/LNiHH3cxRpV+RNMvRlowDULOWYeV+ASgeloXUQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=rnY8iR+41J6GNgg5hmiSP4RPkKtluCpJC7kV3FE0l7eoLCWQjBZeL0+E0rAPl+Tkr
         xRiLtnFeEwOZvtcN2s+m2i+4FWaCnsgQlF6QancvkdlUUfOzt4PQLI9W7nLflaebhx
         pxC4Wa93Rxl0p1td3249pLPO/YlPuO056JbcNpj4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20211101084648epcas1p3b4a0a0cc8c1cfcb676b384792f497ee7~zX8mBySbv0588505885epcas1p3I;
        Mon,  1 Nov 2021 08:46:48 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.247]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4HjRTy1kLYz4x9QL; Mon,  1 Nov
        2021 08:46:46 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.91.09592.D69AF716; Mon,  1 Nov 2021 17:46:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20211101084637epcas1p3a17850a8a437488649be9b41ffa889e2~zX8buobY_0425904259epcas1p3R;
        Mon,  1 Nov 2021 08:46:37 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211101084637epsmtrp27b6db15a05fc60c50294d8570f0827ba~zX8bt-v-F1584715847epsmtrp2b;
        Mon,  1 Nov 2021 08:46:37 +0000 (GMT)
X-AuditID: b6c32a37-2a5ff70000002578-33-617fa96de50d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.1B.08738.D69AF716; Mon,  1 Nov 2021 17:46:37 +0900 (KST)
Received: from hj514.kim-office (unknown [10.253.100.146]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211101084637epsmtip1cbf07b9dacf91e2191cce27b0ee00bb2~zX8bhzYK90966409664epsmtip1X;
        Mon,  1 Nov 2021 08:46:37 +0000 (GMT)
From:   Hyeong-Jun Kim <hj514.kim@samsung.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Hyeong-Jun Kim <hj514.kim@samsung.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] F2FS: invalidate META_MAPPING before IPU/DIO write
Date:   Mon,  1 Nov 2021 17:46:34 +0900
Message-Id: <20211101084634.38727-1-hj514.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmvm7eyvpEgzfFFqennmWymN5xkM3i
        yfpZzBaXFrlbXN41h82B1WPTqk42j90LPjN59G1ZxejxeZNcAEtUtk1GamJKapFCal5yfkpm
        XrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0FYlhbLEnFKgUEBicbGSvp1NUX5p
        SapCRn5xia1SakFKToFZgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnZGz770gqdCFS0t2g2MrXxd
        jJwcEgImEr/2L2fpYuTiEBLYwSixanY/I4TziVHiwr6VzCBVQgKfGSV695TBdMxruscKUbSL
        UWL1sSVsEM57RokpDc/YQKrYBHQkPsxayQhiiwjYS3z+fp0FxGYWKJLY2X+OHcQWFnCTOHHt
        KZjNIqAqceP+bbBeXgEriTsPO5kgtslLzLz0nR0iLihxcuYTqDnyEs1bZzODLJYQ2MQusf/j
        XzaIBheJWV9XsULYwhKvjm9hh7ClJD6/2wtVUy9x/MonVojmFkaJx0tfAV3KAeTYS7y/ZAFi
        MgtoSqzfpQ9Rriix8/dcRoi9fBLvvvawQlTzSnS0CUGUKEtsvnsYarqkxNNFfxkhbA+JJZdv
        skECMVbi+LedbBMY5Wch+WYWkm9mISxewMi8ilEstaA4Nz212LDAGB6lyfm5mxjByU7LfAfj
        tLcf9A4xMnEwHmKU4GBWEuGNuFCTKMSbklhZlVqUH19UmpNafIjRFBi+E5mlRJPzgek2ryTe
        0MTSwMTMyMTC2NLYTEmc97NcYaKQQHpiSWp2ampBahFMHxMHp1QDE/d0M7MPQUbfnU49WvI9
        nsf6QfWbZVse28paJm9xWyXd6mBUJb1ZXERuU+WsNCV1/+MKDhaXH+rPvy1ummIZf2EPg4vS
        j7dPpZ4VHMoRDhPdJK/yOKHmrTNHW2bL5vd77DZftZ29e8d39ptuoZufJ6R+1xB+N+fQ0vBt
        D1dxZfepymytzpow8cbGjzvOz5gqMu3nzu7gJx1HJNlX+e0zjPyZMiX5auCCXAaG/lVW0R+Y
        nrc33bfylagUZno0zzLEMSthrVnJ0cKT3Ws3+Z3KZPRb2OnaVDv52t9vpXmhEq9eHY1/x1lo
        FTT9x+GXQhn6E8WTzp7SnrY+gG9f3ja7WtH493zZfoUJ+34IeU7PUWIpzkg01GIuKk4EAAIo
        Jt//AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsWy7bCSnG7uyvpEg+5ORYvTU88yWUzvOMhm
        8WT9LGaLS4vcLS7vmsPmwOqxaVUnm8fuBZ+ZPPq2rGL0+LxJLoAlissmJTUnsyy1SN8ugSuj
        Z196wVOhipYW7QbGVr4uRk4OCQETiXlN91i7GLk4hAR2MEos+vOQvYuRAyghKTFvfTmEKSxx
        +HAxRMlbRomtK+ewgfSyCehIfJi1khHEFhFwlPj1ehEriM0sUCKxedMLdhBbWMBN4sS1p2A2
        i4CqxI37t8F6eQWsJO487GSCuEFeYual7+wQcUGJkzOfsEDMkZdo3jqbeQIj3ywkqVlIUgsY
        mVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgSHn5bWDsY9qz7oHWJk4mA8xCjBwawk
        whtxoSZRiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBiaz
        3KOek+bt0PDkDXll6Rle7nTKLnaCdN+5kNXtU9Z6tyi21u3yOGn8fOdc11PRaauEtpddT36Q
        lhPaE383UbxI8IRbUdk6SR7DbXVlHytffXPflv/R6+/l/Z8iJ81+pKLLqX5PkJ0lrvhdlPum
        3DdKDlO0HMy+C5rZrWS8UpKj+Isls3ilsfPltJTFxYqFEicNUi5/qNbq3+H6efuDx5PD2Rc9
        Oxdjvv1DkGKgq8L7whmrfTboiHxo9l6w8W1g5tEiFrOOWe69jAEPt/NzKjYtf5KW05XZISvM
        /YzrZYjs9AeZIT85BGc+EKxQ9Pyx+0/cxeZNKbs/TK7ZqFte+P7Z+1vrDvn8N50S4OrGq8RS
        nJFoqMVcVJwIAEtXLgyuAgAA
X-CMS-MailID: 20211101084637epcas1p3a17850a8a437488649be9b41ffa889e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211101084637epcas1p3a17850a8a437488649be9b41ffa889e2
References: <CGME20211101084637epcas1p3a17850a8a437488649be9b41ffa889e2@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Encrypted pages during GC are read and cached in META_MAPPING.
However, due to cached pages in META_MAPPING, there is an issue where
newly written pages are lost by IPU or DIO writes.

Thread A - f2fs_gc()            Thread B
/* phase 3 */
down_write(i_gc_rwsem)
ra_data_block()       ---- (a)
up_write(i_gc_rwsem)
                                f2fs_direct_IO() :
                                 - down_read(i_gc_rwsem)
                                 - __blockdev_direct_io()
                                 - get_data_block_dio_write()
                                 - f2fs_dio_submit_bio()  ---- (b)
                                 - up_read(i_gc_rwsem)
/* phase 4 */
down_write(i_gc_rwsem)
move_data_block()     ---- (c)
up_write(i_gc_rwsem)

(a) In phase 3 of f2fs_gc(), up-to-date page is read from storage and
    cached in META_MAPPING.
(b) In thread B, writing new data by IPU or DIO write on same blkaddr as
    read in (a). cached page in META_MAPPING become out-dated.
(c) In phase 4 of f2fs_gc(), out-dated page in META_MAPPING is copied to
    new blkaddr. In conclusion, the newly written data in (b) is lost.

To address this issue, invalidating pages in META_MAPPING before IPU or
DIO write.

Fixes: 6aa58d8ad20a ("f2fs: readahead encrypted block during GC")
Signed-off-by: Hyeong-Jun Kim <hj514.kim@samsung.com>
---
 fs/f2fs/data.c    | 2 ++
 fs/f2fs/segment.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 74e1a350c1d8..9f754aaef558 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1708,6 +1708,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		 */
 		f2fs_wait_on_block_writeback_range(inode,
 						map->m_pblk, map->m_len);
+		invalidate_mapping_pages(META_MAPPING(sbi),
+						map->m_pblk, map->m_pblk);
 
 		if (map->m_multidev_dio) {
 			block_t blk_addr = map->m_pblk;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 526423fe84ce..f57c55190f9e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3652,6 +3652,9 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 		goto drop_bio;
 	}
 
+	invalidate_mapping_pages(META_MAPPING(fio->sbi),
+				fio->new_blkaddr, fio->new_blkaddr);
+
 	stat_inc_inplace_blocks(fio->sbi);
 
 	if (fio->bio && !(SM_I(sbi)->ipu_policy & (1 << F2FS_IPU_NOCACHE)))
-- 
2.25.1

