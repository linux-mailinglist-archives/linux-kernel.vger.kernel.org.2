Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C40A3508BE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 23:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhCaVE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 17:04:29 -0400
Received: from st43p00im-zteg10073401.me.com ([17.58.63.181]:34883 "EHLO
        st43p00im-zteg10073401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231818AbhCaVEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1617224651; bh=mLmfO9KHGTwVzdxvKCaMc7ab60/ASrOKOwWiogdgsXo=;
        h=From:To:Subject:Date:Message-Id;
        b=jQk+3wlLiLGIn2XUIPbKZC1jKsqrvUGNse8a1m0hCWG6XHoUYknxujjkwrTa7Gj1E
         cfhsM1D+ffrIYukYeTzLk2eCrcy0LCJ1nCeG5DCoFLxkK0ZY5YFOXPzjQo2jzTKKSE
         tpyCQ8Qxn82pdItGxB9kQ73ZboW/W1FwAL7Evxq2b53vDbN8MywLZh9bD8D8b7xIXF
         GXRpr2RowX3U/PWSGHqKDcyTv/xJRbwRDFXV6S5molFTbY5bC7ZqTTyZTAiE+pQqje
         pKPq+mTa9ymx5a+fPQmiC2VPdca+NHcSbBiT8CsL4zFTPN+Fk37OXJ9QXz0HPlF1AW
         N/m2dg7u4JC9A==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10073401.me.com (Postfix) with ESMTPSA id B49585E069F;
        Wed, 31 Mar 2021 21:04:08 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     linux-kernel@vger.kernel.org, avolmat@me.com
Subject: [PATCH v3] mailbox: sti: fix struct description warnings
Date:   Wed, 31 Mar 2021 23:03:57 +0200
Message-Id: <20210331210357.3459-1-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-31=5F08:2021-03-31=5F02,2021-03-31=5F08,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 suspectscore=0
 mlxlogscore=859 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103310146
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix formating of struct description to avoid warning highlighted
by W=1 compilation.

warning: cannot understand function prototype: 'struct sti_mbox_device '
warning: cannot understand function prototype: 'struct sti_mbox_pdata '
warning: cannot understand function prototype: 'struct sti_channel '

Signed-off-by: Alain Volmat <avolmat@me.com>
Reviewed-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mailbox/mailbox-sti.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/mailbox-sti.c b/drivers/mailbox/mailbox-sti.c
index 2baf69a0b81c..0f2bc09c364d 100644
--- a/drivers/mailbox/mailbox-sti.c
+++ b/drivers/mailbox/mailbox-sti.c
@@ -36,7 +36,7 @@
 #define MBOX_BASE(mdev, inst)   ((mdev)->base + ((inst) * 4))
 
 /**
- * STi Mailbox device data
+ * struct sti_mbox_device - STi Mailbox device data
  *
  * An IP Mailbox is currently composed of 4 instances
  * Each instance is currently composed of 32 channels
@@ -60,7 +60,7 @@ struct sti_mbox_device {
 };
 
 /**
- * STi Mailbox platform specific configuration
+ * struct sti_mbox_pdata - STi Mailbox platform specific configuration
  *
  * @num_inst:	Maximum number of instances in one HW Mailbox
  * @num_chan:	Maximum number of channel per instance
@@ -71,7 +71,7 @@ struct sti_mbox_pdata {
 };
 
 /**
- * STi Mailbox allocated channel information
+ * struct sti_channel - STi Mailbox allocated channel information
  *
  * @mdev:	Pointer to parent Mailbox device
  * @instance:	Instance number channel resides in
-- 
2.17.1

