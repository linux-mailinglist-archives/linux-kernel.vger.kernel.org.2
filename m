Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677DF3A4E44
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 13:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhFLLCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 07:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFLLCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 07:02:36 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61853C061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 04:00:22 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id s14so6559149pfd.9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 04:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8iFz8MxPZLy39szDaTinyyt9MSbr8V1d4abH/6Oyi34=;
        b=dsAZPKVtBd9FNW3PfmVk3BX6RVgYyNpg0Raa2+UAkDpXioHz+z76oMr8eGi8viVXKL
         LiNViHV8bVXfGjz0w4vn5sST0m+1oEkawdQVH6VFf3HTzWn9mgM8simVoLWywHcmAjtQ
         Z5oDevv6bonmRxRv8y3Qfal5SfB/GcuD4YJ10Dy3ZuM/P1CR/PAsmHRit8p9LNXwuzmt
         96fq9jE3x5LClunwOps24irJn4iE69mURhQPk9sMhixglFpgcmI6JMUnDtFcCVSWfkUr
         bM+PHdzbUsRyDk8Oj5BS4EVg53CAaiJBGtekU/CtFElLbP/5IYTNvijdZPAefdDb70V8
         tRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8iFz8MxPZLy39szDaTinyyt9MSbr8V1d4abH/6Oyi34=;
        b=oioqC5+bTiFz0utWRT81d7zTDHk+TAvKkR4KpCUMxHy2B1drO6hrJ8JbfBW3d5+VNM
         A6Qpt8w7tNFjdK0TKfpfKh7qvWOV2QVXbZXw13HHautTpsTKv20r1pmJFxOKWS8yp2vb
         XPkpM9kHFCdq0OJerwHYlkeIBf0ecHj/jyzvspCS21CPOzFFLYJr1Q29IfAC+MWZOXp9
         wOw/kWsfqUDhJH7UaN1kepViVmhQs6lK6iIRTmV2FJImJSkMtBEIE4NerfELS6nb4AKr
         RgdBLL3TCD23WlpSizvNg/7CDS0e3goXunYAIMVSDxtgyfTS+HHqy3FI7CW+IzHdxxMg
         5eJQ==
X-Gm-Message-State: AOAM531Iy7056Uo3oXkq59I9lqDOTXZ7cIRJQmuA8T47WcWbmQihXP6a
        vB1chPVry+H+6tIm+HE6WllDGEwr8kH3i/zZ
X-Google-Smtp-Source: ABdhPJxX8jxHPklTMEHdOxhkDMwNRN9obBLTCd8K9iuKwSlL5men33m5itr/QfiIZGiD/H4CqQ9vhA==
X-Received: by 2002:a62:7e05:0:b029:2ea:57f:ec86 with SMTP id z5-20020a627e050000b02902ea057fec86mr12613918pfc.37.1623495621051;
        Sat, 12 Jun 2021 04:00:21 -0700 (PDT)
Received: from raspberrypi ([125.141.84.155])
        by smtp.gmail.com with ESMTPSA id v15sm8060992pgf.26.2021.06.12.04.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 04:00:20 -0700 (PDT)
Date:   Sat, 12 Jun 2021 12:00:14 +0100
From:   Austin Kim <austindh.kim@gmail.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, austin.kim@lge.com,
        austindh.kim@gmail.com
Subject: [PATCH] KVM: arm64: vgic: declear local variable 'flags' before for
 loop starts
Message-ID: <20210612110014.GA1211@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Austin Kim <austin.kim@lge.com>

Normally local variable 'flags' is defined out of for loop,
when 'flags' is used as the second parameter in a call to
spinlock_irq[save/restore] function.

So it had better declear local variable 'flags' ahead of for loop.

Signed-off-by: Austin Kim <austin.kim@lge.com>
---
 arch/arm64/kvm/vgic/vgic-mmio.c | 2 +-
 arch/arm64/kvm/vgic/vgic-v4.c   | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio.c b/arch/arm64/kvm/vgic/vgic-mmio.c
index 48c6067fc5ec..ae32428d9f87 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio.c
@@ -232,11 +232,11 @@ unsigned long vgic_mmio_read_pending(struct kvm_vcpu *vcpu,
 	u32 intid = VGIC_ADDR_TO_INTID(addr, 1);
 	u32 value = 0;
 	int i;
+	unsigned long flags;
 
 	/* Loop over all IRQs affected by this read */
 	for (i = 0; i < len * 8; i++) {
 		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
-		unsigned long flags;
 		bool val;
 
 		raw_spin_lock_irqsave(&irq->irq_lock, flags);
diff --git a/arch/arm64/kvm/vgic/vgic-v4.c b/arch/arm64/kvm/vgic/vgic-v4.c
index c1845d8f5f7e..a0c743f83bbe 100644
--- a/arch/arm64/kvm/vgic/vgic-v4.c
+++ b/arch/arm64/kvm/vgic/vgic-v4.c
@@ -116,7 +116,7 @@ static void vgic_v4_enable_vsgis(struct kvm_vcpu *vcpu)
 {
 	struct its_vpe *vpe = &vcpu->arch.vgic_cpu.vgic_v3.its_vpe;
 	int i;
-
+	unsigned long flags;
 	/*
 	 * With GICv4.1, every virtual SGI can be directly injected. So
 	 * let's pretend that they are HW interrupts, tied to a host
@@ -125,7 +125,6 @@ static void vgic_v4_enable_vsgis(struct kvm_vcpu *vcpu)
 	for (i = 0; i < VGIC_NR_SGIS; i++) {
 		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, i);
 		struct irq_desc *desc;
-		unsigned long flags;
 		int ret;
 
 		raw_spin_lock_irqsave(&irq->irq_lock, flags);
@@ -158,11 +157,11 @@ static void vgic_v4_enable_vsgis(struct kvm_vcpu *vcpu)
 static void vgic_v4_disable_vsgis(struct kvm_vcpu *vcpu)
 {
 	int i;
+	unsigned long flags;
 
 	for (i = 0; i < VGIC_NR_SGIS; i++) {
 		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, i);
 		struct irq_desc *desc;
-		unsigned long flags;
 		int ret;
 
 		raw_spin_lock_irqsave(&irq->irq_lock, flags);
-- 
2.20.1

