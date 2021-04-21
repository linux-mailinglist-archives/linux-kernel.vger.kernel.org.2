Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E983E366A7C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 14:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239508AbhDUMKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 08:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbhDUMKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 08:10:14 -0400
X-Greylist: delayed 341 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Apr 2021 05:09:41 PDT
Received: from mblankhorst.nl (mblankhorst.nl [IPv6:2a02:2308::216:3eff:fe92:dfa3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B43C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 05:09:41 -0700 (PDT)
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        DRI <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH] drm/i915: Fix docbook descriptions for i915_gem_shrinker
Date:   Wed, 21 Apr 2021 14:09:38 +0200
Message-Id: <20210421120938.546076-1-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following htmldocs warning:
drivers/gpu/drm/i915/gem/i915_gem_shrinker.c:102: warning: Function parameter or member 'ww' not described in 'i915_gem_shrink'

Fixes: cf41a8f1dc1e ("drm/i915: Finally remove obj->mm.lock.")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c b/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
index 7545ddd83659..f4fb68e8955a 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
@@ -72,6 +72,7 @@ static void try_to_writeback(struct drm_i915_gem_object *obj,
 
 /**
  * i915_gem_shrink - Shrink buffer object caches
+ * @ww: i915 gem ww acquire ctx, or NULL
  * @i915: i915 device
  * @target: amount of memory to make available, in pages
  * @nr_scanned: optional output for number of pages scanned (incremental)
-- 
2.31.0

