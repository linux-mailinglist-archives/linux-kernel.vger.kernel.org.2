Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE2841512D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237551AbhIVUMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237346AbhIVUMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:12:01 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A941CC0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:09:05 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id b20so16838083lfv.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NOj2MbRZphEUvi8jESJFvdrhu8xMbUqpTuIwZO/a2mE=;
        b=ty6d9Lg2zbZ1f0V/3qL9QWdmjD8rA1Jw0ejwSLF5/Pv81DB3FwUg9sNptfKhY8+04n
         rtumJ+DK7SXHYLhY5J8dVzaalmIiYnueminyPA7Rw+JEPN7mE4JqcCHEypbGAZGU12BP
         ubShsWCOCV5n0831S5H34Mdeog0HWkwXI2jE3DTBJPxHf36t0Jpwy5H2qOAfkwqcpot0
         U8EoBa6Jn4M0SyVU/lblAFJGORXLZHgMYQ0SveHGnoANLHDc/gmYAOJf+c8UPQqhMtyL
         Jp6up1OfizcglZ8q4cw/VhHMy7jefXHKKa9XQdsawZWqkphRJwmXhPWMtGY1FNI6PkcG
         ezvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NOj2MbRZphEUvi8jESJFvdrhu8xMbUqpTuIwZO/a2mE=;
        b=cHYj/BAglhyeidbPYCZYlC1ZJFG691N17Y/enuQTeLmJI5wvha6UTtgkESK/rnClC5
         q2p/Hu2Kafs1/ZM3luwiYpIo7BE4yAII8mepfL9vU+ALUyJnaBmWuBt5IpUbx65axp5X
         kT75RU/VkG7nCmuqX4+Otm9jy/WLo16in+Ca4O+0Y74nQg97UVesNoP6C0AFCRBbMISu
         h6mXVVOlmKVO6cuyxASu+FU75oxNCoJFoRX+GDWr9RIQD2Bb98oTnNVWcnO5TT3Gln/E
         f9GftD/YHKPpYRwAqQJB1Ol6gu6wN1fXAE4vipXuBO26lquZUy7QMthZzcU38o/sSAyG
         BXRg==
X-Gm-Message-State: AOAM531+lXB8DY9Y2UP/hwEQUvjDYt0xY7JhqgdMDcJHLVbqrAe++gOE
        2UN3ExG/UiusAUO6S4YIMgpt9A==
X-Google-Smtp-Source: ABdhPJzn4PjHHowxgYxb3anNpLBH6811ZTEgniNwwk0BZS4Bfukp6dAG70/IBUV+AKoI0XMu7hv0Og==
X-Received: by 2002:ac2:5f41:: with SMTP id 1mr747444lfz.79.1632341344058;
        Wed, 22 Sep 2021 13:09:04 -0700 (PDT)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id a26sm253399lfg.193.2021.09.22.13.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:09:03 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Remi Duraffort <remi.duraffort@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        andrew.cooper3@citrix.com
Subject: [PATCH] x86/fpu/signal: save_xstate_epilog: fix return polarity
Date:   Wed, 22 Sep 2021 22:09:01 +0200
Message-Id: <20210922200901.1823741-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the missing return code polarity in function 'save_xstate_epilog()'.

Reported-by: Remi Duraffort <remi.duraffort@linaro.org>
Fixes: a2a8fd9a3efd ("x86/fpu/signal: Change return code of restore_fpregs_from_user() to boolean")
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1461
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Cc: andrew.cooper3@citrix.com
---
 arch/x86/kernel/fpu/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 68f03da2012e..39c7bae97daf 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -106,7 +106,7 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame)
 	err = __copy_to_user(&x->i387.sw_reserved, sw_bytes, sizeof(*sw_bytes));
 
 	if (!use_xsave())
-		return err;
+		return !err;
 
 	err |= __put_user(FP_XSTATE_MAGIC2,
 			  (__u32 __user *)(buf + fpu_user_xstate_size));
-- 
2.33.0

