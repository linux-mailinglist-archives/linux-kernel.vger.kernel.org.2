Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6912144804C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 14:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbhKHNdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 08:33:53 -0500
Received: from ptr.189.cn ([183.61.185.105]:11384 "EHLO 189.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236934AbhKHNdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 08:33:52 -0500
X-Greylist: delayed 633 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Nov 2021 08:33:52 EST
HMM_SOURCE_IP: 10.64.8.41:55728.1482080932
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id 33217100283;
        Mon,  8 Nov 2021 21:20:17 +0800 (CST)
Received: from  ([14.17.101.177])
        by gateway-151646-dep-b7fbf7d79-9vctg with ESMTP id 7f0b0ff87bb945df8ff1b647098bcf7c for maarten.lankhorst@linux.intel.com;
        Mon, 08 Nov 2021 21:20:18 CST
X-Transaction-ID: 7f0b0ff87bb945df8ff1b647098bcf7c
X-Real-From: 15330273260@189.cn
X-Receive-IP: 14.17.101.177
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        suijingfeng <suijingfeng@loongson.cn>
Subject: [PATCH] drm/drm_plane.h: fix a typo: not -> note
Date:   Mon,  8 Nov 2021 21:20:08 +0800
Message-Id: <20211108132008.3631-1-15330273260@189.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: suijingfeng <suijingfeng@loongson.cn>

Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
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
2.25.1

