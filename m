Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E81743CD74
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 17:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242712AbhJ0P2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 11:28:50 -0400
Received: from mout.perfora.net ([74.208.4.194]:49395 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237820AbhJ0P2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 11:28:49 -0400
Received: from toolbox.cardiotech.int ([194.191.235.54]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M0fUG-1mwrBg1nTC-00uuPU;
 Wed, 27 Oct 2021 17:25:42 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH v1] drm: import DMA_BUF module namespace
Date:   Wed, 27 Oct 2021 17:25:34 +0200
Message-Id: <20211027152534.3366799-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Bl5t3lSPLC2ho7JrhNFfE+Mz2QikL3xU5MGZYbgo/rT3YQWwu/H
 Aktrk+pIqxAdQG37K73bbvCQyf+Oj1szWKgs7pLxr8gNdrbecyBVwdI4GZcltKzXnU6Kh2o
 57exL4Pa/C8CVet8SbO1s2k+ry1nT+aIlceX5zk8uXbSINtaC5C6Rs63bHwipB1fulM2RA5
 A20AZqjcfKUVY5w3EsWhg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MsSoRz00lj0=:BlWzqHevXYA4mqX4PpmhkD
 ouVrY7HI9FkLYI1LM3IA5p7Xf5rJ966a91jwxScT/gCK9tfbRyUJOIdXg+Q1Emo54HzFXJ+JK
 AdS5qWRnUBeTxOKszxzwjCDiy1HJ5q2UYeyTXkQSHHjO1bHQ4dc8xeijPeLBP1laDVNirQSNW
 LOef1DGdVOMkEglHyLmY6w4foMoplUC5OndxT5AZNcNy/UJwWPdQWeSfjupp+euY521w8MULV
 cXnfgPhTRUQOcVX2inSVyWjmMFTy5isroamL7Muw1DmsjCsLNnZm2StGwBk7eAAtJN9pSTuaa
 SNdRSHa3cOM+/UW1JJr4j3wACBrUEC8TqGuNksX1nx3buCkasqZbGqiu/nlToKnBekY1fTk5K
 N5ENUpi9SOO5q9uSWcXrSGzp+5v72M90Wf0UFvOqqzOawGwOhGBrQrMx3u+Eo3dMNfnrdj0nL
 LIa7GC31RdL9L8huJGyTgtY9ojqz2NAbwJxJSdATANC86c5YxeXZ1TPp+MJs5+SbVOGLhE0Tc
 AuTlV5+rgIak2M3TdzqufhYeUhhwKGkRYq/5TdRV5C9yeC1WYbrqXFovUxjTm0BS2Wu5tBrQJ
 F7N6kusdUx8+18l7N8O8TrkuwMzOiQVnH3I/XpC/7bQusw+55Al8fXZDd0FOS5Tysy4wko5UB
 Oryfs7S1BaS17nqKxJs6f+cc07DCXflP/0JqbnSBiXV/99rnXBWBd2SfU9DQOPxhkzFM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Today's -next fails building arm64 defconfig as follows:

ERROR: modpost: module drm_cma_helper uses symbol dma_buf_vunmap from
 namespace DMA_BUF, but does not import it.
ERROR: modpost: module drm_cma_helper uses symbol dma_buf_vmap from
 namespace DMA_BUF, but does not import it.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Fixes: commit 4b2b5e142ff4 ("drm: Move GEM memory managers into modules")
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 drivers/gpu/drm/drm_gem_cma_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
index 6f7b3f8ec04d3..69f8564ad11cd 100644
--- a/drivers/gpu/drm/drm_gem_cma_helper.c
+++ b/drivers/gpu/drm/drm_gem_cma_helper.c
@@ -23,6 +23,8 @@
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_vma_manager.h>
 
+MODULE_IMPORT_NS(DMA_BUF);
+
 /**
  * DOC: cma helpers
  *
-- 
2.26.2

