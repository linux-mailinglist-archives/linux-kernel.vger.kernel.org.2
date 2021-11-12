Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F5044E58D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 12:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbhKLL1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 06:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbhKLL13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 06:27:29 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D766FC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 03:24:38 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so7328079pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 03:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T9wqkH9bvAwB8f9F9+uOBqJWqvyAq2GKd5TaGm+pXFw=;
        b=k7djde65D5+bmsyDgCCkkGPdyGUKZx5wHM2Gz/IZywZVkhc/emt5dcOQ3YPEMCPZay
         jiJA9vkV4aUT9EIoVvs6ixJuh8KL3RRSE3avHfdgNsUbxUz5hFUTThi+HHTU+JGRdLaZ
         jmSQZ2ubSqFZClQ1bzewDUOhe0MnDKUb9M4Ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T9wqkH9bvAwB8f9F9+uOBqJWqvyAq2GKd5TaGm+pXFw=;
        b=i00SvftQNlnzWmkkNwgpmR/jFRp72JBZgPFFiKKHpgbe/jdpuxsBRHL4kKUOMZisnK
         EP0ClyBAWiVLGXf27BfN4hgdkQK8OdO+7IFvZDlhgkJkEjClNaDA4tPUXS87p4gYJW3l
         iVgv3nIjLFIeeuRF7cyNnMJ2KbUHaYuwXhjgqEESgfUDxlwja4NxGwGa4Znq2ExaGTO9
         sL+0AMHKNJT79cTYHgxCHtiNWCgAlTdEW/rszWLTr1Wbut62OH+HMrgRFEnEjp5wnpi9
         CBu8Cdeqy989Eez7AkDq2MsdX2YukcKwYtI702VdwAq1UIaCCb/FoLwErD3U2Jf9E8Zy
         yKJQ==
X-Gm-Message-State: AOAM531juNM38jto5FtsVtktBWqQHKI4OuRa3XBhqJ8dgaUr+76jdJg+
        o5DtQKD7S6HrJJLtf5Ze1z3rvcdPwNnzPA==
X-Google-Smtp-Source: ABdhPJyM2vw9g4VA5zsJdYxFWjZh3TPf2EHpv8A/1s8edDOEdfNdR8rUMtnS/ylrCpGHjtadhkTwWg==
X-Received: by 2002:a17:90b:4c44:: with SMTP id np4mr16710355pjb.195.1636716278293;
        Fri, 12 Nov 2021 03:24:38 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:6a1a:b806:e064:392a])
        by smtp.gmail.com with ESMTPSA id j9sm3431093pgt.54.2021.11.12.03.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 03:24:37 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Robert Foss <robert.foss@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Xin Ji <xji@analogixsemi.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: anx7625: Fix edid_read break case in sp_tx_edid_read()
Date:   Fri, 12 Nov 2021 19:24:33 +0800
Message-Id: <20211112112433.942075-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

edid_read() was assumed to return 0 on success. After
7f16d0f3b8e2("drm/bridge: anx7625: Propagate errors from sp_tx_rst_aux()"),
the function can return >= 0 for successful case. Fix the g_edid_break
condition in sp_tx_edid_read().

Fixes: 7f16d0f3b8e2("drm/bridge: anx7625: Propagate errors from sp_tx_rst_aux()")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 1a871f6b6822ee..392203b576042b 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -826,7 +826,7 @@ static int sp_tx_edid_read(struct anx7625_data *ctx,
 				g_edid_break = edid_read(ctx, offset,
 							 pblock_buf);
 
-				if (g_edid_break)
+				if (g_edid_break < 0)
 					break;
 
 				memcpy(&pedid_blocks_buf[offset],
-- 
2.34.0.rc1.387.gb447b232ab-goog

