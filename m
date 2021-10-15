Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE9342EABB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbhJOH6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbhJOH6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:58:09 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139ACC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 00:56:03 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j21so38616652lfe.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 00:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PPuRIwNEu3lQ7n00DIZZ0IEDneXxbqy0QPWov0TPJ18=;
        b=L8oJ8X1bIATNS1p3u3vouYKH65VE2DR6h2LWNm7iTIOMl8180IJCUrIHQf/6g90Gu2
         9VluYDwjPG3l1Pam3kWi3MywYUlDA+TIxHnncxK5juhRBCksbiIAhfzpXs4ZXIwD5L5Z
         zFEEhjioY0ohlIxXA3LfL1QXx0NVGQgUQwJik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PPuRIwNEu3lQ7n00DIZZ0IEDneXxbqy0QPWov0TPJ18=;
        b=i+XuTNDDiE5YW8zler5uPh79P+MWTMGzX9MziZyJwOT/YYsRwAMs9PCe3p9YN8z9aW
         cUyZsE7xCdShVdv2kTkCu2WICKOqCQv7NtlpH6GP8z3QvFWtj5RIPHpvwG3iI1l/1moy
         1R48TM/L+MF7SD8fwXKCWgFpssImTdgD6D5yj1XrN9Tfo7QgbVMUDkaPeYx4uAOZwUSU
         Od/6t+F/hYFavCQGSkQqljEMKYfqR+36027wPhZRFyHOlArtHVx4yXrewwTyW0bvVzZc
         a3tXUKnXECfr62KQkThz0pH908WapVj7x7qMMc5G739R+roE10lTuqcQ9FGDJORrcttd
         aXNA==
X-Gm-Message-State: AOAM531t4l+s7yE+LEqIFML8Xubc2bjO4tM3LJwSQx57hrq4SVEqXP2/
        vXlEU7F/Zd4O3kN4AjHumwE5dg==
X-Google-Smtp-Source: ABdhPJzdUtRux6WI2D2oEDRHfy11ixOE81eDxDr3iZieeFyjgZ3goRG48l7Ign83ZwlxQ3ExYNu+FQ==
X-Received: by 2002:a2e:9c8d:: with SMTP id x13mr11362051lji.29.1634284561422;
        Fri, 15 Oct 2021 00:56:01 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id s10sm478462lji.50.2021.10.15.00.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 00:56:00 -0700 (PDT)
Subject: Re: [PATCH] compiler_types: mark __compiletime_assert failure as
 __noreturn
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>
References: <20211014132331.GA4811@kernel.org>
 <YWhGQLHnA9BIVBpr@hirez.programming.kicks-ass.net>
 <CAKwvOdnkDUfRKzmLThQGW02Ew6x=KM0MQyHge7=kc673NYxo2g@mail.gmail.com>
 <CANiq72nt+8bCGAm8yhvTZfS64ovOi9_U=Gym7biUhdEsc3Neaw@mail.gmail.com>
 <CANiq72=UVCmjr1tpSwcoOkid5tWZirKCnV17_Peqy-LBmEQHEg@mail.gmail.com>
 <CAKwvOdkSFhzSwo2hfFjXXHypC8eU+VBCnRVjvNima7qx85z65Q@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <e8d28845-3931-c122-f398-f3eaed9e659a@rasmusvillemoes.dk>
Date:   Fri, 15 Oct 2021 09:55:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdkSFhzSwo2hfFjXXHypC8eU+VBCnRVjvNima7qx85z65Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2021 20.55, Nick Desaulniers wrote:
> On Thu, Oct 14, 2021 at 11:41 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> On Thu, Oct 14, 2021 at 8:33 PM Miguel Ojeda
>> <miguel.ojeda.sandonis@gmail.com> wrote:
>>>
>>> That would be a nice to do, but I am not sure about introducing one
>>> more macro about this... I think it would be simpler to submit patches
>>> for moves into `static_assert` even if we have to "flip" the meaning.
> 
> $ grep -r BUILD_BUG_ON | wc -l
> 3405
> 
>> Actually, what would be ideal is a compiler-backed lint that checks
>> whether it could be an `static_assert`, perhaps in clang-tidy?
> 
> Oh, that is a good idea.  There is one already for recommending the
> use of static_assert instead of assert.  That's actually very nice.

So I did

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index b6ff83a714ca..e212220216e8 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -295,12 +295,17 @@ struct ftrace_likely_data {
 # define __compiletime_object_size(obj) -1
 #endif

+#include <linux/const.h>
+
 #ifdef __OPTIMIZE__
 # define __compiletime_assert(condition, msg, prefix, suffix)          \
        do {                                                            \
                extern void prefix ## suffix(void)
__compiletime_error(msg); \
+               extern void prefix ## suffix ## ice(void)
__compiletime_warning("Ice ice baby"); \
                if (!(condition))                                       \
                        prefix ## suffix();                             \
+               if (__is_constexpr(condition))                          \
+                       prefix ## suffix ## ice();                      \
        } while (0)
 #else
 # define __compiletime_assert(condition, msg, prefix, suffix) do { }
while (0)

and that throws a gazillion warnings. Picking one at random shows that
container_of() has a BUILD_BUG_ON. So we could do

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 2776423a587e..0a1969b11619 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -492,9 +492,9 @@ static inline void ftrace_dump(enum ftrace_dump_mode
oops_dump_mode) { }
  */
 #define container_of(ptr, type, member) ({                             \
        void *__mptr = (void *)(ptr);                                   \
-       BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
-                        !__same_type(*(ptr), void),                    \
-                        "pointer type mismatch in container_of()");    \
+       static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
+                     __same_type(*(ptr), void),                        \
+                     "pointer type mismatch in container_of()");       \
        ((type *)(__mptr - offsetof(type, member))); })

 /**
@@ -507,9 +507,9 @@ static inline void ftrace_dump(enum ftrace_dump_mode
oops_dump_mode) { }
  */
 #define container_of_safe(ptr, type, member) ({
        \
        void *__mptr = (void *)(ptr);                                   \
-       BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
-                        !__same_type(*(ptr), void),                    \
-                        "pointer type mismatch in container_of()");    \
+       static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
+                     __same_type(*(ptr), void),                        \
+                     "pointer type mismatch in container_of_safe()");  \
        IS_ERR_OR_NULL(__mptr) ? ERR_CAST(__mptr) :                     \
                ((type *)(__mptr - offsetof(type, member))); })

[fixing the copy-pasto in container_of_safe while at it].

Basically, all BUILD_BUG_ONs like that that do type checking are very
obviously candidates for using static_assert instead (they very
naturally go at the end of all the locally declared variables, so one
won't hit the declaration-after-statement problem that can otherwise
prevent using static_assert).

> I was playing with trying to adapt clang-tidy's C++11 `auto` fixit to
> work on GNU C code to automate the replacement of:
> 
> __typeof(x) y = (x);
> 
> with:
> 
> __auto_type y = (x);
> 
> in macros.  That's perhaps interesting, too.  Given the volume of code
> in the kernel, I wouldn't waste time with one off patches;

Well, for the kind of macros that are used _everywhere_ a few one-off
patches might be in order. It's also interesting if one could measure
any speedup from switching those core macros to static_assert.

Rasmus
