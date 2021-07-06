Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D253BDB6C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 18:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhGFQdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 12:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhGFQdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 12:33:23 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF253C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 09:30:44 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:4cb:a870:66c3:d637:2136:cc21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 4C8AD1F423F8;
        Tue,  6 Jul 2021 17:30:42 +0100 (BST)
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH] MAINTAINERS: Update Benjamin Gaignard maintainer status
Date:   Tue,  6 Jul 2021 18:30:33 +0200
Message-Id: <20210706163033.795805-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Benjamin Gaignard address and remove it from no more maintained
drivers.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c5ee008301a6..c6356cd0446a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5460,7 +5460,7 @@ F:	tools/testing/selftests/dma/
 
 DMA-BUF HEAPS FRAMEWORK
 M:	Sumit Semwal <sumit.semwal@linaro.org>
-R:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
+R:	Benjamin Gaignard <benjamin.gaignard@collabora.com>
 R:	Liam Mark <lmark@codeaurora.org>
 R:	Laura Abbott <labbott@redhat.com>
 R:	Brian Starkey <Brian.Starkey@arm.com>
@@ -6141,7 +6141,6 @@ F:	Documentation/devicetree/bindings/display/rockchip/
 F:	drivers/gpu/drm/rockchip/
 
 DRM DRIVERS FOR STI
-M:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
@@ -6151,7 +6150,6 @@ F:	drivers/gpu/drm/sti
 DRM DRIVERS FOR STM
 M:	Yannick Fertre <yannick.fertre@foss.st.com>
 M:	Philippe Cornu <philippe.cornu@foss.st.com>
-M:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
@@ -17453,7 +17451,6 @@ F:	Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
 F:	sound/soc/sti/
 
 STI CEC DRIVER
-M:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/stih-cec.txt
 F:	drivers/media/cec/platform/sti/
-- 
2.25.1

