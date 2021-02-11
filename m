Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56E3319004
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 17:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhBKQbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 11:31:14 -0500
Received: from pv50p00im-tydg10021701.me.com ([17.58.6.54]:50002 "EHLO
        pv50p00im-tydg10021701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231131AbhBKP0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1613057152;
        bh=WMQ2ew20gKuHcvkWuDVwaoOaOgxu5nNpW69z1RSBBQk=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=PJvSbdIkoEp0PkbpGG+RF2hrVdrz01BVTnnS9Ze9nyvFuNYJ5pTFA1Vuz6wbVLy0E
         vjk2C4AW28BFGxsQy/rA/EcDPIvPFPW/9F9k38urRjChBK4bhySan2Rro41NjTbx/Z
         Db/fReM2DC6EO278sEok5IvlUKVdd6oWi0vc5cI/aeuxAA9U0BszS5A4uus7A6dac2
         tP9A3kuj8R9zyhwTBZAGKNdeUHrqP6eqCpKi8wQWsFy41Y8ErIqYL/1ktZp0EzUebw
         0/XZrcFRqcznhwofS3jbFlfLQcpwbAPUJQQ69yvKqXBQWbfBZMqvAj3Wd3Rf96eP1u
         kzJXribHPNZZA==
Received: from everest.nathzi1505 (unknown [45.250.50.68])
        by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id EBDA98403CE;
        Thu, 11 Feb 2021 15:25:49 +0000 (UTC)
From:   Pritthijit Nath <pritthijit.nath@icloud.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        oscar.carter@gmx.com, tvboxspy@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Pritthijit Nath <pritthijit.nath@icloud.com>
Subject: [PATCH] staging: vt6656: Fixed issue with alignment in rf.c
Date:   Thu, 11 Feb 2021 20:54:26 +0530
Message-Id: <20210211152426.10008-1-pritthijit.nath@icloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_07:2021-02-10,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2102110133
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change fixes a checkpatch CHECK style issue for "Alignment should match open parenthesis".

Signed-off-by: Pritthijit Nath <pritthijit.nath@icloud.com>
---
 drivers/staging/vt6656/rf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vt6656/rf.c b/drivers/staging/vt6656/rf.c
index 5b8da06e3916..bcd4d467e03a 100644
--- a/drivers/staging/vt6656/rf.c
+++ b/drivers/staging/vt6656/rf.c
@@ -687,7 +687,7 @@ static int vnt_rf_set_txpower(struct vnt_private *priv, u8 power,
 
 			if (hw_value < ARRAY_SIZE(vt3226d0_lo_current_table)) {
 				ret = vnt_rf_write_embedded(priv,
-					vt3226d0_lo_current_table[hw_value]);
+							    vt3226d0_lo_current_table[hw_value]);
 				if (ret)
 					return ret;
 			}
-- 
2.25.1

