Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C723B1A04
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhFWM1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:27:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36926 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbhFWM0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:45 -0400
Message-Id: <20210623121455.513729794@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ZViKmgAvoDIjsSImcrB4JzX/lSJp9yd88lzHL3JTODQ=;
        b=4qeularqv1Lmi+RH2Fpqqo3HWo9K0axNcBMVE1zYJihcNB7w6l0rix+s0eOU2sSF8Kp1Il
        5gQ4fZmQpdmtKX1bG6omYKE6JDhyZ3nU/5+/Loqte/nyZbM5PZd0Sfwnrutn1Neo34PMzx
        opclhPn71YxIZzT1EnrNvsUV18lYSH/2hFn1w5QOukdGyXzFFs3UWpcjCtfodfAYDJXypL
        pcBKUhUEHtcH8GHZSJomd7Nm0S8ARhrMNW/2UWXAwPNE7hv4xgYWQ+MlCvqoSvh/EhdeRd
        SZHxGjzqqYSfkmNZpQGZboB7Z5aY2BY2zSlCCa7/nboRF1miU9w/yVyY16cNDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ZViKmgAvoDIjsSImcrB4JzX/lSJp9yd88lzHL3JTODQ=;
        b=HNiul75XiisDoNWWSB0ukaK4tLbKPjHpw5J13drxgg8LGDeCAg8Qn/pkAMjTFRhYoH6IxS
        yso5ecphcEHfU2Aw==
Date:   Wed, 23 Jun 2021 14:02:09 +0200
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
Subject: [patch V4 42/65] x86/pkru: Provide pkru_write_default()
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a simple and trivial helper which just writes the PKRU default
value without trying to fiddle with the task's xsave buffer.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
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

