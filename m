Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71E34260BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 01:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238708AbhJGXzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 19:55:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhJGXzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 19:55:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1254360F46;
        Thu,  7 Oct 2021 23:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633650797;
        bh=y0qzneFXNeP9iCdOlPbYWTtbepyVfClijM/4p7T8XlA=;
        h=From:To:Cc:Subject:Date:From;
        b=W2kBPG+HleHUlHNFB3OZK0Y3M2Io8JMGKILpQdHpQgTdqWPucHcEt8k2RVIpPZ13t
         aMPsX1nQtJ03z877pN86lqk5AhA3k1n+5laIm6GnHUFMoiuNtOht7Gf97eP8Hn+uf0
         M53wCttwkvYru0DamLxOqJCWOffruMNdDpGIfgp5TlZcghmgPW+wHYpWFWobyhP+0R
         ThGZEH5hnnft47AAQ38F+98mCWkLy/c4lU1MQCcJgvXE+Q9PXugzKQTqYmShGjvBLT
         hf3CdD038lKs4Is7J97D1jdiYzrGFGx8LfIwXDjeoYKP/fEXQLzGeQsvitYsudc+tw
         LEXGCQPVgiGwA==
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 0/5] Revert series "CMDQ refinement of Mediatek DRM driver"
Date:   Fri,  8 Oct 2021 07:53:05 +0800
Message-Id: <20211007235310.14626-1-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c1ec54b7b5af
("drm/mediatek: Use mailbox rx_callback instead of cmdq_task_cb")
would cause numerous mtk cmdq mailbox driver warning:

WARNING: CPU: 0 PID: 0 at drivers/mailbox/mtk-cmdq-mailbox.c:198
cmdq_task_exec_done+0xb8/0xe0

So revert that patch and all the patches depend on that patch.

Chun-Kuang Hu (5):
  Revert "drm/mediatek: Clear pending flag when cmdq packet is done"
  Revert "drm/mediatek: Add cmdq_handle in mtk_crtc"
  Revert "drm/mediatek: Detect CMDQ execution timeout"
  Revert "drm/mediatek: Remove struct cmdq_client"
  Revert "drm/mediatek: Use mailbox rx_callback instead of cmdq_task_cb"

 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 157 ++++--------------------
 1 file changed, 24 insertions(+), 133 deletions(-)

-- 
2.25.1

