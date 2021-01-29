Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7041E308577
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 07:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhA2GFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 01:05:35 -0500
Received: from relay.smtp-ext.broadcom.com ([192.19.232.172]:58142 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231865AbhA2GF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 01:05:29 -0500
Received: from lbrmn-lnxub113.broadcom.net (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id A7C9E7FC9;
        Thu, 28 Jan 2021 22:04:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com A7C9E7FC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1611900267;
        bh=m6tIAQSR5CQAehEd44soL/+k6r2fhc3CphJ7RlxXBF8=;
        h=From:To:Cc:Subject:Date:From;
        b=wDnPZSCh6UNVDJ5pIF46PB6Yf0A+2ZG30V6+VubWnKGPU/TyeXSYQnrCpzD3AlEYQ
         XZW1XOYCH+eIqOKE3HudUj5W0BE17FzdPieh5SF2HNqEBpUeGtQJy9/YLCcg9zvGIU
         q8W90qPLJYvNq/C22jsBRNhYUOjiyb/cVNHULj2Y=
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>,
        Desmond Yan <desmond.yan@broadcom.com>
Subject: [PATCH] misc: bcm-vk: fix set_q_num API precedence issue
Date:   Thu, 28 Jan 2021 22:04:03 -0800
Message-Id: <20210129060403.14801-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Desmond Yan <desmond.yan@broadcom.com>

Change set_q_num API to use if-else to make it more explicit,
and avoid a precedence rule issue.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/misc/bcm-vk/bcm_vk_msg.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c b/drivers/misc/bcm-vk/bcm_vk_msg.c
index eec90494777d..a363e2e4f7bc 100644
--- a/drivers/misc/bcm-vk/bcm_vk_msg.c
+++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
@@ -52,8 +52,14 @@ static u32 get_q_num(const struct vk_msg_blk *msg)
 
 static void set_q_num(struct vk_msg_blk *msg, u32 q_num)
 {
-	msg->trans_id = (msg->trans_id & ~BCM_VK_MSG_Q_MASK) |
-		(q_num >= VK_MSGQ_PER_CHAN_MAX) ? VK_MSGQ_NUM_DEFAULT : q_num;
+	u32 trans_q;
+
+	if (q_num >= VK_MSGQ_PER_CHAN_MAX)
+		trans_q = VK_MSGQ_NUM_DEFAULT;
+	else
+		trans_q = q_num;
+
+	msg->trans_id = (msg->trans_id & ~BCM_VK_MSG_Q_MASK) | trans_q;
 }
 
 static u32 get_msg_id(const struct vk_msg_blk *msg)
-- 
2.17.1

