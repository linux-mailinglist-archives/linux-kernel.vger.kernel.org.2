Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C967A358CA2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 20:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbhDHSbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 14:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbhDHSaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 14:30:52 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC9DC0610D0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 11:29:19 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id cf5so1669934qvb.20
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 11:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/RFtNNq4R+HQlfABCrnOp0vGXtCZ+PdK4tYVAs3Xgq4=;
        b=mRyvx1ZyCWRRYs/gtfFKoK8RBt3UI3Cbe8UFU+DjhbwvArNTuLgIFS5sSHA8GrypJO
         h1Ut4lnsHPkWI+6YGudQiUwKpMvE3rw3IvXbMyabZSfdvOVUtUOuttrRv/lU1I0YKtr+
         2KHbgG7VEZaD7k90Q2eC5FYoEypvPzIMBzhRBoMcW7o/u3O1niG3LYNNqbDjD1qMFVl5
         E0r5iFj/NMKIiwFuIz+tbBcn4ksbC5mZayHEJv3FtIIufUIqISS2/csUEuPKce6VPJ6v
         9VVELn3ltJVZx2tcvPVhDFYkynJ6q1lEl6xzivgPR/q2vDBkBfPrFKC+an1ZU7XkvHYL
         wK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/RFtNNq4R+HQlfABCrnOp0vGXtCZ+PdK4tYVAs3Xgq4=;
        b=L5/FDfohywz9J4GEYSKo0RNmuJBCKda9gALFg+2oj8sLF7ATQdkFHVD5A5GofQVjpL
         GDJhfPNNCpZOj5aGD1kN0U4qBG4bduW5n0wvaZqmmrSMVnIA7YPcm8RHmdO4pBWmwFjn
         752/gWL/bnZtbfm5ExFSbg5FWZ/YBuDpCgVyW7dIV4fHGxgQNbA1CkZmYBFvbSsHlf11
         XiL/Vs64HtMKMhYHQb36tqQ3Vgb8o4gkznrDbXLprsITZ0KrNXSU5DxZGjYghIT0OYwe
         uOyRvrtzjyBC2Ub8C/cnwupX9d5QRBPxtCwb8UAiVHb54kPIZUFiWerOBWLAmdAsd+yg
         n8uA==
X-Gm-Message-State: AOAM532dSFO2JJLUd/dJLz9XiCpGzqEA7wE9msnBdnBJCjKH/ZCHa568
        6a7bxmVNk/LEYFuAbIL/LB1O+8j18RGZQP5P5ho=
X-Google-Smtp-Source: ABdhPJx0EQDE5MZTKE/yaW2uV6UWZxJCkACiU6S0cyy4tgm6Rm995yl/yaBcL1JmqZoeGYIAcOfNaP46VqXvbu6lWB8=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:3560:8505:40a2:e021])
 (user=samitolvanen job=sendgmr) by 2002:a0c:b410:: with SMTP id
 u16mr10174868qve.8.1617906558331; Thu, 08 Apr 2021 11:29:18 -0700 (PDT)
Date:   Thu,  8 Apr 2021 11:28:42 -0700
In-Reply-To: <20210408182843.1754385-1-samitolvanen@google.com>
Message-Id: <20210408182843.1754385-18-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210408182843.1754385-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v6 17/18] KVM: arm64: Disable CFI for nVHE
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
Tested-by: Nathan Chancellor <nathan@kernel.org>
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
2.31.1.295.g9ea45b61b8-goog

