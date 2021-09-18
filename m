Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D004104AC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 09:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbhIRHV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 03:21:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:10621 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230509AbhIRHVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 03:21:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10110"; a="222958798"
X-IronPort-AV: E=Sophos;i="5.85,303,1624345200"; 
   d="scan'208";a="222958798"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2021 00:20:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,303,1624345200"; 
   d="scan'208";a="699925850"
Received: from lkp-server01.sh.intel.com (HELO 285e7b116627) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 18 Sep 2021 00:20:29 -0700
Received: from kbuild by 285e7b116627 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mRUeD-0004iT-5d; Sat, 18 Sep 2021 07:20:29 +0000
Date:   Sat, 18 Sep 2021 15:19:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lee Shawn C <shawn.c.lee@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: [RFC PATCH] drm/i915/dsi: intel_gmbus_ddc_reserve_for_mipi() can be
 static
Message-ID: <20210918071945.GA54772@ddb61ee6ab53>
References: <202109181527.NwO2oXCq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109181527.NwO2oXCq-lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/gpu/drm/i915/display/intel_gmbus.c:144:6: warning: symbol 'intel_gmbus_ddc_reserve_for_mipi' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/i915/display/intel_gmbus.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_gmbus.c b/drivers/gpu/drm/i915/display/intel_gmbus.c
index 8d2dcc4a6a533..d9bbb8bbaf02f 100644
--- a/drivers/gpu/drm/i915/display/intel_gmbus.c
+++ b/drivers/gpu/drm/i915/display/intel_gmbus.c
@@ -141,8 +141,8 @@ bool intel_gmbus_is_valid_pin(struct drm_i915_private *dev_priv,
 	return pin < size && get_gmbus_pin(dev_priv, pin)->name;
 }
 
-bool intel_gmbus_ddc_reserve_for_mipi(struct drm_i915_private *dev_priv,
-				      unsigned int pin)
+static bool intel_gmbus_ddc_reserve_for_mipi(struct drm_i915_private *dev_priv,
+					     unsigned int pin)
 {
 	enum port port;
 
diff --git a/scripts/spdxcheck-test.sh b/scripts/spdxcheck-test.sh
old mode 100644
new mode 100755
