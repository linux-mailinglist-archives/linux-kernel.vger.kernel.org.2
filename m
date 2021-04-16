Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B4D362B75
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbhDPWmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbhDPWlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:41:31 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D44CC06138F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:41:04 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id kb13-20020a17090ae7cdb02901503d67f0beso3728818pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2R2klhddf27fuauW3a9nuHGD7igaH//2CcQFXLlNraQ=;
        b=W68GHyvEpfO1q+3/O+WzdKvd5+OcVSwuE2lSZnkb74+WZqEEFrJnB442cV84JtH+gu
         ZZ90g6ROhJkBSzon9lsybQgkpuIcwXmRoe25MxkBJouMalRGkxewvuR0YlQ02ZoyH8a9
         hXau4cSfmaZNUzc3qyclV54Cs/OjcfmNE+vX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2R2klhddf27fuauW3a9nuHGD7igaH//2CcQFXLlNraQ=;
        b=ci0hNKGoe6pBfZtj4QCt/GKVCmQUc4e49PUQzR/4HWcubULcyuBihJrOmJQLk0c2qH
         jT7yAcY5hA/FE3W3rpsUHNhZsIn8euIp9VN/psEsnBu/hf3Q5g0SgxyukAsyP/mGW2oS
         jn2mOkEyINedOW6st0QmKTIPe65tyPN80igr4NVPqICSkeqxeyLrmzs4ZWIAtZSLDVQH
         y4fvitEXYyeR7cshVVHHKOFXep5CK2LrM1o+wtLVOl36lnQlLYy6Y3Unz0Iy42sCIrC8
         SsgrVp+avvaThIe6MAnm/EnXATvqYylZ23vo1n9dnllpRHhYD6333M+q5eEEHLHCVjkh
         jNkw==
X-Gm-Message-State: AOAM531MOcvcgXYiujE4nXZUcpCVeYlljOwGuchN6IGirEWtINAOuXit
        TJA7FCqOX9iOmBiFz8IN9UHQzQ==
X-Google-Smtp-Source: ABdhPJxm/SGUjFbh2/Xar7kdscd7cloDi3lndIKr2gslRNxF3aW7sbGnW3Vz+p2KOu0HjBZz74eitw==
X-Received: by 2002:a17:902:b494:b029:e7:36be:9ce7 with SMTP id y20-20020a170902b494b02900e736be9ce7mr11598042plr.43.1618612864099;
        Fri, 16 Apr 2021 15:41:04 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:dc8a:c9d0:aa5b:5386])
        by smtp.gmail.com with ESMTPSA id r6sm5633659pgp.64.2021.04.16.15.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:41:03 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>, Wolfram Sang <wsa@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, robdclark@chromium.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Steev Klimaszewski <steev@kali.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Linus W <linus.walleij@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/27] drm/bridge: ti-sn65dsi86: Clean debugfs code
Date:   Fri, 16 Apr 2021 15:39:33 -0700
Message-Id: <20210416153909.v4.10.I5fe072753290c6a77eda736ebd5778e17b7cb0fb@changeid>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210416223950.3586967-1-dianders@chromium.org>
References: <20210416223950.3586967-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's cleanup the debugfs code to:
- Check for errors.
- Use devm to manage freeing, which also means we don't need to store
  a pointer in our structure.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 32 +++++++++++++++++----------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 57574132e200..0c6aa99ddc99 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -118,7 +118,6 @@
  * @aux:          Our aux channel.
  * @bridge:       Our bridge.
  * @connector:    Our connector.
- * @debugfs:      Used for managing our debugfs.
  * @host_node:    Remote DSI node.
  * @dsi:          Our MIPI DSI source.
  * @edid:         Detected EDID of eDP panel.
@@ -146,7 +145,6 @@ struct ti_sn65dsi86 {
 	struct drm_dp_aux		aux;
 	struct drm_bridge		bridge;
 	struct drm_connector		connector;
-	struct dentry			*debugfs;
 	struct edid			*edid;
 	struct device_node		*host_node;
 	struct mipi_dsi_device		*dsi;
@@ -245,18 +243,30 @@ static int status_show(struct seq_file *s, void *data)
 
 DEFINE_SHOW_ATTRIBUTE(status);
 
-static void ti_sn65dsi86_debugfs_init(struct ti_sn65dsi86 *pdata)
+static void ti_sn65dsi86_debugfs_remove(void *data)
 {
-	pdata->debugfs = debugfs_create_dir(dev_name(pdata->dev), NULL);
-
-	debugfs_create_file("status", 0600, pdata->debugfs, pdata,
-			&status_fops);
+	debugfs_remove_recursive(data);
 }
 
-static void ti_sn65dsi86_debugfs_remove(struct ti_sn65dsi86 *pdata)
+static void ti_sn65dsi86_debugfs_init(struct ti_sn65dsi86 *pdata)
 {
-	debugfs_remove_recursive(pdata->debugfs);
-	pdata->debugfs = NULL;
+	struct device *dev = pdata->dev;
+	struct dentry *debugfs;
+	int ret;
+
+	debugfs = debugfs_create_dir(dev_name(dev), NULL);
+	if (IS_ERR(debugfs))
+		ret = PTR_ERR(debugfs);
+	else
+		ret = devm_add_action_or_reset(dev, ti_sn65dsi86_debugfs_remove,
+					       debugfs);
+
+	if (ret) {
+		dev_warn(dev, "Failed to create debugfs (%d), skipping\n", ret);
+		return;
+	}
+
+	debugfs_create_file("status", 0600, debugfs, pdata, &status_fops);
 }
 
 /* Connector funcs */
@@ -1310,8 +1320,6 @@ static int ti_sn65dsi86_remove(struct i2c_client *client)
 
 	kfree(pdata->edid);
 
-	ti_sn65dsi86_debugfs_remove(pdata);
-
 	drm_bridge_remove(&pdata->bridge);
 
 	pm_runtime_disable(pdata->dev);
-- 
2.31.1.368.gbe11c130af-goog

