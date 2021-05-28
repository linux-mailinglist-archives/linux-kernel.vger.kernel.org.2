Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347923947F6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 22:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhE1Ucm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 16:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhE1Ucj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 16:32:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D901C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:31:03 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b26so7065537lfq.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vuoM3pI1kbUC5NFBrjLCZhuScVL8DqZ8CBiPpQoVDh0=;
        b=YaxDu+1PlL4rDOFbzA9sK4Pfrvy1JMkgAtk3bsAgr+ODyNM/u9UIK/3Ddcs4lvMK5e
         lL9fFlx90VghFJ16RPRzM6yaUj/oZs8L4MPv5mWkLCdtPgUksXWgRsNxZXpXqzpu0tf4
         Wc5SBK8v4vSDKK61M6HX0y+kI836ITvBpWw/qSYiVV04M1jJ051F4F4ukdwCGtNmJDUi
         6jhggtHqvnDS4FPSZPvsdheUGDH6hW9XkRLQg7jUFb1K96c1i6Gz7Yk5g5Dub+DEjg51
         o06QTgU9h/KBaWsbOtvIv3hqEzPHeVtJ+aNUUQhF5HegWquVYjfebEczd0HDKYWGztPD
         jzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vuoM3pI1kbUC5NFBrjLCZhuScVL8DqZ8CBiPpQoVDh0=;
        b=mZLMe+W06egTB6Pgwp4Pd3JSY26zqt+4lVR95buQ99DxvinOXuYF6b9CqsJAeqQS/R
         69bJzPQ1IPXOYpRpuAkstjikMJZYsXrIKyWVrMHTeW1Ak9OYbQdSBB7xoA6dp9hhrU5V
         qoaz8aW6hXNEnoNxgUWb1b3tHF2VWK9KY2HVwgq1Cgb8/EF0N0aHJ81Fgy0JPcMQ/MdX
         WZ7DKBt1AAKD/aeWxOBxzj7qyjn+Xs/E7X8Qd61CKhIKPjppF4OC87Zj16mFBS2qUYf0
         d6ZCYd6f2wrH20on3Bs47nX4rs+dq48ag+QNWyLXx+ZF2m83sMB+LEz/NjOI/8+3vgTv
         htiw==
X-Gm-Message-State: AOAM533NR27XbsTYTZCsQIiBaB48ZqIwY1ucuDBmHizwDDUXaD1zzebB
        txI/GPXgep3God3TcCKvq3dYinjMm8tGuw==
X-Google-Smtp-Source: ABdhPJyNO4+/xp6BFlx0xfuncqzgNoZ2hriV1Z4J3oSHun1F/RLW8ffaXQVu2FhKGT7E6WASEyCDrg==
X-Received: by 2002:a05:6512:2393:: with SMTP id c19mr6479223lfv.652.1622233861285;
        Fri, 28 May 2021 13:31:01 -0700 (PDT)
Received: from roman-S500CA.. (72-28-179-94.pool.ukrtel.net. [94.179.28.72])
        by smtp.gmail.com with ESMTPSA id a12sm655820ljk.34.2021.05.28.13.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 13:31:00 -0700 (PDT)
From:   Roman Stratiienko <r.stratiienko@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mripard@kernel.org, wens@csie.org, jernej.skrabec@siol.net,
        megous@megous.com, linux-sunxi@googlegroups.com,
        dri-devel@lists.freedesktop.org,
        Roman Stratiienko <r.stratiienko@gmail.com>
Subject: [PATCH v4 1/2] drm/sun4i: Add mode_set callback to the engine
Date:   Fri, 28 May 2021 23:30:35 +0300
Message-Id: <20210528203036.17999-2-r.stratiienko@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210528203036.17999-1-r.stratiienko@gmail.com>
References: <20210528203036.17999-1-r.stratiienko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create callback to allow updating engine's registers on mode change.

Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_crtc.c   |  3 +++
 drivers/gpu/drm/sun4i/sunxi_engine.h | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
index 45d9eb552d86..8f01a6b2bbef 100644
--- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
@@ -146,6 +146,9 @@ static void sun4i_crtc_mode_set_nofb(struct drm_crtc *crtc)
 	struct sun4i_crtc *scrtc = drm_crtc_to_sun4i_crtc(crtc);
 
 	sun4i_tcon_mode_set(scrtc->tcon, encoder, mode);
+
+	if (scrtc->engine->ops->mode_set)
+		scrtc->engine->ops->mode_set(scrtc->engine, mode);
 }
 
 static const struct drm_crtc_helper_funcs sun4i_crtc_helper_funcs = {
diff --git a/drivers/gpu/drm/sun4i/sunxi_engine.h b/drivers/gpu/drm/sun4i/sunxi_engine.h
index 548710a936d5..7faa844646ff 100644
--- a/drivers/gpu/drm/sun4i/sunxi_engine.h
+++ b/drivers/gpu/drm/sun4i/sunxi_engine.h
@@ -9,6 +9,7 @@
 struct drm_plane;
 struct drm_device;
 struct drm_crtc_state;
+struct drm_display_mode;
 
 struct sunxi_engine;
 
@@ -108,6 +109,17 @@ struct sunxi_engine_ops {
 	 * This function is optional.
 	 */
 	void (*vblank_quirk)(struct sunxi_engine *engine);
+
+	/**
+	 * @mode_set:
+	 *
+	 * This callback is used to update engine registers that
+	 * responsible for display frame size and other mode attributes.
+	 *
+	 * This function is optional.
+	 */
+	void (*mode_set)(struct sunxi_engine *engine,
+			 struct drm_display_mode *mode);
 };
 
 /**
-- 
2.30.2

