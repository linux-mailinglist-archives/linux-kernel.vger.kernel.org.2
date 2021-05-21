Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46BE38C0B4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 09:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbhEUH2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 03:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbhEUH2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 03:28:14 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6144C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:26:51 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id i14-20020a0cf10e0000b02901eeced6480dso14410602qvl.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JoxX3vq44wLNgaQOrg3pQOcd8r/g5YBPrzj4+4KLU0o=;
        b=ARASCsMpesYMn32qIslFtKuh5MusyNHMqxDu/DiZ30m6y4jL2kvAz+w577BTsMwWhQ
         kt+amSaNu+1SJVc4HLg98sZ/u70WPKff0AgrWWxaHuhongV2Kmf8o65TGJP/E7Cnz9HP
         LgmSRwpMwDRdkRIWUPOlDe3xvyJX78zuIqin17FpeOLj+h9VJr2LObaCAInNWJVrf30q
         8B8w8PJNUkJzKRl4AkK6fx6cU+8GYy/6dqU1vdIYJ/VJ8PhdnjdnOY5XnO0JYEWftvHp
         rm3akIs1cRssrwDh43vYplSkJgx3Q8LIW7GWRC/FlsCAc0PvjQQLmDw0X9/AonIkCWaM
         2Pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JoxX3vq44wLNgaQOrg3pQOcd8r/g5YBPrzj4+4KLU0o=;
        b=gZwlcLr5gQCgEc0/QVbj/iVwNcSbWun9IB87zVEMvtQdc+PLaFvIniuvZbjXiYrdJe
         Q/OK+b9Ikt8mbrzdVw+/EP3WRYOO80BEix0fgnIobKE5AMbkWK/gyFcAm0yv2yk8bS74
         MUt8TNVgKd1X9YtXTQZErbzGPnP1Wh49YYJTxTCVz7/XOhUxHLHJxlPcGza3EYF5YGTG
         KEJIn2YLyOqyJV3SUAk1qUdMdyigMdMSQzXBWD8d0Waxoa+tqRXmRIUJXIBXLbHEUPO6
         cCkWim7eWptngGrR2wZIQtgYyhSKRZezSgWvnVi0i4nysJFMYO8QMVCkFOORU+iK/iBz
         VdUQ==
X-Gm-Message-State: AOAM5306va/LqtOzDf9amYrs1X+1EZzCRsfTiDMQs8U+yATII1CYtoKp
        ERx+cyQ5kD8xwlFehbylwKMSVa2pjw==
X-Google-Smtp-Source: ABdhPJwmGbSuVl1Wagqi/NbNdmfD2fIY9dly6u0ayHOhdr1CMWrMpYxn/TQ9YJY5gN17oOLG4jc0dqvSvQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:a932:cdd6:7230:17ba])
 (user=elver job=sendgmr) by 2002:ad4:4184:: with SMTP id e4mr11204870qvp.13.1621582010735;
 Fri, 21 May 2021 00:26:50 -0700 (PDT)
Date:   Fri, 21 May 2021 09:26:10 +0200
Message-Id: <20210521072610.2880286-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH] init: verify that function is initcall_t at compile-time
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        samitolvanen@google.com, ojeda@kernel.org, johan@kernel.org,
        akpm@linux-foundation.org, masahiroy@kernel.org, joe@perches.com,
        Arnd Bergmann <arnd@arndb.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the spirit of making it hard to misuse an interface, add a
compile-time assertion in the CONFIG_HAVE_ARCH_PREL32_RELOCATIONS case
to verify the initcall function matches initcall_t, because the inline
asm bypasses any type-checking the compiler would otherwise do. This
will help developers catch incorrect API use in all configurations.

A recent example of this is:
https://lkml.kernel.org/r/20210514140015.2944744-1-arnd@kernel.org

Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 include/linux/init.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 045ad1650ed1..d82b4b2e1d25 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -242,7 +242,8 @@ extern bool initcall_debug;
 	asm(".section	\"" __sec "\", \"a\"		\n"	\
 	    __stringify(__name) ":			\n"	\
 	    ".long	" __stringify(__stub) " - .	\n"	\
-	    ".previous					\n");
+	    ".previous					\n");	\
+	static_assert(__same_type(initcall_t, &fn));
 #else
 #define ____define_initcall(fn, __unused, __name, __sec)	\
 	static initcall_t __name __used 			\
-- 
2.31.1.818.g46aad6cb9e-goog

