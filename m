Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB23F4479DF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 06:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbhKHFTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 00:19:21 -0500
Received: from mail.loongson.cn ([114.242.206.163]:57438 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232906AbhKHFTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 00:19:19 -0500
Received: from openarena.loongson.cn (unknown [10.20.41.56])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxL9OpsohhOhoBAA--.2467S2;
        Mon, 08 Nov 2021 13:16:25 +0800 (CST)
From:   suijingfeng <suijingfeng@loongson.cn>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     15330273260@189.cn, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/drm_plane.h: fix a typo: not -> note
Date:   Mon,  8 Nov 2021 13:16:25 +0800
Message-Id: <20211108051625.47207-1-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxL9OpsohhOhoBAA--.2467S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw1Utw1DCrWDKF1rZw15CFg_yoW3trbEva
        47Zw18u34UZ3y8tw15Z3WkZFyfKFW8GFs8Xw1rJan8AryDXF97JFs7XF1IkFyUWw1DK34D
        u3ZrX345Jr1I9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7kYjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK6svPMxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
        AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2xR6UUUUU
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

