Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F823F9C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 18:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbhH0Qbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 12:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbhH0QbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:31:21 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B041C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 09:30:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id e1so4245242plt.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 09:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wUGiyr3xsPMSx8OhiS6MBjOzSMfwTo6qvLGkcomqylk=;
        b=fp4bpLYYPI+3WOpsTvOtEeHprf2IR2AKq6W/3xnQzzVUCltG6pZHvyAJF2Uo4qOQcI
         AIJzz21a/RRTPLMNI3o6iG17hcRzEjY2LXxBOn9zlXopEM7eZUuDpNawxS7KUhRn4UMS
         Ngc1Uer/Aq8RxX7P+GLs5CVqdQXE6DzRmBbfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wUGiyr3xsPMSx8OhiS6MBjOzSMfwTo6qvLGkcomqylk=;
        b=XotnvpIKCbwNqjNvnM1UM/pkaO6I+v32uutc9X/j72S9pX+GlExTL6nmQqIw+X+K3M
         j8ZG0OLvCKnrhN5uUkxggNFN9N/mzwG8QZz2fqQkqvaMnGhX93EMasHjSxhcgCA51L/R
         ONYdO1K3u1jiqOW8CKf48opWFJtNH5TmlGTwpHLtee/LbsAe+tEclFdaL/kLfHSIGm3k
         95tlVz/lUkdEm2B8s3E425XQHoRPC4XuTPD+ZrgLEdevIbgct0lwtTg8a2OzSIaZteBO
         axkqCfHxjRxmXQa4KoIJz8O6RFIEvkZi/mIwQ4fbI59SMzym+9xtvfmlkYCTOvlkB7Ff
         4VAw==
X-Gm-Message-State: AOAM530QgL8eeiDli+q+X5b3dXkSf9QjaRhiLu3xBFa2/BP6bOgnlUbi
        e2OVDJgDv7vHc3wrqZMQEDXq2Q==
X-Google-Smtp-Source: ABdhPJxC0+0qNud6ZTr6aglKyM9SV2kAn2ypTGmgEhPWqQ1vUABPB06D5nBNxiIx4J1MtQmzkiTV5A==
X-Received: by 2002:a17:902:744c:b0:136:a8cb:a05 with SMTP id e12-20020a170902744c00b00136a8cb0a05mr9520190plt.72.1630081831590;
        Fri, 27 Aug 2021 09:30:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x16sm7444696pgc.49.2021.08.27.09.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 09:30:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Keith Packard <keithp@keithp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH v3 5/5] Makefile: Enable -Wzero-length-bounds
Date:   Fri, 27 Aug 2021 09:30:15 -0700
Message-Id: <20210827163015.3141722-6-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210827163015.3141722-1-keescook@chromium.org>
References: <20210827163015.3141722-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=996; h=from:subject; bh=/SN5+6T3ztIGtswjzUhGWY/cmKXtgVAB5r1vX4FHhD8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhKRMX4PEFBk7l4lz+prByvaAJlFG/Y2kCmVwrumJm JhcDUiyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSkTFwAKCRCJcvTf3G3AJizPD/ 92QLLpXTpLLRbzzzUB0IeioWQMIASzu0K89wSsZYLn2LG8ukNzwMXgyCoq+RMzJi64FthppGJC4dxn 5waUOlOPI9Ck0FaQ+xaR+apjpwbHPLFUbRDFdyUnKZg7O4l6av1TCIMvNuy6kUvc9DiPPCeRhdJzOt 3PeVgCh/kiVQlZo3Lp/+fypoWYtwJ63sUk8oMYoO84eyPcGo1AxVkUDf7sCBFsSNkwl54aukpDN8hf 3cTSGKtAjZhbGsZWY0Ss/Sgly58d7vt/muhqP+671muebBbWRt/gbKpYVw4kWGFZN4ND71kbpgffG4 Z0Pg6pc8oBC1b7y7RApdPHMWVXidsmJ2gHUd+11zidZZmrrOOkd6eW/RDMh2T5BCmQqm/vy9RJpOOH WPGdPwqHWFpPaLKUpVap6svg3uoGlfiuPWymjuTrHylUYbUGfj8JYlQU6J6Hiwr8uGFKqOF2v0RGeW m12csqq0mPHmmw6HWPatqh5TYvD6135KC6iGIuPJZxXWRhyNjiUw2cTqPG8z77TsYWOYbevTNzx73p 1gqJBbNM+JNygLPWnfYMiFVNAGr4jKs0t0IjRpIfxlS9uJQMuzy7ctEPaGqXsAEIVicVSGVy9BAgJ1 iJCGKyn6DOr+od18DToNiML6X9vAbLBRNDtgSXgqFNXdJYyuU0+Fygr4T43A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With all known internal zero-length accesses fixed, it is possible to
enable -Wzero-length-bounds globally. Since this is included by default
in -Warray-bounds, we just need to stop disabling it.

Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index 8e7e73a642e2..8e732e875e78 100644
--- a/Makefile
+++ b/Makefile
@@ -994,7 +994,6 @@ KBUILD_CFLAGS += -Wno-pointer-sign
 KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
 
 # We'll want to enable this eventually, but it's not going away for 5.7 at least
-KBUILD_CFLAGS += $(call cc-disable-warning, zero-length-bounds)
 KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
 
 # Another good warning that we'll want to enable eventually
-- 
2.30.2

