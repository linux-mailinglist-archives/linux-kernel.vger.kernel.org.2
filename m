Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78A6433596
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbhJSMP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbhJSMPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:15:25 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0041C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:12 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id k6-20020a7bc306000000b0030d92a6bdc7so1074530wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9qioxcWNTdM29KTskJovFvpNouj7jwaQhn/w48JNYr0=;
        b=RCVF+kFj8+Q1ZIvAw2o1YEfdbyV/QvERANN2zOL3vp6KFp4sOKvq50TuiuJVXjk8CI
         sJ8+ANxFKAZIB5XW2WXqgfxqioUa8/FqpJDAAlHYk4VwJzPsMiTKfyXjGsWp6nYM2egs
         6ve8/RASgPFUMVKruWnMc+7Dq7xO467GfVDxse/ta3etQdRPTINc1Tn1t35gFQUffSa4
         I17Na6p96zob6zezj90RVS7pxK8HHoy186iRxq1vgOzGonEHYihEMN8mRi5acuaAqYmN
         0uVSCaCv9OaDCrMFHRsAD+gEn2IzZEReHw70B6v4JZTVux2bKXVrx5uW9Gfu3BqI6frT
         y8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9qioxcWNTdM29KTskJovFvpNouj7jwaQhn/w48JNYr0=;
        b=IugALC0pb51Nt5WtTQCFWXfN3X4+YJMhqeKjaGqOwQcoWA3muGEMi6wLGp2zu7l9V9
         w42jUgU9Q/px00PkRxbteCANOgVT206RVMvNS2wSQRkspvoEPCmCxyPqPYu+UypGCM+N
         dz6OHRf6G1g+QWdk8Y9yz8DpdMWW35UDkyPeb2UdeqryYDyJ4uCH6pi0JsFgAdz3Ok4X
         Bb/Rw0lJuJjZ0mFm16qCoHiEYEsz/pJM+cC18Tky02dnIFeaUrebayE8A3h4hc2p/UhN
         WLJda95LYYbRH8WzdZSO2jyeJtVn7/+LUgWzo1akaI3WmoDia/Xo5j2lNPD6MQ2UR/Xz
         1kaA==
X-Gm-Message-State: AOAM5339v9kRK/Urep5EddXRIZeYlhimQtolQ/OwGNrrUPOtks2IVOJN
        NlsQcOgwP6BykJG/I0m8yFao1W2IbB+j
X-Google-Smtp-Source: ABdhPJwlXJ0DM6qyO/wxtqG0399vc1RBGDWqJP0qqKuvfhECekIT7zJoTt4K3Fn+DO1gRLB/9VBwvtDmOWwC
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:59ca:401f:83a8:de6d])
 (user=qperret job=sendgmr) by 2002:a05:6000:50:: with SMTP id
 k16mr42638419wrx.32.1634645591442; Tue, 19 Oct 2021 05:13:11 -0700 (PDT)
Date:   Tue, 19 Oct 2021 13:12:51 +0100
In-Reply-To: <20211019121304.2732332-1-qperret@google.com>
Message-Id: <20211019121304.2732332-3-qperret@google.com>
Mime-Version: 1.0
References: <20211019121304.2732332-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 02/15] KVM: arm64: Provide {get,put}_page() stubs for early
 hyp allocator
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Andrew Walbran <qwandor@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nVHE protected mode, the EL2 code uses a temporary allocator during
boot while re-creating its stage-1 page-table. Unfortunately, the
hyp_vmmemap is not ready to use at this stage, so refcounting pages
is not possible. That is not currently a problem because hyp stage-1
mappings are never removed, which implies refcounting of page-table
pages is unnecessary.

In preparation for allowing hypervisor stage-1 mappings to be removed,
provide stub implementations for {get,put}_page() in the early allocator.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/early_alloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/early_alloc.c b/arch/arm64/kvm/hyp/nvhe/early_alloc.c
index 1306c430ab87..00de04153cc6 100644
--- a/arch/arm64/kvm/hyp/nvhe/early_alloc.c
+++ b/arch/arm64/kvm/hyp/nvhe/early_alloc.c
@@ -43,6 +43,9 @@ void *hyp_early_alloc_page(void *arg)
 	return hyp_early_alloc_contig(1);
 }
 
+static void hyp_early_alloc_get_page(void *addr) { }
+static void hyp_early_alloc_put_page(void *addr) { }
+
 void hyp_early_alloc_init(void *virt, unsigned long size)
 {
 	base = cur = (unsigned long)virt;
@@ -51,4 +54,6 @@ void hyp_early_alloc_init(void *virt, unsigned long size)
 	hyp_early_alloc_mm_ops.zalloc_page = hyp_early_alloc_page;
 	hyp_early_alloc_mm_ops.phys_to_virt = hyp_phys_to_virt;
 	hyp_early_alloc_mm_ops.virt_to_phys = hyp_virt_to_phys;
+	hyp_early_alloc_mm_ops.get_page = hyp_early_alloc_get_page;
+	hyp_early_alloc_mm_ops.put_page = hyp_early_alloc_put_page;
 }
-- 
2.33.0.1079.g6e70778dc9-goog

