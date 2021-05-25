Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B1D390434
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 16:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbhEYOop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 10:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbhEYOok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 10:44:40 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE75C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 07:43:09 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n8so11237248plf.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 07:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zb2QwH1UtOiW+tjgJrhn0irzzM0kjvk4s0F4xwZQFkE=;
        b=GoazEnqzrYSOQCI12GaK/8eoHXVSZ23m4WnEz3IMst56c3GL5RiGX2S4uEw8MIdjE9
         AUtinTt9QWi/OSD1czD1kdEdk3B41IuejgAAq9PiGkJVZq5gK7oDd7gxpqz2Y1MaRF8T
         UF0jKzXgBcsKYFyikrUF+4oiOxviLEBgEhPtGy/sCIhrMDccpXa5VfMYDP0qBrBHss/D
         3GjBnGeRFs/t1ejnlYhdF1/4Mqu+4Cejt9MNck7yaQ56Ir0VH6817hAu5PDHxfavYBth
         8pXsAOfyg62DAQOLfV3AwKwOe82A4Mv172NIbNYDfggrScH+52reIw7FAmtAMWVAOu9l
         FI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zb2QwH1UtOiW+tjgJrhn0irzzM0kjvk4s0F4xwZQFkE=;
        b=axNizaaUzxHrl80LhJqqIxy06+t7kzYEJXcb54OVpKkJlvP3AB8+CC5qFuzxSJyO3V
         g8S2CGxoXi3fqC8t5q8xZVUqF4Z5bloXWPlLqv2bRy+rEVP1Y9RSN/vhSxzdxl/a0q5E
         UCCNkuSL9UHr1NcBXP2TIt/IJ0g5L4bjvd7q/Ry4mMyYjfdfqt/0leAcUBafN+JlpFn9
         S7tWM09l4QyjT/hh33BHWHFpLBI6BoNUBObdpRMg2hxuj2zVNApOawE0oV0Shkw5XEli
         Vn6Vsgs+Pq+b2yfifWIJd/wUb7BVXDuyICpp+Cz8JBbNFDydpjQiSVRe/UscF/iEFZqW
         3+Ng==
X-Gm-Message-State: AOAM533Y3i3h/zs9qcJieKXYj2waX3XLLPmJ0p9BtFOFbkcJJHYKKyqt
        pgUqOhwxoZanCaaCrsw95Zb17L2Zg32LIA==
X-Google-Smtp-Source: ABdhPJzLA/8QT1sg0Nb1Xgs57tMCFBEvEVuxncF4CKD8ZAtIhAseWB+Vnw6+nYE61a9CEpaahJAzEA==
X-Received: by 2002:a17:903:2287:b029:ef:671e:c943 with SMTP id b7-20020a1709032287b02900ef671ec943mr30856913plh.35.1621953788644;
        Tue, 25 May 2021 07:43:08 -0700 (PDT)
Received: from zen.local (97-113-152-155.tukw.qwest.net. [97.113.152.155])
        by smtp.gmail.com with ESMTPSA id z7sm3359086pgr.28.2021.05.25.07.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 07:43:08 -0700 (PDT)
From:   Trent Piepho <tpiepho@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     andy@kernel.org, akpm@linux-foundation.org, oskar@scara.com,
        Daniel Latypov <dlatypov@google.com>,
        Trent Piepho <tpiepho@gmail.com>, Yiyuan Guo <yguoaz@gmail.com>
Subject: [PATCH v2 1/2] lib/math/rational.c: Fix divide by zero
Date:   Tue, 25 May 2021 07:42:49 -0700
Message-Id: <20210525144250.214670-1-tpiepho@gmail.com>
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

