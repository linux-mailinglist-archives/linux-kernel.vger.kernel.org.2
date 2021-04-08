Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0086E357E61
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhDHIqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:46:50 -0400
Received: from m12-17.163.com ([220.181.12.17]:42274 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhDHIqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hAJCn
        0+oHfyjAm5HefGdXbPdmgpU4l0aRalPUPuht8E=; b=hr/S8pJ0mAmvkY/74DCEi
        +nCy2/Lx9qeRlIu7PataY0bkEY+Zkr/KI6Lw4aY8FNfmNOh51FBG4+qbbx68PQUa
        Ky9MdTMu1NpIZT9MBBClKaZSn3soPLVcKCkWb7AN/2M8yAO1H2laSQTuj7LWXy+D
        xqKBHIhNkx+UCPI2kpcIBs=
Received: from localhost.localdomain (unknown [119.137.53.45])
        by smtp13 (Coremail) with SMTP id EcCowABXWpLMwm5gR4EIuQ--.56324S2;
        Thu, 08 Apr 2021 16:46:05 +0800 (CST)
From:   Carlis <llyz108@163.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Xuezhi Zhang <zhangxuezhi1@yulong.com>
Subject: [PATCH] drm/panel: panel-dsi-cm: convert sysfs snprint to sysfs_emit
Date:   Thu,  8 Apr 2021 08:46:03 +0000
Message-Id: <20210408084603.2112-1-llyz108@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowABXWpLMwm5gR4EIuQ--.56324S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7GrW3Xry3Gw1xCF47Zry3CFg_yoW8Jr4rpF
        47G347ZrW8JFyqyFWrCFZ2vFyrZ3WIqFWxKa4kGanxuF4UAF48AF9rAFW7Kr15Jr1xG34a
        gF4DKrW5uay8Ar7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j6SoJUUUUU=
X-Originating-IP: [119.137.53.45]
X-CM-SenderInfo: xoo16iiqy6il2tof0z/1tbiPg1uhVxBmQhfnQAAsW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xuezhi Zhang <zhangxuezhi1@yulong.com>

Fix the following coccicheck warning:
drivers/gpu/drm//panel/panel-dsi-cm.c:271:8-16: 
WARNING: use scnprintf or sprintf
drivers/gpu/drm//panel/panel-dsi-cm.c:251:8-16: 
WARNING: use scnprintf or sprintf

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@yulong.com>
---
 drivers/gpu/drm/panel/panel-dsi-cm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-dsi-cm.c b/drivers/gpu/drm/panel/panel-dsi-cm.c
index 5fbfb71ca3d9..a8efb06cca64 100644
--- a/drivers/gpu/drm/panel/panel-dsi-cm.c
+++ b/drivers/gpu/drm/panel/panel-dsi-cm.c
@@ -248,7 +248,7 @@ static ssize_t num_dsi_errors_show(struct device *dev,
 	if (r)
 		return r;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", errors);
+	return sysfs_emit(buf, "%d\n", errors);
 }
 
 static ssize_t hw_revision_show(struct device *dev,
@@ -268,7 +268,7 @@ static ssize_t hw_revision_show(struct device *dev,
 	if (r)
 		return r;
 
-	return snprintf(buf, PAGE_SIZE, "%02x.%02x.%02x\n", id1, id2, id3);
+	return sysfs_emit(buf, "%02x.%02x.%02x\n", id1, id2, id3);
 }
 
 static DEVICE_ATTR_RO(num_dsi_errors);
-- 
2.25.1


