Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B737B3183BF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 03:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhBKCwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 21:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhBKCwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 21:52:39 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D24C061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 18:51:59 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id v3so1889330qte.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 18:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=X7hsd6YoqSU3QOkH9Rww2PvhQN7iVOHiNC9z6sY88Qw=;
        b=JERg3RTi/YSAsxDt581kKZvol+sVk4Lu/Z4w3KksQUuyCN4AcR/rQE+BMQoLQvqUGj
         XSZ5n6HsAlmPbnDbQ/XgtRYR1bXAWy6bmHqCLvlomp+F+5gxpXQ8BF/tKnWct/OFPacC
         h/pVdGDTpB3hTzts45NX4kt1MjDtBqFJitIqkjLyAkeWPheOaxlkKVwMsxJp0WI4+AkR
         ehP0iF4LFXwmFeVJhzeksq6esoVUlfyKmi1xpSWW34teDPDSSRSuolNicj7pz7E53sOX
         eppB3HZVg95ECSedHauQg6PfZDcbzMMztjs2m4JNjzHNa2EAr2V+iIcY8YQsG9Rkj1bq
         VJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X7hsd6YoqSU3QOkH9Rww2PvhQN7iVOHiNC9z6sY88Qw=;
        b=nLlfvPIdwn3o1zhrwhl7YVj1b81aGeodG+4bj/bfiW8M6KhonKD2QHlUqdaqr58IuR
         2xWr+xvQgMjMmw+2Yf/8McmdihKjRPXhRrDtrTa6ftCIWIW5xeyuaAk1ABoMAYo0Uc/e
         PKYtTdq3FcPCgaNUBF8UWhn9QqnFT2F9/iiCVkFFl4CReEPVehH4HtIY8v4cKkfT22Na
         2HiU2b9gSVpQ9iVZqk0pxU5sNRk+4iBfDCAIb2Iwup8nIRmpGIu+I0eyo3y4mXM8Xror
         P6UMZdA0Zl6dByVRk3t01f32kCJkXU50dFOICCZv3t3WJN5peYFHO8tf0c5pesMU+Bqh
         FPDQ==
X-Gm-Message-State: AOAM533NcmA/Bn8mX/u4+c9mIlL49vYDWSJYhZpIyUYPLbVQdtPWOY8i
        UkBF0N54s20I0uhGfX2GG40oGSTGkAm1ILdeE4Q=
X-Google-Smtp-Source: ABdhPJxOjdh2pe+SR86iowGOlBqbu2s4elij+Ij2Ra1DA0N0ImOH8DlhPiJmBvDqueT6WovuBRxRmtZC+kUvUxgJUQ0=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:1dc:8608:b4eb:4dd0])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:ac43:: with SMTP id
 m3mr6010448qvb.37.1613011918613; Wed, 10 Feb 2021 18:51:58 -0800 (PST)
Date:   Wed, 10 Feb 2021 18:51:48 -0800
In-Reply-To: <20210211025149.3544593-1-ndesaulniers@google.com>
Message-Id: <20210211025149.3544593-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210211025149.3544593-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v5 1/2] ARM: kprobes: fix UNPREDICTABLE warnings
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Smith <peter.smith@arm.com>,
        Renato Golin <rengolin@systemcall.eu>,
        David Spickett <david.spickett@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "kernelci . org bot" <bot@kernelci.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GNU as warns twice for this file:
Warning: using r15 results in unpredictable behaviour

via the Arm ARM:
K1.1.1 Overview of the constraints on Armv7 UNPREDICTABLE behaviors

  The term UNPREDICTABLE describes a number of cases where the
  architecture has a feature that software must not use.

Link: https://github.com/ClangBuiltLinux/linux/issues/1271
Link: https://reviews.llvm.org/D95586
Reported-by: kernelci.org bot <bot@kernelci.org>
Suggested-by: Peter Smith <peter.smith@arm.com>
Suggested-by: Renato Golin <rengolin@systemcall.eu>
Suggested-by: David Spickett <david.spickett@linaro.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm/probes/kprobes/test-arm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/probes/kprobes/test-arm.c b/arch/arm/probes/kprobes/test-arm.c
index 977369f1aa48..2543106a203e 100644
--- a/arch/arm/probes/kprobes/test-arm.c
+++ b/arch/arm/probes/kprobes/test-arm.c
@@ -166,10 +166,10 @@ void kprobe_arm_test_cases(void)
 
 	/* Data-processing with PC as a target and status registers updated */
 	TEST_UNSUPPORTED("movs	pc, r1")
-	TEST_UNSUPPORTED("movs	pc, r1, lsl r2")
+	TEST_UNSUPPORTED(__inst_arm(0xe1b0f211) "	@movs	pc, r1, lsl r2")
 	TEST_UNSUPPORTED("movs	pc, #0x10000")
 	TEST_UNSUPPORTED("adds	pc, lr, r1")
-	TEST_UNSUPPORTED("adds	pc, lr, r1, lsl r2")
+	TEST_UNSUPPORTED(__inst_arm(0xe09ef211) "	@adds	pc, lr, r1, lsl r2")
 	TEST_UNSUPPORTED("adds	pc, lr, #4")
 
 	/* Data-processing with SP as target */
-- 
2.30.0.478.g8a0d178c01-goog

