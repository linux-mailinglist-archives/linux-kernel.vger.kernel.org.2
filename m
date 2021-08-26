Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2ED13F80CC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 04:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbhHZC51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 22:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbhHZC50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 22:57:26 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A41C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 19:56:39 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g14so1468554pfm.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 19:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vjFyaPLJq7d41xsQ0Ub2Dz36OvdKw1xIWIuZp7vFybM=;
        b=ZjLf16/FV8SL4+3VkdHnifcQwGNBNqy/2s8QZ7lUTTgN/vU+Cm1PAOewNKpkE3P/n4
         cqqnWeMyIL92WRLnjgDYf8ni9mqZkb5LlRAlwAkPjQg4tNkdnuxmUmDlVjZpRbK7Oxc6
         9FWuvdHBAjcysfo33hxE5NfUwNgwBak2B34p0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vjFyaPLJq7d41xsQ0Ub2Dz36OvdKw1xIWIuZp7vFybM=;
        b=M9VaJ55nxpHmKqs0JAD+wy3TmKJvuhv/V1F84oAwimofAhw48S3mWWHn4mN88Si66a
         dzuZXXHdqPI1cdP3rEMWXtjDX3garNOubeqGgqlhJFh9dn9MBNaMvcVVXU/LDJY2DJzN
         3SrBCqxQPSqmC4BERxN/wsafMmBwwk8c1lili1c84YhghgtJnY7GqcaFBCh15yLa1xL8
         nXuFUBMfKRKFw8x4PlSZZb2LOrvBYHsI0D3u/GVyx6Odn+fghyocRRjVWpzwu+o78a1h
         Sc0MZ/GsQ0vhkVfMIc+I1r35Y3+1ckE3cpCc6J0ROBwS0D5IAdEP2Ysng9E7EbxC/G5W
         dUiQ==
X-Gm-Message-State: AOAM530Xz9hk474UGprQFrtlRXDh8cirpDZfQz2O0UJuQVw46c+eX3Dk
        NMcs0J36MYtlPTM9LOXqdc9P9g==
X-Google-Smtp-Source: ABdhPJwbdAeN/df8R344ak31FsUULbySJGGQTp2hcnRm+4cE29aVKuu8C2p4V0YC9oRoAUkJS/7LIg==
X-Received: by 2002:a62:8287:0:b0:3ec:f6dc:9672 with SMTP id w129-20020a628287000000b003ecf6dc9672mr1314917pfd.65.1629946599192;
        Wed, 25 Aug 2021 19:56:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a2sm1383840pgb.19.2021.08.25.19.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 19:56:38 -0700 (PDT)
Date:   Wed, 25 Aug 2021 19:56:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH for-next 19/25] fortify: Allow strlen() and strnlen() to
 pass compile-time known lengths
Message-ID: <202108251950.61F7A4CD@keescook>
References: <20210822075122.864511-1-keescook@chromium.org>
 <20210822075122.864511-20-keescook@chromium.org>
 <CAKwvOdnrO+oagJEiBMmoHrhTJKSRwzb0DK=R_QdVjhiNzb34dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnrO+oagJEiBMmoHrhTJKSRwzb0DK=R_QdVjhiNzb34dg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 03:05:56PM -0700, Nick Desaulniers wrote:
> On Sun, Aug 22, 2021 at 12:57 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Under CONFIG_FORTIFY_SOURCE, it is possible for the compiler to perform
> > strlen() and strnlen() at compile-time when the string size is known.
> > This is required to support compile-time overflow checking in strlcpy().
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/fortify-string.h | 47 ++++++++++++++++++++++++++--------
> >  1 file changed, 36 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> > index a3cb1d9aacce..e232a63fd826 100644
> > --- a/include/linux/fortify-string.h
> > +++ b/include/linux/fortify-string.h
> > @@ -10,6 +10,18 @@ void __read_overflow(void) __compiletime_error("detected read beyond size of obj
> >  void __read_overflow2(void) __compiletime_error("detected read beyond size of object (2nd parameter)");
> >  void __write_overflow(void) __compiletime_error("detected write beyond size of object (1st parameter)");
> >
> > +#define __compiletime_strlen(p)        ({              \
> > +       size_t ret = (size_t)-1;                        \
> > +       size_t p_size = __builtin_object_size(p, 1);    \
> > +       if (p_size != (size_t)-1) {                     \
> > +               size_t p_len = p_size - 1;              \
> > +               if (__builtin_constant_p(p[p_len]) &&   \
> > +                   p[p_len] == '\0')                   \
> > +                       ret = __builtin_strlen(p);      \
> > +       }                                               \
> > +       ret;                                            \
> > +})
> 
> Can this be a `static inline` function that accepts a `const char *`
> and returns a `size_t` rather than a statement expression?

