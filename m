Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188264175E6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346520AbhIXNeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346566AbhIXNec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:34:32 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B6AC08E9BA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:29:17 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id v19so6991875pjh.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Uue+yztpX5IM7kP0vfiTVA2GtP2LIyQitnNsalGpdo=;
        b=ICWjXmDPNT7mP37H9Ct+Iwt9gOslgCNFdX+RO8yQAQFsW+YFBsIU8abgsW5964B2PM
         +kglcXD+s5Zt37TzAT+FIY6wJbJ32W2Rru2aJq8g9M29AVokeJSZHEyvbs7HysaReRDz
         XFVcYvAgfPCpH2LUVdyJh0mWRv6IIR0swoEBSgOaCn9uwxhWukDLDTsd4CzhBcEHa13Q
         5AW14pdksgsVq5r/p5qzNrQxr+fk3kHYr35k1JdCFTPxxySav3G7QmMSuGsP8rjdgyiS
         qEtI217++EolPYTaGeUrgq5t2E9uYLUKUkyI5jdm8AljOjOjuML4SCv/VAzqGycXn69K
         pe+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Uue+yztpX5IM7kP0vfiTVA2GtP2LIyQitnNsalGpdo=;
        b=3SJiKagy04+g1AWkypkfGv34dlQAzfRD0E2Ok98FwitC7VzBE1BWFB6djgecigNLHF
         lPSl7vYUPfe6b4d6mog6Qeuihatz0fzJgy/Vy7ReYHb1xty4hrOz32ZCffB2ROi1NVrD
         /efL0ZGirdTfGdBI8hR8oZaytz29bnkDMPr92ylJBPVmIw180qfrkO0xnKH5wIcsxQ1j
         pEAcPnmYtoU57lcHGxu3BXH+2QKo81x3BEuelZnA5TqToxJNrvzJh2cG/1MRdWMMSskj
         3W4BNxtvAPNB+ZcABNKailOwGjYe2lnKc4zDRuTlwg2lHzAedUL9xfP7hJy8sPfT0JvB
         BZFQ==
X-Gm-Message-State: AOAM5322xZjtUh/dxc65bS3lhXO4xbnR8k6DzYI5VWEOQErC7TOg884D
        HdacCo3F5WwWDFDpnrxQIg==
X-Google-Smtp-Source: ABdhPJydAbj296V1R49Fk2kv5TFPlIv5RgcrNJwUoCYjkaac0cwhj428TdO8RO/PFkKoS6MFkrVV+A==
X-Received: by 2002:a17:90b:3715:: with SMTP id mg21mr2297406pjb.186.1632490156639;
        Fri, 24 Sep 2021 06:29:16 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 26sm11756573pgx.72.2021.09.24.06.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:29:16 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCHv2 4/5] irqchip/GICv3: let gic_handle_irq() utilize irqentry on arm64
Date:   Fri, 24 Sep 2021 21:28:36 +0800
Message-Id: <20210924132837.45994-5-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924132837.45994-1-kernelfans@gmail.com>
References: <20210924132837.45994-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to rcu_irq_enter() originated from gic_handle_irq() is
redundant now, since arm64 has enter_from_kernel_mode() akin to
irqenter_entry(), which has already called rcu_irq_enter().

Based on code analysis, the redundant can raise some mistake, e.g.
rcu_data->dynticks_nmi_nesting inc 2, which causes
rcu_is_cpu_rrupt_from_idle() unexpected.

So eliminate the call to irq_enter() in handle_domain_irq(). And
accordingly supplementing irq_enter_rcu().

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yuichi Ito <ito-yuichi@fujitsu.com>
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/Kconfig           | 1 +
 drivers/irqchip/irq-gic-v3.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5c7ae4c3954b..d29bae38a951 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -98,6 +98,7 @@ config ARM64
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
+	select HAVE_ARCH_IRQENTRY
 	select ARM_GIC
 	select AUDIT_ARCH_COMPAT_GENERIC
 	select ARM_GIC_V2M if PCI
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 89dcec902a82..906538fa8771 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -729,10 +729,12 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 	else
 		isb();
 
+	irq_enter_rcu();
 	if (handle_domain_irq(gic_data.domain, irqnr, regs)) {
 		WARN_ONCE(true, "Unexpected interrupt received!\n");
 		gic_deactivate_unhandled(irqnr);
 	}
+	irq_exit_rcu();
 }
 
 static u32 gic_get_pribits(void)
-- 
2.31.1

