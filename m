Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAAA388D78
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 14:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353310AbhESMGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 08:06:35 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:51026 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhESMGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 08:06:34 -0400
Received: from localhost (unknown [192.168.167.32])
        by lucky1.263xmail.com (Postfix) with ESMTP id 0C4FFD1806;
        Thu, 20 May 2021 03:52:12 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [111.207.172.18])
        by smtp.263.net (postfix) whith ESMTP id P30809T139673931085568S1621425646703999_;
        Wed, 19 May 2021 20:01:00 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <d8bd1af7ca0da760329237065e3fea88>
X-RL-SENDER: songqiang@uniontech.com
X-SENDER: songqiang@uniontech.com
X-LOGIN-NAME: songqiang@uniontech.com
X-FST-TO: sam@ravnborg.org
X-RCPT-COUNT: 12
X-SENDER-IP: 111.207.172.18
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   songqiang <songqiang@uniontech.com>
To:     sam@ravnborg.org, b.zolnierkie@samsung.com,
        penguin-kernel@i-love.sakura.ne.jp, george.kennedy@oracle.com,
        arnd@arndb.de, tzimmermann@suse.de, jgg@ziepe.ca,
        willy@infradead.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, songqiang <songqiang@uniontech.com>
Subject: [PATCH] drivers/video/fbdev/core/fbmem.c: add pointer judgment
Date:   Wed, 19 May 2021 20:00:28 +0800
Message-Id: <20210519120028.7350-1-songqiang@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: songqiang <songqiang@uniontech.com>
---
 drivers/video/fbdev/core/fbmem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 072780b0e570..6036ab849475 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1859,6 +1859,9 @@ void fb_set_suspend(struct fb_info *info, int state)
 {
 	WARN_CONSOLE_UNLOCKED();
 
+	if (!info) {
+		return;
+	}
 	if (state) {
 		fbcon_suspended(info);
 		info->state = FBINFO_STATE_SUSPENDED;
-- 
2.20.1



