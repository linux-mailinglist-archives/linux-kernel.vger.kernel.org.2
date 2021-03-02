Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F9132A7FE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579500AbhCBQ6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381702AbhCBO1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 09:27:54 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF09CC061788
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 06:27:00 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id f12so16275441wrx.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 06:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yWlrjFexy8M1BTmzcn8bBpaBNdFUIFba6+3oEr3HKEU=;
        b=OgaPmgQq/RqruCoDLsRgB6eD9PNfhWbdThb/vCtDP425CKA1UAqfU+sMhauFnf2lov
         sFL2qSg4lLonNrOhRFGpdD2TK6KuINw0wMHfl3Pw+J6v964/eA4PcySUGixd/SH1oPHf
         1/xqMPQHSsjPtLObR/FMOi5nRV4h6kPckV2/b6mF004A5POwsL8lwQr5Rhv3a0+5+p4C
         JbQ+cDolWmfmk05jVTdePBRvNhgAoCfhYcORgLs7JUGHVBTgOlynWPCVDbx7I6nasPgd
         nnx+iE+fi2JytPl9klpnye6Iy8986EsUGMqmVB2MIthwu3kna0AZ0Ey4aSAVvUo0VZWY
         +DTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yWlrjFexy8M1BTmzcn8bBpaBNdFUIFba6+3oEr3HKEU=;
        b=qWk/ZPjQSzqAtllXoU6ZL44NijSOg/GqwXP8Iaobbi/rZSlMe0VXSLd9QUCUN+Rt1m
         Z3i0N8p4H2HTAahIF0NdEJgLEVFLm9CkSEaTwFoIS0DPPjaZQDDUVuuNLPh0gGLtC78V
         WpqYIgUtVYn20LyPpZDoBtlfG2ROYiI4DSelONfC5I+tnTakb86aGnPskUAIyAngqHaX
         9MBZ0N84NU3XQxY/E6Br5hipCkQD095NG61q1oHegDLtMu1y3FwZTGqkYxLFFz3u2p3Y
         xCiX82WkqUHAmM4rFLayxZs6kGur7DsW62Fcyd7GNujvJn8BGohxhsnyumUjglECn9po
         aCuA==
X-Gm-Message-State: AOAM530EHgCP37CTHtTdp9tY7kV3+Yk/CkzA+xQWANXD0PpmGY1FxTws
        NJMO5GtQcX9oTWLAqfBdN7EEhA==
X-Google-Smtp-Source: ABdhPJwLdqNnmnuSYBFaKxrGCoaQn3wQfaj5NbwcfmqhJh0wwdjbYKuvriZJiHT795mE6Rz1yN/aXA==
X-Received: by 2002:adf:f8cd:: with SMTP id f13mr21595970wrq.27.1614695219243;
        Tue, 02 Mar 2021 06:26:59 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:811:228c:e84:3381])
        by smtp.gmail.com with ESMTPSA id z3sm29591835wrw.96.2021.03.02.06.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 06:26:58 -0800 (PST)
Date:   Tue, 2 Mar 2021 15:26:50 +0100
From:   Marco Elver <elver@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Petr Mladek <pmladek@suse.com>, Timur Tabi <timur@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        roman.fietze@magna.com, Kees Cook <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH 3/3] [v4] lib/vsprintf: no_hash_pointers prints all
 addresses as unhashed
Message-ID: <YD5LKqtSz5r1Xp7B@elver.google.com>
References: <20210214161348.369023-1-timur@kernel.org>
 <20210214161348.369023-4-timur@kernel.org>
 <CAMuHMdULKZCJevVJcp7TxzLdWLjsQPhE8hqxhnztNi9bjT_cEw@mail.gmail.com>
 <CANpmjNNm-4s16_KQ1_NqFN4XOESJh4_=33LHQzt+p4V0Cy=Xzw@mail.gmail.com>
 <CAMuHMdWWsZ-vTGZCeLtcwLTuBYpeP0STfhrK37wiwmyfsQ798A@mail.gmail.com>
 <YD49x/UGUq6MSE39@alley>
 <8893ff08-1e50-316c-f632-cd37be1690d5@suse.cz>
 <CAMuHMdUB4DZxHo=j1+EsSsoGCdWmDO9mBo0cUtAH4OYHy3sBzw@mail.gmail.com>
 <20210302090811.620ae7d0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302090811.620ae7d0@gandalf.local.home>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 09:08AM -0500, Steven Rostedt wrote:
