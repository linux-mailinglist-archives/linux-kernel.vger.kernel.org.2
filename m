Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFE13523FB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 01:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbhDAXeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 19:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbhDAXdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 19:33:52 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB001C05BD1A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 16:32:55 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id g62so4784508qkf.18
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 16:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CIBsMUAzqVBKJMC//YF4MdkZzSoA2eT4NBvrPysyfhQ=;
        b=BFiANp0pMWHC/IyuQ9DGSiKV70Aw33MNbDtGFQZCptIZJl11fKLLDwlPfO4BrNVOJp
         xzRqfWKuwuvy9O8TfYc7fcGPZWCdHHqTS3flzLSd3zVxDLZBElZvtCaoUsohNJ42lKS+
         7yY0vSiJ4daBjV9yrkjy1OXNtCCbOBPV5KYjE1jSVn2d02AszzrZlgXf0dFPaZ9Up5To
         eq4R0xU+5yBj0s5fhti8O+UcraNwDXGjf0cZET5W6nlaaVo/DY6UE56DTVPCdAsmBb27
         Qg0VzjbU12KqVP1onYHpSPh4rX6We4KOqxllBqzjOZeRf3DS2g8QdGnZX5lmwOzR6vrP
         SHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CIBsMUAzqVBKJMC//YF4MdkZzSoA2eT4NBvrPysyfhQ=;
        b=pBh4jiDh0eAxEBNXwVMLUVeCeidH6RJ/uFA+UvMclJcoSClAuScfZRyacUu57Jfjhf
         FbAjNjWmTkQ0kBjjYnfb19UQJpmBER49d1IESiacWgvltHwPhFl7jD/biS+iWpWYD4u8
         7hdvxy8uovuGFWtozuBLF/9k/qg8W/8pX6XOkhbxJTK+dijhJgpQXPxyDw06B6ZG44kP
         ljVANh3inV99iMoquUEy7t2txnzL08G9WL+HOYYCYmPd78KVCDJLZMJT2PzPi6uzTLwh
         dYQaqnsuEp+A0WSLaAm+UhaDJg4GODaTRRPkdX2gO+ETZUTOgllD944Q+sDX8unX0ewO
         0B5Q==
X-Gm-Message-State: AOAM530Ktz4dDXENSDGXBJJmWl9YBCzamvau1qLnB3LuBWiUg9H+m49M
        C2TLBFHqNGCYu3fGq263OXT38jWI95C0pc0WVmQ=
X-Google-Smtp-Source: ABdhPJwrLvJN4iFq87bXxxrX4+4K8e7wEfk2totPF6AIrVykX4E6RMB+YDXBq4nStyRioTba7CPxK2ZVTVGbLw7Xcks=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:4cd1:da86:e91b:70b4])
 (user=samitolvanen job=sendgmr) by 2002:a0c:f7d1:: with SMTP id
 f17mr10229433qvo.38.1617319974835; Thu, 01 Apr 2021 16:32:54 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:32:15 -0700
In-Reply-To: <20210401233216.2540591-1-samitolvanen@google.com>
Message-Id: <20210401233216.2540591-18-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 17/18] KVM: arm64: Disable CFI for nVHE
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable CFI for the nVHE code to avoid address space confusion.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kvm/hyp/nvhe/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index a6707df4f6c0..fb24a0f022ad 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -75,9 +75,9 @@ quiet_cmd_hyprel = HYPREL  $@
 quiet_cmd_hypcopy = HYPCOPY $@
       cmd_hypcopy = $(OBJCOPY) --prefix-symbols=__kvm_nvhe_ $< $@
 
-# Remove ftrace and Shadow Call Stack CFLAGS.
-# This is equivalent to the 'notrace' and '__noscs' annotations.
-KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+# Remove ftrace, Shadow Call Stack, and CFI CFLAGS.
+# This is equivalent to the 'notrace', '__noscs', and '__nocfi' annotations.
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_CFI), $(KBUILD_CFLAGS))
 
 # KVM nVHE code is run at a different exception code with a different map, so
 # compiler instrumentation that inserts callbacks or checks into the code may
-- 
2.31.0.208.g409f899ff0-goog

