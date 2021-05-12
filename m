Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C3937B8E3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhELJKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:10:46 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:26331 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhELJKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:10:43 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210512090933epoutp0197fb8375df42fb05c46fe97e89346263~_RqEO7bL60964209642epoutp01L
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 09:09:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210512090933epoutp0197fb8375df42fb05c46fe97e89346263~_RqEO7bL60964209642epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1620810573;
        bh=jsB6TAeu+Gzqs9Qhm/LfQhaqT2U/PKyrzK2xKp1ySZw=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=fZ/xCxI1TqCv8wFwuyN6n5pRH+mfkwtOIJH5F85TTU+vO9/94+0melLmBIUW+MVpn
         ZHxEhZw2fxQR6V/+/0nfGQwFOy7re4i5nYo3qoy2BdeA8mRhEcw3RgoowQSGkIExcR
         ooTYIrXhaAeITaINFRvS427vFIQcHfzUpQgAaBB4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20210512090933epcas2p1d504b74e0bde9e826cb3bc6b37505312~_RqDz7HuH2054420544epcas2p1m;
        Wed, 12 May 2021 09:09:33 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.186]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Fg8B32d7Bz4x9Pw; Wed, 12 May
        2021 09:09:31 +0000 (GMT)
X-AuditID: b6c32a45-db3ff70000002584-27-609b9b4ab08e
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.8F.09604.A4B9B906; Wed, 12 May 2021 18:09:30 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] f2fs: support cold file defragementation
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210512090930epcms2p2227112d22c961ca129462861108c03b6@epcms2p2>
Date:   Wed, 12 May 2021 18:09:30 +0900
X-CMS-MailID: 20210512090930epcms2p2227112d22c961ca129462861108c03b6
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmma7X7NkJBrv+a1icnnqWyeLlIU2L
        VQ/CLZ6sn8VscWmRu8XlXXPYHNg8Nq3qZPPYveAzk0ffllWMHp83yQWwROXYZKQmpqQWKaTm
        JeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gBtVlIoS8wpBQoFJBYXK+nb
        2RTll5akKmTkF5fYKqUWpOQUGBoW6BUn5haX5qXrJefnWhkaGBiZAlUm5GT82nGFtaCHr6Lz
        +2qWBsbt3F2MnBwSAiYSy2/0MXUxcnEICexglNj+awdLFyMHB6+AoMTfHcIgNcIClhLfr19m
        A7GFBJQk1l+cxQ4R15O49XANI4jNJqAjMf3EfbC4iECIxOvJLWAzmQUOMUrMv3uXCWIZr8SM
        9qcsELa0xPblWxkhbA2JH8t6mSFsUYmbq9+yw9jvj82HqhGRaL13FqpGUOLBz91QcUmJY7s/
        QM2vl9h65xcjyGIJgR5GicM7b7FCJPQlrnVsBFvMK+ArMXXfX7AGFgFViaXrWtkgalwkzs89
        AFbPLCAvsf3tHGZQQDALaEqs36UPYkoIKEscucUC80rDxt/s6GxmAT6JjsN/4eI75j2BOk1N
        Yt3P9UwQY2Qkbs1jnMCoNAsR0LOQrJ2FsHYBI/MqRrHUguLc9NRiowJD5LjdxAhOhFquOxgn
        v/2gd4iRiYMRGNoczEoivGJJsxOEeFMSK6tSi/Lji0pzUosPMZoCPTyRWUo0OR+YivNK4g1N
        jczMDCxNLUzNjCyUxHl/ptYlCAmkJ5akZqemFqQWwfQxcXBKNTBtrWHnfb6s007tQNziZcdr
        JNLOy/CbmRw+snv5rkXXeZ7y6nyXnTUh8j/rbI2dFzYtMZ+nnrunfvfCze9Yr285NmVpx9Hf
        qV5CUkwmR1NaFjgu65lwZaWm7PO7l6pT58pGuyX1xJX8TlYIvFO65Jd+uhyL/XSd8ouaJZdO
        /Fnnnpalp2F9pSnXdLb5z403xL8sUWkxlK94ub+PPZtf3NUi7mxZ3oJ/17jn/m7f1VK4mvf7
        5IMvLlseWR31zI79z6HyT1Putb5Xn3zh5/3Uxz2aeQYCeyUUd217pfpSoJ3v4/y7rzrbFLbJ
        bJI4Ni8vZ5v6uiP1M1PbhQ/w6p7NVz3DV6fxbVN8uHfLreN359yrUGIpzkg01GIuKk4EAHPV
        ImUNBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210512090930epcms2p2227112d22c961ca129462861108c03b6
References: <CGME20210512090930epcms2p2227112d22c961ca129462861108c03b6@epcms2p2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

F2FS_IOC_DEFRAGMENT performs defragmentation of a file. In
f2fs_defragment_range(), it checks whether in-place update policy is
applied, for avoiding unnecessary write operations.
The cold file may be fragmented according to the write order. However,
in the case of a cold file, the in-place update policy is applied, so it
is can not be defragmented.
This patch temporarily clears the cold bit so that the file can be
defragmented.

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 fs/f2fs/file.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ceb575f99048..c38e9727ce25 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2536,11 +2536,23 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	unsigned int total = 0, sec_num;
 	block_t blk_end = 0;
 	bool fragmented = false;
+	bool is_cold = file_is_cold(inode);
 	int err;
 
+	/*
+	 * Cold file can be fragmented by write order. So we clear cold bit from
+	 * the file temporarily.
+	 */
+	if (is_cold)
+		file_clear_cold(inode);
+
 	/* if in-place-update policy is enabled, don't waste time here */
-	if (f2fs_should_update_inplace(inode, NULL))
+	if (f2fs_should_update_inplace(inode, NULL)) {
+		/* restore file temperature */
+		if (is_cold)
+			file_set_cold(inode);
 		return -EINVAL;
+	}
 
 	pg_start = range->start >> PAGE_SHIFT;
 	pg_end = (range->start + range->len) >> PAGE_SHIFT;
@@ -2665,6 +2677,9 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	clear_inode_flag(inode, FI_DO_DEFRAG);
 out:
 	inode_unlock(inode);
+	/* restore file temperature */
+	if (is_cold)
+		file_set_cold(inode);
 	if (!err)
 		range->len = (u64)total << PAGE_SHIFT;
 	return err;
-- 
2.25.1

