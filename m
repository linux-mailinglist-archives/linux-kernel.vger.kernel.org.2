Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A20841CBB9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 20:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345984AbhI2SXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 14:23:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:60388 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343727AbhI2SXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 14:23:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="212265500"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="212265500"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 11:21:48 -0700
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="457137080"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 11:21:48 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     gfx-internal-devel@eclists.intel.com
Cc:     Daniel Vetter <daniel.vetter@intel.com>,
        dri-devel@lists.freedesktop.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Rename IS_ACTIVE() and move to kconfig.h
Date:   Wed, 29 Sep 2021 11:16:29 -0700
Message-Id: <20210929181632.1489847-1-lucas.demarchi@intel.com>
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

