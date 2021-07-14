Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CEC3C8996
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237980AbhGNRUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhGNRUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:20:45 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB37C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 10:17:53 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s18so3174297pgq.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 10:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bENsX+LeMytA2zjVecvBK1VL3puGtwAJgEyJncEZ4GQ=;
        b=I2FYLupL1xI0cs2auUwgoUh+J5wb2099XljgutjGzDdgMC2NOVMZ1chfJn4Lxcgyf1
         gZY603cMnrg3wfp1vnXHTZ+0n6CPuKLv/xU4t/WskvzHm7tRGfr+TyFDGZaBbNIOOMsA
         G+nR/GkUT9NOrY2Sxh3428qnfANgBfZoiD8VA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bENsX+LeMytA2zjVecvBK1VL3puGtwAJgEyJncEZ4GQ=;
        b=oH/JgzUVReKMRKKVFGPfoYvFasoliicyK4jXbudxwCv1yUahesO+2plJLcc6yV42lr
         eXvwjwICqJDJX7xJqNyhgKyrQ90Dr2jfSoOdd5Qhc9zqPUFpy5PJJ4qednsG2G5S3o9I
         bZbN9dK7jjDv+Qb4bFbmS5p3xWLdXBNAq43XFFo+N+oEZcEgXWAm2Y/2CkvXTmn4/9eU
         f4J1i/SToAG5tEwN4aAnlma4J0tkLZZwSqZ4TUCic1KygGWU10ffNCApWNOrDWC83aoS
         WtS5A9l8052QbV1gZrdA3eOnDM3Md+yRBtLpzCqZyJkLRw0eQP0yRHGH7Mhc2veSVQMR
         dEPg==
X-Gm-Message-State: AOAM5315YOao02ufg+az5a3g8TXTy4i3RYSt+V8Ff3k+nCJawJHlCfkR
        aokEJ3bV06W2nsVhglC0GOeKMA==
X-Google-Smtp-Source: ABdhPJx7n6zTW3KQXf0LlLAL9PN0ojlSxrYavYaK8+VTBLX/hRmUNxtquGxKS1TGfMSy9Px9Y/de8g==
X-Received: by 2002:a62:80c5:0:b029:327:b54f:72f7 with SMTP id j188-20020a6280c50000b0290327b54f72f7mr11278437pfd.42.1626283073099;
        Wed, 14 Jul 2021 10:17:53 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:5a9d:ef42:7eb4:5fea])
        by smtp.gmail.com with ESMTPSA id t2sm6502681pjq.0.2021.07.14.10.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 10:17:52 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rajeev Nandan <rajeevny@codeaurora.org>,
        Lyude Paul <lyude@redhat.com>,
        Robert Foss <robert.foss@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/dp: For drm_panel_dp_aux_backlight(), init backlight as disabled
Date:   Wed, 14 Jul 2021 10:17:46 -0700
Message-Id: <20210714101744.1.Ifc22696b27930749915e383f0108b7bcdc015a6e@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even after the DP AUX backlight on my board worked OK after applying
the patch ("drm/panel-simple: Power the panel when probing DP AUX
backlight") [1], I still noticed some strange timeouts being reported
by ti_sn_aux_transfer(). Digging, I realized the problem was this:
* Even though `enabled` in `struct dp_aux_backlight` was false, the
  base backlight structure (`base` in that structure) thought that the
  backlight was powered on.
* If userspace wrote to sysfs in this state then we'd try to enable
  the backlight.
* Unfortunatley, enabling the backlight didn't work because the panel
  itself wasn't powered.

We can only use the backlight if the panel is on and the panel is not
officially on when we probe (it's temporarily just on enough for us to
talk to it).

The important thing we want here is to get `BL_CORE_FBBLANK` set since
userspace can't mess with that. This will keep us disabled until
drm_panel enables us, which means that the panel is enabled
first. Ideally we'd just set this in our `props` before calling
devm_backlight_device_register() but the comments in the header file
are pretty explicit that we're not supposed to much with the `state`
ourselves. Because of this, there may be a small window where the
backlight device is registered and someone could try to tweak with the
backlight. This isn't likely to happen and even if it did, I don't
believe this causes any huge problem.

[1] https://lore.kernel.org/lkml/20210714093334.1.Idb41f87e5abae4aee0705db7458b0097fc50e7ab@changeid/

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/drm_dp_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index e8eec20ab364..b5f75ca05774 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -3568,6 +3568,8 @@ int drm_panel_dp_aux_backlight(struct drm_panel *panel, struct drm_dp_aux *aux)
 	if (IS_ERR(bl->base))
 		return PTR_ERR(bl->base);
 
+	backlight_disable(bl->base);
+
 	panel->backlight = bl->base;
 
 	return 0;
-- 
2.32.0.93.g670b81a890-goog

