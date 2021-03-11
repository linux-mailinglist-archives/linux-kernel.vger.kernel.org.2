Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FCA3369DF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 02:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhCKBp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 20:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhCKBp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 20:45:29 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97174C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 17:45:28 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id jt13so42944164ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 17:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SY5V6i27ldWgis/iBzSFHzigha9x7usDUW2o9hKgplU=;
        b=AMnHSDEfzJBvlHxD0yNsrAT3FjdqwxBqxFgPWVmr9pFhvxMqgiAEKyOAx7PnxOqs1L
         cgyfLEVk/A2lYdVbkY2xEB4TQDdYwQsFZKcP8Y2AXgsNIYNoRA7NpceANFfUgajGhc2P
         ganMAr2nlSWIHO1y1Ce2FYvu2fYXO40B3aKNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SY5V6i27ldWgis/iBzSFHzigha9x7usDUW2o9hKgplU=;
        b=eGjM556hHjpUNOrdzd2ohGlTiJfdnYjtI93pg3Gt72lD9DXOOJH7FkGxI0r3YMh/M9
         5ZwwlJLiX5FKTpWenuIjGY0tk1FLsVyxq4c6u/XE/hWlSCxbJCQard9/fgRwlfoZmIgs
         SDqDSL+m9Hb60rxOvC3c12n5M6LU05+3D3rZ7vymrPWo/dOksUqdjk3gIqWglqZb4oFT
         vV0O3gHiuDO8rjnvHtonpZvL0qnXgYqfQPASsQdRLzp4H+HdTIketwVtqBNmuNUChflW
         G4rVV8Tt8EesUIeQ1In7wa4ld38h+YCdiiwZXJtgKVfGaFdqAe9xXI0P5z4CZOIC2k3+
         QZUw==
X-Gm-Message-State: AOAM53329bttZVva1N+qtmXcAgtCjc6Iwdm2Xllz9Rb1g4ern5nbURF+
        CQCiqwtuq+6V15GJhfAvaDx48w==
X-Google-Smtp-Source: ABdhPJxiZC2lKB0JglhCUiTK1t5ACufKS/2t/7HQbMAryVkAlsdCXeQ5un3MTjFTRHoxLRWaU7vhNw==
X-Received: by 2002:a17:907:9858:: with SMTP id jj24mr716939ejc.212.1615427127324;
        Wed, 10 Mar 2021 17:45:27 -0800 (PST)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id bm6sm523803ejb.50.2021.03.10.17.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 17:45:26 -0800 (PST)
Subject: Re: [PATCH v2 1/2] init/initramfs.c: allow asynchronous unpacking
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20210224142909.2092914-1-linux@rasmusvillemoes.dk>
 <20210309211700.2011017-1-linux@rasmusvillemoes.dk>
 <20210309211700.2011017-2-linux@rasmusvillemoes.dk>
 <CAHk-=wgfMQyYSkdRkCuHOQEcvoyw=fN7q+0cU-s9dNqDHkSmrw@mail.gmail.com>
 <2a33d478-b7a8-5b3c-7bc5-f33eb27b44fa@rasmusvillemoes.dk>
Message-ID: <2a8c6ceb-9dda-f8b6-1a96-6e75dd3b4eea@rasmusvillemoes.dk>
Date:   Thu, 11 Mar 2021 02:45:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <2a33d478-b7a8-5b3c-7bc5-f33eb27b44fa@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2021 01.17, Rasmus Villemoes wrote:
> On 09/03/2021 23.16, Linus Torvalds wrote:
>> On Tue, Mar 9, 2021 at 1:17 PM Rasmus Villemoes
>> <linux@rasmusvillemoes.dk> wrote:
>>>
>>> So add an initramfs_async= kernel parameter, allowing the main init
>>> process to proceed to handling device_initcall()s without waiting for
>>> populate_rootfs() to finish.
>>
>> Oh, and a completely unrelated second comment about this: some of the
>> initramfs population code seems to be actively written to be slow.
>>
>> For example, I'm not sure why that write_buffer() function uses an
>> array of indirect function pointer actions. Even ignoring the whole
>> "speculation protections make that really slow" issue that came later,
>> it seems to always have been actively (a) slower and (b) more complex.
>>
>> The normal way to do that is with a simple switch() statement, which
>> makes the compiler able to do a much better job. Not just for the
>> state selector - maybe it picks that function pointer approach, but
>> probably these days just direct comparisons - but simply to do things
>> like inline all those "it's used in one place" cases entirely. In
>> fact, at that point, a lot of the state machine changes may end up
>> turning into pure goto's - compilers are sometimes good at that
>> (because state machines have often been very timing-critical).
> 
> FWIW, I tried doing
> 

