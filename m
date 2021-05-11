Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237C337B026
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 22:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhEKUig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 16:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhEKUic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 16:38:32 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3BEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 13:37:22 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z13so30556545lft.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 13:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3jFdsng7MNLqQkqqc30EAOm2kSsehax2jXaaI+7Irg=;
        b=dKtSPyiDwJGuayW4AO74qQwi1HkhNNYeVjn5SblBn46APoVlDvJt0fkfucnHJlD8dO
         DB44RmSrSgehmARnU4relLQx/GR50jy5TRwZ2B81kB+j4DXFfTvpOa3YCrYgM+RNyNCw
         f3zU6Nru5Q2TkVOpHHq/udx/YBYsBushoOSQy+YqRjuTmiPm1nP73DLSPRSmMIYA8FCC
         Pz70bA3Z2BL3Pg4Iz3A7y50FcWIE4mv1OelEYFX6AH76vrFSBMZ8yMfbz9VLFrKQgScy
         mN4GnJjofW7ksCNP98FLG9RhH2X5ahAZof3GzMNZAkuighAANX4KXbGJWboiSOvOSxa2
         GT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3jFdsng7MNLqQkqqc30EAOm2kSsehax2jXaaI+7Irg=;
        b=PgiYEYmG4fdRgJQ0054KppsHlTJVHficUEVS3i4z91lTj8XYSs14QeejCYAYIEViKo
         FE5GJjDmh0o3dc8Xxew0cOTZ12Z4jUkbpC9KKescv4qyXOWQk42EY3f+QfIqKwKc/vsU
         /8m6v/yZ/ypMZuWnlNEF9oqz+u+R8BNMVsq2YQMrhGYly3EHLg4LO9oQHLLKKzv8nYup
         yjTxt1kxG4FlepE7fqbauqrz/gPebUejFLc9OyTbiWrydVfC06qdsDOLWsPD5oErCMQY
         zWPHh2Gq522oT4D3uitG18qE5v4lC4k2of/WA2rVxKu3Now79pUKvR/EICrynvzfNPwR
         Dt5Q==
X-Gm-Message-State: AOAM530W8x3L92a0g2iObHR8hIHG47OSARqCEoMeLcf/bc2ZKPoFW6KG
        PgOHxTOYZ2HKsX4bCoUqkBjWELKSfZAlaA==
X-Google-Smtp-Source: ABdhPJxX5SEZ/cHaaWrcr5eVJAyamlCH4JvHjp0uFsGruBhnvwfQ/WcYrirUB8Prm5vrXYoMapc92A==
X-Received: by 2002:a05:6512:3e14:: with SMTP id i20mr21585257lfv.142.1620765441335;
        Tue, 11 May 2021 13:37:21 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-223.NA.cust.bahnhof.se. [158.174.22.223])
        by smtp.gmail.com with ESMTPSA id f17sm2701613lfu.215.2021.05.11.13.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 13:37:20 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] linux/bits.h: Fix compilation error with GENMASK
Date:   Tue, 11 May 2021 22:37:15 +0200
Message-Id: <20210511203716.117010-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GENMASK() has an input check which uses __builtin_choose_expr() to enable
a compile time sanity check of its inputs if they are known at compile
time. However, it turns out that __builtin_constant_p() does not always
return a compile time constant [0]. It was thought this problem was fixed
with gcc 4.9 [1], but apparently this is not the case [2].

Switch to use __is_constexpr() instead which always returns a compile
time constant, regardless of its inputs.

[0]: https://lore.kernel.org/lkml/42b4342b-aefc-a16a-0d43-9f9c0d63ba7a@rasmusvillemoes.dk
[1]: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=19449
[2]: https://lore.kernel.org/lkml/1ac7bbc2-45d9-26ed-0b33-bf382b8d858b@I-love.SAKURA.ne.jp

Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
Feedback on placing __is_constexpr() in const.h is welcome, at least the
name is appropriate...

 include/linux/bits.h        |  2 +-
 include/linux/const.h       |  8 ++++++++
 include/linux/minmax.h      | 10 ++--------
 tools/include/linux/bits.h  |  2 +-
 tools/include/linux/const.h |  8 ++++++++
 5 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 7f475d59a097..87d112650dfb 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -22,7 +22,7 @@
 #include <linux/build_bug.h>
 #define GENMASK_INPUT_CHECK(h, l) \
 	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
-		__builtin_constant_p((l) > (h)), (l) > (h), 0)))
+		__is_constexpr((l) > (h)), (l) > (h), 0)))
 #else
 /*
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
diff --git a/include/linux/const.h b/include/linux/const.h
index 81b8aae5a855..435ddd72d2c4 100644
--- a/include/linux/const.h
+++ b/include/linux/const.h
@@ -3,4 +3,12 @@
 
 #include <vdso/const.h>
 
+/*
+ * This returns a constant expression while determining if an argument is
+ * a constant expression, most importantly without evaluating the argument.
+ * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
+ */
+#define __is_constexpr(x) \
+	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
+
 #endif /* _LINUX_CONST_H */
diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index c0f57b0c64d9..5433c08fcc68 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_MINMAX_H
 #define _LINUX_MINMAX_H
 
+#include <linux/const.h>
+
 /*
  * min()/max()/clamp() macros must accomplish three things:
  *
@@ -17,14 +19,6 @@
 #define __typecheck(x, y) \
 	(!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
 
-/*
- * This returns a constant expression while determining if an argument is
- * a constant expression, most importantly without evaluating the argument.
- * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
- */
-#define __is_constexpr(x) \
-	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
-
 #define __no_side_effects(x, y) \
 		(__is_constexpr(x) && __is_constexpr(y))
 
diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
index 7f475d59a097..87d112650dfb 100644
--- a/tools/include/linux/bits.h
+++ b/tools/include/linux/bits.h
@@ -22,7 +22,7 @@
 #include <linux/build_bug.h>
 #define GENMASK_INPUT_CHECK(h, l) \
 	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
-		__builtin_constant_p((l) > (h)), (l) > (h), 0)))
+		__is_constexpr((l) > (h)), (l) > (h), 0)))
 #else
 /*
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
diff --git a/tools/include/linux/const.h b/tools/include/linux/const.h
index 81b8aae5a855..435ddd72d2c4 100644
--- a/tools/include/linux/const.h
+++ b/tools/include/linux/const.h
@@ -3,4 +3,12 @@
 
 #include <vdso/const.h>
 
+/*
+ * This returns a constant expression while determining if an argument is
+ * a constant expression, most importantly without evaluating the argument.
+ * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
+ */
+#define __is_constexpr(x) \
+	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
+
 #endif /* _LINUX_CONST_H */
-- 
2.31.1

