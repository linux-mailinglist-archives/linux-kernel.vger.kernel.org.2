Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EA23B1A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhFWM37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhFWM3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:29:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6C2C06115D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:24:46 -0700 (PDT)
Message-Id: <20210623121456.992342060@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vyV0uI4sd86NyUPdnZryhYObdvU/8rc9zS84+0XQYhQ=;
        b=jD2ZfSEMdjxUZ/bd6/dE//xXDN42zWwvpGN/zW5qVXaiVusQy/MxsNELruxAyF52bMCAls
        jRfVeXu9YMI1S1DaLwbq3o/cIU0mHk9mpUUljQgxL6sdS+YzQIiRMu8mF3VgxFpRsieUTe
        Kjv1fnL08U1wFZNC7X7mpGUlQCYn0AOeYYyMeVKqEJ4+L466RBDIHucEqGOpVaNKMtKsAn
        sZCdtCXg+mGglVE4vOGzTvL6mv9vcc5QcgRsJ0YlqbR9Pk/B+X74Ex2jG34Z13RQ+9JxIM
        9E7R4tbU0r+Rwn67wSfKCUBzl8hG+1Lfzqd2b/Kn3LIYz7SAmG5foV7yWq9YTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vyV0uI4sd86NyUPdnZryhYObdvU/8rc9zS84+0XQYhQ=;
        b=yCkuL3KNtZBCZ2UguQYF8JKaCtbW/7YjmmzzzG+FqRRvzPDzZJ3SihVvhBFQHQIrm5zZHY
        7456K1oiC6XkKMDw==
Date:   Wed, 23 Jun 2021 14:02:24 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Chang Seok Bae" <chang.seok.bae@intel.com>,
        Megha Dey <megha.dey@linux.intel.com>,
        Oliver Sang <oliver.sang@intel.com>
Subject: [patch V4 57/65] x86/fpu: Mark init_fpstate __ro_after_init
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing has to write into that state after init

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/kernel/fpu/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -23,7 +23,7 @@
  * Represents the initial FPU state. It's mostly (but not completely) zeroes,
  * depending on the FPU hardware format:
  */
-union fpregs_state init_fpstate __read_mostly;
+union fpregs_state init_fpstate __ro_after_init;
 
 /*
  * Track whether the kernel is using the FPU state

