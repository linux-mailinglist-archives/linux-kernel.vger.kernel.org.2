Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26B93F3E87
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 09:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhHVH5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 03:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbhHVH5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 03:57:39 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC56AC061756
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 00:56:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id f1so1525622plg.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 00:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mboTeGUKr9yolgqYZyfRuYdmdGDjzaFuP+f8ddDuJQs=;
        b=XBzC31VH8i8YFSRYWUDQDKnfPjacjuEkYZb43tC9vNuaDj/OpZDKardqf1WUo2sasc
         qo24sxFkkBPYPPGcAobqrN/+kT5bHgYaqIdGhfFbyb6oGFWgMYhc3D40ZGex/hK30hr1
         OsgTDmiU+s2z9HboX9Yia271ldfY+LiL633/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mboTeGUKr9yolgqYZyfRuYdmdGDjzaFuP+f8ddDuJQs=;
        b=QrVbyBKJXGDZUVoBzi63dG3i18EU499Asp5lQQJjczwaOn5RhqKzwldQ5y9plBV2KW
         jS/4bFc4TgsNHAvV0fwP3N5LF+yC9IEvEoQgLFXmEMUE5DLNDzzXgBNvToHQd+Mjn34y
         Uv2QsZ1NViDJbeS+3zKH7sZNfc2PbSWDDdlwKdJqeVXsppwuUvoae76xfSwDOB8ktfPo
         ztbntatrCsuMOkx8EWkz+QzdnSaqqGKiFJIlcabQWkn2gxjch85q1rqvBc6jli7Fnqzb
         C/Rl2tCbTWr9h95togKz0y/2RxvfdxAHPAm3Uhpshn7zM55T4rbMO12jQTWCKefFyIPd
         BxdQ==
X-Gm-Message-State: AOAM5335CVEZneCmBeo8gfinbmFwTrXzjoeKYU8yLxg5c0S3MoupKZ0q
        ZFr/emWUYEAZhuDVRFZ3rnWtJg==
X-Google-Smtp-Source: ABdhPJy70piasRcCiq1N1hSgrYpJdyQ7VNKb16zqOJbn9anqN5BpWkCkqwMAwM30x8WGb1EwEiH3zw==
X-Received: by 2002:a17:902:7282:b029:12c:75a0:faa5 with SMTP id d2-20020a1709027282b029012c75a0faa5mr23697524pll.35.1629619018281;
        Sun, 22 Aug 2021 00:56:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z3sm10510268pjn.43.2021.08.22.00.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 00:56:57 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Daniel Axtens <dja@axtens.net>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH for-next 17/25] fortify: Fix dropped strcpy() compile-time write overflow check
Date:   Sun, 22 Aug 2021 00:51:14 -0700
Message-Id: <20210822075122.864511-18-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210822075122.864511-1-keescook@chromium.org>
References: <20210822075122.864511-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1260; h=from:subject; bh=sAqjTzTf+mWFy7xD73ZEpzjamgoLfVlMB8Pw3aei0Xc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhIgH4HMEpm10nE/aAHB48K6cSsvZL5sfcJfQj9wD4 87AucWeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSIB+AAKCRCJcvTf3G3AJlWyD/ 43aKzGW6g25weJEJsyQ7zCnEMVGGabRxLFQoGd2ODvAXaG7BEMjTe6KHLFfYgussxYeGPNYMyIFUqK ifxOcEWs0Swau1DhGUkYHxZXaXGgspP22zyTe6AzhaxlbCDY/rrzd1zZTyorgwHOOdVZhI2aPTHdlc 20vpjKyvE7Ca62vG9hu9k/970JL1vPz37iEwCMcNW3gO3l62qI7A+xuf+CIYEtvAO85k8sOwHCPCL+ /ACPHoZvTKubJE/7j8ccUcqmiqRTXSSmOpzWpz3iiv0C2+OlQnZjSsruizTYFTcgBjftFuNWAnfZ89 ktCe3sKEYiELWm4h9bXxcUN+iEomsBMWsRmNZhm3pHBtSenmqFvhIzE5KSUTmgiaHT3eKum6L995xf tY+jrUPWQJ0bNaOSYuNN+EMKPS2QNtM9zNjtijutTMjlZ7EEstt9td94KI9DO/GA2s99IKcTOw4WvC Eg2GKgIAfOkfKa9wTCadBJKiDQn2lDy5XKGYjoGsbbdhhJqjqLiIQDvE8L0FEMEHvZoRykYosNVXZt eBUj6YYoLvPEnpoaKqBUBvLRfgevLlTuZBwzsD3IgpPqgYK42igeCrm6ZYu/Di6WM55WjvAnKfkdat 5uXvPQNcUMMrgXfuYJtJxTEuQyw8V1ZdY/Zh5EaIf2hnmN/+DKeKMaN9MP3Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The implementation for intra-object overflow in str*-family functions
accidentally dropped compile-time write overflow checking in strcpy(),
leaving it entirely to run-time. Add back the intended check.

Fixes: 6a39e62abbaf ("lib: string.h: detect intra-object overflow in fortified string functions")
Cc: Daniel Axtens <dja@axtens.net>
Cc: Francis Laniel <laniel_francis@privacyrequired.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 7e67d02764db..68bc5978d916 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -287,7 +287,10 @@ __FORTIFY_INLINE char *strcpy(char *p, const char *q)
 	if (p_size == (size_t)-1 && q_size == (size_t)-1)
 		return __underlying_strcpy(p, q);
 	size = strlen(q) + 1;
-	/* test here to use the more stringent object size */
+	/* Compile-time check for const size overflow. */
+	if (__builtin_constant_p(size) && p_size < size)
+		__write_overflow();
+	/* Run-time check for dynamic size overflow. */
 	if (p_size < size)
 		fortify_panic(__func__);
 	memcpy(p, q, size);
-- 
2.30.2

