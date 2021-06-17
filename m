Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1180D3AB01D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhFQJuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:50:06 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:56762 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhFQJuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:50:04 -0400
Received: from localhost (unknown [192.168.167.13])
        by lucky1.263xmail.com (Postfix) with ESMTP id 59324D1E8B;
        Thu, 17 Jun 2021 17:47:41 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [111.207.172.18])
        by smtp.263.net (postfix) whith ESMTP id P5456T140566025205504S1623923255883568_;
        Thu, 17 Jun 2021 17:47:42 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <a357138165591929524564ebbd2486a8>
X-RL-SENDER: maqianga@uniontech.com
X-SENDER: maqianga@uniontech.com
X-LOGIN-NAME: maqianga@uniontech.com
X-FST-TO: maarten.lankhorst@linux.intel.com
X-RCPT-COUNT: 8
X-SENDER-IP: 111.207.172.18
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Qiang Ma <maqianga@uniontech.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH] drm/auth: Move master pointer from drm_device to drm_file
Date:   Thu, 17 Jun 2021 17:47:33 +0800
Message-Id: <20210617094733.8429-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drm_file pointer clears to zero during multi-user switching,
so it needs to call drm_new_set_master for master pointer from drm_file.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 drivers/gpu/drm/drm_auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
index f2d46b7ac6f9..02431af6d0c5 100644
--- a/drivers/gpu/drm/drm_auth.c
+++ b/drivers/gpu/drm/drm_auth.c
@@ -302,7 +302,7 @@ int drm_master_open(struct drm_file *file_priv)
 	/* if there is no current master make this fd it, but do not create
 	 * any master object for render clients */
 	mutex_lock(&dev->master_mutex);
-	if (!dev->master)
+	if (!file_priv->master)
 		ret = drm_new_set_master(dev, file_priv);
 	else
 		file_priv->master = drm_master_get(dev->master);
-- 
2.20.1



