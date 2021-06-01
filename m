Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B34397BC5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 23:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbhFAVdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 17:33:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234513AbhFAVda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 17:33:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9105F60FE3;
        Tue,  1 Jun 2021 21:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622583108;
        bh=kvGZ/iThdsHX6lx/mK//0fCXDu5p9x4gQqJ8bXxQPCc=;
        h=From:To:Cc:Subject:Date:From;
        b=UYejXAk2vgPs1tJWdtNdXHMidre/gIvpL8bXkx8+f7ZLKSLtmZ/mKb9mN08h/klQL
         YxsBeYf+VW3IjpKS842i6d3/yRfroBKDrfOeNjh1Q5zM7KUVqrW8L94DRav73uQE1l
         RdvmGrQ2wj4h8P9k31xxkaIYCu4i/VfjS7wKZlElp/59MDjuG/fr04yH1kb4WRl2pN
         5vvC8AvbhSwn5WXCuZjlv0clBKrj+jbtb6tZwJidKvikVSq0Sby478S2g6C7gCkoyk
         orNy+FWHr5wb3mT+CfXgNG8U5/w+4p5IG3nuz08bmRMXq6/53dKQDr/olpv1l7jHOQ
         XTPmsvtDrGq5A==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Cercueil <paul@crapouillou.net>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] kconfig.h: explain IS_MODULE(), IS_ENABLED()
Date:   Tue,  1 Jun 2021 16:31:43 -0500
Message-Id: <20210601213143.1973770-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Extend IS_MODULE() and IS_ENABLED comments to explain why one might use
"#if IS_ENABLED(CONFIG_FOO)" instead of "#ifdef CONFIG_FOO".

To wit, "#ifdef CONFIG_FOO" is true only for CONFIG_FOO=y, while
"#if IS_ENABLED(CONFIG_FOO)" is true for both CONFIG_FOO=y and
CONFIG_FOO=m.

This is because "CONFIG_FOO=m" in .config does not result in "CONFIG_FOO"
being defined.  The actual definitions are in autoconf.h, where:

  CONFIG_FOO=y   results in   #define CONFIG_FOO 1
  CONFIG_FOO=m   results in   #define CONFIG_FOO_MODULE 1

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/kconfig.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
index cc8fa109cfa3..20d1079e92b4 100644
--- a/include/linux/kconfig.h
+++ b/include/linux/kconfig.h
@@ -51,7 +51,8 @@
 
 /*
  * IS_MODULE(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'm', 0
- * otherwise.
+ * otherwise.  CONFIG_FOO=m results in "#define CONFIG_FOO_MODULE 1" in
+ * autoconf.h.
  */
 #define IS_MODULE(option) __is_defined(option##_MODULE)
 
@@ -66,7 +67,8 @@
 
 /*
  * IS_ENABLED(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y' or 'm',
- * 0 otherwise.
+ * 0 otherwise.  Note that CONFIG_FOO=y results in "#define CONFIG_FOO 1" in
+ * autoconf.h, while CONFIG_FOO=m results in "#define CONFIG_FOO_MODULE 1".
  */
 #define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))
 
-- 
2.25.1

