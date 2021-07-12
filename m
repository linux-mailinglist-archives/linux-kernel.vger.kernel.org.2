Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78903C6729
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 01:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhGLXxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 19:53:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232878AbhGLXxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 19:53:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E145C608FE;
        Mon, 12 Jul 2021 23:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626133821;
        bh=gUy0PrVeHFh0s36T5G5fu9zOhj3dvn5O88uSQ8Cwfms=;
        h=From:To:Cc:Subject:Date:From;
        b=kFB57WzxZdy4YGTAxV/3HyESb49xCZ10kHuoG3SuMpkVUGNGb6lAfwrdUbZJVGZXX
         dyzfipvn2hWiwarV7BSDlUlSXLy2VCa0f7CxHAHk5v2O49ycJ6si31rtiXGmeu/AQQ
         aQCYEqcbH+tgyD6gwoh98aAyXD93NxplI+vL8rQINR3q6buNRengZc5Ig3eNDQXJSZ
         g42AQYNYTcBb9rUovdZUw0Ipkb9gpVw8TyblxKWTd3F1swJqKUSzn9cnRG0MrvzJfe
         hFnmyLbkd7PvkbAF54Jbgpe/6TuNY/80yKktc1by5nZAsOtzIR2e4aX+6LIg+jquE/
         i1QwN00n1NHuA==
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 0/4] CMDQ refinement of Mediatek DRM driver
Date:   Tue, 13 Jul 2021 07:50:10 +0800
Message-Id: <20210712235014.42673-1-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These refinements include using standard mailbox callback interface,
timeout detection, and a fixed cmdq_handle.

Chun-Kuang Hu (4):
  drm/mediatek: Use mailbox rx_callback instead of cmdq_task_cb
  drm/mediatek: Remove struct cmdq_client
  drm/mediatek: Detect CMDQ execution timeout
  drm/mediatek: Add cmdq_handle in mtk_crtc

 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 110 ++++++++++++++++++++----
 1 file changed, 91 insertions(+), 19 deletions(-)

-- 
2.25.1

