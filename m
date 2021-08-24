Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1133F6BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 00:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhHXWzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 18:55:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233400AbhHXWzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 18:55:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8F6561368;
        Tue, 24 Aug 2021 22:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629845693;
        bh=YMZVjnEuueEqT8Dgrliww3EzUw/B4Yz4C4XgwxetSfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PDnYE3RqPH5egYvodseyZB8vFBQDMDOjywCoB5KoRCILSZSZ5POdOEn/fDVM42MUs
         4SEyaEptsec2BPHiPBErABUdEP/YF4VUp6J0UvbSclxtziZLhNU/2OSEmDAVYdncYs
         NQuuczLWmv1UqhykGn1AjvrJsr1WDnDVtSnAmA0+io9g3wvIyvnx7T+4zHcwiNJO/G
         8SMmCL/wBqg4DARfRiLiuEcA7pnE/5MTZHAaSnyVTNtvYBlSFuT4HL8+bvjrcQje/7
         3yC9S9eb6GY0B+VQ8TXWNtYy4aqNBi8csKOx+1IrDYD7xCBkJcMiWIVZpA5YlHoobU
         LWeuzEDn3OM5g==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Jason Ekstrand <jason@jlekstrand.net>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 3/3] drm/i915: Enable -Wsometimes-uninitialized
Date:   Tue, 24 Aug 2021 15:54:27 -0700
Message-Id: <20210824225427.2065517-4-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210824225427.2065517-1-nathan@kernel.org>
References: <20210824225427.2065517-1-nathan@kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This warning helps catch uninitialized variables. It should have been
enabled at the same time as commit b2423184ac33 ("drm/i915: Enable
-Wuninitialized") but I did not realize they were disabled separately.
Enable it now that i915 is clean so that it stays that way.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/gpu/drm/i915/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 642a5b5a1b81..335ba9f43d8f 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -19,7 +19,6 @@ subdir-ccflags-y += $(call cc-disable-warning, missing-field-initializers)
 subdir-ccflags-y += $(call cc-disable-warning, unused-but-set-variable)
 # clang warnings
 subdir-ccflags-y += $(call cc-disable-warning, sign-compare)
-subdir-ccflags-y += $(call cc-disable-warning, sometimes-uninitialized)
 subdir-ccflags-y += $(call cc-disable-warning, initializer-overrides)
 subdir-ccflags-y += $(call cc-disable-warning, frame-address)
 subdir-ccflags-$(CONFIG_DRM_I915_WERROR) += -Werror
-- 
2.33.0

