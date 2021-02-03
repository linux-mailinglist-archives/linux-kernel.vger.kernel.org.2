Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B1B30D5FE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbhBCJNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:13:48 -0500
Received: from mga14.intel.com ([192.55.52.115]:30338 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233105AbhBCJJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:09:59 -0500
IronPort-SDR: OVpAOo0a2TuvhjGal+0XxaNwxkLaw4UTwNPtPyUZTrwgUwoVJVThOZlo7aIwHATmbI+Wz+Op1v
 RcKsqSPox5Yg==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="180236135"
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="180236135"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 01:09:16 -0800
IronPort-SDR: iBUxEd65Y1Bmv38cbCxVhzippc/Vipg9M4cOgIQTCg43ApvuJ47hqTdSrzWSmNnYRRnw8nxedQ
 QcyQiqxux6KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="406488887"
Received: from anand-nuc8i7beh.iind.intel.com ([10.145.162.17])
  by fmsmga004.fm.intel.com with ESMTP; 03 Feb 2021 01:09:12 -0800
From:   Anand Moon <anandx.ram.moon@intel.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Anand Moon <anandx.ram.moon@intel.com>
Subject: [PATCH] drm/i915/adl_s: ADL-S platform Update PCI ids for Mobile BGA
Date:   Wed,  3 Feb 2021 14:40:29 +0530
Message-Id: <20210203091029.2089-1-anandx.ram.moon@intel.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Bspec: 53655 Update PCI ids for Mobile BGA.

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Anand Moon <anandx.ram.moon@intel.com>

diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
index ebd0dd1c35b3..3be25768321d 100644
--- a/include/drm/i915_pciids.h
+++ b/include/drm/i915_pciids.h
@@ -640,6 +640,8 @@
 	INTEL_VGA_DEVICE(0x4681, info), \
 	INTEL_VGA_DEVICE(0x4682, info), \
 	INTEL_VGA_DEVICE(0x4683, info), \
+	INTEL_VGA_DEVICE(0x4688, info), \
+	INTEL_VGA_DEVICE(0x4689, info), \
 	INTEL_VGA_DEVICE(0x4690, info), \
 	INTEL_VGA_DEVICE(0x4691, info), \
 	INTEL_VGA_DEVICE(0x4692, info), \
-- 
2.30.0

