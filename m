Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC093912E0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbhEZItn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbhEZItQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:16 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20734C06138F
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:45 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j14so207453wrq.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b58/b35h1ySITpV32UiH3hgADkqDQkiEXVcNLNWEueg=;
        b=lS2dDBdK3+lqs/BpdDNpVbyj4ptYsVo8RYqPRKNGSWwAX72gmfXIQtRmaqAPtS2a27
         VtwUMNtHed1uPMM4kJHGvF41ejYzstijQToVtJKeXj4Au3Xe4o+RehgjcsYOTuxsA7Wq
         AHXdyji7xPFSiksN67m9VVZbiR0XEx+MFzWgP7tOq3GT4vnTbW+LTnYVvozRJ8YJckp1
         15CLocjxNl4gGzqAYHsa0Tud7Fljic6Ockj+03OqQy4v5wU2hhyGJ4W1ORbj31C8z3gc
         +LXHOUkVrztyKpQk8k2SwIqHIxOSF0HR48NvkUB2iml7BjE8fI0Tln6vmDCVv3WSwXgr
         P3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b58/b35h1ySITpV32UiH3hgADkqDQkiEXVcNLNWEueg=;
        b=jxelfAdBWTwulIbSdqr+naf4nGm7gFB1PP//vesqB+pO076nJ5sk+brc5zYEuu3xsY
         3u+wEDlTpH7LZs4jJrMtnWagODax5fgh29Sx5PpAjvfjfvLdr4ERXNEiSHETuNzs5GbT
         iucFXSs6e9HtF0Obo75hkOdcWknqH+Mv8kD0L92Lb8rZbzd6apXmbqbTLb8duXXFNvui
         xckHG4xdjsaDsmXuNye0B2o4LnlQ9PqsTkTrWYpxFjPCsr273mZTQqIUzBY0TVSmkCHW
         Dwg6Kyn0jMqnjOukEYgMKTgVinlWcnO0tYpaFwSeIgUn1Mxo2z6S2CJ2l7B6bgxKJJam
         dvTg==
X-Gm-Message-State: AOAM533cJN40VK0AI9yGfzvmOBcXiAJJtZPz33ZyAThPmT7Hp5s9j15O
        P6oClgTANZY4oiS7y2zpwUtzAg==
X-Google-Smtp-Source: ABdhPJyNaLy+RiYocIz059ItZ6quUW2ShSpj8xz6ANJUGgnXUvL5SlhLPaLRy61OVzWgjhdqgUb6eA==
X-Received: by 2002:a5d:4e8c:: with SMTP id e12mr31664433wru.94.1622018863739;
        Wed, 26 May 2021 01:47:43 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:43 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
        Jun Lei <Jun.Lei@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 13/34] drm/amd/display/dc/dce/dmub_outbox: Convert over to kernel-doc
Date:   Wed, 26 May 2021 09:47:05 +0100
Message-Id: <20210526084726.552052-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_outbox.c:30: warning: Cannot understand  *****************************************************************************

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Cc: Jun Lei <Jun.Lei@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../gpu/drm/amd/display/dc/dce/dmub_outbox.c    | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_outbox.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_outbox.c
index 295596d1f47f2..faad8555ddbb6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_outbox.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_outbox.c
@@ -27,19 +27,10 @@
 #include "dmub/inc/dmub_cmd.h"
 
 /**
- *****************************************************************************
- *  Function: dmub_enable_outbox_notification
- *
- *  @brief
- *		Sends inbox cmd to dmub to enable outbox1 messages with interrupt.
- *		Dmub sends outbox1 message and triggers outbox1 interrupt.
- *
- *  @param
- *		[in] dc: dc structure
- *
- *  @return
- *     None
- *****************************************************************************
+ *  dmub_enable_outbox_notification - Sends inbox cmd to dmub to enable outbox1
+ *                                    messages with interrupt. Dmub sends outbox1
+ *                                    message and triggers outbox1 interrupt.
+ * @dc: dc structure
  */
 void dmub_enable_outbox_notification(struct dc *dc)
 {
-- 
2.31.1

