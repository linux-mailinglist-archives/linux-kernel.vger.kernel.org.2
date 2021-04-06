Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574663552E2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343595AbhDFLzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:55:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15555 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243355AbhDFLze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:55:34 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FF5Vw4CgQzPnlj;
        Tue,  6 Apr 2021 19:52:40 +0800 (CST)
Received: from mdc.localdomain (10.175.104.57) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 19:55:19 +0800
From:   Huang Guobin <huangguobin4@huawei.com>
To:     <huangguobin4@huawei.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] gma500: Use DEFINE_SPINLOCK() for spinlock
Date:   Tue, 6 Apr 2021 19:55:14 +0800
Message-ID: <1617710114-48071-1-git-send-email-huangguobin4@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guobin Huang <huangguobin4@huawei.com>

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Guobin Huang <huangguobin4@huawei.com>
---
 drivers/gpu/drm/gma500/power.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/power.c b/drivers/gpu/drm/gma500/power.c
index 56ef88237ef6..f07641dfa5a4 100644
--- a/drivers/gpu/drm/gma500/power.c
+++ b/drivers/gpu/drm/gma500/power.c
@@ -36,7 +36,7 @@
 #include <linux/pm_runtime.h>
 
 static struct mutex power_mutex;	/* Serialize power ops */
-static spinlock_t power_ctrl_lock;	/* Serialize power claim */
+static DEFINE_SPINLOCK(power_ctrl_lock);	/* Serialize power claim */
 
 /**
  *	gma_power_init		-	initialise power manager
@@ -55,7 +55,6 @@ void gma_power_init(struct drm_device *dev)
 	dev_priv->display_power = true;	/* We start active */
 	dev_priv->display_count = 0;	/* Currently no users */
 	dev_priv->suspended = false;	/* And not suspended */
-	spin_lock_init(&power_ctrl_lock);
 	mutex_init(&power_mutex);
 
 	if (dev_priv->ops->init_pm)

