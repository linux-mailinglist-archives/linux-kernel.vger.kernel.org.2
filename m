Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9701E41CBE3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 20:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346245AbhI2SgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 14:36:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:24845 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345901AbhI2Sf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 14:35:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="212095103"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="212095103"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 11:34:16 -0700
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="520927754"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 11:34:16 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Daniel Vetter <daniel.vetter@intel.com>,
        dri-devel@lists.freedesktop.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] drm/i915/utils: do not depend on config being defined
Date:   Wed, 29 Sep 2021 11:33:56 -0700
Message-Id: <20210929183357.1490204-3-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210929183357.1490204-1-lucas.demarchi@intel.com>
References: <20210929183357.1490204-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the IS_ENABLED() counterpart, we can make IS_CONFIG_NONZERO() to
return the right thing when the config is not defined rather than a
build error, with the limitation that it can't be used on preprocessor
context.

The trick here is that macro names can't start with a number or dash, so
we stringify the argument and check that the first char is a number != 0
(or starting with a dash to cover negative numbers). Except for -O0
builds the strings are all eliminated.

Taking CONFIG_DRM_I915_REQUEST_TIMEOUT in
drivers/gpu/drm/i915/gem/i915_gem_context.c as example, we have the
following output of the preprocessor:

old:
 if (((20000) != 0) &&
new:
 if (( ("20000"[0] > '0' && "20000"[0] < '9') || "20000"[0] == '-' ) &&

New one looks worse, but is also eliminated from the object:

$ size drivers/gpu/drm/i915/gem/i915_gem_context.o.*
   text    data     bss     dec     hex filename
  52021    1070     232   53323    d04b drivers/gpu/drm/i915/gem/i915_gem_context.o.new
  52021    1070     232   53323    d04b drivers/gpu/drm/i915/gem/i915_gem_context.o.old

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/i915/i915_utils.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
index 02bbfa4d68d3..436ce612c46a 100644
--- a/drivers/gpu/drm/i915/i915_utils.h
+++ b/drivers/gpu/drm/i915/i915_utils.h
@@ -28,6 +28,7 @@
 #include <linux/list.h>
 #include <linux/overflow.h>
 #include <linux/sched.h>
+#include <linux/stringify.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
@@ -469,6 +470,9 @@ static inline bool timer_expired(const struct timer_list *t)
  *
  * Returns 0 if @config is 0, 1 if set to any value.
  */
-#define IS_CONFIG_NONZERO(config) ((config) != 0)
+#define IS_CONFIG_NONZERO(config) (						\
+	(__stringify_1(config)[0] > '0' && __stringify_1(config)[0] < '9') ||	\
+	__stringify_1(config)[0] == '-'						\
+)
 
 #endif /* !__I915_UTILS_H */
-- 
2.33.0