> On Tue, 2 Mar 2021 14:49:42 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
> > > So this is basically a kernel tinyfication issue, right? Is that still pursued
> > > today? Are there better config options suitable for this than CONFIG_DEBUG_KERNEL?  
> > 
> > As long as I hear about products running Linux on SoCs with 10 MiB of
> > SRAM, I think the answer is yes.
> > I'm not immediately aware of a better config option.  There are no more
> > TINY options left, and EXPERT selects DEBUG_KERNEL.
> 
> Since the trace_printk() uses the same type of notice, I wonder if we could
> make this into a helper function and just pass in the top part.
> 
> +	pr_warn("**********************************************************\n");
> +	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> +	pr_warn("**                                                      **\n");
> 
> 
> +	pr_warn("** This system shows unhashed kernel memory addresses   **\n");
> +	pr_warn("** via the console, logs, and other interfaces. This    **\n");
> +	pr_warn("** might reduce the security of your system.            **\n");
> 
> Only the above section is really unique. The rest can be a boiler plate.

Short of procedurally generating some of these strings, I was
experimenting with the below.

Would that be reasonable?

Thanks,
-- Marco

------ >8 ------

From: Marco Elver <elver@google.com>
Date: Tue, 2 Mar 2021 15:07:28 +0100
Subject: [PATCH] lib/vsprintf: reduce space taken by no_hash_pointers warning

Move the no_hash_pointers warning string into __initconst section, so
that it is discarded after init. Remove common start/end characters and
remove repeated lines from the array.

Link: https://lkml.kernel.org/r/CAMuHMdULKZCJevVJcp7TxzLdWLjsQPhE8hqxhnztNi9bjT_cEw@mail.gmail.com
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 lib/vsprintf.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 41ddc353ebb8..1e63b43955f6 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2094,23 +2094,27 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
 bool no_hash_pointers __ro_after_init;
 EXPORT_SYMBOL_GPL(no_hash_pointers);
 
+static const char no_hash_pointers_warning[9][55] __initconst = {
+	"******************************************************",
+	"   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   ",
+	"                                                      ",
+	" This system shows unhashed kernel memory addresses   ",
+	" via the console, logs, and other interfaces. This    ",
+	" might reduce the security of your system.            ",
+	" If you see this message and you are not debugging    ",
+	" the kernel, report this immediately to your system   ",
+	" administrator!                                       ",
+};
+
 static int __init no_hash_pointers_enable(char *str)
 {
+	const int lines[] = { 0, 1, 2, 3, 4, 5, 2, 6, 7, 8, 2, 1, 0 };
+	int i;
+
 	no_hash_pointers = true;
 
-	pr_warn("**********************************************************\n");
-	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
-	pr_warn("**                                                      **\n");
-	pr_warn("** This system shows unhashed kernel memory addresses   **\n");
-	pr_warn("** via the console, logs, and other interfaces. This    **\n");
-	pr_warn("** might reduce the security of your system.            **\n");
-	pr_warn("**                                                      **\n");
-	pr_warn("** If you see this message and you are not debugging    **\n");
-	pr_warn("** the kernel, report this immediately to your system   **\n");
-	pr_warn("** administrator!                                       **\n");
-	pr_warn("**                                                      **\n");
-	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
-	pr_warn("**********************************************************\n");
+	for (i = 0; i < ARRAY_SIZE(lines); i++)
+		pr_warn("**%s**\n", no_hash_pointers_warning[lines[i]]);
 
 	return 0;
 }
-- 
2.30.1.766.gb4fecdf3b7-goog

