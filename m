Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176F1362983
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 22:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344024AbhDPUj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 16:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343882AbhDPUjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 16:39:32 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37C0C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:39:06 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id z17-20020a0cf0110000b029019a84330150so4958293qvk.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3kLlLNgA4/UR3gGgysL5O/QEoIGDVBy6cBdyLqywCPE=;
        b=F374P8++Vwir3ShakHXwcrpAJk6Pma6R0F6X6Hy1kbo6qBe7nSm3ms/w22MMiKhH6S
         9rAuBvUuFvTljsyaEcXqpcaM/MvgNgK0hVbC7rlF4ExDX+LVtlILJtPmEtZte+ZXGuqu
         RCDFemFFqHZC/zfqIzh3moKubhrjXndfEzXZ8N3XLOPopPP07UpYyvjItW+lDM+E33JZ
         GNblwn2fm+Dfk6fMZX+ixZVgD7ani8w23K1Uq1hYv64iI4nlH2LnL89jt3CY9Qi3PYoX
         r+ojzhrhVotDxafuRppPTmp68X896U5d2cYVaaxNgZSWXymolvK+uM+98GFoEy3MW2d7
         F4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3kLlLNgA4/UR3gGgysL5O/QEoIGDVBy6cBdyLqywCPE=;
        b=C01SbJvQImnh+dKFyKMeUg5XQ1TeDd0q83v/iVixzlNWW8XoeWDdy+QluF/37o0nsh
         GgkzJ0H8CGOK7k5nnwoo8etQCkWjiV5jtdfR1wt9v8p2AdlrB4j4cycIA2sDk4mCdCMD
         oORthEKpHu2dRZqncyOJvZfiHD4QUCS/C57U0QgIxAII5hJct4GngfaPo0/fTuHecQrr
         GoOmVVc66G2pWUWlooyWXY/FLKwwGSFpd0UkMaL3R2/bYUjf6ax2MuYV1PdGC03MrOpU
         Ohju/nos6dTQrowQorGoEoe6T90/MHfbx31te8SIfz6jtmpUI6HX+K2Q5TAkuGfTe8tl
         42Ew==
X-Gm-Message-State: AOAM530menXcc2z8TrVRQIkbuBj+cTtGNQlpAI3CNI7bbLjFTznYs9Pe
        DBBcRIkwOK83Tj5HOTtBqrZ+yy5wTqWPbfwUWpU=
X-Google-Smtp-Source: ABdhPJwVTh3VpMUIDKmf2FeFHaHe9QDxfCZGRUtAwwurFZbFJM7zVrsZyq0qPEqZFg+S6o2thKhy3f0QtikE0RRctF4=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e262:3d8e:cbf:6164])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:224b:: with SMTP id
 c11mr3729106qvc.44.1618605545980; Fri, 16 Apr 2021 13:39:05 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:38:39 -0700
In-Reply-To: <20210416203844.3803177-1-samitolvanen@google.com>
Message-Id: <20210416203844.3803177-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 10/15] x86/purgatory: Disable CFI
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable CONFIG_CFI_CLANG for the stand-alone purgatory.ro.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/purgatory/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 95ea17a9d20c..ed46ad780130 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -31,7 +31,7 @@ KCOV_INSTRUMENT := n
 # These are adjustments to the compiler flags used for objects that
 # make up the standalone purgatory.ro
 
-PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
+PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel $(CC_FLAGS_CFI)
 PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss -g0
 PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += -fno-stack-protector
-- 
2.31.1.368.gbe11c130af-goog

