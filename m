Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C8834D41A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhC2Pha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:37:30 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51300 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbhC2Pgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:36:55 -0400
Received: from guri.fritz.box (unknown [IPv6:2a02:810a:880:f54:85ba:22ea:8b43:4375])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 485381F40F09;
        Mon, 29 Mar 2021 16:36:52 +0100 (BST)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     dafna.hirschfeld@collabora.com, kernel@collabora.com,
        dafna3@gmail.com, chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        airlied@linux.ie, daniel@ffwll.ch, enric.balletbo@collabora.com,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH v2 0/3] drm/mediatek: Don't support hdmi connector creation
Date:   Mon, 29 Mar 2021 17:36:29 +0200
Message-Id: <20210329153632.17559-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit f01195148967 ("drm/mediatek: mtk_dpi: Create connector for bridges")
broke the display support for elm device since mtk_dpi calls
drm_bridge_attach with the flag DRM_BRIDGE_ATTACH_NO_CONNECTOR
while mtk_hdmi does not yet support this flag.

These three patches fix that by adding support for DRM_BRIDGE_ATTACH_NO_CONNECTOR
in mtk_hdmi bridge attachment.

changes since v1:
1. split the first patch - now the first patch only moves the bridge ops to the atomic API
while the replacement of the field 'conn' with the field '*curr_conn' is done in a new third patch.
2. in the function 'get_eld' use the current conn only if 'enabled = true'.

Dafna Hirschfeld (3):
  drm/mediatek: Switch the hdmi bridge ops to the atomic versions
  drm/mediatek: Don't support hdmi connector creation
  drm/mediatek: in struct mtk_hdmi, replace conn field with curr_conn
    ptr

 drivers/gpu/drm/mediatek/mtk_hdmi.c | 171 ++++++++++++----------------
 1 file changed, 73 insertions(+), 98 deletions(-)

-- 
2.17.1

