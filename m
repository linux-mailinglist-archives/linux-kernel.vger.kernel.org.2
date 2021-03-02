Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE69132A961
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245034AbhCBSUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238867AbhCBP2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:28:12 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FA8C0611C1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:16:20 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id c10so9398389ejx.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3JaAzi78nDR1hUJwPXrGNpYmlye2JHIBYYofhN+lLx4=;
        b=btaeOwObdhAo117aAhbHs7xY6wTrKeJZYvYPNbDq/bpzP8t4TIvyTxOR52ztJ0Ag69
         Pgt9hBQ8nk/j3JfQ856j0lG8bUSkG9kNUGPIJL+taUPDbZji3RPjfh39rv9OcUzKUYyN
         a9nlUaG2T23usUSjEqO+X93sLl5qRC+ACRQLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3JaAzi78nDR1hUJwPXrGNpYmlye2JHIBYYofhN+lLx4=;
        b=CIO6U7+VUmbQ0AYkfV+TvdrtPEjZ0dJpIobKCtonK/Jkr/F1eScXrbuFKGNl3UVzlE
         X8kLcPhn+DPbaeUsTLi1WlhdxOdb3qAhsOoJTYEqotmOdMCr+O9axhT1rLxRtH0rk7Gu
         8+kWq0DwNR4NAVivZwNUCdhhPLWLbFo46fVTUyzsb5QvVRyd1yZUuLE5v0ZBBomgry1E
         jgWkp3bID78XjoT/qOitnMaJ8yrZwIZDqEuaFNfUoAiwWbcRQ5WSB3q4dOHQI8+Cx3kf
         ZDYOGXcDvpek5lMII450ZLTbMqXz0MkY+bdAzs9TENzjXOgHJjgnUUtWY4COv3vBNDzY
         arHg==
X-Gm-Message-State: AOAM5321B9Jt++JGLSC35Aq/cZEBGAhAb/EDfIustW3A6bibEqXYIuTT
        T8nuyNJ2jYbmKHQdDLuQUFKs1A==
X-Google-Smtp-Source: ABdhPJwQP10jIeMvIL6nBCKwQolqOlOlN2yRwkqREwlQ1pOzBW82vh5v7iWyH6U/vN60di0pRN/KYg==
X-Received: by 2002:a17:906:b6cc:: with SMTP id ec12mr21184157ejb.520.1614698179688;
        Tue, 02 Mar 2021 07:16:19 -0800 (PST)
Received: from [192.168.1.149] ([80.208.71.141])
        by smtp.gmail.com with ESMTPSA id b17sm17763342ejj.9.2021.03.02.07.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 07:16:19 -0800 (PST)
Subject: Re: [PATCH 3/3] [v4] lib/vsprintf: no_hash_pointers prints all
 addresses as unhashed
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Petr Mladek <pmladek@suse.com>,
        Marco Elver <elver@google.com>, Timur Tabi <timur@kernel.org>,
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
        Pavel Machek <pavel@ucw.cz>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
References: <20210214161348.369023-1-timur@kernel.org>
 <20210214161348.369023-4-timur@kernel.org>
 <CAMuHMdULKZCJevVJcp7TxzLdWLjsQPhE8hqxhnztNi9bjT_cEw@mail.gmail.com>
 <CANpmjNNm-4s16_KQ1_NqFN4XOESJh4_=33LHQzt+p4V0Cy=Xzw@mail.gmail.com>
 <CAMuHMdWWsZ-vTGZCeLtcwLTuBYpeP0STfhrK37wiwmyfsQ798A@mail.gmail.com>
 <YD49x/UGUq6MSE39@alley> <8893ff08-1e50-316c-f632-cd37be1690d5@suse.cz>
 <CAMuHMdUB4DZxHo=j1+EsSsoGCdWmDO9mBo0cUtAH4OYHy3sBzw@mail.gmail.com>
 <20210302090811.620ae7d0@gandalf.local.home>
 <CAMuHMdVYJ0ydFEZ+xPLt27J9pBW+B8pJNPBDZ2Vw5g5k1atarg@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <7a3c0525-efac-debf-895c-cf984916daaf@rasmusvillemoes.dk>
Date:   Tue, 2 Mar 2021 16:16:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVYJ0ydFEZ+xPLt27J9pBW+B8pJNPBDZ2Vw5g5k1atarg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2021 15.28, Geert Uytterhoeven wrote:

> Fortunately gcc is already smart enough to deduplicate identical strings,
> but only in the same source file.

Yeah, gcc can't do much more since it only handles one source file at a
time. However, the linker certainly deduplicates strings across
translation units :)

I don't think gcc bothers to do the tail merging since the linker does
it, but that may depend on optimization level and gcc version; it does
seem to merge identical strings within a TU, at least in very simple cases.

Rasmus

$ grep . *.c
a.c:const char *a1(void) { return "string"; }
a.c:const char *a2(void) { return "string"; }
a.c:const char *a3(void) { return "longer string"; }
b.c:const char *b1(void) { return "string"; }
b.c:const char *b2(void) { return "longer string"; }
b.c:const char *b3(void) { return "much longer string"; }
main.c:#include <stdio.h>
main.c:const char *a1(void);
main.c:const char *a2(void);
main.c:const char *a3(void);
main.c:const char *b1(void);
main.c:const char *b2(void);
main.c:const char *b3(void);
main.c:int main(int argc, char *argv[])
main.c:{
main.c:#define p(x) printf("%s(): %p - [%s]\n", #x, x(), x())
main.c: p(a1);
main.c: p(a2);
main.c: p(a3);
main.c: p(b1);
main.c: p(b2);
main.c: p(b3);
main.c:
main.c: return 0;
main.c:}

$ gcc -O2 -o a.o -c a.c ; gcc -O2 -o b.o -c b.c ; gcc -O2 -o main.o -c
main.c ; gcc -o main main.o a.o b.o ; ./main
a1(): 0x560b1bc3d033 - [string]
a2(): 0x560b1bc3d033 - [string]
a3(): 0x560b1bc3d02c - [longer string]
b1(): 0x560b1bc3d033 - [string]
b2(): 0x560b1bc3d02c - [longer string]
b3(): 0x560b1bc3d027 - [much longer string]
