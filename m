Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8B133EA5E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 08:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbhCQHLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 03:11:44 -0400
Received: from m12-16.163.com ([220.181.12.16]:41237 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhCQHLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 03:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pH7nh
        paleJ/7ukwCP8E2DXBfIB5ssIKEREx9oLsDBpo=; b=QuvsY0XtbcbcZmmMU8kny
        x4hbCtMqedR6nlLBCT6Cco9QFozJi5C+xJBkH0GznwEyYMfcDYDp4B6D2Lq2bl1K
        54tuhCGxqU8tz59nAnhLYu3gF+NExi4hlFkB0MXmK72WMO98HpSJB7vrFWxlNF3T
        LNRKvSHEcYAcYsGVdlEgAc=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp12 (Coremail) with SMTP id EMCowAAXHSFxq1FgnVAehA--.23334S2;
        Wed, 17 Mar 2021 15:10:45 +0800 (CST)
From:   zuoqilin1@163.com
To:     shaggy@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] fs: Fix typo issue
Date:   Wed, 17 Mar 2021 15:10:52 +0800
Message-Id: <20210317071052.1101-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowAAXHSFxq1FgnVAehA--.23334S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFy8Jr45Zr13WrW7XFy3twb_yoWxtwc_Ca
        n7Ar48WayrXayUur1fXrs5Kryq9rW8urn8urWDJFZIkryqyrnxJrs7Cr47XryDKrZ0kryk
        Zw18KryrurykWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0j2NtUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/xtbBRQ1YiVPAKjBU8QADs2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

Change 'inacitve' to 'inactive'.

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 fs/jfs/jfs_dmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 7aee156..91f4ec93 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -3660,7 +3660,7 @@ void dbFinalizeBmap(struct inode *ipbmap)
 	 * (the leftmost ag with average free space in it);
 	 */
 //agpref:
-	/* get the number of active ags and inacitve ags */
+	/* get the number of active ags and inactive ags */
 	actags = bmp->db_maxag + 1;
 	inactags = bmp->db_numag - actags;
 	ag_rem = bmp->db_mapsize & (bmp->db_agsize - 1);	/* ??? */
-- 
1.9.1


