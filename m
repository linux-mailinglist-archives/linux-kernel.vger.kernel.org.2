Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0D6349EA6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhCZB0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:26:13 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:24378 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhCZBZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:25:52 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 2696F98027A;
        Fri, 26 Mar 2021 09:25:49 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] [v2] drm/i915: Remove repeated declaration
Date:   Fri, 26 Mar 2021 09:25:17 +0800
Message-Id: <20210326012527.875026-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSUpDSU8ZSRodSk5KVkpNSk1MSUpCT0JMTUxVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBg6PBw5Pj8TPD1RTw4eC0IU
        MjUwFBVVSlVKTUpNTElKQk5LTUxNVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFIQkxJNwY+
X-HM-Tid: 0a786c2333ead992kuws2696f98027a
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct drm_i915_private, struct intel_crtc_state and
struct intel_crtc is declared twice.
Remove the duplicate.

Reviewed-by: José Roberto de Souza <jose.souza@intel.com>
Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
Changelog:
v2:
- Modify subject line.
- Delete trailing whitespace in commit log.
---
 drivers/gpu/drm/i915/display/intel_crt.h     | 1 -
 drivers/gpu/drm/i915/display/intel_display.h | 1 -
 drivers/gpu/drm/i915/display/intel_vrr.h     | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_crt.h b/drivers/gpu/drm/i915/display/intel_crt.h
index 1b3fba359efc..6c5c44600cbd 100644
--- a/drivers/gpu/drm/i915/display/intel_crt.h
+++ b/drivers/gpu/drm/i915/display/intel_crt.h
@@ -11,7 +11,6 @@
 enum pipe;
 struct drm_encoder;
 struct drm_i915_private;
-struct drm_i915_private;
 
 bool intel_crt_port_enabled(struct drm_i915_private *dev_priv,
 			    i915_reg_t adpa_reg, enum pipe *pipe);
diff --git a/drivers/gpu/drm/i915/display/intel_display.h b/drivers/gpu/drm/i915/display/intel_display.h
index 76f8a805b0a3..29cb6d84ed70 100644
--- a/drivers/gpu/drm/i915/display/intel_display.h
+++ b/drivers/gpu/drm/i915/display/intel_display.h
@@ -48,7 +48,6 @@ struct i915_ggtt_view;
 struct intel_atomic_state;
 struct intel_crtc;
 struct intel_crtc_state;
-struct intel_crtc_state;
 struct intel_digital_port;
 struct intel_dp;
 struct intel_encoder;
diff --git a/drivers/gpu/drm/i915/display/intel_vrr.h b/drivers/gpu/drm/i915/display/intel_vrr.h
index fac01bf4ab50..96f9c9c27ab9 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.h
+++ b/drivers/gpu/drm/i915/display/intel_vrr.h
@@ -15,7 +15,6 @@ struct intel_crtc;
 struct intel_crtc_state;
 struct intel_dp;
 struct intel_encoder;
-struct intel_crtc;
 
 bool intel_vrr_is_capable(struct drm_connector *connector);
 void intel_vrr_check_modeset(struct intel_atomic_state *state);
-- 
2.25.1

