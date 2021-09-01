Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C53D3FE18B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 19:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344602AbhIARzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 13:55:45 -0400
Received: from rosenzweig.io ([138.197.143.207]:45114 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236754AbhIARzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:55:44 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: [PATCH 1/5] drm: Add drm_fixed_16_16 helper
Date:   Wed,  1 Sep 2021 13:54:27 -0400
Message-Id: <20210901175431.14060-1-alyssa@rosenzweig.io>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This constructs a fixed 16.16 rational, useful to specify the minimum
and maximum scaling in drm_atomic_helper_check_plane_state. It is
open-coded as a macro in multiple drivers, so let's share the helper.

Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 include/drm/drm_fixed.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/drm/drm_fixed.h b/include/drm/drm_fixed.h
index 553210c02ee0..df1f369b4918 100644
--- a/include/drm/drm_fixed.h
+++ b/include/drm/drm_fixed.h
@@ -208,4 +208,9 @@ static inline s64 drm_fixp_exp(s64 x)
 	return sum;
 }
 
+static inline int drm_fixed_16_16(s32 mult, s32 div)
+{
+	return (mult << 16) / div;
+}
+
 #endif
-- 
2.30.2

