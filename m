Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987C8390CFC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 01:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhEYXhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 19:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbhEYXhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 19:37:24 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB79AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 16:35:52 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f22so23080636pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 16:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zb2QwH1UtOiW+tjgJrhn0irzzM0kjvk4s0F4xwZQFkE=;
        b=W0JZ/N1ecsDMGGmmGGwdRIFblPGNDEEw5HFhd1nEqebSuO7j3rvlmXHtj8TZqigAAl
         TYxQVWTX260YNA+ctc9z1v1cXRQPwcIpBpD1cIrwbL1nzgV4tsu+bHyZ29+D9pmEzlEW
         tE9vzarGXHoHoDRfG+Z7ldBhx50oV9GUaJ7NU5dGl41I/0aay9ADvc0digSpwDJ5z4xP
         Gx/2cSP9LdWrYhjYyeodXYbdRftTGBCkwuJVWglcSduo5i3wisgz0k21kI4CItblm4WW
         PfWWFUqUPMqG+9PgDCtGn4R8/Z+E1QnQ1B90ncKw0N67Yh2MFBkw/JI1NHGJ9OJyisXh
         DT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zb2QwH1UtOiW+tjgJrhn0irzzM0kjvk4s0F4xwZQFkE=;
        b=KszxIz7DHMcVr7op2GIG6yFyvZqLtFNg1CpkJG6l7dAf9GtGJNyMYq37OuAxUFDZz7
         SLkeOv0IgIkoqBXgem1grcpUZ3WXxVmNkMxexeRRhLCvyLlRrKPSxENmHxd4ShHEMysD
         gAyH+QQs7G8TwtN7VkbgAJ7W9Mifej5HGuacHGv7/o8c+niII/uzuFUErYR9MI9GVgbN
         Wnh18kCq4TmyeKm5WGY9E+R2LJ90gPHf4qGsxz5XQwkz4win5Pv65wG1B1rcgqXixq9X
         jIcZDIcA+1o8I5SB7UMrOf4bQKQYHDgu6pusfZMWWP65wbpgG69Ne+6Wv4SkcJaigzyb
         1ESw==
X-Gm-Message-State: AOAM533t/x3po/HLR+eqSDm4drpTAXUymWSwSjpQp0P99jJVpaH+KwLw
        /k6fFVoFeR/x1+kc/7AKQyNHd7WEjn16pQ==
X-Google-Smtp-Source: ABdhPJy67ARkM3789H42nGqNSmgm5hp++o4wQCsDXjTFYz5yJOhVo8damlKSN3YiUnj6k4tlujEOAQ==
X-Received: by 2002:a63:3342:: with SMTP id z63mr21708771pgz.187.1621985751910;
        Tue, 25 May 2021 16:35:51 -0700 (PDT)
Received: from zen.local (97-113-152-155.tukw.qwest.net. [97.113.152.155])
        by smtp.gmail.com with ESMTPSA id p17sm2971438pjg.54.2021.05.25.16.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 16:35:51 -0700 (PDT)
From:   Trent Piepho <tpiepho@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     andy@kernel.org, akpm@linux-foundation.org, oskar@scara.com,
        Daniel Latypov <dlatypov@google.com>,
        Trent Piepho <tpiepho@gmail.com>, Yiyuan Guo <yguoaz@gmail.com>
Subject: [PATCH v3 1/2] lib/math/rational.c: Fix divide by zero
Date:   Tue, 25 May 2021 16:35:18 -0700
Message-Id: <20210525233519.343068-1-tpiepho@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the input is out of the range of the allowed values, either larger
than the largest value or closer to zero than the smallest non-zero
allowed value, then a division by zero would occur.

In the case of input too large, the division by zero will occur on the
first iteration.  The best result (largest allowed value) will be found
by always choosing the semi-convergent and excluding the denominator
based limit when finding it.

In the case of the input too small, the division by zero will occur on
the second iteration.  The numerator based semi-convergent should not be
calculated to avoid the division by zero.  But the semi-convergent vs
previous convergent test is still needed, which effectively chooses
between 0 (the previous convergent) vs the smallest allowed fraction
(best semi-convergent) as the result.

Fixes: 323dd2c3ed0 ("lib/math/rational.c: fix possible incorrect result from rational fractions helper")
Reported-by: Yiyuan Guo <yguoaz@gmail.com>
Signed-off-by: Trent Piepho <tpiepho@gmail.com>
---
 lib/math/rational.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/lib/math/rational.c b/lib/math/rational.c
index 9781d521963d..c0ab51d8fbb9 100644
--- a/lib/math/rational.c
+++ b/lib/math/rational.c
@@ -12,6 +12,7 @@
 #include <linux/compiler.h>
 #include <linux/export.h>
 #include <linux/minmax.h>
+#include <linux/limits.h>
 
 /*
  * calculate best rational approximation for a given fraction
@@ -78,13 +79,18 @@ void rational_best_approximation(
 		 * found below as 't'.
 		 */
 		if ((n2 > max_numerator) || (d2 > max_denominator)) {
-			unsigned long t = min((max_numerator - n0) / n1,
-					      (max_denominator - d0) / d1);
+			unsigned long t = ULONG_MAX;
 
-			/* This tests if the semi-convergent is closer
-			 * than the previous convergent.
+			if (d1)
+				t = (max_denominator - d0) / d1;
+			if (n1)
+				t = min(t, (max_numerator - n0) / n1);
+
+			/* This tests if the semi-convergent is closer than the previous
+			 * convergent.  If d1 is zero there is no previous convergent as this
+			 * is the 1st iteration, so always choose the semi-convergent.
 			 */
-			if (2u * t > a || (2u * t == a && d0 * dp > d1 * d)) {
+			if (!d1 || 2u * t > a || (2u * t == a && d0 * dp > d1 * d)) {
 				n1 = n0 + t * n1;
 				d1 = d0 + t * d1;
 			}
-- 
2.26.2

