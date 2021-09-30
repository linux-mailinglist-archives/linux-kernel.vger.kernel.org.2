Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB64141E3F6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 00:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345428AbhI3WcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 18:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237087AbhI3Wb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 18:31:59 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BF0C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 15:30:16 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id u7so6225483pfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 15:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ay1V9ffhoIQpAyVwXtDPPJf/MtSlguJd/osoDxW8SDA=;
        b=kVsHfZVKOYr6X7ZVCJLOUmZbyKyVf/bYM8s99VI4B80qJy7pPxA628vxCTsFzp7tyP
         XSpU3MVW1ltSiWhVPbk+zaJMLCSAq0kFseKWHZ8+4JW5TyaIJrVmKMO922X8q/GK/TuJ
         YVuK/6k0A3pH00DPOaraAo1wT5H3pv/3ClKf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ay1V9ffhoIQpAyVwXtDPPJf/MtSlguJd/osoDxW8SDA=;
        b=ZNXO0dHlPdQGVOioAaRgspskuRzwNHKkGo5sMVC4ywcaPCgwBbUlrKTYI+t8mlB1hw
         DQv8r7pkxbqHnpbameQa3WArUs029zXb57QDi9PFJuoEqw4QHEa1RncWiH5dj9+B+QvK
         1ch4tN0Z/xKh0X7WPFqEJvoMsTj2qYzeLrEi1Yht/B32879zeBANBSfuTbOPBab9PvqN
         5OgewzS14bv1PopE5pf84Znkb4etg3UqrTE6bh/dKqAOU9AVZa4T0zQXZCBeSVK5tC80
         wKrYHl127c0+lL7dklDKEuczWiELgIMj1ipiax6Etp8OpZqsDdOy5Kx8lPvWZoSKhZRY
         4f3Q==
X-Gm-Message-State: AOAM531cD8SBL00gJvDFoOj93D1D5UrsixBOAbBiv8gzSzU0DhTi4yMQ
        mMcjOjxc6dafjsq9vZ1lzxqFcQ==
X-Google-Smtp-Source: ABdhPJwZ793yTpzmrRHTCtRd2jlASWf7dvmXfH5zjJdW0TTlbdlf2QpIXv1clEmFFvWLEYrABHKSYA==
X-Received: by 2002:a63:125f:: with SMTP id 31mr6964264pgs.98.1633041015750;
        Thu, 30 Sep 2021 15:30:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p17sm5680848pjg.54.2021.09.30.15.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 15:30:15 -0700 (PDT)
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
        linux-hardening@vger.kernel.org
Subject: [PATCH v3] docs: Explain the desired position of function attributes
Date:   Thu, 30 Sep 2021 15:30:11 -0700
Message-Id: <20210930223011.2632202-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2757; h=from:subject; bh=3wGJertCA84vSipOAoJMdWC2Kpb30Chb+rYiYzarEXY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhVjpzJYBemhbhMV2SCbBlCVqtipvyBjBdX7HDeYGf 4SgtxWOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYVY6cwAKCRCJcvTf3G3AJiTpEA CTbq+h6g0PRtkcBqqqPBHTpRRub1OUpFluXUYffpv0W6UYQjeWYdubXisKrUg0YbF6RXqz/qrjjJgC 4yPj1dzMppohf81BqnBRPR5mwTf31SLI4QYvBSvfO6rHiGQL1ozIf2GklWAGE+WdxAmkaGbm//PjFY uGsO/PGsg7eRYp2v0WsRr4FhzVFhw7gsDjlpLUHtEf68W7Jwk9K2oSTUEq3+l8cEZZYHPMbF5b/vi7 eRy1hFZhJOya1qmBli8UuSn4hrmI7+iBD0i9FP0Kv0UeOwruc8CmrnONkjWCGeJYGviBfnFIq6GP0Q U1CpRG476qAUfL4X8LaE/2MzDIEVWCLFUa3ndx4FDJ/16R4fZEWOc98juTzkGONPx2lwpPCYPdH7AK Kynky1PcNAgQjN2ikfS23agy1n3RkWKZ9lvP0y3Kc0bidWyaYEU/dhEdm5Qd+Hm3cGinsDxU43uKvv kBA20jxfW4Sqlu0zty6cxM6MdGb+q/xEBxHimTiMDMPxKxiqaihnV26BUAhG9q8Jn4mIUXX/BiczXe 5dfQonXbRhAYjdo26Nu/oNqmPvdkrjRtxansaJqToBTiZUKoPKECnW64qc3Gnr/rUk352yZplQV9qD bO7LVdGDEyu1jFEq+0Zv3YD4/zOivFBunW0KwcAaeCK+8uu6oeJ9KkRLnpjg==
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
Fixed-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/process/coding-style.rst | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 42969ab37b34..1b0800591e73 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -487,6 +487,36 @@ because it is a simple way to add valuable information for the reader.
 Do not use the ``extern`` keyword with function prototypes as this makes
 lines longer and isn't strictly necessary.
 
+When writing a function declarations, please keep the `order of elements regular
+<https://lore.kernel.org/mm-commits/CAHk-=wiOCLRny5aifWNhr621kYrJwhfURsa0vFPeUEm8mF0ufg@mail.gmail.com/>`_.
+For example::
+
+ extern __init void * __must_check void action(enum magic value, size_t size,
+ 	u8 count, char *fmt, ...) __printf(4, 5) __malloc;
+
+The preferred order of elements for a function prototype is:
+
+- storage class (here, ``extern``, and things like ``static __always_inline`` even though
+  ``__always_inline`` is technically an attribute, it is treated like ``inline``)
+- storage class attributes (here, ``__init`` -- i.e. section declarations, but also things like ``__cold``)
+- return type (here, ``void *``)
+- return type attributes (here, ``__must_check``)
+- function name (here, ``action``)
+- function parameters (here, ``(enum magic value, size_t size, u8 count, char *fmt, ...)``, noting that parameter names should always be included)
+- function parameter attributes (here, ``__printf(4, 5)``)
+- function behavior attributes (here, ``__malloc``)
+
+Note that for a function definition (e.g. ``static inline``), the compiler does
+not allow function parameter attributes after the function parameters. In these
+cases, they should go after the storage class attributes (e.g. note the changed
+position of ``__printf(4, 5)``)::
+
+ static __always_inline __init __printf(4, 5) void * __must_check action(enum magic value,
+ 		size_t size, u8 count, char *fmt, ...)
+ 		__malloc
+ {
+ 	...
+ }
 
 7) Centralized exiting of functions
 -----------------------------------
-- 
2.30.2