Hm, gcc does elide the test of the return value, but jumps back to a
place where it always loads state from its memory location and does the
whole switch(). To get it to jump directly to the code implementing the
various do_* helpers it seems one needs to avoid that global variable
and instead return the next state explicitly. The below boots, but I
still can't see any measurable improvement on ppc.

Rasmus

Subject: [PATCH] init/initramfs.c: change state machine implementation

Instead of having write_buffer() rely on the global variable "state",
have each of the do_* helpers return the next state, or the new token
Stop. Also, instead of an array of function pointers, use a switch
statement.

This means all the do_* helpers end up inlined into write_buffer(),
and all the places which return a compile-time constant next state now
compile to a direct jump to that code.

We still need the global variable state for the initial choice within
write_buffer, and we also need to preserve the last non-Stop state
across calls.
---
 init/initramfs.c | 90 ++++++++++++++++++++++++------------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 1d0fdd05e5e9..ad7e04393acb 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -189,7 +189,8 @@ static __initdata enum state {
 	GotName,
 	CopyFile,
 	GotSymlink,
-	Reset
+	Reset,
+	Stop
 } state, next_state;

 static __initdata char *victim;
@@ -207,17 +208,17 @@ static __initdata char *collected;
 static long remains __initdata;
 static __initdata char *collect;

-static void __init read_into(char *buf, unsigned size, enum state next)
+static int __init read_into(char *buf, unsigned size, enum state next)
 {
 	if (byte_count >= size) {
 		collected = victim;
 		eat(size);
-		state = next;
+		return next;
 	} else {
 		collect = collected = buf;
 		remains = size;
 		next_state = next;
-		state = Collect;
+		return Collect;
 	}
 }

@@ -225,8 +226,7 @@ static __initdata char *header_buf, *symlink_buf,
*name_buf;

 static int __init do_start(void)
 {
-	read_into(header_buf, 110, GotHeader);
-	return 0;
+	return read_into(header_buf, 110, GotHeader);
 }

 static int __init do_collect(void)
@@ -238,50 +238,46 @@ static int __init do_collect(void)
 	eat(n);
 	collect += n;
 	if ((remains -= n) != 0)
-		return 1;
-	state = next_state;
-	return 0;
+		return Stop;
+	return next_state;
 }

 static int __init do_header(void)
 {
 	if (memcmp(collected, "070707", 6)==0) {
 		error("incorrect cpio method used: use -H newc option");
-		return 1;
+		return Stop;
 	}
 	if (memcmp(collected, "070701", 6)) {
 		error("no cpio magic");
-		return 1;
+		return Stop;
 	}
 	parse_header(collected);
 	next_header = this_header + N_ALIGN(name_len) + body_len;
 	next_header = (next_header + 3) & ~3;
-	state = SkipIt;
 	if (name_len <= 0 || name_len > PATH_MAX)
-		return 0;
+		return SkipIt;
 	if (S_ISLNK(mode)) {
 		if (body_len > PATH_MAX)
-			return 0;
+			return SkipIt;
 		collect = collected = symlink_buf;
 		remains = N_ALIGN(name_len) + body_len;
 		next_state = GotSymlink;
-		state = Collect;
-		return 0;
+		return Collect;
 	}
 	if (S_ISREG(mode) || !body_len)
-		read_into(name_buf, N_ALIGN(name_len), GotName);
-	return 0;
+		return read_into(name_buf, N_ALIGN(name_len), GotName);
+	return SkipIt;
 }

 static int __init do_skip(void)
 {
 	if (this_header + byte_count < next_header) {
 		eat(byte_count);
-		return 1;
+		return Stop;
 	} else {
 		eat(next_header - this_header);
-		state = next_state;
-		return 0;
+		return next_state;
 	}
 }

