Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C521043124A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 10:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhJRIn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 04:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhJRIn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 04:43:57 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC16C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 01:41:46 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pi19-20020a17090b1e5300b0019fdd3557d3so11978466pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 01:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wk6+rEeyV7eHbPWMKJo+Qpq+GwDxADSGhPjQYfKUne4=;
        b=jNiTi0cZOC9M6uQg94kZkSGn3OrAQrSu6r8SRssg//sn5P432teZU28/v9RIqdlD5O
         FDWwyESEa70tNVGhVeOGe1F5ZAIPJMKiX3P8jEiAbSyNM54IpSQyb9dk/vAcEJfMnrXj
         zNBHvhXgy/rMAPIBLXv/ABA4B+bVuAeA++cRSW1P7RugxMH24Vge6lJz1VOLhc25s/ls
         VIhydhuQ9C6tIKMxlUDIXZlJS9KBy1EfKYZ4K+ty6vz1zM3zC2/vlB6YVxPLlFVR9BvY
         h9NoAYponSEiN1Y8aUWWDEsWN+dvWZ48Asm2fHwd/sSG6AwymDCbgiQEDz9h6JfhgJtQ
         irfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wk6+rEeyV7eHbPWMKJo+Qpq+GwDxADSGhPjQYfKUne4=;
        b=2xF8ktGO4+O/Wy3d7C8Bh0d0pOu7IHwCdku7cHXEOIDPAvnFncS06eU4gZQLmRGyTS
         P8S6GGM3pv+ltBFsYmIWB84dOBbVHDQfgL9B5f6d7C2k5EOmYDenCWLaP/zvEsTyXBX3
         bS9q+wP8A1rYcNZOSrCVtRjqtKsk9T3ZYCSkJp6ORdaFu+FiuCCJlli5tyS89c3kW9qc
         nJfNmcsN0RDwoSOm/IXuoacN5M8B7a/rQADcYQwSoeUKLUh3s1dLsD9cxBnXMDWAJzFW
         WQyq7p0pOCIIRy9gfK1P/WRyp0rYZRH646bqco2pTUwioCjbx/wv5SIY56JzHp38XU38
         LBBw==
X-Gm-Message-State: AOAM530tchcxuoGiFRffZcbPnOR1TpraeX88M/GDeFFup+j5EjclT5Gq
        xOkiLsJpU2Aauruh7sqPFdQ=
X-Google-Smtp-Source: ABdhPJxXMPda9FOWVgG87Ibowe+I2Ff21yuG8uqATHh+NbcQaB8zGsEBOfKggffCbibaCL4IiPlIdQ==
X-Received: by 2002:a17:90a:b117:: with SMTP id z23mr46490695pjq.74.1634546506085;
        Mon, 18 Oct 2021 01:41:46 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id il17sm12642508pjb.52.2021.10.18.01.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 01:41:45 -0700 (PDT)
From:   luo penghao <cgel.zte@gmail.com>
X-Google-Original-From: luo penghao <luo.penghao@zte.com.cn>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/i915/display: Remove unused variable and corresponding assignment
Date:   Mon, 18 Oct 2021 08:41:40 +0000
Message-Id: <20211018084140.851583-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable is not used in functions, and its assignment is redundant too.
So it should be deleted.

The clang_analyzer complains as follows:

drivers/gpu/drm/i915/display/vlv_dsi.c:143:2 warning:

Value stored to 'data' is never read.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 drivers/gpu/drm/i915/display/vlv_dsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/vlv_dsi.c b/drivers/gpu/drm/i915/display/vlv_dsi.c
index 081b772..634de91 100644
--- a/drivers/gpu/drm/i915/display/vlv_dsi.c
+++ b/drivers/gpu/drm/i915/display/vlv_dsi.c
@@ -131,7 +131,7 @@ static ssize_t intel_dsi_host_transfer(struct mipi_dsi_host *host,
 	enum port port = intel_dsi_host->port;
 	struct mipi_dsi_packet packet;
 	ssize_t ret;
-	const u8 *header, *data;
+	const u8 *header;
 	i915_reg_t data_reg, ctrl_reg;
 	u32 data_mask, ctrl_mask;
 
@@ -140,7 +140,6 @@ static ssize_t intel_dsi_host_transfer(struct mipi_dsi_host *host,
 		return ret;
 
 	header = packet.header;
-	data = packet.payload;
 
 	if (msg->flags & MIPI_DSI_MSG_USE_LPM) {
 		data_reg = MIPI_LP_GEN_DATA(port);
-- 
2.15.2
