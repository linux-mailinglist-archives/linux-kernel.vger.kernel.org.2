Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3627A3D0171
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 20:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhGTRgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 13:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbhGTRfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 13:35:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8340CC061762
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 11:15:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x5-20020a0569021025b029055b9b68cd3eso31400091ybt.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 11:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mN7rCkcALbLQM/R7NDnSDNWf3cZq+FCXJCfkRrG6i3w=;
        b=PP5iqiNfyXblKuaLLoCAetm52GHEE7uQ20id6SefOeBNOqrrzT7274qyfPpEcHcGzv
         OkvITWDzGg1yCIo4ACov/UNvwqS1kG2LK7JjkHm35aA8WHFF2IBogkSL9EWd3VLYQmEg
         EjLcWUZRglqN/JQ2GCmBEFvw14JjtWrItcxIJwXAnVYqF3jboTn52GtOXXeFVUPk5XlN
         4ecVp3tQi70Ad16gqOZG5QTRpeXYR/sGjKoOlHBuakSvKsJvuzWYqD75z+rVFR74MsQB
         IkEmOgS77jrPkLAjwwtoWxwg7YDujn+/C9LMtJsB/4PEZfx0XDoZfIkSH4Hr1YJ6v85l
         jQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mN7rCkcALbLQM/R7NDnSDNWf3cZq+FCXJCfkRrG6i3w=;
        b=n6oOKBF2eoeqL0grtSDcuzcGh6eduuxctCkvUfzhaxqzPuIrCBaE54KIFPQFVSyhSj
         eWcSsevC+0nIDD05upa6a4HHkJL3RdZI6gSI/OKuAC3vP0Q1BWuBEKmrU5fiSsf//z0i
         vnYbcjllh5IENxCryvePak3tUs6uXN5O/2cEArb+MQg6qElwZ3pL/AX2C9rtu4IazLqq
         gf3EGay2MhodoQ+PJU+Zfz59NukXJVQY2DpnDs9736m1D8UnE53Wu6w3rcWOqKyzjjVk
         2gdm6iGMv75JwTDfZuQh7l98pOY/CdJ1qbMBzCTYM1V1Xeh783glcmyM9s1k9YiN3Tcp
         0Kqw==
X-Gm-Message-State: AOAM531YnPlxUZSdgx+g0H2/VKsZ7Q/Xw/HCAOwNsiHcibZKtcPqwoDN
        KGnXnQZXLGtU6Vyng1HvQHxzaKW8ekW4KuccuFI=
X-Google-Smtp-Source: ABdhPJxM9GiZsc3G1CcZqJQC+vnvDw65kDgmxJDIh0biAymz08yGN0PArhHN5jFJ70cbVTE5h0GJmv9hWLuFj1baxIU=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:cf0d:433d:7377:6a13])
 (user=ndesaulniers job=sendgmr) by 2002:a25:c708:: with SMTP id
 w8mr43132005ybe.246.1626804952750; Tue, 20 Jul 2021 11:15:52 -0700 (PDT)
Date:   Tue, 20 Jul 2021 11:15:42 -0700
Message-Id: <20210720181542.2896262-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH] MAINTAINERS: add Nick as Reviewer for compiler_attributes.h
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$ ./scripts/get_maintainer.pl --rolestats --git-blame -f \
  include/linux/compiler_attributes.h
...
Nick Desaulniers <ndesaulniers@google.com> (supporter:CLANG/LLVM BUILD
SUPPORT,authored lines:43/331=13%,commits:8/15=53%)

It's also important for me to stay up on which compiler attributes clang
is missing.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 548783bf6505..fe9b2ab45402 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4658,6 +4658,7 @@ F:	drivers/platform/x86/compal-laptop.c
 
 COMPILER ATTRIBUTES
 M:	Miguel Ojeda <ojeda@kernel.org>
+R:	Nick Desaulniers <ndesaulniers@google.com>
 S:	Maintained
 F:	include/linux/compiler_attributes.h
 
-- 
2.32.0.402.g57bb445576-goog

