Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC66446706
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhKEQeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbhKEQeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:34:22 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF654C061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 09:31:42 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id y8so15957249ljm.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 09:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PUqLV3fpKHQyXEqMjALE9Xxq292YHe5DbJQ4syhYGCg=;
        b=uJ33zvabized2zxjsRx7AmimMKmmuUhtG5Mre5qemMR417+xCYZA5GFz3viT9AUjrN
         Gm4gyQuJ5OPIPfLZwepkAL4g4yA15DItMhu6qhyyVSbnp7xQKDuzT0bQQZ3QiNxi1ZLr
         GwPwQvN8gZAsJJtSd7K9MzpTEQLmux/jYj/YuOeFivBA71sBZFinmhFEFhrdJbPAI87z
         2bKjESm2PMnNvPuOTR35bN87zsx3aUggAlcjzl86jzfzNkNpI5LA0kHe0FJmUcokwXzz
         EY7b39ZBqOXtgem7G8l+pBtEa7uHYNu8cX4OYUTSBKNKQNN1D2e3tgyZF9Q7naervZUo
         XYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PUqLV3fpKHQyXEqMjALE9Xxq292YHe5DbJQ4syhYGCg=;
        b=UbsLBUWpQPzdBvgebTULXgg2SU6Fv/FDqbjyDf1KawrWGFDTuuxD8Ia3PiNx90E8dv
         SmtPqNH7noBYJ2RdZQP9IRaWISkbZ0ClwKthcZYRpOyNBOUYjpx2TioAB0xUWCAT3QmI
         p9pI0sEeze9gxpA6AeFti5LnEXJypzwUjCOZJbWehfKjQ79eXkZrAuSjrqalTAobmv0R
         cL0vJfiv4+TQwm710pagogMzu/xcjS9CDxwMv9DpVXVWls5uBjcUfMjMa+XBvYteU6Il
         MQAQt+JfVcUrRnJdfEv8OoOiNfi235csyjJ7CzN0o0NiBpDs8MivI8GY8DPioIh9bA/i
         B/2g==
X-Gm-Message-State: AOAM5303zshjK2GupqAA+qW9qVjJ7QtYG3yVg81dJwCK1qFOU3n/1Kr/
        ptFoJxm3O3xAvIVNFA1HXp/UlA==
X-Google-Smtp-Source: ABdhPJwrM1vwk+Wx26Wz8pbR+HyTsRhkjuUolqU9y7ewjb7jE5PGL7aFGQtAcoBlESXvNgR+mYxYag==
X-Received: by 2002:a2e:8115:: with SMTP id d21mr23089395ljg.411.1636129901316;
        Fri, 05 Nov 2021 09:31:41 -0700 (PDT)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id s7sm778919lji.67.2021.11.05.09.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 09:31:40 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 2/2] selftests: timens: exec: use 'labs()' over 'abs()'
Date:   Fri,  5 Nov 2021 17:31:37 +0100
Message-Id: <20211105163137.3324344-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211105163137.3324344-1-anders.roxell@linaro.org>
References: <20211105163137.3324344-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building selftests/timens with clang, the compiler warn about the
function abs() see below:

exec.c:33:8: error: absolute value function 'abs' given an argument of type 'long' but has parameter of type 'int' which may cause truncation of value [-Werror,-Wabsolute-value]
                        if (abs(tst.tv_sec - now.tv_sec) > 5)
                            ^
exec.c:33:8: note: use function 'labs' instead
                        if (abs(tst.tv_sec - now.tv_sec) > 5)
                            ^~~
                            labs

The note indicates what to do, Rework to use the function 'labs()'.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/timens/exec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selftests/timens/exec.c
index e40dc5be2f66..d12ff955de0d 100644
--- a/tools/testing/selftests/timens/exec.c
+++ b/tools/testing/selftests/timens/exec.c
@@ -30,7 +30,7 @@ int main(int argc, char *argv[])
 
 		for (i = 0; i < 2; i++) {
 			_gettime(CLOCK_MONOTONIC, &tst, i);
-			if (abs(tst.tv_sec - now.tv_sec) > 5)
+			if (labs(tst.tv_sec - now.tv_sec) > 5)
 				return pr_fail("%ld %ld\n", now.tv_sec, tst.tv_sec);
 		}
 		return 0;
@@ -50,7 +50,7 @@ int main(int argc, char *argv[])
 
 	for (i = 0; i < 2; i++) {
 		_gettime(CLOCK_MONOTONIC, &tst, i);
-		if (abs(tst.tv_sec - now.tv_sec) > 5)
+		if (labs(tst.tv_sec - now.tv_sec) > 5)
 			return pr_fail("%ld %ld\n",
 					now.tv_sec, tst.tv_sec);
 	}
@@ -70,7 +70,7 @@ int main(int argc, char *argv[])
 		/* Check that a child process is in the new timens. */
 		for (i = 0; i < 2; i++) {
 			_gettime(CLOCK_MONOTONIC, &tst, i);
-			if (abs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
+			if (labs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
 				return pr_fail("%ld %ld\n",
 						now.tv_sec + OFFSET, tst.tv_sec);
 		}
-- 
2.33.0

