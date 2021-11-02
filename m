Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C672E4427DF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhKBHNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:13:01 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:62517 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhKBHMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:12:46 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20211102071009epoutp046090ad42f2bdbf52ef4bfb8e780e3534~zqRfTDLIq2193521935epoutp04I
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 07:10:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20211102071009epoutp046090ad42f2bdbf52ef4bfb8e780e3534~zqRfTDLIq2193521935epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1635837009;
        bh=gj2rTat6TSri4dAUVObjHNPofHFnBqgihqy5ybyAR24=;
        h=From:To:Cc:Subject:Date:References:From;
        b=YUsqwky5I3Jd87xbEkCjgPFVTPgRF32cHm+k2tRQKkPvFQJnQr5oQ16aYagcCco/h
         BQ2Rd+TNtWz0q8FwFi2GBCZzktQ4tyyk/RjsmNypMtfLuQ9HMfoi57sl4960dZY+Zw
         DmFFeSWfVSkM0qxiAB1BLQNb1C9gxbibEUyMoz/4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211102071009epcas1p1e879c69dbdd26d5d36319f0ef67f6acf~zqRfAs5ZA0473704737epcas1p14;
        Tue,  2 Nov 2021 07:10:09 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.247]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Hk1Hz2S0Vz4x9Q1; Tue,  2 Nov
        2021 07:10:07 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.51.09592.C44E0816; Tue,  2 Nov 2021 16:10:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20211102071004epcas1p4d6422cb2ccaa6af495cee4f041f63048~zqRa8391Q1087810878epcas1p4T;
        Tue,  2 Nov 2021 07:10:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211102071004epsmtrp18e451e9cbbd1cec2f3ec6cf35ce9e011~zqRa8KWB33247232472epsmtrp1P;
        Tue,  2 Nov 2021 07:10:04 +0000 (GMT)
