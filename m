Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697E63F8E5A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 20:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243361AbhHZS7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 14:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243400AbhHZS7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 14:59:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDC6C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:58:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v126-20020a254884000000b005991fd2f912so4015481yba.20
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ViiFU95KoTSobvcFkVPuRN1El/Eu374C5RgTnO412cQ=;
        b=jTZHLx6W+kz9z/WI6uBPj4MWz5OMrQbE+r6SyGzXSq0PN3gcFJRFysbxOVBCYeDN9K
         bYCOJyI/iJSyYCPyPAS6apfvPZfgSmFTovS0UdWt6qttKd+dQqpP+fag4KPOpzVfpYxC
         weuZKVyUpeCbT1BhQtEYybFudT8onXbiHfVmAKsUpBhqkYvlhtHwLg10bmNPP/VkFdEr
         4ZtH5jZhiIKJGUoM0TPF9X2mvV+KqR+irm8C2aTHFnpArcgIInh7t96+P/w5KhYgDY/D
         gct4OUqOq10DpgaJZ6nIxoLLUwOZGg75AAovB3l+ZXB2qbmrOaiWRoesoBVTrg97aXPz
         51ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ViiFU95KoTSobvcFkVPuRN1El/Eu374C5RgTnO412cQ=;
        b=cLaJtXOVbajuVHoDN4Q/K+gB+DV2y+R0v+vmIoHyQ4czdbiQaUBeLybCb6Q1Gmk6vJ
         aKfMAlWwELCaOifC8mM2QFeQHDgK/+7NhIQsf86kGrpFW4Wp/qWNrHJ9AjQ+wwKVKzBv
         XnyLDVTYsj0fdsWSPTSZ/3CkpG/d5r7WvNpl87duc4Qu7dv0mDo7msBkszEz2EnLbBl6
         2CJ7S4O40WK6V4yTbigt3ydbRg6w/eKXpdMaJz0vtWx+yJ6RgQ3NiPpP3orVtU+USs2/
         y2/Fn6zaSGpBa5R24i4D0s5AjN6AjzZn3qSGTybUXN4B3AmssK0cn+f0k2+JaDlducdc
         3QGw==
X-Gm-Message-State: AOAM532fY2QAGMMO5LG9SRvomThxeeUSNxclEqg3wiM+NHd6TApIBIMb
        Mo20iPS5G+NSaKfOWGkFi1E0UwvfvcZIwov7a8w=
X-Google-Smtp-Source: ABdhPJz4jhB0w3DUKkroOtMsJHJfDf3OBGTK3SYqm+qoFrGnQVdPe3RtkEXvXoqPFnplUJhVFhjLSiztB4XSEqnotqA=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:cbc9:2aed:6fce:b9e8])
 (user=ndesaulniers job=sendgmr) by 2002:a25:5e8a:: with SMTP id
 s132mr261813ybb.510.1630004325605; Thu, 26 Aug 2021 11:58:45 -0700 (PDT)
Date:   Thu, 26 Aug 2021 11:58:33 -0700
In-Reply-To: <CAKwvOd=ML1ytp8Q10oiz8q1ERAHcGnjjCSMOHj=tq6E2vHAkQw@mail.gmail.com>
Message-Id: <20210826185833.174862-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CAKwvOd=ML1ytp8Q10oiz8q1ERAHcGnjjCSMOHj=tq6E2vHAkQw@mail.gmail.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH] x86/build: Refresh stale cc-option check for stack alignment
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     llvm@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC did not support values for -mpreferred-stack-boundary= outside the
range [4, 12] for -m64 until GCC 7+. Modify the cc-option tests to check
for support for a value of 3, and only when using GCC.

GCC has long supported values in the range [2, 12] for -m16 and -m32
targets, so there's no need to test for support for
-mpreferred-stack-boundary=2, since cc_stack_align4 is only used for
-m16 and -m32 targets.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index d82d01490dd3..2744c4f60b63 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -14,10 +14,11 @@ endif
 
 # For gcc stack alignment is specified with -mpreferred-stack-boundary,
 # clang has the option -mstack-alignment for that purpose.
-ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
+ifdef CONFIG_CC_IS_GCC
       cc_stack_align4 := -mpreferred-stack-boundary=2
-      cc_stack_align8 := -mpreferred-stack-boundary=3
-else ifneq ($(call cc-option, -mstack-alignment=16),)
+      cc_stack_align8 := $(call cc-option,-mpreferred-stack-boundary=3)
+endif
+ifdef CONFIG_CC_IS_CLANG
       cc_stack_align4 := -mstack-alignment=4
       cc_stack_align8 := -mstack-alignment=8
 endif

base-commit: 2e98d9bede666aa8f2137047043bfba9c2c2edc0
-- 
2.33.0.259.gc128427fd7-goog