No because both __builtin_object_size() and __builtin_strlen() may not
work. See:
https://lore.kernel.org/lkml/20210818060533.3569517-64-keescook@chromium.org/

Regardless, it will always collapse to a const value of either -1 or
the length of the string.

> 
> > +
> >  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
> >  extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
> >  extern int __underlying_memcmp(const void *p, const void *q, __kernel_size_t size) __RENAME(memcmp);
> > @@ -60,21 +72,31 @@ extern __kernel_size_t __real_strnlen(const char *, __kernel_size_t) __RENAME(st
> >  __FORTIFY_INLINE __kernel_size_t strnlen(const char *p, __kernel_size_t maxlen)
> >  {
> >         size_t p_size = __builtin_object_size(p, 1);
> > -       __kernel_size_t ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
> > +       size_t p_len = __compiletime_strlen(p);
> > +       size_t ret;
> > +
> > +       /* We can take compile-time actions when maxlen is const. */
> > +       if (__builtin_constant_p(maxlen) && p_len != (size_t)-1) {
> > +               /* If p is const, we can use its compile-time-known len. */
> > +               if (maxlen >= p_size)
> > +                       return p_len;
> > +       }
> >
> > +       /* Do no check characters beyond the end of p. */
> 
> s/no/not/

Thanks!

> 
> > +       ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
> >         if (p_size <= ret && maxlen != ret)
> >                 fortify_panic(__func__);
> >         return ret;
> >  }
> >
> > +/* defined after fortified strnlen to reuse it. */
> >  __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
> >  {
> >         __kernel_size_t ret;
> >         size_t p_size = __builtin_object_size(p, 1);
> >
> > -       /* Work around gcc excess stack consumption issue */
> > -       if (p_size == (size_t)-1 ||
> > -               (__builtin_constant_p(p[p_size - 1]) && p[p_size - 1] == '\0'))
> > +       /* Give up if we don't know how large p is. */
> > +       if (p_size == (size_t)-1)
> >                 return __underlying_strlen(p);
> >         ret = strnlen(p, p_size);
> >         if (p_size <= ret)
> > @@ -86,24 +108,27 @@ __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
> >  extern size_t __real_strlcpy(char *, const char *, size_t) __RENAME(strlcpy);
> >  __FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
> >  {
> > -       size_t ret;
> >         size_t p_size = __builtin_object_size(p, 1);
> >         size_t q_size = __builtin_object_size(q, 1);
> > +       size_t q_len;   /* Full count of source string length. */
> > +       size_t len;     /* Count of characters going into destination. */
> >
> >         if (p_size == (size_t)-1 && q_size == (size_t)-1)
> >                 return __real_strlcpy(p, q, size);
> > -       ret = strlen(q);
> > -       if (size) {
> > -               size_t len = (ret >= size) ? size - 1 : ret;
> > -
> > -               if (__builtin_constant_p(len) && len >= p_size)
> > +       q_len = strlen(q);
> > +       len = (q_len >= size) ? size - 1 : q_len;
> > +       if (__builtin_constant_p(size) && __builtin_constant_p(q_len) && size) {
> > +               /* Write size is always larger than destintation. */
> 
> s/destintation/destination/

I can't type. :)

Fixed now.

-Kees

> 
> > +               if (len >= p_size)
> >                         __write_overflow();
> > +       }
> > +       if (size) {
> >                 if (len >= p_size)
> >                         fortify_panic(__func__);
> >                 __underlying_memcpy(p, q, len);
> >                 p[len] = '\0';
> >         }
> > -       return ret;
> > +       return q_len;
> >  }
> >
> >  /* defined after fortified strnlen to reuse it */
> > --
> > 2.30.2
> >
> > --
> > You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210822075122.864511-20-keescook%40chromium.org.
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers

-- 
Kees Cook
