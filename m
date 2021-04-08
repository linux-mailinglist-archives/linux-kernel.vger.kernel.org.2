Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126FA357E16
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhDHIck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:32:40 -0400
Received: from m12-11.163.com ([220.181.12.11]:34343 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhDHIcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=U+IWT
        dIROHmOJoPT3L0orSHFKktYzbY2trOkSRmL0Gk=; b=IgJrraD1paFmm73Xtc4jI
        7Ms7HFDBaoSjHgT7+qbrENvHOXDKJHSbLceDScIlYthaSw54fmT2LOWdDhy4XVP5
        Mx9/4GU4Zs7bJPlArXMWIB558OJ7k2A60Evgz91bdY3V/CNq+/eaqALsiA4gtU+v
        1zIsFlvqSUKS6B3W1FGQ2s=
Received: from localhost.localdomain (unknown [119.137.53.45])
        by smtp7 (Coremail) with SMTP id C8CowAAH_5ZYv25gvwTDWA--.27213S2;
        Thu, 08 Apr 2021 16:31:21 +0800 (CST)
From:   Carlis <llyz108@163.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Xuezhi Zhang <zhangxuezhi1@yulong.com>
Subject: [PATCH] drm/panel: tpo-td043mtea1: convert sysfs snprintf to sysfs_emit
Date:   Thu,  8 Apr 2021 08:31:18 +0000
Message-Id: <20210408083118.557966-1-llyz108@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowAAH_5ZYv25gvwTDWA--.27213S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF1DWFWUKF15AFy8tF4ktFb_yoW8Xry7pF
        srGa45ArWrJw1DKF4UCan7ZFyS9a4xtFySqFykGwn5uw4UJrWDtFZ8Jay7tFy5Jr1xCrW3
        tF1ktry3Za40yr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j6RRiUUUUU=
X-Originating-IP: [119.137.53.45]
X-CM-SenderInfo: xoo16iiqy6il2tof0z/xtbBGhJuhV3l-MgAqQAAsG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xuezhi Zhang <zhangxuezhi1@yulong.com>

Fix the following coccicheck warning:
drivers/gpu/drm//panel/panel-tpo-td043mtea1.c:217:8-16: 
WARNING: use scnprintf or sprintf
drivers/gpu/drm//panel/panel-tpo-td043mtea1.c:189:8-16: 
WARNING: use scnprintf or sprintf

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@yulong.com>
---
 drivers/gpu/drm/panel/panel-tpo-td043mtea1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c b/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
index 49e6c9386258..bacaf1b7fb70 100644
--- a/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
+++ b/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
@@ -186,7 +186,7 @@ static ssize_t vmirror_show(struct device *dev, struct device_attribute *attr,
 {
 	struct td043mtea1_panel *lcd = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", lcd->vmirror);
+	return sysfs_emit(buf, "%d\n", lcd->vmirror);
 }
 
 static ssize_t vmirror_store(struct device *dev, struct device_attribute *attr,
@@ -214,7 +214,7 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
 {
 	struct td043mtea1_panel *lcd = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", lcd->mode);
+	return sysfs_emit(buf, "%d\n", lcd->mode);
 }
 
 static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
-- 
2.25.1

