Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA454073FE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbhIJXmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbhIJXmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:42:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AB3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 16:41:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 63-20020a250d42000000b0059dc43162c9so4491091ybn.23
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 16:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Q5Lb7e2vgavVwQ4D08qL5EmkhBoCA6wKbGlKTNkLNSI=;
        b=aWtGEFs/z5evTm1HEbnJiIjzV6zhziqLmrYqKg00fjbO6TLvF8GVhJ+YqRpgjwRdxs
         lHWuWXuIK8Rb7fiRL3nZB1Xla/xqH3InnQ9eU4FZJBgn5DapWVLNfJSz5JDkhXiI4JZv
         jdo7I3YEn7pjHurXKaTswqYkCygOk44ZIWPF5tlNa92ENnSOTSfXVQXIVVPyCNVsRbQF
         9Q8Ww7/sZNnW/81IGG9qLWiKDOwANhiVAsMabS04vNGFzu+/mK3gI1DHVblzcadiDswz
         Za38BmAEGfrh/5DOp0lXxkGzlQDXd6wnDjrKpgCd+hEoG/oLHfLfieFfDzGwB9d/ZJpG
         /RTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q5Lb7e2vgavVwQ4D08qL5EmkhBoCA6wKbGlKTNkLNSI=;
        b=TQHKEB6JW8gezU9AKSvp/VeVZ58a41gghCYpi8Z8q43KkSG8jrA4FymwES/gY3wOmv
         4R7hZHQUda7XTfM8fpaSJcqHxpGFW29VCXsVuTeYl7bwCfv5XVNeJMTA7Yq7Z5+FeCk2
         9Knkwr7FoV79O11M688PaoEiQ+rrsGqMU9BfcQPUqy18qiUvVkXWpE9ZGeyMmVtDa0Gg
         GRUuuXvE+kCHF9rGt4v/FTghsybu26IOlnkBy8g0J3Wb/MsfGjytQoAzWcvmBoE/N8le
         vz5N6mGNzpD9A0i6GUglW/5ADo+iJFddjIZvrdbj3W21HBtff6QLkUuY7IBAuZiU8MdD
         H0uQ==
X-Gm-Message-State: AOAM530FxyBIanC9Penlyrn+crgtA4pDdIeQ2EABWXi87dv/8SuSwUQY
        PfXh3iBudQrZROIExMtILQEobExTP+Ay9iOfKKw=
X-Google-Smtp-Source: ABdhPJzxzb+3bK+bR8SA2swgwjDHDcBccp8Nxjg24ARkUTHf7IrR/2cU954HvNmJuNCK8FQwmJ88Yf1ZbWbbqJmK/CM=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:2b76:71d3:b5fb:3734])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6902:110b:: with SMTP id
 o11mr360373ybu.207.1631317260479; Fri, 10 Sep 2021 16:41:00 -0700 (PDT)
Date:   Fri, 10 Sep 2021 16:40:41 -0700
In-Reply-To: <20210910234047.1019925-1-ndesaulniers@google.com>
Message-Id: <20210910234047.1019925-5-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210910234047.1019925-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 04/10] Kconfig.debug: drop GCC 5+ version check for DWARF5
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the minimum supported version of GCC is 5.1, we no longer need
this Kconfig version check for CONFIG_DEBUG_INFO_DWARF5.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ed4a31e34098..d566f601780f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -295,7 +295,7 @@ config DEBUG_INFO_DWARF4
 
 config DEBUG_INFO_DWARF5
 	bool "Generate DWARF Version 5 debuginfo"
-	depends on GCC_VERSION >= 50000 || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
+	depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
 	depends on !DEBUG_INFO_BTF
 	help
 	  Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
-- 
2.33.0.309.g3052b89438-goog

