Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4E13F3E8D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 09:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbhHVH6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 03:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbhHVH5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 03:57:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A92C0617A8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 00:57:00 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so3826326pjx.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 00:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6lG0U8bM2TUXGlj9bAHKfwVFEdBo2YZlvkgJ69Lo3ko=;
        b=hmArB39kTHDWjHkicA8v/VnEfzXloQM/um2zezothBwlueh0y6wW3Ms8vGXfoJFyQu
         9A2CZuvT+yTq1xfM2MniAoudl7ERA9s4DODVC4WVCS7baDau/R9Bq+raDBaJCFMYFDg8
         1Ot2UvIT1AT4E6UxA8DYaVwHg6TZbar8hqrzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6lG0U8bM2TUXGlj9bAHKfwVFEdBo2YZlvkgJ69Lo3ko=;
        b=csUx6kS3lG8pYbh8CvSDK8bCGEJtFZihdnzhSTcuHrwjM/FWrc4fH1qIrolqElP47a
         0ce3Hk74Th04ICcGLxoxXID3MBkRM+eLymrFUbHvDv/HSJUfv69H6iOoYvaDJ5zi9Y/T
         kQFiEkoEyddWw0+POds/ki/ATl4OJ1L86QeIUjdNZDI3muSBdjIegKj6RHlzT4nS3lcN
         X4r7piRa6vAsv/+bPV7JGQTGOYkUjbggjc4UM1FxSqE9pKlsdNe5ny7VtkKgfz55K/a8
         /NAoJuy2qw7XOOFfwTw0HBm6ApGDrO0YJ3sazD9Xw8dBE5ipuN1NG6Q9OzQH0nZcTksG
         HgOg==
X-Gm-Message-State: AOAM532kSZqXc52333/AOYKeYRn1DfEerYVeibRmeqhuYkiVRJq3XTda
        0Il4JYtInNAx+QTLVwYu/AwPBQ==
X-Google-Smtp-Source: ABdhPJxbZc4slAX4O5AT09UD6LAIss4P9R7ITuHe4cUc8SdAMeUm7ZtkSm+bN61mJQs8bLc5Pz9K6g==
X-Received: by 2002:a17:902:9b90:b029:12d:5ce1:4d99 with SMTP id y16-20020a1709029b90b029012d5ce14d99mr23174201plp.37.1629619020320;
        Sun, 22 Aug 2021 00:57:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v63sm14116932pgv.59.2021.08.22.00.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 00:56:57 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH for-next 16/25] fortify: Explicitly disable Clang support
Date:   Sun, 22 Aug 2021 00:51:13 -0700
Message-Id: <20210822075122.864511-17-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210822075122.864511-1-keescook@chromium.org>
References: <20210822075122.864511-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1427; h=from:subject; bh=MScHo/g3fAm2U5yn8644/6JAGaRCvw+x4s3NMxUkYP4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhIgH4DmaoP7/LrBvrUTwAq8PIwkOtE8yNEb1/iGaE eotqJxGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSIB+AAKCRCJcvTf3G3AJouiEA CsQiKQU8yYLNVDRGiXfb930RN38G6VaPkiNVGfbOxlF8/NoReYlwwRLDaxYLWGNC+2hr+Mc+tSLQkC OyYXt34aEJ8RAaHd9J/XKojK7zzp175gEonMD/B1Z27Cvc3YwQ9PZFZ9zHiRgdfGEb+A1L4m6XAHs2 nVTs1DLzBrka+jxx90WoJMswpooU+snjTASsX2dUlc5/iKaRIhoUCKJ7MiU8u5DJJrP13KYk1T1qw5 IQV6HcCiUU2CqwU7BOrGvW+aPV7uZH+nVbHKkB8ast8zYcMQW7Hk/zjl6bd+KOo5c85wp81wg1hbbO uY+ZPXO1XtkxBufB7aLp1K13CSmSaUZn2tBdS54SF6pVZ0Up1NdhFTHyITFWebbJ4MCYmcwKl2TonX 3NPE4QX26nK4llSQO92fZCvFrk6ZPmic7RjHU8me+iXixcjehnqvwvLLIzXBm0Si0rTGbXGndfwSh9 30hPvjFC3PxNl08R8Jp76/DvMcL6t1PkoUS5jjcny0Pijci3ywE60TO6ZcVL1BUAVyvrB4nKoecydW h16hmhXHPA0TGXjR4MsY3oP/BlGTZGS3wgyOFsxYY05ZtlMM3lVw9gALsWACvz6yCe1FZ1auY1Ubho MMH2LGLCeJq1miHi8AvBF8sQ4ceYrPEArUoWMsDNaXMI+EwkqvkExj1J8m0Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang has never correctly compiled the FORTIFY_SOURCE defenses due to
a couple bugs:

	Eliding inlines with matching __builtin_* names
	https://bugs.llvm.org/show_bug.cgi?id=50322

	Incorrect __builtin_constant_p() of some globals
	https://bugs.llvm.org/show_bug.cgi?id=41459

In the process of making improvements to the FORTIFY_SOURCE defenses, the
first (silent) bug (coincidentally) becomes worked around, but exposes
the latter which breaks the build. As such, Clang must not be used with
CONFIG_FORTIFY_SOURCE until at least latter bug is fixed (in Clang 13),
and the fortify routines have been rearranged.

Update the Kconfig to reflect the reality of the current situation.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/Kconfig b/security/Kconfig
index 0ced7fd33e4d..fe6c0395fa02 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -191,6 +191,9 @@ config HARDENED_USERCOPY_PAGESPAN
 config FORTIFY_SOURCE
 	bool "Harden common str/mem functions against buffer overflows"
 	depends on ARCH_HAS_FORTIFY_SOURCE
+	# https://bugs.llvm.org/show_bug.cgi?id=50322
+	# https://bugs.llvm.org/show_bug.cgi?id=41459
+	depends on !CC_IS_CLANG
 	help
 	  Detect overflows of buffers in common string and memory functions
 	  where the compiler can determine and validate the buffer sizes.
-- 
2.30.2

