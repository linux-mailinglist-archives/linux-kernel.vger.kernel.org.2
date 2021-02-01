Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EDB30A46E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 10:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbhBAJeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:34:50 -0500
Received: from mail.loongson.cn ([114.242.206.163]:46984 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232830AbhBAJek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:34:40 -0500
Received: from ubuntu.localdomain (unknown [124.64.18.147])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx3_PxyhdgZS0BAA--.1258S2;
        Mon, 01 Feb 2021 17:33:44 +0800 (CST)
From:   Zhaoge Zhang <zhangzhaoge@loongson.cn>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: Fix drm_atomic_get_new_crtc_state call error
Date:   Mon,  1 Feb 2021 17:33:44 +0800
Message-Id: <1612172024-3556-1-git-send-email-zhangzhaoge@loongson.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: AQAAf9Dx3_PxyhdgZS0BAA--.1258S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFW8XFWrAr1DtrW3Jr47Jwb_yoWfAFc_W3
        W7Xw4xK39xCryvy3Wjyrs8ta4IkasFvF48W3WjqayrAryvgry5Aw43WFnYgr15XF1UX39F
        qanrX34qyrn7KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb28YjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r4fMxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jY89tUUUUU=
X-CM-SenderInfo: x2kd0w52kd0w3h6o00pqjv00gofq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This position is to clear the previous mask flags,
so drm_atomic_get_crtc_state should be used.

Signed-off-by: Zhaoge Zhang <zhangzhaoge@loongson.cn>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 268bb69..07fe01b 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -313,8 +313,8 @@ drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state,
 		return 0;
 
 	if (conn_state->crtc) {
-		crtc_state = drm_atomic_get_new_crtc_state(conn_state->state,
-							   conn_state->crtc);
+		crtc_state = drm_atomic_get_crtc_state(conn_state->state,
+							conn_state->crtc);
 
 		crtc_state->connector_mask &=
 			~drm_connector_mask(conn_state->connector);
-- 
2.7.4

