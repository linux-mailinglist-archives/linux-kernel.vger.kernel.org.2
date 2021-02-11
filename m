Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471D4319541
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 22:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhBKVin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 16:38:43 -0500
Received: from pv50p00im-zteg10021401.me.com ([17.58.6.47]:47553 "EHLO
        pv50p00im-zteg10021401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229991AbhBKVid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 16:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1613079448;
        bh=2kPInYmiLdbdUSVjWnNrG2+HLjtCKcElGsBjJRebRQA=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=NCtqFcivPuyHlTqY48O3+E52PMZ1F5AtKTEaRCOQdpuUnf7ctL4OM7H19vfzDx3Nq
         earzmQj/tkg3aWSAnUcagbQYwSKBTeYHNra5ik3tsuozf2fZE4Opc6pgbaCRMxCqzC
         nfF+NYJHfZYAfM8NKpmPaXxB7jwUWDHpekjX3bxAWX0JhlpJg0UjWqVob/LtWyGK0z
         CwaWleUwW8dAjMWD/y2Yd2q9xvSYt0EgacNc1NurH6aSE+xt5JXZ7n05zNHRhcq22t
         DO8q4q8bGKfr6u2K0tSGwNqGUULTgQI/8wOhhg+s5cCulewlijoCDvCJhpAzYazUZ2
         dr0nvaoIQntHA==
Received: from everest.nathzi1505 (unknown [45.250.50.68])
        by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id 19F32480274;
        Thu, 11 Feb 2021 21:37:24 +0000 (UTC)
From:   Pritthijit Nath <pritthijit.nath@icloud.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        oscar.carter@gmx.com, tvboxspy@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Pritthijit Nath <pritthijit.nath@icloud.com>
Subject: [PATCH] staging: vt6656: Fixed issue with alignment in rf.c
Date:   Fri, 12 Feb 2021 03:07:15 +0530
Message-Id: <20210211213715.7386-1-pritthijit.nath@icloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_07:2021-02-11,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2102110168
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change fixes a checkpatch CHECK style issue for "Alignment should
match open parenthesis".

Signed-off-by: Pritthijit Nath <pritthijit.nath@icloud.com>
---
 Fixed trailing space in changelog.

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

