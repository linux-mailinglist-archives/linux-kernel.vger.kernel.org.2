Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6D842E32B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 23:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbhJNVVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 17:21:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhJNVV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 17:21:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB81661040;
        Thu, 14 Oct 2021 21:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634246364;
        bh=MpJNT0WyCGwBQXF7gN/2cyrmmi7LfgmPgWDBNXOdBzA=;
        h=From:To:Cc:Subject:Date:From;
        b=TO7YOhD53c/vD2A/0vTHTqITac7DLVFZVpBXIJEIBJ2aOjsZ9ukxQ0dvUGUcc2l9S
         IiZ7kH0NgxgYhvHHT6ATO0xw70dOH+gXkRAYLFmx45rqVDd3QKr21aRMlXDRzwBqQI
         lcocduH089hv9pPpY5Iu3Hj5u73c8ezOaWhHnTfD+sQQDwyIQlvIQQ8uQfKdDN+/z7
         SJCN5AH8SrTv2/dV0wpjDpDXXp03W9EkczqXiF97Ssp5mHEVPWKKkOGOgDiflXRYZk
         TgBvKav8hmAeW8iegRlhm0dnSLIx9GRPHwfvbBhcSua1EDDs7qrrODnKecwGNNLCLg
         5khe1wGP3fE+Q==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] drm/i915: Avoid bitwise vs logical OR warning in snb_wm_latency_quirk()
Date:   Thu, 14 Oct 2021 14:19:16 -0700
Message-Id: <20211014211916.3550122-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.1.637.gf443b226ca
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new warning in clang points out a place in this file where a bitwise
OR is being used with boolean types:

drivers/gpu/drm/i915/intel_pm.c:3066:12: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
        changed = ilk_increase_wm_latency(dev_priv, dev_priv->wm.pri_latency, 12) |
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This construct is intentional, as it allows every one of the calls to
ilk_increase_wm_latency() to occur (instead of short circuiting with
logical OR) while still caring about the result of each call.

To make this clearer to the compiler, use the '|=' operator to assign
the result of each ilk_increase_wm_latency() call to changed, which
keeps the meaning of the code the same but makes it obvious that every
one of these calls is expected to happen.

Link: https://github.com/ClangBuiltLinux/linux/issues/1473
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/gpu/drm/i915/intel_pm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
index f90fe39cf8ca..aaa3a0998e4c 100644
--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -3050,9 +3050,9 @@ static void snb_wm_latency_quirk(struct drm_i915_private *dev_priv)
 	 * The BIOS provided WM memory latency values are often
 	 * inadequate for high resolution displays. Adjust them.
 	 */
-	changed = ilk_increase_wm_latency(dev_priv, dev_priv->wm.pri_latency, 12) |
-		ilk_increase_wm_latency(dev_priv, dev_priv->wm.spr_latency, 12) |
-		ilk_increase_wm_latency(dev_priv, dev_priv->wm.cur_latency, 12);
+	changed = ilk_increase_wm_latency(dev_priv, dev_priv->wm.pri_latency, 12);
+	changed |= ilk_increase_wm_latency(dev_priv, dev_priv->wm.spr_latency, 12);
+	changed |= ilk_increase_wm_latency(dev_priv, dev_priv->wm.cur_latency, 12);
 
 	if (!changed)
 		return;

base-commit: d73b17465d6da0a94bc0fcc86b150e1e923e8f71
-- 
2.33.1.637.gf443b226ca

