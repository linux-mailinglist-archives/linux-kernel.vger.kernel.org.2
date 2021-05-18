Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DEE387840
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbhERMB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348955AbhERMBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:01:53 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39438C061760
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:00:35 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u133so5274798wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L40kgGa2qSYQhunqwgFrps+V87qOTbY9UGr/1vnVAr0=;
        b=IBOD+jMOtuj242Sg58GjJxseUEKxLIbNd045aYwKOlq/7spofAL0zogw86+zbWrg+9
         3eMgGTd/ELO4KNJSMjnDMq3f4J0MrLvMxuLA80RG54E/HTDBfdgoWIexDYTwD+AbvOe2
         OulXqYvK6k8i4LpCSRVr+MPrLnDVpcu5pbT48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L40kgGa2qSYQhunqwgFrps+V87qOTbY9UGr/1vnVAr0=;
        b=lU63NllyA9Tke+NRbS0Ab0Fx+6pSldVjsaqMC1d+ts5z5ej+eOD9n9akB4F6JJszxH
         vVpNF2OAd0fBKm+yR6D4Ttzrl+sRNmldFIvotj3hrDZLTLaoPT4lAYROzy5y719BFsQD
         it9dgitDv9PAfiy0ixIkKEznNOkd05crufHltjNX7MAfZaNJx/nC+ujHhFrl0SWPB5F8
         v9+6wlyGfvfuv2ojajWeSbtjHqbON4R+HirLllk5WgMxO48xvJsVS7HtS5RHJdzbnL+M
         xCK1Nc076/wTuW9SzU47RN9cLxFSO7TX85ItIaqEcsgF3dkyKDCVujB0vdc/pmv5r2hO
         9NUA==
X-Gm-Message-State: AOAM533AUA1GuFMLXSrQRQnWukaXT5gw92HxnR8027skZk2Laq3hni4T
        OsAVf0c1hlP8CyJFy9a8WXZQCamgSpsZt+FOLYE=
X-Google-Smtp-Source: ABdhPJyJHMfVKPT11zL1QasnOtg/BGnAw22m59nCwADNXzwuT6D6hYMAGgfdaMOCc/onLJw7ZCOTcw==
X-Received: by 2002:a1c:98c6:: with SMTP id a189mr4589087wme.178.1621339233471;
        Tue, 18 May 2021 05:00:33 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:5c4a])
        by smtp.gmail.com with ESMTPSA id n2sm20853306wmb.32.2021.05.18.05.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 05:00:33 -0700 (PDT)
Date:   Tue, 18 May 2021 13:00:32 +0100
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
Subject: [PATCH v6 1/4] string_helpers: Escape double quotes in escape_special
Message-ID: <56771f7dafd884d8d2ffcf104104a0c2522391d4.1621338324.git.chris@chrisdown.name>
References: <cover.1621338324.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1621338324.git.chris@chrisdown.name>
User-Agent: Mutt/2.0.7 (481f3800) (2021-05-04)
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

A new ESCAPE_QUOTE/ESCAPE_PRINTK option is also possible, but it seems
reasonable to use the simplest strategy first, since this is already
decoded properly.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

