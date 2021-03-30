Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CFD34E61D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhC3LJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbhC3LJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:09:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B763CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:09:11 -0700 (PDT)
Received: from guri.fritz.box (unknown [IPv6:2a02:810a:880:f54:2d37:13aa:2f32:9c00])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id CC72D1F4520F;
        Tue, 30 Mar 2021 12:09:09 +0100 (BST)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     dafna.hirschfeld@collabora.com, kernel@collabora.com,
        dafna3@gmail.com, chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        airlied@linux.ie, daniel@ffwll.ch, enric.balletbo@collabora.com,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH v3 0/2] drm/mediatek: Don't support hdmi connector creation
Date:   Tue, 30 Mar 2021 13:09:00 +0200
Message-Id: <20210330110902.14178-1-dafna.hirschfeld@collabora.com>
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

changes since v2:
1. squash patch 3 with patch 2 to not break bisection
2. remove the funtion mtk_hdmi_get_edid and inline its code in mtk_hdmi_bridge_get_edid
3. small aligment

changes since v1:
1. split the first patch - now the first patch only moves the bridge ops to the atomic API
while the replacement of the field 'conn' with the field '*curr_conn' is done in a new third patch.
2. in the function 'get_eld' use the current conn only if 'enabled = true'.

Dafna Hirschfeld (2):
  drm/mediatek: Switch the hdmi bridge ops to the atomic versions
  drm/mediatek: Don't support hdmi connector creation

 drivers/gpu/drm/mediatek/mtk_hdmi.c | 174 ++++++++++++----------------
 1 file changed, 71 insertions(+), 103 deletions(-)

-- 
2.17.1

