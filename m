Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B613C402641
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 11:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbhIGJgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 05:36:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47290 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbhIGJgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 05:36:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 31C6121F3C;
        Tue,  7 Sep 2021 09:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631007327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eq1ZQUKBcH1qQ6ktPb35o3ViSQD3n/y0nbGpPw4pPfg=;
        b=HZusuMxgCsfacshOUVpeX0+q7BSUOu39kcF1MKKVbesLu1/U5Jz+JPAc+ZwuEmUHRTTqOu
        lT3gfC5nwlxjZNb9CyRnzA+AC/VbMZ9N8y+seY++6x+S/8KYKGPQg915PbekrkDwKgv/cv
        oEiu4hrdYPvTgoCcUY4xoauKMhjX5w4=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 91B11A3B8C;
        Tue,  7 Sep 2021 09:35:26 +0000 (UTC)
Date:   Tue, 7 Sep 2021 11:35:26 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Down <chris@chrisdown.name>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Ingo Molnar <mingo@kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [PATCH v2 1/2] lib: add sputchar() helper
Message-ID: <YTcyXmLpbL0BWbU+@alley>
References: <20210904231020.331185-1-yury.norov@gmail.com>
 <20210904231020.331185-2-yury.norov@gmail.com>
 <04164ecc-ba60-a0c6-1975-694b2d02c4ae@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04164ecc-ba60-a0c6-1975-694b2d02c4ae@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-09-06 13:51:59, Rasmus Villemoes wrote:
> On 05/09/2021 01.10, Yury Norov wrote:
> > There are 47 occurrences of the code snippet like this:
> > 	if (buf < end)
> > 	        *buf = ' ';
> > 	++buf;
> > 
> > This patch adds a helper function sputchar() to replace opencoding.
> > It adds a lot to readability, and also saves 43 bytes of text on x86.
> > 
> > v2: cleanup cases discovered with coccinelle script.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  include/linux/kernel.h |   8 ++
> 
> Sorry, but 47 cases, mostly in one .c file, is not enough justification
> for adding yet another piece of random code to
> the-dumping-ground-which-is-kernel.h, especially since this helper is
> very specific to the needs of the vsnprintf() implementation, so
> extremely unlikely to find other users.

What about putting it into include/linux/string_helpers.h ?

Or create include/linux/vsprintf.h ?

> I'm also not a fan of the sputchar name - it's unreadable at first
> glance, and when you figure out it's "a _s_tring version of putchar",
> that doesn't help, because its semantics are nothing like the stdio putchar.

I do not like the name either.

What about vsprintf_putc(buf, end, c) or vsp_putc(buf, end, c)?

Well, the ugly thing are the three parameters. Which brings an idea of

	struct vsprintf_buffer {       // or struct vsp_buf
		char *buf,
		char *end,
	}

and using vprintf_putc(vsp_buf, c) or vsp_putc(vsp_buf, c).

The change would look like:

From 32119545392f560be42c7042721811a3177fb1dc Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Tue, 7 Sep 2021 11:31:22 +0200
Subject: [PATCH] vsprintf: Sample use of struct vsp_buf

This is just partial replacement of [buf,end] couple with
struct vsp_buf.

The intention is to see how the code would look like. It does
not compile.
---
 lib/vsprintf.c | 85 +++++++++++++++++++++-----------------------------
 1 file changed, 35 insertions(+), 50 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3bcb7be03f93..963c9212141d 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -446,8 +446,9 @@ static_assert(sizeof(struct printf_spec) == 8);
 #define PRECISION_MAX ((1 << 15) - 1)
 
 static noinline_for_stack
