Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D426457E98
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 14:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbhKTNEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 08:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237524AbhKTNEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 08:04:30 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FFBC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:26 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r8so23123481wra.7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0GXFwkIRJwsoxbvrB/JwPV5Hj3vSDgAQLkAvVHGNi+E=;
        b=mWk7jZc+YfyveOQdyZxk9aRkKJsVjFU8yitAD51J9xoQrOwl17mMFNCiaNK9zXa9iY
         pgHH1Dqszwhod1gTOvlg25wi37oqw3jAEMAdJ0k8fVEomSbriidf7BZBDQF5Dtk/Z0Vi
         agVICXSqaBdpJZhuIErTE4/FTXR2f/iyAqf8RAFlW0ZjlJxfHT7sm1I8sHg/S/QhSOc1
         EGBfWrLmcTD0AaidiBKP53WiqGUdjr14U+76GaoSje4u7/ZZ1PNeT5jUbE6a9uj1nJMT
         Uh4q4EeX/B/qKQRIV48jMUHfUFVL36QOELRV4+ebiEUTYMVFzOP1QCrON/7BsE2g9eb3
         f+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0GXFwkIRJwsoxbvrB/JwPV5Hj3vSDgAQLkAvVHGNi+E=;
        b=2oRrieR2wnyeb6IDY2wdMJhzlatINkikO1I1Mf9Y7t5M0XP6lpiUxhYy4KwHNzaVs0
         XAkpv/3gL0LlkWtRBphSNhEr+x+1e6/5kqyNe5KdViOmsXuQdec1Ql7l1Qc8JW3fAOC/
         rRtsbUd+exVexQVXfeWDphHYJ9DNcj0xFWkTdB8OGP4bg7iAW/AfhznkK6mIvyWmDcQ2
         cLXqR4DoJ7fG1AcsUv2QMjfMdXJCSQZZxcTlAx7R7o1I7Z2OI/HgCKRNkIhBBQTYLTsh
         Wjd/TSI5U/AcE/OjiLsg22u8sgmoWTZiszhlUbCqZW2WvIsp3+yx3KHkCJQKzaRkAmCn
         Xd9g==
X-Gm-Message-State: AOAM532hldcWJxNn/OYt6/TvWYEyyEzr747sc/OoyR1+AHcW9++K6s7x
        6OPjl6BXmtp2SnZ6gJOVnSTdEzjr2ivRoQ==
X-Google-Smtp-Source: ABdhPJwlpPOnalRptjTPdgCjUnBRFURp4ahHlITBfYCZkVU6FFTeq/tUfoD7CY7zbC0Jq9pPsNuNoQ==
X-Received: by 2002:a5d:550c:: with SMTP id b12mr17570164wrv.427.1637413285369;
        Sat, 20 Nov 2021 05:01:25 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id m17sm2636736wrz.22.2021.11.20.05.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 05:01:25 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2 08/20] Implement container_of_safe() in terms of container_of()
Date:   Sat, 20 Nov 2021 14:00:51 +0100
Message-Id: <20211120130104.185699-9-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211120130104.185699-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <20211120130104.185699-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no more a need for the temporary variable __mptr,
since now it's only passed to functions that accept a 'const void *',
and everything can convert automatically to it,
reducing the need for the cast too.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 include/linux/container_of.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index 220990db7b61..03809348f333 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -30,12 +30,7 @@
  *
  * If IS_ERR_OR_NULL(ptr), ptr is returned unchanged.
  */
-#define container_of_safe(ptr, type, member) ({				\
-	void *__mptr = (void *)(ptr);					\
-	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
-		      __same_type(*(ptr), void),			\
-		      "pointer type mismatch in container_of_safe()");	\
-	IS_ERR_OR_NULL(__mptr) ? ERR_CAST(__mptr) :			\
-		((type *)(__mptr - offsetof(type, member))); })
+#define container_of_safe(ptr, type, member) 				\
+	(IS_ERR_OR_NULL(ptr) ? ERR_CAST(ptr) : container_of(type, member))
 
 #endif	/* _LINUX_CONTAINER_OF_H */
-- 
2.33.1

