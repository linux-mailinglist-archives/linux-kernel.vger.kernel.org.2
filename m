Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8D43492BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhCYNI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:08:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49828 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhCYNHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:07:40 -0400
Received: from guri.fritz.box (unknown [IPv6:2a02:810a:880:f54:dd4e:1b63:5a5e:1980])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E752B1F464D6;
        Thu, 25 Mar 2021 13:07:36 +0000 (GMT)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     dafna.hirschfeld@collabora.com, kernel@collabora.com,
        dafna3@gmail.com, chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        airlied@linux.ie, daniel@ffwll.ch, enric.balletbo@collabora.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add linux-mediatek ML for drm Mediatek drivers
Date:   Thu, 25 Mar 2021 14:07:28 +0100
Message-Id: <20210325130728.16634-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the linux-mediatek mailing list to drm Mediatek drivers

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e876927c60d..8260bc5afe66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5963,6 +5963,7 @@ DRM DRIVERS FOR MEDIATEK
 M:	Chun-Kuang Hu <chunkuang.hu@kernel.org>
 M:	Philipp Zabel <p.zabel@pengutronix.de>
 L:	dri-devel@lists.freedesktop.org
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/display/mediatek/
 F:	drivers/gpu/drm/mediatek/
-- 
2.17.1