-char *number(char *buf, char *end, unsigned long long num,
-	     struct printf_spec spec)
+strcut vsp_buf *number(struct vsp_buf *vsp_buf,
+		       unsigned long long num,
+		       struct printf_spec spec)
 {
 	/* put_dec requires 2-byte alignment of the buffer. */
 	char tmp[3 * sizeof(num)] __aligned(2);
@@ -506,68 +507,52 @@ char *number(char *buf, char *end, unsigned long long num,
 	/* printing 100 using %2d gives "100", not "00" */
 	if (i > precision)
 		precision = i;
+
 	/* leading space padding */
 	field_width -= precision;
 	if (!(spec.flags & (ZEROPAD | LEFT))) {
-		while (--field_width >= 0) {
-			if (buf < end)
-				*buf = ' ';
-			++buf;
-		}
+		while (--field_width >= 0)
+			vsp_putc(vsp_buf, ' ');
 	}
+
 	/* sign */
-	if (sign) {
-		if (buf < end)
-			*buf = sign;
-		++buf;
-	}
+	if (sign)
+		vsp_putc(vsp_buf, sign);
+
 	/* "0x" / "0" prefix */
 	if (need_pfx) {
-		if (spec.base == 16 || !is_zero) {
-			if (buf < end)
-				*buf = '0';
-			++buf;
-		}
+		if (spec.base == 16 || !is_zero)
+			vsp_putc(vps_buf, '0');
 		if (spec.base == 16) {
-			if (buf < end)
-				*buf = ('X' | locase);
-			++buf;
-		}
+			vsp_putc(vps_buf, 'X' | locase);
 	}
+
 	/* zero or space padding */
 	if (!(spec.flags & LEFT)) {
 		char c = ' ' + (spec.flags & ZEROPAD);
 
-		while (--field_width >= 0) {
-			if (buf < end)
-				*buf = c;
-			++buf;
-		}
+		while (--field_width >= 0)
+			vsp_putc(vps_buf, c);
 	}
+
 	/* hmm even more zero padding? */
-	while (i <= --precision) {
-		if (buf < end)
-			*buf = '0';
-		++buf;
-	}
+	while (i <= --precision)
+		vsp_putc(vps_buf, '0');
+
 	/* actual digits of result */
-	while (--i >= 0) {
-		if (buf < end)
-			*buf = tmp[i];
-		++buf;
-	}
+	while (--i >= 0)
+		vsp_putc(vps_buf, tmp[i]);
+
 	/* trailing space padding */
-	while (--field_width >= 0) {
-		if (buf < end)
-			*buf = ' ';
-		++buf;
-	}
+	while (--field_width >= 0)
+		vsp_putc(vps_buf, ' ');
 
 	return buf;
 }
 
 static noinline_for_stack
-char *special_hex_number(char *buf, char *end, unsigned long long num, int size)
+	struct vsp_buf* *special_hex_number(struct vsp_buf *vsp_buf,
+					    unsigned long long num, int size)
 {
 	struct printf_spec spec;
 
@@ -577,7 +562,7 @@ char *special_hex_number(char *buf, char *end, unsigned long long num, int size)
 	spec.base = 16;
 	spec.precision = -1;
 
-	return number(buf, end, num, spec);
+	return number(vsp_buf, num, spec);
 }
 
 static void move_right(char *buf, char *end, unsigned len, unsigned spaces)
@@ -646,14 +631,14 @@ static char *string_nocheck(char *buf, char *end, const char *s,
 	return widen_string(buf, len, end, spec);
 }
 
-static char *err_ptr(char *buf, char *end, void *ptr,
+static struct vsp_buf *err_ptr(struct vsp_buf *vsp_buf, void *ptr,
 		     struct printf_spec spec)
 {
 	int err = PTR_ERR(ptr);
 	const char *sym = errname(err);
 
 	if (sym)
-		return string_nocheck(buf, end, sym, spec);
+		return string_nocheck(vsp_buf, sym, spec);
 
 	/*
 	 * Somebody passed ERR_PTR(-1234) or some other non-existing
@@ -662,7 +647,7 @@ static char *err_ptr(char *buf, char *end, void *ptr,
 	 */
 	spec.flags |= SIGN;
 	spec.base = 10;
-	return number(buf, end, err, spec);
+	return number(vsp_buf, err, spec);
 }
 
 /* Be careful: error messages must fit into the given buffer. */
@@ -720,9 +705,9 @@ char *string(char *buf, char *end, const char *s,
 	return string_nocheck(buf, end, s, spec);
 }
 
-static char *pointer_string(char *buf, char *end,
-			    const void *ptr,
-			    struct printf_spec spec)
+static vsp_buf *pointer_string(struct vsp_buf *vsp_buf,
+			       const void *ptr,
+			       struct printf_spec spec)
 {
 	spec.base = 16;
 	spec.flags |= SMALL;
@@ -731,7 +716,7 @@ static char *pointer_string(char *buf, char *end,
 		spec.flags |= ZEROPAD;
 	}
 
-	return number(buf, end, (unsigned long int)ptr, spec);
+	return number(vsp_buf, (unsigned long int)ptr, spec);
 }
 
 /* Make pointers available for printing early in the boot sequence. */
-- 
2.26.2

