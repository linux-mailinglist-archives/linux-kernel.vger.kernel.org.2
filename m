Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3002D3ACEB0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbhFRPX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:23:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56454 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbhFRPWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:22:21 -0400
Message-Id: <20210618143449.299151449@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=k6/81Nf+e6pRycJkI5KcFdhXFlJ0ri3uWt/suup+NPo=;
        b=EyZJjIYsQHTA/o3qLrvngcq58F+P1SknUoqz7cEAQJcGpvZZLSTU85yc2BXqgfDdogw2xR
        gU9zOytwKOzAJxVVIAdLNezb4+I95TBE38oD6I5xsdEgpD55AAVJXY5dIJizPasIGQUVFR
        cpxgspwQ45/wAvmjylCigD5t01p+QbnfC7exfEv/JrcZWs6yvaywA3xT8Zc97uhXKIWnW5
        nLtZjxfdrUOoXXyrRWFKXjAafUdRp2OaO5AnZjnQCxYa2/E9gG3L2o5Gtuh86KiCtiWOkp
        1gLs4sOgqDFV99QAS7cQIVIgkRTCgIfmXO4hbjO5x5BecMf7l//N1eXOh4O4Vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=k6/81Nf+e6pRycJkI5KcFdhXFlJ0ri3uWt/suup+NPo=;
        b=q1B7G3SvXsnPbS4ZERp24kLpsuNc5nQ7IHuXoXv0L+LoBzTXYkRmyAhXjIA71CDX4D7upV
        KGhL+QTx62jlODAA==
Date:   Fri, 18 Jun 2021 16:19:06 +0200
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
Subject: [patch V3 43/66] x86/pkru: Provide pkru_write_default()
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a simple and trivial helper which just writes the PKRU default
value without trying to fiddle with the tasks xsave buffer.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/pkru.h |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/x86/include/asm/pkru.h
+++ b/arch/x86/include/asm/pkru.h
@@ -60,4 +60,12 @@ static inline void write_pkru(u32 pkru)
 	fpregs_unlock();
 }
 
+static inline void pkru_write_default(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
+		return;
+
+	wrpkru(pkru_get_init_value());
+}
+
 #endif