X-AuditID: b6c32a37-2a5ff70000002578-50-6180e44c35f4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.9B.29871.C44E0816; Tue,  2 Nov 2021 16:10:04 +0900 (KST)
Received: from hj514.kim-office (unknown [10.253.100.146]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211102071004epsmtip232cbc4a0f250ca10ebfdf0d49b297026~zqRawbv0B2709627096epsmtip2l;
        Tue,  2 Nov 2021 07:10:04 +0000 (GMT)
From:   Hyeong-Jun Kim <hj514.kim@samsung.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Hyeong-Jun Kim <hj514.kim@samsung.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] F2FS: invalidate META_MAPPING before IPU/DIO write
Date:   Tue,  2 Nov 2021 16:10:02 +0900
Message-Id: <20211102071002.71823-1-hj514.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHKsWRmVeSWpSXmKPExsWy7bCmvq7vk4ZEg6U/GC1OTz3LZDG94yCb
        xZP1s5gtLi1yt7i8aw6bA6vHplWdbB67F3xm8ujbsorR4/MmuQCWqGybjNTElNQihdS85PyU
        zLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKC1SgpliTmlQKGAxOJiJX07m6L8
        0pJUhYz84hJbpdSClJwCswK94sTc4tK8dL281BIrQwMDI1OgwoTsjJdt3SwFPSIVbX96WBsY
        2/i7GDk5JARMJH53XmbsYuTiEBLYwShxbONGZgjnE6PEkpZZbBDON0aJL71fWGFazp9ZyASR
        2MsoMbN7J5TznlFi1uobbCBVbAI6Eh9mrWQEsUUE7CU+f7/OAmIzCxRJ7Ow/xw5iCwu4SUw6
        cIQJxGYRUJVYd/Me0AYODl4BK4k3s2wglslLzLz0HaycV0BQ4uTMJ1Bj5CWat84GO1VCYBe7
        xIWmZkaIBheJk1MmsUHYwhKvjm9hh7ClJF72t0HZ9RLHr3xihWhuYZR4vPQVI8hiCaBD31+y
        ADGZBTQl1u/ShyhXlNj5ey4jxF4+iXdfe1ghqnklOtqEIEqUJTbfPQy1VVLi6aK/UNd4SMx7
        fowNpFxIIFaiq1dyAqP8LCTPzELyzCyEvQsYmVcxiqUWFOempxYbFhjD4zQ5P3cTIzjhaZnv
        YJz29oPeIUYmDsZDjBIczEoivMxHGxKFeFMSK6tSi/Lji0pzUosPMZoCQ3cis5Rocj4w5eaV
        xBuaWBqYmBmZWBhbGpspifN+litMFBJITyxJzU5NLUgtgulj4uCUamCa3rfb75Rd5NkSkda1
        N48H/ZFN3pjX9c9z2gH/0JyGltk9XlklYR7RJoxKBi4vE1wu2pdcaFqxIlR6RYTEvnPt/WrS
        66Idvx76Ubgw4m6RuXx6rIKB3OXMkkTB753JUjbGZQ67D6q8VojhXn17/fzQ+M0fIo5VnXrq
        bXvE+KdwrD6vB/fE97ulvl08dYjX4WLHh2qjI0Zz179ZaLDy3q4LW0P4lWevFrtrvi/8XsT2
        ePvEtVc2suRu+r/nT7hZ+352WYcVz6IW8ITxFH8+rr5BbY9K3ZIdi/bavg776bDi+9tv10Tb
        0tWm2Drb33/z6uJl/cBrfzSrv2+R3d293rx2m3r6rN4FF0/yp6fGZZQosRRnJBpqMRcVJwIA
        klExqwEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDLMWRmVeSWpSXmKPExsWy7bCSvK7Pk4ZEg4crtCxOTz3LZDG94yCb
        xZP1s5gtLi1yt7i8aw6bA6vHplWdbB67F3xm8ujbsorR4/MmuQCWKC6blNSczLLUIn27BK6M
        l23dLAU9IhVtf3pYGxjb+LsYOTkkBEwkzp9ZyNTFyMUhJLCbUWLuvhbGLkYOoISkxLz15RCm
        sMThw8UQJW8ZJQ79nMAE0ssmoCPxYdZKRhBbRMBR4tfrRawgNrNAicTmTS/YQWxhATeJSQeO
        gNWzCKhKrLt5jxVkJq+AlcSbWTYQJ8hLzLz0HaycV0BQ4uTMJywQY+QlmrfOZp7AyDcLSWoW
        ktQCRqZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjBAailuYNx+6oPeocYmTgYDzFK
        cDArifAyH21IFOJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNT
        qoHJQdlpTV2Ca39R4nehyT+z90xM39bA/P/do52WXTO4FvhvfLjAS2a+Qf/VuHvaF8wE/NyV
        Jvm8m8usFXDBpObtzpDkH8y6Fe/PnvJYIdy1VcODn+Pvh4Ksk96PBXP17i1f+po1U7E3dLv4
        sUSx1jctq/2e1TIt2rjd7xDPLJEJ2+fL3Tmwgrd7wsRitofnDtp9VF6UrPP/8iPdot0LopZP
        rL8uft9YcE7GUum7miU/p6i0uaQt6/hesLx3W+j+lOsCwiH1/HoWUix6Zgd1F/4KYhTe4uf4
        i+F3/VYZ+ZdRE/NEBJRNRZ3jDn+zctFbo+PrV/T75M4F79g2GBncm7139Zw/JZcLCqaqvOX4
        1lavxFKckWioxVxUnAgADVnOuq8CAAA=
X-CMS-MailID: 20211102071004epcas1p4d6422cb2ccaa6af495cee4f041f63048
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211102071004epcas1p4d6422cb2ccaa6af495cee4f041f63048
References: <CGME20211102071004epcas1p4d6422cb2ccaa6af495cee4f041f63048@epcas1p4.samsung.com>
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
v4:
 - Fix change log in patch description
v3:
 - Use sbi instead of fio->sbi in f2fs_inplace_write_data()
v2:
 - Update patch description with race condition
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
index 526423fe84ce..df9ed75f0b7a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3652,6 +3652,9 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 		goto drop_bio;
 	}
 
+	invalidate_mapping_pages(META_MAPPING(sbi),
+				fio->new_blkaddr, fio->new_blkaddr);
+
 	stat_inc_inplace_blocks(fio->sbi);
 
 	if (fio->bio && !(SM_I(sbi)->ipu_policy & (1 << F2FS_IPU_NOCACHE)))
-- 
2.25.1

