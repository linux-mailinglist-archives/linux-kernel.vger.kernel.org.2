Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E4A3E0979
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 22:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240911AbhHDUmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 16:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbhHDUmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 16:42:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD87C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 13:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=f9gSgEz86yFFQ7CEO9gWv946kye+BSxNr15YYmTIIXs=; b=f0EXkLpLotyGgBVVyg/MPMzSlF
        LikWAmrnOndI5J5MFM5sTgNa2lbW5/Ss/CBg+cDayuEShzqnOVS9XwYspfWfRdcas5pn4WgYFYLD1
        kaKaCzE5di9CjUHC5WDLjzEyjnil2p+ynAD4YEDuyfNJDcvgE1/qGmXQAOoF4aC4MR5FVskoHASlp
        7jQiMD+LhqqHgoFQmB9Xgw/l0yJqNbOWEu1HYUr7mwt3JNxfxHJ601QnhSXyoAtjfYDqX6HT8VpDX
        lJE+fku0pDff+4p5pqsjV3meVjN6Tr0hLbpjevBvWpNKhMM+w9TvDL8rG0OJhyAQiITf1xVDGTcvM
        HhGoo6sQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBNi1-007QAy-Pu; Wed, 04 Aug 2021 20:41:50 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH -next] drm/i915: fix i915_globals_exit() section mismatch error
Date:   Wed,  4 Aug 2021 13:41:47 -0700
Message-Id: <20210804204147.2070-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix modpost Section mismatch error in i915_globals_exit().
Since both an __init function and an __exit function can call
i915_globals_exit(), any function that i915_globals_exit() calls
should not be marked as __init or __exit. I.e., it needs to be
available for either of them.

WARNING: modpost: vmlinux.o(.text+0x8b796a): Section mismatch in reference from the function i915_globals_exit() to the function .exit.text:__i915_globals_flush()
The function i915_globals_exit() references a function in an exit section.
Often the function __i915_globals_flush() has valid usage outside the exit section
and the fix is to remove the __exit annotation of __i915_globals_flush.

ERROR: modpost: Section mismatches detected.
Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.

Fixes: 1354d830cb8f ("drm/i915: Call i915_globals_exit() if pci_register_device() fails")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jason Ekstrand <jason@jlekstrand.net>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/i915/i915_globals.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linext-2021-0804.orig/drivers/gpu/drm/i915/i915_globals.c
+++ linext-2021-0804/drivers/gpu/drm/i915/i915_globals.c
@@ -138,7 +138,7 @@ void i915_globals_unpark(void)
 	atomic_inc(&active);
 }
 
-static void __exit __i915_globals_flush(void)
+static void  __i915_globals_flush(void)
 {
 	atomic_inc(&active); /* skip shrinking */
 
