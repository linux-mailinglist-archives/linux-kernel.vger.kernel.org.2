Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0580241CBE2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 20:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346222AbhI2Sf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 14:35:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:24845 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345800AbhI2Sf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 14:35:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="212095100"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="212095100"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 11:34:16 -0700
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="520927746"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 11:34:16 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Daniel Vetter <daniel.vetter@intel.com>,
        dri-devel@lists.freedesktop.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Rename IS_ACTIVE() and move to kconfig.h
Date:   Wed, 29 Sep 2021 11:33:54 -0700
Message-Id: <20210929183357.1490204-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we try to reduce our i915-only helpers, let's try to improve
IS_ACTIVE() logic and move to kconfig.h.

I'm not 100% happy with the name, but it's the best I could come up
with, hopefully a little better than trying to add IS_ACTIVE() to be
used broadly.

v2: now with Cc/To list fixed up - no changes to the patches.

Lucas De Marchi (3):
  drm/i915: rename IS_ACTIVE
  drm/i915/utils: do not depend on config being defined
  Move IS_CONFIG_NONZERO() to kconfig.h

 drivers/gpu/drm/i915/gem/i915_gem_context.c      |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c         |  2 +-
 drivers/gpu/drm/i915/gt/intel_engine.h           |  4 ++--
 drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c |  2 +-
 drivers/gpu/drm/i915/gt/intel_engine_types.h     |  2 +-
 .../gpu/drm/i915/gt/intel_execlists_submission.c |  2 +-
 .../gpu/drm/i915/gt/selftest_engine_heartbeat.c  |  4 ++--
 drivers/gpu/drm/i915/gt/selftest_execlists.c     | 14 +++++++-------
 drivers/gpu/drm/i915/i915_config.c               |  2 +-
 drivers/gpu/drm/i915/i915_request.c              |  2 +-
 drivers/gpu/drm/i915/i915_utils.h                | 13 -------------
 include/linux/kconfig.h                          | 16 ++++++++++++++--
 12 files changed, 32 insertions(+), 33 deletions(-)

-- 
2.33.0

