Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A983E3D2E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 01:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbhHHXsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 19:48:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230034AbhHHXsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 19:48:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21A5560F0F;
        Sun,  8 Aug 2021 23:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628466468;
        bh=vAX7ct7i52crHEpDhW8a+hOoXWU7tRkGXmsRCoFh/F0=;
        h=From:To:Cc:Subject:Date:From;
        b=Zfh9SdjTpJXAXQZziq3FKDbPJgWbqPcZEsHdxHS4tv+OhIwlF4ywJMYdjXuaU75Om
         po/10SD6SPkBi93nV5sVohojN3i786MuuheAzWLYi2+jmoNEHnOyQjn9Dq5Xn35Mei
         +CQ0QawA3evvh7TSmLkGBIaK2Cdrbx5sIQmKPJQStWGV3Q7Rc+TRsLs6wEaXpYq1eQ
         2Os3Q8yj7xXwNFWNrQhoFzLTtoO6Me7Eh7oaGx5JWAKnK3tZVZcSv05mEEypmApt0q
         pTFjRJmdssNv37FHKA3UJGKGNSQlSmdflRovjhSICi7fLQhgaCbnZ+cag6L5jMThcC
         WEf9R1OdAKRww==
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH v2 0/4] CMDQ refinement of Mediatek DRM driver
Date:   Mon,  9 Aug 2021 07:47:29 +0800
Message-Id: <20210808234733.14782-1-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These refinements include using standard mailbox callback interface,
timeout detection, and a fixed cmdq_handle.

Changes in v2:
1. Define mtk_drm_cmdq_pkt_create() and mtk_drm_cmdq_pkt_destroy()
   when CONFIG_MTK_CMDQ is reachable.

Chun-Kuang Hu (4):
  drm/mediatek: Use mailbox rx_callback instead of cmdq_task_cb
  drm/mediatek: Remove struct cmdq_client
  drm/mediatek: Detect CMDQ execution timeout
  drm/mediatek: Add cmdq_handle in mtk_crtc

 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 110 ++++++++++++++++++++----
 1 file changed, 91 insertions(+), 19 deletions(-)

-- 
2.25.1

