Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CC53A86CC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhFOQry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbhFOQrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:47:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C261C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:45:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a7-20020a5b00070000b02904ed415d9d84so20752204ybp.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=5J+F1+gxQZha6L7jPzTwe/D+QNbp9yn6LLcrwr/XuqM=;
        b=drwfA8kcFaRzbrcWSZiMY53wogCp0r4cbuqwGSVyDmm62d4DzVvu2oDlPCJThquOdh
         NAG28hDmlngWDfKSQjq/MqIJdwRKhii0+Fv1pqrzzxOJO/k4yThVQTWP/NGmAf5mY2fa
         CCMFRPY5xiXgsooBfHcQ/rI9jeI0YoONIg7x2t0p7zVX89yKBT4YnMjFwS19jrKAmP6+
         d1YBMcOowFVURwo11HbqVqu3BYzrSSUAMK7bOQZwKE15RqpCgALT1vOkuatGynv5dJK7
         vr4Qon0FqMAFC/zdR0k11kiyu5BsG1s9ugQ8amuR7PdODZHf9TM2G8rt/LRYVEDTkvMb
         9wEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=5J+F1+gxQZha6L7jPzTwe/D+QNbp9yn6LLcrwr/XuqM=;
        b=LBTgpW4EAId8tslmtxplq6mIb5Ar3UzyjZLCY3vxRQtouTb2HW5W+9bUI2sA30NksM
         lypiltyjPH1RAUBIE1jCAzOtyAZIRRByYvSByC4UbI2YQhKmqheAiTR41U17cLEGu0yW
         IzPg8cN4j0uvq7FeEq0a1OZa2J3AJiCRxHVkVEgsfC9jAUfIJDGI3X1EXkvkUQ+fi7V8
         oWcLfifGoR+ujID3/Mze4+Z5dXNIBqsYInqaZ4qNZr0FGY6FnVbItd5TyrOMF2pzpI1W
         xu0GkI4BF+VPcl9HvRjnFZH9gNlz3KDiPLiSyOgLOZe9+k/X1mHu4Ju5WX0Gvar6pqrN
         rSNA==
X-Gm-Message-State: AOAM531Vh1pVmndqNvsi2+a8bC5kQWKG37yAV6hNifSnfE2ps5YLM78V
        PqRwaRca/uTl/jQc1xP97we0W434k00=
X-Google-Smtp-Source: ABdhPJyPNtVwD2fc2tl8zW5dgtxkBBd9ee5zBmohB9oc608IOyvT20yNJ0ZB8WAfwcAokCrjmIEJumna1f8=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:13fc:a8bd:9d6b:e5])
 (user=seanjc job=sendgmr) by 2002:a25:b983:: with SMTP id r3mr104378ybg.238.1623775545321;
 Tue, 15 Jun 2021 09:45:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 15 Jun 2021 09:45:34 -0700
In-Reply-To: <20210615164535.2146172-1-seanjc@google.com>
Message-Id: <20210615164535.2146172-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210615164535.2146172-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH 3/4] KVM: x86: WARN and reject loading KVM if NX is supported
 but not enabled
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN if NX is reported as supported but not enabled in EFER.  All flavors
of the kernel, including non-PAE 32-bit kernels, set EFER.NX=1 if NX is
supported, even if NX usage is disable via kernel command line.  KVM relies
on NX being enabled if it's supported, e.g. KVM will generate illegal NPT
entries if nx_huge_pages is enabled and NX is supported but not enabled.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index acc28473dec7..1f6595df45de 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10981,6 +10981,9 @@ int kvm_arch_hardware_setup(void *opaque)
 	int r;
 
 	rdmsrl_safe(MSR_EFER, &host_efer);
+	if (WARN_ON_ONCE(boot_cpu_has(X86_FEATURE_NX) &&
+			 !(host_efer & EFER_NX)))
+		return -EIO;
 
 	if (boot_cpu_has(X86_FEATURE_XSAVES))
 		rdmsrl(MSR_IA32_XSS, host_xss);
-- 
2.32.0.272.g935e593368-goog

