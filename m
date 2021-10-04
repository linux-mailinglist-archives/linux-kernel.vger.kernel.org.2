Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED34F4213F5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 18:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbhJDQX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 12:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236674AbhJDQX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 12:23:58 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4ADC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 09:22:09 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y1so234235plk.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 09:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CFpFWPozOzmy1DYe8ZLU7j6QoXqHuTATAw+aImmNdlM=;
        b=jYaBj98wBy8NWMsSZogOXvVs5ZrmutlaeeQHykTZuMA/iEJvsrJTzKqDAIVPtzQRJX
         a2XM+P0+y5KIzZ87gXb63Tk+KiB53e4xf5PVZFTFaQy3rIPYKm8Kx2LYuodD+EFSu7Yr
         fHGF4ijZW8+zjdGbtmBo0qAleKuiyQJsFEJws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CFpFWPozOzmy1DYe8ZLU7j6QoXqHuTATAw+aImmNdlM=;
        b=q4mMRsRMfSSTMdXnf9pxhAJyaCeDlNl/m3Oxf4ZrK4PWJwdWu65zTGIhJpr96cDiF2
         lHORrNJ84Klgs2lsRWk2aCAGR4ENqMm+7rjLvg2p1F/EWg29UghuW3IAgEikbLQEiZBP
         gUck8P57v8Qn6WNb3945sHj2x3NDu+h7DE020MbsL7gXHM+kh221UY8KBNDqFtvpW/5n
         rpV0fv/H6aZkLoKHR5p997pw6egbxyY1dylz6zUoo3NcrAS1DLt2KXCjlurs9zjIfFeW
         q1hn2cIu5NCxhhWWyS2QbgAoW98E/D7le2x6usRUGGB/opCqfv4my6rTjhqWGqYJEk/p
         RrAw==
X-Gm-Message-State: AOAM530mr1qx2xzAzo1HLpl+gDp3ZsOfq6PuaUSI2iIZ4hTK34Bn7jHn
        XffH4XQFi4T0cI3BnIgKex/UaQ==
X-Google-Smtp-Source: ABdhPJyZp0tzYGkW5Se1POV4ouM3VXk0hM9wnbQTUnbk89IdzQNv6XhqoWjTDpDMwqUtpEQMHE/eLg==
X-Received: by 2002:a17:90b:1806:: with SMTP id lw6mr25650086pjb.222.1633364528836;
        Mon, 04 Oct 2021 09:22:08 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:5ca5:f2e1:5fdb:e20e])
        by smtp.gmail.com with ESMTPSA id w5sm14334476pgp.79.2021.10.04.09.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:22:08 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     geert@linux-m68k.org, oliver.sang@intel.com,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/edid: Fix crash with zero/invalid EDID
Date:   Mon,  4 Oct 2021 09:21:27 -0700
Message-Id: <20211004092100.1.Ic90a5ebd44c75db963112be167a03cc96f9fb249@changeid>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the commit bac9c2948224 ("drm/edid: Break out reading block 0 of
the EDID") I broke out reading the base block of the EDID to its own
function. Unfortunately, when I did that I messed up the handling when
drm_edid_is_zero() indicated that we had an EDID that was all 0x00 or
when we went through 4 loops and didn't get a valid EDID. Specifically
I needed to pass the broken EDID to connector_bad_edid() but now I was
passing an error-pointer.

Let's re-jigger things so we can pass the bad EDID in properly.

Fixes: bac9c2948224 ("drm/edid: Break out reading block 0 of the EDID")
Reported-by: kernel test robot <oliver.sang@intel.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/drm_edid.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 9b19eee0e1b4..9c9463ec5465 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -1911,13 +1911,15 @@ int drm_add_override_edid_modes(struct drm_connector *connector)
 }
 EXPORT_SYMBOL(drm_add_override_edid_modes);
 
-static struct edid *drm_do_get_edid_base_block(
+static struct edid *drm_do_get_edid_base_block(struct drm_connector *connector,
 	int (*get_edid_block)(void *data, u8 *buf, unsigned int block,
 			      size_t len),
-	void *data, bool *edid_corrupt, int *null_edid_counter)
+	void *data)
 {
-	int i;
+	int *null_edid_counter = connector ? &connector->null_edid_counter : NULL;
+	bool *edid_corrupt = connector ? &connector->edid_corrupt : NULL;
 	void *edid;
+	int i;
 
 	edid = kmalloc(EDID_LENGTH, GFP_KERNEL);
 	if (edid == NULL)
@@ -1941,9 +1943,8 @@ static struct edid *drm_do_get_edid_base_block(
 	return edid;
 
 carp:
-	kfree(edid);
-	return ERR_PTR(-EINVAL);
-
+	if (connector)
+		connector_bad_edid(connector, edid, 1);
 out:
 	kfree(edid);
 	return NULL;
@@ -1982,14 +1983,9 @@ struct edid *drm_do_get_edid(struct drm_connector *connector,
 	if (override)
 		return override;
 
-	edid = (u8 *)drm_do_get_edid_base_block(get_edid_block, data,
-						&connector->edid_corrupt,
-						&connector->null_edid_counter);
-	if (IS_ERR_OR_NULL(edid)) {
-		if (IS_ERR(edid))
-			connector_bad_edid(connector, edid, 1);
+	edid = (u8 *)drm_do_get_edid_base_block(connector, get_edid_block, data);
+	if (!edid)
 		return NULL;
-	}
 
 	/* if there's no extensions or no connector, we're done */
 	valid_extensions = edid[0x7e];
@@ -2142,14 +2138,13 @@ u32 drm_edid_get_panel_id(struct i2c_adapter *adapter)
 	struct edid *edid;
 	u32 panel_id;
 
-	edid = drm_do_get_edid_base_block(drm_do_probe_ddc_edid, adapter,
-					  NULL, NULL);
+	edid = drm_do_get_edid_base_block(NULL, drm_do_probe_ddc_edid, adapter);
 
 	/*
 	 * There are no manufacturer IDs of 0, so if there is a problem reading
 	 * the EDID then we'll just return 0.
 	 */
-	if (IS_ERR_OR_NULL(edid))
+	if (!edid)
 		return 0;
 
 	panel_id = edid_extract_panel_id(edid);
-- 
2.33.0.800.g4c38ced690-goog

