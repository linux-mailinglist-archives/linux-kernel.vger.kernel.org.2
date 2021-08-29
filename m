Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37813FAD02
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 18:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbhH2QFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 12:05:20 -0400
Received: from rosenzweig.io ([138.197.143.207]:44196 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235548AbhH2QFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 12:05:18 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     dri-devel@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: [PATCH] drm/plane: Fix comment typo
Date:   Sun, 29 Aug 2021 12:04:01 -0400
Message-Id: <20210829160401.4588-1-alyssa@rosenzweig.io>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor typofix noticed when reading the KMS documentation.

Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 include/drm/drm_plane.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index fed97e35626f..0c1102dc4d88 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -43,7 +43,7 @@ enum drm_scaling_filter {
 /**
  * struct drm_plane_state - mutable plane state
  *
- * Please not that the destination coordinates @crtc_x, @crtc_y, @crtc_h and
+ * Please note that the destination coordinates @crtc_x, @crtc_y, @crtc_h and
  * @crtc_w and the source coordinates @src_x, @src_y, @src_h and @src_w are the
  * raw coordinates provided by userspace. Drivers should use
  * drm_atomic_helper_check_plane_state() and only use the derived rectangles in
-- 
2.30.2

