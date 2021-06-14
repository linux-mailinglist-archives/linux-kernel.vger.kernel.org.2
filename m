Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8153A6C39
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbhFNQmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:42:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56422 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbhFNQkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:53 -0400
Message-Id: <20210614155358.990811764@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vyV0uI4sd86NyUPdnZryhYObdvU/8rc9zS84+0XQYhQ=;
        b=SV3zSFp+VBfjekyDr/lYeSmG8OhPRKl+PNhf6ZMk1DwMQ3CmlR7jULLmG9SOMSGrOoLcLh
        tnO45clnveF8L6G3GrLNsDw+LK3iEKGhQLNybMiXlmq6ITd2SpGwdCKi448nqPJGMiIoXz
        xIrlIqN/h9qc0PZ5xP/QcZpy8HQbKCFj9QfsKFHKkdmpaSd5efCBsBjYkTKGrCbcSNsDgl
        +NLqPewMchxNXaRs1sWaxHqvmMuCvd6PGDSKx8rvpvA1rFM8h7mSLKpaBQWUh+N1/m6wEl
        lqDH0U55YCR8onFNb2sLB34xNClEentx4tBc72TKM1RAz2ncaRiwYU0CK8d6Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vyV0uI4sd86NyUPdnZryhYObdvU/8rc9zS84+0XQYhQ=;
        b=s/uG26vnZOBOZKQQ4cFRn2Wzyziktuq8Zme2MCufhCUJW+v/Xw7zHga+4/2BoHg10zn2og
        r1Hibtc7N/JDZwCw==
Date:   Mon, 14 Jun 2021 17:45:00 +0200
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
        Kan Liang <kan.liang@linux.intel.com>
Subject: [patch V2 52/52] x86/fpu: Mark init_fpstate __ro_after_init
References: <20210614154408.673478623@linutronix.de>
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

