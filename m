Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5934E36E4C3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 08:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbhD2GVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 02:21:00 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:20079 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhD2GU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 02:20:57 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210429062009epoutp0376103b564d44d9026194b70384e385d4~6P9c4bwDe1832018320epoutp03N
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 06:20:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210429062009epoutp0376103b564d44d9026194b70384e385d4~6P9c4bwDe1832018320epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1619677209;
        bh=evdDv/wF3+Vhn2ZW2v+vhX2J8hbBZ8flU0eoahtAteI=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=tofInGT/8w78bG/zq1J+DtoSI3RcU5ewSWgU8sNg51OZGZcuWGyjXmr4PVT93nPPu
         Dnwq46c+W0zZFTOq2CUuHSFumSScuhJfLYZumlXcnUWRXqcnATUiY/yH6HTCYIrtKZ
         j1IG2oYQE2lWwsuvgoCyEKvvbUZx3thHoM+8o46A=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20210429062007epcas2p1dfdf264071cdbf9d6285bfff10b56bbb~6P9a5ErBK3259432594epcas2p1g;
        Thu, 29 Apr 2021 06:20:07 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4FW52Z2Hjjz4x9Pq; Thu, 29 Apr
        2021 06:20:06 +0000 (GMT)
X-AuditID: b6c32a47-f4bff700000024d9-cc-608a501695ac
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.4E.09433.6105A806; Thu, 29 Apr 2021 15:20:06 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] f2fs: set file as cold when file defragmentation
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Chao Yu <yuchao0@huawei.com>,
        Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210429062005epcms2p352ef77f96ab66cbffe0c0ab6c1b62d8a@epcms2p3>
Date:   Thu, 29 Apr 2021 15:20:05 +0900
X-CMS-MailID: 20210429062005epcms2p352ef77f96ab66cbffe0c0ab6c1b62d8a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdljTQlcsoCvB4M0lQYvTU88yWbw8pGmx
        6kG4xZP1s5gtLi1yt7i8aw6bxdTHa1kd2D1ajrxl9di0qpPNY/eCz0wefVtWMXp83iQXwBqV
        Y5ORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdIOSQlli
        TilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8DQsECvODG3uDQvXS85P9fK0MDAyBSoMiEn
        4+MJpYJpbBW3pvWyNTA2snYxcnJICJhIXH/+n7GLkYtDSGAHo8TPiQeZuxg5OHgFBCX+7hAG
        qREWcJTonX2bDcQWElCSWH9xFjtEXE/i1sM1jCA2m4COxPQT99lB5ogIbGKSWLJkMzPEAl6J
        Ge1PWSBsaYnty7cyQtgaEj+W9ULViErcXP2WHcZ+f2w+VI2IROu9s1A1ghIPfu6GiktKHNv9
        gQnCrpfYeucX2AMSAj2MEod33oL6TF/iWsdGsMW8Ar4SE1pms4M8xiKgKrGgyR6ixEXiXFs/
        WAmzgLzE9rdzwH5nFtCUWL9LH8SUEFCWOHKLBeaTho2/2dHZzAJ8Eh2H/8LFd8x7AnWZmsS6
        n+uZIMbISNyaB3W8h0T37+nMExgVZyHCeRaSE2YhnLCAkXkVo1hqQXFuemqxUYExcsxuYgQn
        Ri33HYwz3n7QO8TIxMF4iFGCg1lJhPf3us4EId6UxMqq1KL8+KLSnNTiQ4ymQL9PZJYSTc4H
        pua8knhDUyMzMwNLUwtTMyMLJXHen6l1CUIC6YklqdmpqQWpRTB9TBycUg1McW0CWewWN4/s
        uv5QzvV248b/Cx+Y7Vt/S1P75rnm3x0H102U+h1q8+nrc+cq9j4f620eU261LS2zn2FiXdu8
        VN3qmofuism7cy8z/l5df6BvcVDwZhlum6lmkypvt83N3Lhf8VDXgoc9MTrTpJXmr/KTdt0v
        OUnO5I5709r/r2vf1MWfePhRaa/KpKXxU1Jvn1A4sHWXcb3Nx+J1ge1BAlsX/d7zsG5F9jMV
        WSXt2lomFjb3I63sSxKWBMjlXPu6Za+mLEvuo/YlmfWaa2x+ZLf4LvZzKrhc0iYgffmlQMCc
        BNnHm1OXpV98wXv64l9nj4N2zUXBqcKqXif3pnOKBEstk7fMZVy97ohp5dmtSizFGYmGWsxF
        xYkAx/qomxUEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210429062005epcms2p352ef77f96ab66cbffe0c0ab6c1b62d8a
References: <CGME20210429062005epcms2p352ef77f96ab66cbffe0c0ab6c1b62d8a@epcms2p3>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In file defragmentation by ioctl, all data blocks in the file are
re-written out-of-place. File defragmentation implies user will not update
and mostly read the file. So before the defragmentation, we set file
temperature as cold for better block allocation.

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d697c8900fa7..dcac965a05fe 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2669,6 +2669,9 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	map.m_len = pg_end - pg_start;
 	total = 0;
 
+	if (!file_is_cold(inode))
+		file_set_cold(inode);
+
 	while (map.m_lblk < pg_end) {
 		pgoff_t idx;
 		int cnt = 0;
-- 
2.25.1

