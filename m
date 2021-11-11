Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1245744D49C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 11:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhKKKG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 05:06:29 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:59340 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230021AbhKKKG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 05:06:27 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Uw0F3zS_1636625010;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Uw0F3zS_1636625010)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Nov 2021 18:03:36 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] drm/amd/display: Clean up some inconsistent indenting
Date:   Thu, 11 Nov 2021 18:03:25 +0800
Message-Id: <1636625005-87952-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:

drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_srv.c:622
dmub_srv_cmd_execute() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 56a0332..e9fadf1 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -618,8 +618,8 @@ enum dmub_status dmub_srv_cmd_execute(struct dmub_srv *dmub)
 	 * read back stale, fully invalid or partially invalid data.
 	 */
 	dmub_rb_flush_pending(&dmub->inbox1_rb);
+	dmub->hw_funcs.set_inbox1_wptr(dmub, dmub->inbox1_rb.wrpt);
 
-		dmub->hw_funcs.set_inbox1_wptr(dmub, dmub->inbox1_rb.wrpt);
 	return DMUB_STATUS_OK;
 }
 
-- 
1.8.3.1

