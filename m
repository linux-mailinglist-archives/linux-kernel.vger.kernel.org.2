Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA063F3E6D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 09:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhHVHw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 03:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbhHVHwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 03:52:11 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15586C061757
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 00:51:31 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id n5so9984762pjt.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 00:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fzauuC8ic6euFu2nevB4hJA961dHUsCKyfH8JaAaPYw=;
        b=lmEkDNTP20jBjNY48XAiYsYW/MBYQ3sN/CDF2Ko50sNEkJm3zQfGkg+k8cRnlKQIyH
         q83W2P6fjMv7SK5OaniOvebrTxZWqQcnlOjRtzpZ0i8Au70Hd/xOhLzIEpY+vQF4yHf5
         uhWRCV8emFDW2PfzDnJr1IOrZmdCLn4Pj/Oo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fzauuC8ic6euFu2nevB4hJA961dHUsCKyfH8JaAaPYw=;
        b=lOH1ur+lhLEq/4Zfp5ksA7+0oh93s7+BzEDmz9DjhfmcS7M103eUfYFfhrhy9iHfe2
         Nx2C0LAiKgq6kEc1YS9nxU0aF0NxHu5pFlPh+7FHmxfPCqHvRTzlsriUt4jws/4C2SeH
         128Lsh67AgYjywBo86JuoK1pYZrCb8xm7cOBPxdZQh/q+emLxlDHvBLr5hjECVWrfwoV
         8jU961SNYBiE9w5vQrF+aTWM9gC1JnMPLGXjFj9m4kh2Z9+cij/D60REjdcNnJPL3aBU
         FaOghc/fhKxPHzGN8NxknPPeSCDvwnTKvTpQoAnNI6vvWATVwHNI61IrxWnmPiq0L2wt
         /mxA==
X-Gm-Message-State: AOAM531GfhHgAt/WQ/Hnn0Z17DV+pFtgJzhTo7vev31BTXaCYvnFrmEl
        V48P0/GTyAbJIBAxmgj4NNZ5pQ==
X-Google-Smtp-Source: ABdhPJwHm2Jq6kWwqk6H70hIXs1fPt0IgObmagXMxdXVwaHwcGfUduJAQSApWIitzp5cRJBOqHJRHw==
X-Received: by 2002:a17:90a:de04:: with SMTP id m4mr13568742pjv.187.1629618690696;
        Sun, 22 Aug 2021 00:51:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u10sm12058480pfg.168.2021.08.22.00.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 00:51:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH for-next 08/25] drm/mga/mga_ioc32: Use struct_group() for memcpy() region
Date:   Sun, 22 Aug 2021 00:51:05 -0700
Message-Id: <20210822075122.864511-9-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210822075122.864511-1-keescook@chromium.org>
References: <20210822075122.864511-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3914; h=from:subject; bh=uOOrsewr644NJeAzCYidrEKEGv2vRVphg8eu6V3X6z0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhIgH2xzLlFJ+4mCLkGozhJQQt38rzB4tGqclcqzBH ivLGoy6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSIB9gAKCRCJcvTf3G3AJrhbD/ 4pWHRzwDefaEhV+PtbfMW2oQ842w5wgZtULGOftua+s5ddfdO7zhR49LWA+pkGRcCPN1X8PZdqCQoC o32unro6Z2bE/zYqsOWBK3jbO9m+ag7kRx77bouZBKVr/n1vP1DUo0NqDHENxyFa6Iueut7BbVorms u9Jl+/0s8YfVcLNh1dftEErGbN+jNgO8w3Y8b7PJdQdpnE0MSLlk3iLCh7665wNIRPFtRv0qGUQVdG Foj8o43KymbeBHJMcXi+7m67DyS3UyyUIrBJ9hOZaaaS5dTS3JlYJ1vb21Zuv3TL2p/MB+IglbJ0g0 fclaVrLvClh3TIs9oBKHlCXdynkzx9fXYFQVe1te2tY/uwcCb89HW70CW7NqXeDNEuAwb7fltPusYm y/U0s45WLu03V2qRWSm3CWW8Ikh4zwQYME29KsTumgj3q3WRQPutyAPG7NoS7v61mer+w0GLNOynS8 QiafvGY3P7ySMBQOhXtgw5i1reEED28wNoK70Fmozlpc0J8jTcur78j/ggGLda1Yz2oSvaI/qNGeLz VfB6ccEIrzqEksr7BpVpEdGnQzKBlM5qnew3YQSRf21S0yupCAtH8L5I2YWKnlJ/DugUTLFAUL6yhM tLtA4h+B8xHbrX9z9dkNkYiNzS1OJIrir7f4tW/bR0wyuEBNDaLg0BYBGGKg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Use struct_group() in struct drm32_mga_init around members chipset, sgram,
maccess, fb_cpp, front_offset, front_pitch, back_offset, back_pitch,
depth_cpp, depth_offset, depth_pitch, texture_offset, and texture_size,
so they can be referenced together. This will allow memcpy() and sizeof()
to more easily reason about sizes, improve readability, and avoid future
warnings about writing beyond the end of chipset.

