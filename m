Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF403ACED0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbhFRP1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:27:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56700 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbhFRPXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:23:08 -0400
Message-Id: <20210618143450.964417799@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vyV0uI4sd86NyUPdnZryhYObdvU/8rc9zS84+0XQYhQ=;
        b=WavoX4mC5nNIYzJQahm9p8o0yKfPwUcErAZeOpQrufuQiNIBaswu5beePkNrhfRVwC34mq
        Ye93MG4z4O++DOrN8alNEygsSJAzm3LGkJMpES8nH/VYaKMk19xMvZnWCNyRY+Ev9POZhh
        hZU8zGat9yefBmdCN7ijP8iZydhSCnKBRfo2KysZVzG+T1tz5iygloXZM/2u5sjG4B4iyI
        f90WF61JlZfOpLZu4rfVJzHtNWJ9l4VO93Jkp6TtfeNWmP1H1OTQ2BQlx+zaxHB0xrF3cU
        7k9FrhT/KXwWCEzie4cBkrOPIq4ch3hy/aA2izuaY3J+G0EsksxI3pRReVzVGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vyV0uI4sd86NyUPdnZryhYObdvU/8rc9zS84+0XQYhQ=;
        b=wrAxvYUiLaHKuBh/Hl+3i011jNvTSb9X0Onk149HvYNkEpwPQvpV81oMQdW79Wc0ypZqL4
        ColjCzPP2UZWwoAg==
Date:   Fri, 18 Jun 2021 16:19:21 +0200
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
Subject: [patch V3 58/66] x86/fpu: Mark init_fpstate __ro_after_init
References: <20210618141823.161158090@linutronix.de>
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

