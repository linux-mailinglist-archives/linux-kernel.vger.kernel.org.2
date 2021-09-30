Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F6041DFFA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 19:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352519AbhI3RUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 13:20:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:4357 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352486AbhI3RUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 13:20:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="310787665"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="310787665"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 10:16:25 -0700
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="520489703"
Received: from dboland-mobl.ger.corp.intel.com (HELO tursulin-mobl2.home) ([10.213.223.141])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 10:16:23 -0700
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     Intel-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Aravind Iddamsetty <aravind.iddamsetty@intel.com>
Subject: [RFC 3/6] drm/i915: Make GEM contexts track DRM clients
Date:   Thu, 30 Sep 2021 18:15:49 +0100
Message-Id: <20210930171552.501553-4-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210930171552.501553-1-tvrtko.ursulin@linux.intel.com>
References: <20210930171552.501553-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Make GEM contexts keep a reference to i915_drm_client for the whole of
of their lifetime which will come handy in following patches.

v2: Don't bother supporting selftests contexts from debugfs. (Chris)
v3 (Lucas): Finish constructing ctx before adding it to the list
v4 (Ram): Rebase.
v5: Trivial rebase for proto ctx changes.
v6: Rebase after clients no longer track name and pid.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk> # v5
Reviewed-by: Aravind Iddamsetty <aravind.iddamsetty@intel.com> # v5
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
---
 drivers/gpu/drm/i915/gem/i915_gem_context.c       | 5 +++++
 drivers/gpu/drm/i915/gem/i915_gem_context_types.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index 8208fd5b72c3..9296d69681d7 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -956,6 +956,9 @@ static void i915_gem_context_release_work(struct work_struct *work)
 	if (vm)
 		i915_vm_put(vm);
 
+	if (ctx->client)
+		i915_drm_client_put(ctx->client);
+
 	mutex_destroy(&ctx->engines_mutex);
 	mutex_destroy(&ctx->lut_mutex);
 
@@ -1373,6 +1376,8 @@ static void gem_context_register(struct i915_gem_context *ctx,
 	ctx->file_priv = fpriv;
 
 	ctx->pid = get_task_pid(current, PIDTYPE_PID);
+	ctx->client = i915_drm_client_get(fpriv->client);
+
 	snprintf(ctx->name, sizeof(ctx->name), "%s[%d]",
 		 current->comm, pid_nr(ctx->pid));
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context_types.h b/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
index c4617e4d9fa9..598c57ac5cdf 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
@@ -277,6 +277,9 @@ struct i915_gem_context {
 	/** @link: place with &drm_i915_private.context_list */
 	struct list_head link;
 
+	/** @client: struct i915_drm_client */
+	struct i915_drm_client *client;
+
 	/**
 	 * @ref: reference count
 	 *
-- 
2.30.2