"pahole" shows no size nor member offset changes to struct drm32_mga_init.
"objdump -d" shows no meaningful object code changes (i.e. only source
line number induced differences and optimizations).

Note that since this is a UAPI header, __struct_group() is used
directly.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Daniel Vetter <daniel@ffwll.ch>
Link: https://lore.kernel.org/lkml/YQKa76A6XuFqgM03@phenom.ffwll.local
---
 drivers/gpu/drm/mga/mga_ioc32.c | 27 ++++++++++++++-------------
 include/uapi/drm/mga_drm.h      | 22 ++++++++++++----------
 2 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/mga/mga_ioc32.c b/drivers/gpu/drm/mga/mga_ioc32.c
index 4fd4de16cd32..894472921c30 100644
--- a/drivers/gpu/drm/mga/mga_ioc32.c
+++ b/drivers/gpu/drm/mga/mga_ioc32.c
@@ -38,16 +38,18 @@
 typedef struct drm32_mga_init {
 	int func;
 	u32 sarea_priv_offset;
-	int chipset;
-	int sgram;
-	unsigned int maccess;
-	unsigned int fb_cpp;
-	unsigned int front_offset, front_pitch;
-	unsigned int back_offset, back_pitch;
-	unsigned int depth_cpp;
-	unsigned int depth_offset, depth_pitch;
-	unsigned int texture_offset[MGA_NR_TEX_HEAPS];
-	unsigned int texture_size[MGA_NR_TEX_HEAPS];
+	struct_group(always32bit,
+		int chipset;
+		int sgram;
+		unsigned int maccess;
+		unsigned int fb_cpp;
+		unsigned int front_offset, front_pitch;
+		unsigned int back_offset, back_pitch;
+		unsigned int depth_cpp;
+		unsigned int depth_offset, depth_pitch;
+		unsigned int texture_offset[MGA_NR_TEX_HEAPS];
+		unsigned int texture_size[MGA_NR_TEX_HEAPS];
+	);
 	u32 fb_offset;
 	u32 mmio_offset;
 	u32 status_offset;
@@ -67,9 +69,8 @@ static int compat_mga_init(struct file *file, unsigned int cmd,
 
 	init.func = init32.func;
 	init.sarea_priv_offset = init32.sarea_priv_offset;
-	memcpy(&init.chipset, &init32.chipset,
-		offsetof(drm_mga_init_t, fb_offset) -
-		offsetof(drm_mga_init_t, chipset));
+	memcpy(&init.always32bit, &init32.always32bit,
+	       sizeof(init32.always32bit));
 	init.fb_offset = init32.fb_offset;
 	init.mmio_offset = init32.mmio_offset;
 	init.status_offset = init32.status_offset;
diff --git a/include/uapi/drm/mga_drm.h b/include/uapi/drm/mga_drm.h
index 8c4337548ab5..bb31567e66c0 100644
--- a/include/uapi/drm/mga_drm.h
+++ b/include/uapi/drm/mga_drm.h
@@ -279,20 +279,22 @@ typedef struct drm_mga_init {
 
 	unsigned long sarea_priv_offset;
 
-	int chipset;
-	int sgram;
+	__struct_group(/* no tag */, always32bit, /* no attrs */,
+		int chipset;
+		int sgram;
 
-	unsigned int maccess;
+		unsigned int maccess;
 
-	unsigned int fb_cpp;
-	unsigned int front_offset, front_pitch;
-	unsigned int back_offset, back_pitch;
+		unsigned int fb_cpp;
+		unsigned int front_offset, front_pitch;
+		unsigned int back_offset, back_pitch;
 
-	unsigned int depth_cpp;
-	unsigned int depth_offset, depth_pitch;
+		unsigned int depth_cpp;
+		unsigned int depth_offset, depth_pitch;
 
-	unsigned int texture_offset[MGA_NR_TEX_HEAPS];
-	unsigned int texture_size[MGA_NR_TEX_HEAPS];
+		unsigned int texture_offset[MGA_NR_TEX_HEAPS];
+		unsigned int texture_size[MGA_NR_TEX_HEAPS];
+	);
 
 	unsigned long fb_offset;
 	unsigned long mmio_offset;
-- 
2.30.2

