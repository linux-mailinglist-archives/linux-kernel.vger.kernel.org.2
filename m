Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AED30BE1E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhBBMYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:24:30 -0500
Received: from mail-m17640.qiye.163.com ([59.111.176.40]:33268 "EHLO
        mail-m17640.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhBBMY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:24:29 -0500
Received: from ubuntu.localdomain (unknown [157.0.31.124])
        by mail-m17640.qiye.163.com (Hmail) with ESMTPA id F27EC5404D7;
        Tue,  2 Feb 2021 20:23:45 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Eric Anholt <eric@anholt.net>, Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drm/vc4: remove unneeded variable: "ret"
Date:   Tue,  2 Feb 2021 04:23:38 -0800
Message-Id: <20210202122338.15351-1-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZThoaT04aS0hDHR1MVkpNSklJTUNNSU1KQ0NVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P006Kjo*Tj8QTDYSFCkrLywU
        TBAaCQpVSlVKTUpJSU1DTUlNTkpJVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU9ZV1kIAVlBSkNPSDcG
X-HM-Tid: 0a7762b2e0ccd995kuwsf27ec5404d7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unneeded variable: "ret".

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/vc4/vc4_gem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index b641252939d8..445d3bab89e0 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -1026,7 +1026,6 @@ int vc4_queue_seqno_cb(struct drm_device *dev,
 		       void (*func)(struct vc4_seqno_cb *cb))
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
-	int ret = 0;
 	unsigned long irqflags;
 
 	cb->func = func;
@@ -1041,7 +1040,7 @@ int vc4_queue_seqno_cb(struct drm_device *dev,
 	}
 	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
 
-	return ret;
+	return 0;
 }
 
 /* Scheduled when any job has been completed, this walks the list of
-- 
2.29.0

