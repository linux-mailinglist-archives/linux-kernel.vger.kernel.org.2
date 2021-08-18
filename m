Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E823EFB40
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 08:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240044AbhHRGJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 02:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239474AbhHRGJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 02:09:16 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF6DC061BC3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 23:06:00 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id f3so1151019plg.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 23:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hSMMgZw7/2olmGwk+x9hLUDcbTdJzqluz+oi39a5oaM=;
        b=AMRBYGxWigAndwRUkfX3NhBSUU8MSjoRTCHz9zrrsgdg3Vx7dfMY0hvzndczVU9K2K
         OwjIPvlD7qSunG4V08GZHGWtKJwfeKCLlU3S37o3Gz4IcLm+qCx3PPRbw20HXjHiEzkE
         uX9jeofCLBVvaQkzgW2gi+vm4H1Oim/Okgn7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hSMMgZw7/2olmGwk+x9hLUDcbTdJzqluz+oi39a5oaM=;
        b=T6ce902LOEXFO+R+3XmMe7PYVpZqd2gtuaO4nIxkDFh/BV6pCY0grdJN2h8RsL4H2N
         V3SRJudgtpQT03dQOnHPIH2T0bavXz+uHD2rs1Fsn3ycC9RHXvTxc8MwFxjHb7RvOIGS
         ok3XjT0YmwN55SfRinxje6N0sIXjR7bUBa8vJRvmYuibP6BJVTMXY268XTTZF8PRWq6G
         Jtx5o+mrEH2nBR2XmYRhOqGt1FkRNh41dua8TIiLJfofxaaSgKMBSZGK0oLWkOUp+On/
         EBki9jHQbYuc7p5X4BTAxIPpMPXnps5aSPjBb2f9Mp88z2ep+rNeOe6Ol7vVfpXzj+Sv
         FwgA==
X-Gm-Message-State: AOAM533+SKotSF7DIR8wxoECOztw0bbjRI6RCl4mNMZQ5cxdK/62IkHj
        qz/orTArFe1Q1281ZPqW/7mLsA==
X-Google-Smtp-Source: ABdhPJw3YCb8XFLM24p+5tCFOEGFX4q333wRrCUDGyZQSVGiN6LbUqPysW/vGPLsQ7I9wOKcC9qAYw==
X-Received: by 2002:a17:902:b190:b029:12d:487:dddc with SMTP id s16-20020a170902b190b029012d0487dddcmr5995051plr.24.1629266760257;
        Tue, 17 Aug 2021 23:06:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ms19sm3881385pjb.53.2021.08.17.23.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 23:05:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 30/63] fortify: Prepare to improve strnlen() and strlen() warnings
Date:   Tue, 17 Aug 2021 23:05:00 -0700
Message-Id: <20210818060533.3569517-31-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818060533.3569517-1-keescook@chromium.org>
References: <20210818060533.3569517-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1906; h=from:subject; bh=wvK3U1xEzLn7HBnl3TVbXk2P5Mye7QhLMp4JdS3JmN8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHKMkjtivRrqM/8t8pX2BgfBDvrRaH9kWYRdFJy03 ZmaWqcKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyjJAAKCRCJcvTf3G3AJnZBD/ 9ZO2jtNOBwLeuE65ugO7S8QVPVTc02JQcjXAhVIMip8GcftBIh6y33OIXJbGvumJ/EBr4oAJKmP1+L +oCFFakYPIeuRV6pxMxO5+wfJJPqCT3cphUSCrquRhKuZxNJlP1uRMqbL/K2OLFwn4Rqr295BG/Ij7 bIuDzHDRDYuTekT9PxGCWIUivMtqV1HLgXIhtxri3qlsFlwdbx1zU/5GmOLFNh+btb9eKauiShw4vB Ae3CvfS1tdmSXrvEgvGSz0wG9HcHySLpIsZglW8TI+gV/WPu/q3Izlql98/zjYhKCVFpN56jlwkoyx zcKcg+gRzQRrROnH/ZkeMj4iHx7aenKCH2VKKG5+PbFX2LcaG6OYcmX/AlIJ7kzv1caSMVeESCpb9F xeqmqDw5IN+/8UVBy/7bNpQ7uu2aF/hk2m7Hf07uYrLH/+NRJor0Fqsfz4VYDNfsHb3mkTeLYZvdL5 V79pX7BaQEUTM11ow989NnALA2oTs242bRvfR7vGQccFJk8QsH3kWYnDaR1HrXnh+M5cU2H4jxIFDj qR4X2svRVHZBfMvnGQgeEkvADKirqLGVc+4vohELtBuJ/63n2yvR1gtZwjZo1KYFSY1RxyqzGjfvPd scVAGDxupEYbw0MN1qMftL6MMY2m0jmHqf5z7ekO4APDSXkLXnzkcpyCrLMg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to have strlen() use fortified strnlen() internally, swap their
positions in the source. Doing this as part of later changes makes
review difficult, so reoroder it here; no code changes.

Cc: Francis Laniel <laniel_francis@privacyrequired.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 68bc5978d916..a3cb1d9aacce 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -56,6 +56,17 @@ __FORTIFY_INLINE char *strcat(char *p, const char *q)
 	return p;
 }
 
+extern __kernel_size_t __real_strnlen(const char *, __kernel_size_t) __RENAME(strnlen);
+__FORTIFY_INLINE __kernel_size_t strnlen(const char *p, __kernel_size_t maxlen)
+{
+	size_t p_size = __builtin_object_size(p, 1);
+	__kernel_size_t ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
+
+	if (p_size <= ret && maxlen != ret)
+		fortify_panic(__func__);
+	return ret;
+}
+
 __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
 {
 	__kernel_size_t ret;
@@ -71,17 +82,6 @@ __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
 	return ret;
 }
 
-extern __kernel_size_t __real_strnlen(const char *, __kernel_size_t) __RENAME(strnlen);
-__FORTIFY_INLINE __kernel_size_t strnlen(const char *p, __kernel_size_t maxlen)
-{
-	size_t p_size = __builtin_object_size(p, 1);
-	__kernel_size_t ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
-
-	if (p_size <= ret && maxlen != ret)
-		fortify_panic(__func__);
-	return ret;
-}
-
 /* defined after fortified strlen to reuse it */
 extern size_t __real_strlcpy(char *, const char *, size_t) __RENAME(strlcpy);
 __FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
-- 
2.30.2

