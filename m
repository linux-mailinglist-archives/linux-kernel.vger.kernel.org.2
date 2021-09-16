Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D991140E9BC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 20:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347181AbhIPSTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 14:19:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54334 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242692AbhIPSR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 14:17:26 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BF367223E8;
        Thu, 16 Sep 2021 18:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631816164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eqmm/qJ4NjK4BV6YBoCDhqOHEZHdHnz1DHDENQSfpqM=;
        b=ro4MYD8IEg9406sdyKJKCGEBgIXhtglGfyBL2y7U3wf6pB4Az0ucEZrodFx0ZDmvgysIqg
        qOlFqB0nXh5z6BW8E2qaY1E7ZzKhJ5X75COQ1uHagc34kM2xGXRVfn9FA1GcJmpH2HHl+Z
        GlhAj5Wnn3R2TJfKyCK3srhMCUtYabE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631816164;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eqmm/qJ4NjK4BV6YBoCDhqOHEZHdHnz1DHDENQSfpqM=;
        b=BUtuy3s7BfrCxcjeXO0kQzCNZa53JDdetnStwESacA6KkhostjoJ7O+zQDQVNLbce0CFC9
        3vTFzlA9gqhnR2BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8160C13D67;
        Thu, 16 Sep 2021 18:16:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0KOpHuSJQ2FleQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 16 Sep 2021 18:16:04 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     airlied@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        hdegoede@redhat.com, marcan@marcan.st, maz@kernel.org,
        akpm@linux-foundation.org, npiggin@gmail.com,
        thunder.leizhen@huawei.com, gregkh@linuxfoundation.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/5] drm/ast: Use managed interfaces for framebuffer write combining
Date:   Thu, 16 Sep 2021 20:15:59 +0200
Message-Id: <20210916181601.9146-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210916181601.9146-1-tzimmermann@suse.de>
References: <20210916181601.9146-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace arch_phys_wc_add() and arch_io_reserve_memtype_wc() with
the rsp managed functions. Allows for removing the cleanup code
for memory management

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/ast/ast_drv.h |  2 --
 drivers/gpu/drm/ast/ast_mm.c  | 27 ++++++++++-----------------
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
index 39ca338eb80b..2cfce7dc95af 100644
--- a/drivers/gpu/drm/ast/ast_drv.h
+++ b/drivers/gpu/drm/ast/ast_drv.h
@@ -158,8 +158,6 @@ struct ast_private {
 	uint32_t dram_type;
 	uint32_t mclk;
 
-	int fb_mtrr;
-
 	struct drm_plane primary_plane;
 	struct ast_cursor_plane cursor_plane;
 	struct drm_crtc crtc;
diff --git a/drivers/gpu/drm/ast/ast_mm.c b/drivers/gpu/drm/ast/ast_mm.c
index 7592f1b9e1f1..6e999408dda9 100644
--- a/drivers/gpu/drm/ast/ast_mm.c
+++ b/drivers/gpu/drm/ast/ast_mm.c
@@ -74,35 +74,28 @@ static u32 ast_get_vram_size(struct ast_private *ast)
 	return vram_size;
 }
 
-static void ast_mm_release(struct drm_device *dev, void *ptr)
-{
-	struct ast_private *ast = to_ast_private(dev);
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
-
-	arch_phys_wc_del(ast->fb_mtrr);
-	arch_io_free_memtype_wc(pci_resource_start(pdev, 0),
-				pci_resource_len(pdev, 0));
-}
-
 int ast_mm_init(struct ast_private *ast)
 {
 	struct drm_device *dev = &ast->base;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	resource_size_t base, size;
 	u32 vram_size;
 	int ret;
 
+	base = pci_resource_start(pdev, 0);
+	size = pci_resource_len(pdev, 0);
+
+	/* Don't fail on errors, but performance might be reduced. */
+	devm_arch_io_reserve_memtype_wc(dev->dev, base, size);
+	devm_arch_phys_wc_add(dev->dev, base, size);
+
 	vram_size = ast_get_vram_size(ast);
 
-	ret = drmm_vram_helper_init(dev, pci_resource_start(pdev, 0), vram_size);
+	ret = drmm_vram_helper_init(dev, base, vram_size);
 	if (ret) {
 		drm_err(dev, "Error initializing VRAM MM; %d\n", ret);
 		return ret;
 	}
 
-	arch_io_reserve_memtype_wc(pci_resource_start(pdev, 0),
-				   pci_resource_len(pdev, 0));
-	ast->fb_mtrr = arch_phys_wc_add(pci_resource_start(pdev, 0),
-					pci_resource_len(pdev, 0));
-
-	return drmm_add_action_or_reset(dev, ast_mm_release, NULL);
+	return 0;
 }
-- 
2.33.0

