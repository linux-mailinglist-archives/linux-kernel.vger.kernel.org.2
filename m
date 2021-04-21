Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B8D366A83
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 14:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238310AbhDUMLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 08:11:53 -0400
Received: from mblankhorst.nl ([141.105.120.124]:42900 "EHLO mblankhorst.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235580AbhDUMLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 08:11:51 -0400
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Apr 2021 08:11:51 EDT
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        DRI <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH] drm/i915: Fix docbook descriptions for i915_cmd_parser
Date:   Wed, 21 Apr 2021 14:03:53 +0200
Message-Id: <20210421120353.544518-1-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following htmldocs warnings:
drivers/gpu/drm/i915/i915_cmd_parser.c:1420: warning: Excess function parameter 'trampoline' description in 'intel_engine_cmd_parser'
drivers/gpu/drm/i915/i915_cmd_parser.c:1420: warning: Function parameter or member 'jump_whitelist' not described in 'intel_engine_cmd_parser'
drivers/gpu/drm/i915/i915_cmd_parser.c:1420: warning: Function parameter or member 'shadow_map' not described in 'intel_engine_cmd_parser'
drivers/gpu/drm/i915/i915_cmd_parser.c:1420: warning: Function parameter or member 'batch_map' not described in 'intel_engine_cmd_parser'
drivers/gpu/drm/i915/i915_cmd_parser.c:1420: warning: Excess function parameter 'trampoline' description in 'intel_engine_cmd_parser'

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_cmd_parser.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_cmd_parser.c b/drivers/gpu/drm/i915/i915_cmd_parser.c
index e6f1e93abbbb..afb9b7516999 100644
--- a/drivers/gpu/drm/i915/i915_cmd_parser.c
+++ b/drivers/gpu/drm/i915/i915_cmd_parser.c
@@ -1369,6 +1369,18 @@ static int check_bbstart(u32 *cmd, u32 offset, u32 length,
 	return 0;
 }
 
+/**
+ * intel_engine_cmd_parser_alloc_jump_whitelist() - preallocate jump whitelist for intel_engine_cmd_parser()
+ * @batch_length: length of the commands in batch_obj
+ * @trampoline: Whether jump trampolines are used.
+ *
+ * Preallocates a jump whitelist for parsing the cmd buffer in intel_engine_cmd_parser().
+ * This has to be preallocated, because the command parser runs in signaling context,
+ * and may not allocate any memory.
+ *
+ * Return: NULL or pointer to a jump whitelist, or ERR_PTR() on failure. Use
+ * IS_ERR() to check for errors. Must bre freed() with kfree().
+ */
 unsigned long *intel_engine_cmd_parser_alloc_jump_whitelist(u32 batch_length,
 							    bool trampoline)
 {
@@ -1401,7 +1413,9 @@ unsigned long *intel_engine_cmd_parser_alloc_jump_whitelist(u32 batch_length,
  * @batch_offset: byte offset in the batch at which execution starts
  * @batch_length: length of the commands in batch_obj
  * @shadow: validated copy of the batch buffer in question
- * @trampoline: whether to emit a conditional trampoline at the end of the batch
+ * @jump_whitelist: buffer preallocated with intel_engine_cmd_parser_alloc_jump_whitelist()
+ * @shadow_map: mapping to @shadow vma
+ * @batch_map: mapping to @batch vma
  *
  * Parses the specified batch buffer looking for privilege violations as
  * described in the overview.
-- 
2.31.0

