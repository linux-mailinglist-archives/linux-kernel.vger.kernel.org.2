Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94715422C77
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbhJEP2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbhJEP2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:28:05 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEB4C061753
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 08:26:14 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id v19so14410823pjh.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 08:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y+CXagab7PxUntsHmQwSoW+7QEad0PGh6YiwvwQ6POk=;
        b=Ovx8ePeVuaBdXaf4sSei8G5RhV6+tpMwlizyNVN3nW+SVon5m8Ua5sGldNqflgatAx
         rwdjxxKeNJArumIHX0gFSTntD3ymrbSaTSf5bt6xLje5nvCWKSeZGwWuxgsnRbq4GGSF
         WutTrXQIRB1LLydhTMmdIUXNlvUdfLNo7yBXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y+CXagab7PxUntsHmQwSoW+7QEad0PGh6YiwvwQ6POk=;
        b=XOBRJStaT4H3KiLKoSLjZ3G0vOitqKW3MUyGgEBGdAqLY8T/4TCQWz/3V8LnyqusqT
         CPrthj1Elm4eoKK4KIhhsGADLhnDO+/Qbut9Zeg0SnloBSDlgzoEInQYoexanTXKk3hB
         4plqGbb2Tbb22RkZ+K3+bUKDSgN89NdLvgUDa/3ea9m4KZluVgMc9hoika9qH9S3HIvq
         sagimtihABRXYHtvZ0gPTkmhcrxEiQgSj8/XWNvSHdaVGNmht+rCIShdfq8coksK+H5/
         Y+4WBspuM+uB/IkJL50D0Ov69SQXJEMWgqXL5ODUGaOPCEUJlrfUJ7nKzNr6yjj9GBEE
         3NKA==
X-Gm-Message-State: AOAM5334ZMoUmangrji7gtv2pDgm841FaUE/V8cB69LQkjXB+9KiUmp7
        wvWSK7AXaQ31h6K0paoUdzyJrA==
X-Google-Smtp-Source: ABdhPJyRZBdwICMPJo0CuxPpnxFK9DLNA0nPaq+dBQBT9mLkSZg7waLpinbeDbR1PHVabABWDKkXlw==
X-Received: by 2002:a17:90b:350f:: with SMTP id ls15mr4556493pjb.220.1633447574039;
        Tue, 05 Oct 2021 08:26:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b11sm17916356pge.57.2021.10.05.08.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 08:26:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH v5] docs: Explain the desired position of function attributes
Date:   Tue,  5 Oct 2021 08:26:11 -0700
Message-Id: <20211005152611.4120605-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3306; h=from:subject; bh=GIC8/+ECEEVVphKjAgK5jYr49AQgjKc8vhWqATkcXOY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhXG6SA1IwEIkRJ1pStDILLhURumXRkW0dEyB/ZV2+ 5OBpELmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYVxukgAKCRCJcvTf3G3AJlBgD/ 0YJawfHIAq0WAexvhUBbygFNQvyCdz3MJ8pKUgFn6i5Q/N6Akd8wjBcAMxnwQB0UUyK1OC61qXpUrR fFbbOkmHolcPQatD3opKofWmoAfVgkWh/0YUPejwRib/UCJQLYr8QQcc5NsY0TY4y74K084h+lzNA1 D4i4I3EWHsCP/G9DQMUZGSzAj4Tv5yb7+djpBJY8v7a/EyTp9HakVYee9GjTuqeiG8sZNzJqldr0Fe OkEsitQvoDA+2k191Jy70Kokw6Tg+d9a92TgIyN3tgULrUi4sZMDAs73jYzgas53YraYrm5r110LN7 ulKjfr/e4D+UJhfrsHqCO8QWMm43sVivjrzLvH2iFwtVTTCWFnZTv1R6GNbOD24GmVFPzJv1Vgnx9N pravIMIlKPJumR+FLPT7nzk+FXNXZtnGwEazBcTFr/jEa0tLrYVPT7CBGe1RAjPEYkgRmkYlDEbdex NrZljr3yixJ4s9c+9FcKxXsvr0/S8H1XZGP+stgLsICwNP1GL/LdVRWrBdnzj6QcjaItUAcgj0Xgdq IgFMqSmDA5u9nsjF14KILeqng9fFXemAqgvljrO9Lmt12fHmUhK1GPXUJWvfp3c5zjvDci592WFGZm G+RadowBi+k2WZeqGH9R64PRpbPjXOsXqIw59sHkqtCr7TGxH8saFBoz9zgA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While discussing how to format the addition of various function
attributes, some "unwritten rules" of ordering surfaced[1]. Capture as
close as possible to Linus's preferences for future reference.

(Though I note the dissent voiced by Joe Perches, Alexey Dobriyan, and
others that would prefer all attributes live on a separate leading line.)

[1] https://lore.kernel.org/mm-commits/CAHk-=wiOCLRny5aifWNhr621kYrJwhfURsa0vFPeUEm8mF0ufg@mail.gmail.com/

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v5:
- drop extern (joe)
- fix __malloc position (miguel)
v4: https://lore.kernel.org/lkml/20210930235754.2635912-1-keescook@chromium.org
---
 Documentation/process/coding-style.rst | 37 +++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 42969ab37b34..5756ff775233 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -480,13 +480,48 @@ closing function brace line.  E.g.:
 	}
 	EXPORT_SYMBOL(system_is_up);
 
+6.1) Function prototypes
+************************
+
 In function prototypes, include parameter names with their data types.
 Although this is not required by the C language, it is preferred in Linux
 because it is a simple way to add valuable information for the reader.
 
-Do not use the ``extern`` keyword with function prototypes as this makes
+Do not use the ``extern`` keyword with function declarations as this makes
 lines longer and isn't strictly necessary.
 
+When writing function prototypes, please keep the `order of elements regular
+<https://lore.kernel.org/mm-commits/CAHk-=wiOCLRny5aifWNhr621kYrJwhfURsa0vFPeUEm8mF0ufg@mail.gmail.com/>`_.
+For example, using this function declaration example::
+
+ __init void * __must_check action(enum magic value, size_t size, u8 count,
+				   char *fmt, ...) __printf(4, 5) __malloc;
+
+The preferred order of elements for a function prototype is:
+
+- storage class (below, ``static __always_inline``, noting that ``__always_inline``
+  is technically an attribute but is treated like ``inline``)
+- storage class attributes (here, ``__init`` -- i.e. section declarations, but also
+  things like ``__cold``)
+- return type (here, ``void *``)
+- return type attributes (here, ``__must_check``)
+- function name (here, ``action``)
+- function parameters (here, ``(enum magic value, size_t size, u8 count, char *fmt, ...)``,
+  noting that parameter names should always be included)
+- function parameter attributes (here, ``__printf(4, 5)``)
+- function behavior attributes (here, ``__malloc``)
+
+Note that for a function **definition** (i.e. the actual function body),
+the compiler does not allow function parameter attributes after the
+function parameters. In these cases, they should go after the storage
+class attributes (e.g. note the changed position of ``__printf(4, 5)``
+below, compared to the **declaration** example above)::
+
+ static __always_inline __init __printf(4, 5) void * __must_check action(enum magic value,
+		size_t size, u8 count, char *fmt, ...) __malloc
+ {
+	...
+ }
 
 7) Centralized exiting of functions
 -----------------------------------
-- 
2.30.2