@@ -291,7 +287,7 @@ static int __init do_reset(void)
 		eat(1);
 	if (byte_count && (this_header & 3))
 		error("broken padding");
-	return 1;
+	return Stop;
 }

 static void __init clean_path(char *path, umode_t fmode)
@@ -324,11 +320,12 @@ static __initdata loff_t wfile_pos;

 static int __init do_name(void)
 {
-	state = SkipIt;
+	int s = SkipIt;
+
 	next_state = Reset;
 	if (strcmp(collected, "TRAILER!!!") == 0) {
 		free_hash();
-		return 0;
+		return s;
 	}
 	clean_path(collected, mode);
 	if (S_ISREG(mode)) {
@@ -339,14 +336,14 @@ static int __init do_name(void)
 				openflags |= O_TRUNC;
 			wfile = filp_open(collected, openflags, mode);
 			if (IS_ERR(wfile))
-				return 0;
+				return s;
 			wfile_pos = 0;

 			vfs_fchown(wfile, uid, gid);
 			vfs_fchmod(wfile, mode);
 			if (body_len)
 				vfs_truncate(&wfile->f_path, body_len);
-			state = CopyFile;
+			s = CopyFile;
 		}
 	} else if (S_ISDIR(mode)) {
 		init_mkdir(collected, mode);
@@ -362,7 +359,7 @@ static int __init do_name(void)
 			do_utime(collected, mtime);
 		}
 	}
-	return 0;
+	return s;
 }

 static int __init do_copy(void)
@@ -378,14 +375,13 @@ static int __init do_copy(void)

 		fput(wfile);
 		eat(body_len);
-		state = SkipIt;
-		return 0;
+		return SkipIt;
 	} else {
 		if (xwrite(wfile, victim, byte_count, &wfile_pos) != byte_count)
 			error("write error");
 		body_len -= byte_count;
 		eat(byte_count);
-		return 1;
+		return Stop;
 	}
 }

@@ -396,29 +392,33 @@ static int __init do_symlink(void)
 	init_symlink(collected + N_ALIGN(name_len), collected);
 	init_chown(collected, uid, gid, AT_SYMLINK_NOFOLLOW);
 	do_utime(collected, mtime);
-	state = SkipIt;
 	next_state = Reset;
-	return 0;
+	return SkipIt;
 }

-static __initdata int (*actions[])(void) = {
-	[Start]		= do_start,
-	[Collect]	= do_collect,
-	[GotHeader]	= do_header,
-	[SkipIt]	= do_skip,
-	[GotName]	= do_name,
-	[CopyFile]	= do_copy,
-	[GotSymlink]	= do_symlink,
-	[Reset]		= do_reset,
-};
-
 static long __init write_buffer(char *buf, unsigned long len)
 {
+	int s = state;
+	int save;
+
 	byte_count = len;
 	victim = buf;

-	while (!actions[state]())
-		;
+	do {
+		save = s;
+		switch (s) {
+		case Start: s = do_start(); break;
+		case Collect: s = do_collect(); break;
+		case GotHeader: s = do_header(); break;
+		case SkipIt: s = do_skip(); break;
+		case GotName: s = do_name(); break;
+		case CopyFile: s = do_copy(); break;
+		case GotSymlink: s = do_symlink(); break;
+		case Reset: s = do_reset(); break;
+		}
+	} while (s != Stop);
+	state = save;
+
 	return len - byte_count;
 }

-- 
2.29.2

