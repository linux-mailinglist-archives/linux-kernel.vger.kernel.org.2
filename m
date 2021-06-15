Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C313A86E3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhFOQy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhFOQyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:54:52 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A26C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:52:48 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id b205so9836464wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TdsZ4DlmZMWp7IIX24/wJw3Spb9c4r2beuPMEL4JlFA=;
        b=ZbCQEokp5V6qt+imbaiPM+2G3xigia6lDuXitL+Vh80IWHXNB/FS4cVR4pbP3/eWAU
         +VwrAXRAsl4vzm0bvBMfgULQAh9KDmVshiYpXW4VpL9bEwSwtMMYs6lB4ekFRPGZ5/TN
         LBr1EVC+qQ7h2AZEFGqaJmVNOJtsAZDi/86fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TdsZ4DlmZMWp7IIX24/wJw3Spb9c4r2beuPMEL4JlFA=;
        b=VS86QLcABq2ABrWNu/cASLyIik7KvpmYxsJeteKiQrsRGwbwhsGUqc2qXTs/ms4iUO
         SDhXuNWjnQBfYU5tTNu5qsGq9amYH2bxJj/UClxX3P/XckoIpCTa4M4QYS1zA/G1xaVF
         w9+06nTU+WVathRBxdEzugaGDkDHJQuZlpF+IlRjzxQAm7/RPxQGvapiaLUkuPbywroj
         rIJeQN9WsojPsJ6kyLjjd9REHF9wxmfi/RjXeyCwKTzc63A87BIVnzAzp+0iv4ZGUbYk
         oMkiQ0dhqHLGqZbLkAgiG91gZnUgCnKURYs8HGcyZWYPbZkGDG/4/O04DdjPydgDDLdO
         201Q==
X-Gm-Message-State: AOAM532puq8eNsoJkHqomrUvAM5+ItZI1C3CZMbtoNdkPpxjQhvNVDwV
        QcwgUmLU2poAwin3doE+pUmioyv6rZLZP0lUvWw=
X-Google-Smtp-Source: ABdhPJwffYlItxHtaWvqiEIlXyzWYaJGIW5uStgxcX+CKIlAaIGu/pUFNFbrpNpyGJ1onXEn2oIvKw==
X-Received: by 2002:a1c:1f54:: with SMTP id f81mr215760wmf.121.1623775966461;
        Tue, 15 Jun 2021 09:52:46 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id z10sm13581734wmp.39.2021.06.15.09.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 09:52:46 -0700 (PDT)
Date:   Tue, 15 Jun 2021 17:52:45 +0100
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: [PATCH v7 1/5] string_helpers: Escape double quotes in escape_special
Message-ID: <af144c5b75e41ce417386253ba2694456bc04118.1623775748.git.chris@chrisdown.name>
References: <cover.1623775748.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1623775748.git.chris@chrisdown.name>
User-Agent: Mutt/2.1 (4b100969) (2021-06-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From an abstract point of view, escape_special's counterpart,
unescape_special, already handles the unescaping of blackslashed double
quote sequences.

As a more practical example, printk indexing is an example case where
this is already practically useful. Compare an example with
`ESCAPE_SPECIAL | ESCAPE_SPACE`, with quotes not escaped:

    [root@ktst ~]# grep drivers/pci/pci-stub.c:69 /sys/kernel/debug/printk/index/vmlinux
    <4> drivers/pci/pci-stub.c:69 pci_stub_init "pci-stub: invalid ID string "%s"\n"

...and the same after this patch:

    [root@ktst ~]# grep drivers/pci/pci-stub.c:69 /sys/kernel/debug/printk/index/vmlinux
    <4> drivers/pci/pci-stub.c:69 pci_stub_init "pci-stub: invalid ID string \"%s\"\n"

One can of course, alternatively, use ESCAPE_APPEND with a quote in
@only, but without this patch quotes are coerced into hex or octal which
can hurt readability quite significantly.

I've checked uses of ESCAPE_SPECIAL and %pE across the codebase, and I'm
pretty confident that this shouldn't affect any stable interfaces.

Signed-off-by: Chris Down <chris@chrisdown.name>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/string_helpers.c      |  4 ++++
 lib/test-string_helpers.c | 14 +++++++-------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 5a35c7e16e96..3806a52ce697 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -361,6 +361,9 @@ static bool escape_special(unsigned char c, char **dst, char *end)
 	case '\e':
 		to = 'e';
 		break;
+	case '"':
+		to = '"';
+		break;
 	default:
 		return false;
 	}
