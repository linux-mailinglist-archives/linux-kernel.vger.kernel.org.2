Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490C744760C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 22:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbhKGVTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 16:19:23 -0500
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:60723 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235012AbhKGVTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 16:19:22 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id jpWnmO5VXwQZfjpWomDtl1; Sun, 07 Nov 2021 22:16:38 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 07 Nov 2021 22:16:38 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] gpu: host1x: Fix a memory leak in 'host1x_remove()'
Date:   Sun,  7 Nov 2021 22:16:36 +0100
Message-Id: <f3dc9c70f3dca6462a98d595e276c9d00f607bc8.1636319710.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <05c1932b66048ebf6742705e2ab16eea852c46d9.1636319710.git.christophe.jaillet@wanadoo.fr>
References: <05c1932b66048ebf6742705e2ab16eea852c46d9.1636319710.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a missing 'host1x_channel_list_free()' call in the remove function,
as already done in the error handling path of the probe function.

Fixes: 8474b02531c4 ("gpu: host1x: Refactor channel allocation code")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/host1x/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index fa00e31ea2f9..6cc749f030ee 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -533,6 +533,7 @@ static int host1x_remove(struct platform_device *pdev)
 	host1x_syncpt_deinit(host);
 	reset_control_assert(host->rst);
 	clk_disable_unprepare(host->clk);
+	host1x_channel_list_free(&host->channel_list);
 	host1x_iommu_exit(host);
 	host1x_bo_cache_destroy(&host->cache);
 
-- 
2.30.2

