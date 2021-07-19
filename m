Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389DC3CD2BC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 12:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbhGSKID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236740AbhGSKHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:07:40 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D85C0613E7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 02:56:11 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id k16-20020a7bc3100000b02901d849b41038so3810061wmj.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 03:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xCrkHvgx5Vjp7sEk2L8Nl84wrwMoF/axMUKdY9pah24=;
        b=pDxR+oOIO361IE8JTpjXvK01glJPoXIl5CKZaNz+ZEfkmqJ2xvk3unbPd+7kb+OWda
         trEZrnZ3NzpP8uHCTZzYftalFdx/5wIdaoBQhrxNPVxgdiIghwpg+2wP8M3OPqfirjTd
         xnwKYQbjP84kmxrLM9ZxQ2L+sfZUek62Dy3owBDZGm0aQ2qax8dWHJG04y1UCCQkOeuM
         PcvsBY4gP2Eu0tIv5EGGfrTI+RlXVojwsHLkOMz6yutWmR06OxR8yq1klADXa4P0bQwV
         ool2uXbjJpW+F45cx8urCBsHAnKEob82EgvPFM7Eq5WwW85p/LaSm12Ccfkyebt5WyL7
         ovvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xCrkHvgx5Vjp7sEk2L8Nl84wrwMoF/axMUKdY9pah24=;
        b=a03V4oHmPF2DZSJwkB5SBGvnXE6wV61hsxafCAeuqZ6WvO6nm1l9k8sSXu8hnzj5i6
         z/pVh8a8uBPKwGVIsVSQdBVMLfm/b6UIhYxLpcSFbJt1Gp7qHXSEHMtCSkNx+qYNVCU4
         xLCA+bp8Keb9YDpK7WBIzAzibFUA0VSsq2A2BpzCxRnUM6gWeSipWthNQe2jsT0S/qfw
         +IQOyzEyXGp0fXaZCuJba8kHc9lqrzsWWvTATczFgoSJk/fYDjVoBGMOfoUp0n/AHtJl
         MzjrdgtETvLM3WDOwTLd2MGuPWhX52729i/DVwe9we/zxVEbFVQRaNxezM63R/1CkpBa
         7psw==
X-Gm-Message-State: AOAM532XOBwc8YfboeawTfzWx25PkLWoy9bJ8Ur6BwJdzOd/4MBdRlIs
        DE4BcTMYxdGgtz0l6y4Fcyh9ImcrP7cc
X-Google-Smtp-Source: ABdhPJyIruRnm597DeIoz+H4lQk2XaV0lp7fhRFMVmFaiZHZyDX1vs7MSEJSK9DYDl49AjGViAobxaMPEAN7
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:1a96:a43f:6c2e:bb5a])
 (user=qperret job=sendgmr) by 2002:a1c:4c18:: with SMTP id
 z24mr32007850wmf.168.1626691692999; Mon, 19 Jul 2021 03:48:12 -0700 (PDT)
Date:   Mon, 19 Jul 2021 11:47:35 +0100
In-Reply-To: <20210719104735.3681732-1-qperret@google.com>
Message-Id: <20210719104735.3681732-15-qperret@google.com>
Mime-Version: 1.0
References: <20210719104735.3681732-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 14/14] KVM: arm64: Prevent late calls to __pkvm_create_private_mapping()
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__pkvm_create_private_mapping() allows the host kernel to create
arbitrary mappings the hypervisor's "private" range. However, this is
only needed early on, and there should be no good reason for the host
to need this past the point where the pkvm static is set. Make sure to
stub the hypercall past this point to ensure it can't be used by a
malicious host.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index f05ecbd382d0..e1d12f8122a7 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -154,7 +154,10 @@ static void handle___pkvm_create_private_mapping(struct kvm_cpu_context *host_ct
 	DECLARE_REG(size_t, size, host_ctxt, 2);
 	DECLARE_REG(enum kvm_pgtable_prot, prot, host_ctxt, 3);
 
-	cpu_reg(host_ctxt, 1) = __pkvm_create_private_mapping(phys, size, prot);
+	if (static_branch_unlikely(&kvm_protected_mode_initialized))
+		cpu_reg(host_ctxt, 1) = -EPERM;
+	else
+		cpu_reg(host_ctxt, 1) = __pkvm_create_private_mapping(phys, size, prot);
 }
 
 static void handle___pkvm_prot_finalize(struct kvm_cpu_context *host_ctxt)
-- 
2.32.0.402.g57bb445576-goog

