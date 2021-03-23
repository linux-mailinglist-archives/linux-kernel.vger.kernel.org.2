Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF2B345AB1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhCWJWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhCWJWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:22:33 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B9FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:22:32 -0700 (PDT)
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <sebastian@breakpoint.cc>)
        id 1lOdEz-0003VM-TV; Tue, 23 Mar 2021 10:22:21 +0100
Date:   Tue, 23 Mar 2021 10:22:21 +0100
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH] drm/i915: Use tasklet_unlock_spin_wait() in
 __tasklet_disable_sync_once()
Message-ID: <20210323092221.awq7g5b2muzypjw3@flow>
References: <20210322082522.GH32426@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210322082522.GH32426@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i915 driver has its own tasklet interface which was overseen in the
tasklet rework. __tasklet_disable_sync_once() is a wrapper around
tasklet_unlock_wait(). tasklet_unlock_wait() might sleep, but the i915
wrappers invoke it from non-preemtible contexts with bottom halves disabled.

Use tasklet_unlock_spin_wait() instead which can be invoked from
non-preemptible contexts.

Fixes: da044747401fc ("tasklets: Replace spin wait in tasklet_unlock_wait()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/gpu/drm/i915/i915_gem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_gem.h b/drivers/gpu/drm/i915/i915_gem.h
index e622aee6e4be9..440c35f1abc9e 100644
--- a/drivers/gpu/drm/i915/i915_gem.h
+++ b/drivers/gpu/drm/i915/i915_gem.h
@@ -105,7 +105,7 @@ static inline bool tasklet_is_locked(const struct tasklet_struct *t)
 static inline void __tasklet_disable_sync_once(struct tasklet_struct *t)
 {
 	if (!atomic_fetch_inc(&t->count))
-		tasklet_unlock_wait(t);
+		tasklet_unlock_spin_wait(t);
 }
 
 static inline bool __tasklet_is_enabled(const struct tasklet_struct *t)
-- 
2.31.0