@@ -474,6 +477,7 @@ static bool escape_hex(unsigned char c, char **dst, char *end)
  *		'\t' - horizontal tab
  *		'\v' - vertical tab
  *	%ESCAPE_SPECIAL:
+ *		'\"' - double quote
  *		'\\' - backslash
  *		'\a' - alert (BEL)
  *		'\e' - escape
diff --git a/lib/test-string_helpers.c b/lib/test-string_helpers.c
index 2185d71704f0..437d8e6b7cb1 100644
--- a/lib/test-string_helpers.c
+++ b/lib/test-string_helpers.c
@@ -140,13 +140,13 @@ static const struct test_string_2 escape0[] __initconst = {{
 },{
 	.in = "\\h\\\"\a\e\\",
 	.s1 = {{
-		.out = "\\\\h\\\\\"\\a\\e\\\\",
+		.out = "\\\\h\\\\\\\"\\a\\e\\\\",
 		.flags = ESCAPE_SPECIAL,
 	},{
-		.out = "\\\\\\150\\\\\\042\\a\\e\\\\",
+		.out = "\\\\\\150\\\\\\\"\\a\\e\\\\",
 		.flags = ESCAPE_SPECIAL | ESCAPE_OCTAL,
 	},{
-		.out = "\\\\\\x68\\\\\\x22\\a\\e\\\\",
+		.out = "\\\\\\x68\\\\\\\"\\a\\e\\\\",
 		.flags = ESCAPE_SPECIAL | ESCAPE_HEX,
 	},{
 		/* terminator */
@@ -157,10 +157,10 @@ static const struct test_string_2 escape0[] __initconst = {{
 		.out = "\eb \\C\007\"\x90\\r]",
 		.flags = ESCAPE_SPACE,
 	},{
-		.out = "\\eb \\\\C\\a\"\x90\r]",
+		.out = "\\eb \\\\C\\a\\\"\x90\r]",
 		.flags = ESCAPE_SPECIAL,
 	},{
-		.out = "\\eb \\\\C\\a\"\x90\\r]",
+		.out = "\\eb \\\\C\\a\\\"\x90\\r]",
 		.flags = ESCAPE_SPACE | ESCAPE_SPECIAL,
 	},{
 		.out = "\\033\\142\\040\\134\\103\\007\\042\\220\\015\\135",
@@ -169,10 +169,10 @@ static const struct test_string_2 escape0[] __initconst = {{
 		.out = "\\033\\142\\040\\134\\103\\007\\042\\220\\r\\135",
 		.flags = ESCAPE_SPACE | ESCAPE_OCTAL,
 	},{
-		.out = "\\e\\142\\040\\\\\\103\\a\\042\\220\\015\\135",
+		.out = "\\e\\142\\040\\\\\\103\\a\\\"\\220\\015\\135",
 		.flags = ESCAPE_SPECIAL | ESCAPE_OCTAL,
 	},{
-		.out = "\\e\\142\\040\\\\\\103\\a\\042\\220\\r\\135",
+		.out = "\\e\\142\\040\\\\\\103\\a\\\"\\220\\r\\135",
 		.flags = ESCAPE_SPACE | ESCAPE_SPECIAL | ESCAPE_OCTAL,
 	},{
 		.out = "\eb \\C\007\"\x90\r]",
-- 
2.31.1

