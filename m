Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373A138D7FE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 02:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhEWAVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 20:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbhEWAVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 20:21:00 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4047FC061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 17:19:29 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id l70so17326280pga.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 17:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xaASHzy0OyL7hCJcV49+Miv7+JhczAD+r8WqQugW90I=;
        b=dTGFzO4lJeOgURCTzGT4rdllEwqlvtOWQgSsZ5+g3Y1dtiUXTUR4/GXxcYUSF9fvwN
         Bt5cotR7T3U+ek+D7p3UOyCo4MMOy8cK+wp2+y3+PFeRf9na70BC3ykZebHF7xR6Dbmc
         CDuKuPbLCrQMztlkFJ1lRcVoVi5wAW6iIQoyVIh3crJX9Ozh9F/PZdobnx5te5VDefml
         MQxX76m7nlfEZTDJrnNq2kSrCOeVxmdZNKmNXB+O0FpHoKbfHPiLw2w38yBtB30gMVG0
         VfhEmk9M6RSOC9sclqAqg6z139ECeHtBTImHnd2Spwyten4xNx28v/CTZE4cpXpeKERa
         pVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xaASHzy0OyL7hCJcV49+Miv7+JhczAD+r8WqQugW90I=;
        b=skGS09PVLvtxuD4Sp4KADX9MrBxEx8xrpAjMtLgqxeIg867gxSQXy8O+eBRCRJQSZ3
         yGgW1EoqyH9D17LvA81pByS7EcK+PKQ9YPG62fl8xSpJt8ahsuj+pP+HivbVTjYMhuyP
         UrCqFt0tPjFgbKQeXC3vdVYyzTO9mcXPp4IJYyJFmaSDLXLsCl82AFikJfmU47OpdlHz
         4JAshtFbVPYSOGAHVIiWJ1ltFs2afOMbzLKTGymL36mERY6eSxiaBgBXUB9jgJlT5nPy
         pZ/IPl+0Ir1oUdx14G5hNUjxym6iS2QHYa0DLl1UDxnqgYS3P3pKgUWngy51Wec3s/7U
         HwtA==
X-Gm-Message-State: AOAM530YcJCyA8rHXhDk3Z7vrAKZjYE4ggZ46icLkrK4Zon1uZ6SjRiZ
        B6KLtDOMY7yi3qey0mMQBkGSRRFoajustg==
X-Google-Smtp-Source: ABdhPJwl3LdGUIgMbxsgPDAz6ilzv2/eXV44IzZL2iWSNtkYRWScDC0JePrz+L+2az71fUS6E8bNgA==
X-Received: by 2002:a62:6491:0:b029:28e:8c90:6b16 with SMTP id y139-20020a6264910000b029028e8c906b16mr16883790pfb.24.1621729168247;
        Sat, 22 May 2021 17:19:28 -0700 (PDT)
Received: from zen.local (97-113-152-155.tukw.qwest.net. [97.113.152.155])
        by smtp.gmail.com with ESMTPSA id m191sm7840701pga.88.2021.05.22.17.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 17:19:27 -0700 (PDT)
From:   Trent Piepho <tpiepho@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     andy@kernel.org, akpm@linux-foundation.org, oskar@scara.com,
        Trent Piepho <tpiepho@gmail.com>, Yiyuan Guo <yguoaz@gmail.com>
Subject: [PATCH] lib/math/rational.c: Fix divide by zero
Date:   Sat, 22 May 2021 17:18:06 -0700
Message-Id: <20210523001806.3927609-1-tpiepho@gmail.com>
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

