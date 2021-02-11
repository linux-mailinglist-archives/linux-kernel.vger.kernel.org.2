Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC106318D19
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 15:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhBKOQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 09:16:34 -0500
Received: from pv50p00im-ztdg10011201.me.com ([17.58.6.39]:36331 "EHLO
        pv50p00im-ztdg10011201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231912AbhBKN5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 08:57:37 -0500
X-Greylist: delayed 611 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Feb 2021 08:57:36 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1613051166;
        bh=WMQ2ew20gKuHcvkWuDVwaoOaOgxu5nNpW69z1RSBBQk=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=NJHTLTwpz0HnusHQihwPPv6xVzrCMZ134hQIQ9kRK4R58P171wAe+sANhWpjEW8L2
         +NMjQ1BQkcMem7y5pYnTBUEn01fOqd8psZ/8SNoSE/slMxEr+GqMllvz57BBhMGAQx
         ROMzsw1q3oxDqHtfjoW69EO5kJqZNSj/mIPJmlQZ2EfmeNqjONy/g4xfvzzH+c7rDA
         0CozYOSE6gPUz2Feo0WFYz//Ulw87a1yMuTA/sG7DTuZZAS7lLHZnMVB57KI+gsQoR
         a+dWgprTWABOquqeIF72Afh5rtwYxslvOgJCW02ofFTl/wIjhpPMPFKFQzfqe23dTe
         opPjy9p/wmzqQ==
Received: from everest.nathzi1505 (unknown [45.250.50.68])
        by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id 57F902A047F;
        Thu, 11 Feb 2021 13:46:02 +0000 (UTC)
From:   Pritthijit Nath <pritthijit.nath@icloud.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        oscar.carter@gmx.com, tvboxspy@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Pritthijit Nath <pritthijit.nath@icloud.com>
Subject: [PATCH] staging: vt6656: Fixed alignment with issue in rf.c
Date:   Thu, 11 Feb 2021 19:15:48 +0530
Message-Id: <20210211134548.84956-1-pritthijit.nath@icloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_06:2021-02-10,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2102110120
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

