Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00613ED93B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 16:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhHPOwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 10:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbhHPOv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 10:51:57 -0400
X-Greylist: delayed 593 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 Aug 2021 07:40:50 PDT
Received: from gregdf.com (gregdf.com [IPv6:2001:41d0:304:200::b62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DEFC061796
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 07:40:50 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c9:7bb0:47f6:13d5:48e6:af34])
        by mail.gregdf.com (Postfix) with ESMTPSA id CEAB830A0AF;
        Mon, 16 Aug 2021 16:30:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gregdf.com; s=mail;
        t=1629124252; bh=eLQYMMz0CluCtWGgDPOvxIf0ym6QLpqRpYmB5sXLSRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ojf9VPbTWDlE3MkJMGYFcgu9b1LH8N6yNKO9Dl3zM+9Ae93byP6RuK+RS6sFFq7BJ
         hTinfBcDH70yIsWbYb5+jMJkFCjhPvhGfXFuX6qnf9mr23CQqXPm06pvaFxCsKlkI2
         BOYot8AtZjTHWQJ0yMUDi1F6jmt8ZEvqlRojVVHY=
From:   lnx7586@gregdf.com
To:     mikpelinux@gmail.com
Cc:     daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
        jason@jlekstrand.net, linux-kernel@vger.kernel.org,
        Greg Depoire--Ferrer <lnx7586@gregdf.com>,
        Duncan <j.duncan@cox.net>
Subject: [PATCH] drm/ttm: allow debugfs_create_file() to fail in ttm_global_init()
Date:   Mon, 16 Aug 2021 16:30:46 +0200
Message-Id: <20210816143046.3320-1-lnx7586@gregdf.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <CAM43=SNDAcS952MZpsiD2Z-WU9Bd0EPv=7Z86i7FGdvDtsSXdQ@mail.gmail.com>
References: <CAM43=SNDAcS952MZpsiD2Z-WU9Bd0EPv=7Z86i7FGdvDtsSXdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Depoire--Ferrer <lnx7586@gregdf.com>

Commit 69de4421bb4c ("drm/ttm: Initialize debugfs from ttm_global_init()")
unintentionally made ttm_global_init() return early with an error when
debugfs_create_file() fails. When CONFIG_DEBUG_FS is disabled,
debugfs_create_file() returns a ENODEV error so the TTM device would fail
to initialize.

Instead of returning early with the error, print it and continue. ENODEV
can be ignored because it just means that CONFIG_DEBUG_FS is disabled.

Fixes: 69de4421bb4c ("drm/ttm: Initialize debugfs from ttm_global_init()")
Reported-by: Mikael Pettersson <mikpelinux@gmail.com>
Reported-by: Duncan <j.duncan@cox.net>
Signed-off-by: Greg Depoire--Ferrer <lnx7586@gregdf.com>
---
Hi, I had this bug as well with the nouveau driver after updating. This
patch fixes it for me.

 drivers/gpu/drm/ttm/ttm_device.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index 74e3b460132b..12b73979c798 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -69,6 +69,7 @@ static int ttm_global_init(void)
 	unsigned long num_pages, num_dma32;
 	struct sysinfo si;
 	int ret = 0;
+	int tmp;
 
 	mutex_lock(&ttm_global_mutex);
 	if (++ttm_glob_use_count > 1)
@@ -78,9 +79,9 @@ static int ttm_global_init(void)
 
 	ttm_debugfs_root = debugfs_create_dir("ttm", NULL);
 	if (IS_ERR(ttm_debugfs_root)) {
-		ret = PTR_ERR(ttm_debugfs_root);
-		ttm_debugfs_root = NULL;
-		goto out;
+		tmp = PTR_ERR(ttm_debugfs_root);
+		if (tmp != -ENODEV)
+			pr_err("failed to create debugfs: %d", tmp);
 	}
 
 	/* Limit the number of pages in the pool to about 50% of the total
-- 
2.31.1

