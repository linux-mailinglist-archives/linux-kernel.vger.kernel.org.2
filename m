Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3133942C579
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbhJMQBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbhJMQA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:00:56 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53B8C061760
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:58:49 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id 41-20020adf812c000000b00160dfbfe1a2so2375671wrm.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=geKOuDyapRPU6is2PIHNocmWi3CmDJ2JnpgjpVKS/bU=;
        b=VN++2S+k4KN11UpNmg8AFQd0V1g+GIwPCw0Aq+JGPbUyihxnFmzsQSjAQWJFFjtaNm
         YYyApUmsmPcCpglJBS0OcaxZiObaBCtCRWdAcMluLCbf9XZeWJNDLP+/YN4gnsmUw/f7
         xZoAHQ0KIU3Z9WWrkwvKBpCF+1Aaxuw+GPZHCqSAmBBFKgOICUlNmDE9bQXcKoPjsW5j
         qdrcCUUxcrJnn6YKO7/p/oFhIV5I4JFfwjL4N46KjxY96Z+o1Y9z1MCRtDQ1cIV2V2ST
         svmcIQV2XP3IGVQgY4dBe1Q0RNlIo0cD+KFGU4K6IAmRkQQkkco+HEFX3nhr9v6m70zt
         BFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=geKOuDyapRPU6is2PIHNocmWi3CmDJ2JnpgjpVKS/bU=;
        b=H96oQwUlq0Gua+AXjCAhjcjKonWZM4ZLpwuhgP1fqJ2uDL7eu6ec+KGpNM2C9jbh9F
         93Tqp2EGMD9rDhqnDV480JyHyNvxO516DrtN6GLFmiyL/j5KhwGUVH2ZWB2hm8A8MdXI
         hHhrCXXYHVFct4GLg/CUZXkrWsLewCvJ9GjaCZM7pe2PT9VAfJvNVv74p7m1cvB6qMM8
         xoake75+eSRjbbNjIsU3tGPv3GkRRJhiiDjrdecndSpBKNAGafrDCKLv4LGUUfTCtiA8
         aYLFEF0admtQPwE8NmeCIhlj2AiTxjamAttcJ82APX9sw3ngtBF1Ox9oYMB1na1Bc9dP
         J+ow==
X-Gm-Message-State: AOAM530SnECn0R6m4BwCdX11yJMy/i0VumXejlSCeyz4AlIsNWLIbRNv
        1jZ8LNgPDkkEmfUAZT/lkILPEybKYTdM
X-Google-Smtp-Source: ABdhPJz0XCfJeYia0X1UAzFkedYN1KhyaiIYXjxhsEH0zsNp+ml8wu+2Vv+dlUCbDB1lFLK95GPgHM0lsljj
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:65b5:73d3:1558:b9ae])
 (user=qperret job=sendgmr) by 2002:a05:600c:4fcd:: with SMTP id
 o13mr14107564wmq.158.1634140728272; Wed, 13 Oct 2021 08:58:48 -0700 (PDT)
Date:   Wed, 13 Oct 2021 16:58:21 +0100
In-Reply-To: <20211013155831.943476-1-qperret@google.com>
Message-Id: <20211013155831.943476-7-qperret@google.com>
Mime-Version: 1.0
References: <20211013155831.943476-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 06/16] KVM: arm64: Provide {get,put}_page() stubs for early
 hyp allocator
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
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
2.33.0.882.g93a45727a2-goog

