Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72E540119C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 22:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbhIEUxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 16:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238207AbhIEUxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 16:53:35 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8942C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 13:52:31 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ot2-20020a17090b3b4200b0019127f8ed87so2561384pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 13:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DJE+e7F/cWqTlMRkrkUj4HK+0jz5SspbCiD/vy9NmRw=;
        b=LdYEdbmQ4ufsF2/MOs+EhwmwhRqF9wPiu5gjJK9fZKpLbYPCfpT7a+NX0ufSBJRL4O
         C5LS3QJT9AgfjdUTZylbFFo60v4dQWEgydkRGFJbakInJTMhpZ6Et/u3gdmplkCstmEe
         kd6dT6LbvqDyfSKEk+Zi1vk+i6WVz/C77EdVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DJE+e7F/cWqTlMRkrkUj4HK+0jz5SspbCiD/vy9NmRw=;
        b=pFgj7vVXGrF+1ltgUFoFODd+/hqCvnmjsHMIO4VlmCPl/IsYQOHf5U5gcxC7rzrwIn
         /r4Eu5d2YdtPkpJwrnL78UIdaFAT+U9YgBArsWCGki2zjfc1UhxeLfZxOHeVNNUqFL0p
         jwMk0VKrdx3bfI06tvYJfQfPvqDFBj8wbroclcKXjy3vT5UZXAEe4IiRqXGyiiVhDMz0
         9vLdQAF+PResxSJ/GOv4792k9MPP758n0bWtDFTriN49CsWkYeA7W+ePwC49lLDFmAty
         Y6nbOjZBlXQ28nykdtq5Rw66qCRv6urg037bTm9QVIt8lGBVGDSz8cXL8llxU8MNq+uW
         3QQQ==
X-Gm-Message-State: AOAM533pzCv6b2xZaKbl18NDgwApONpQah6N6aLiKx+OzxaSutUmrTb2
        1uDRWWj5gbl0mq9yQ5CjnyGaJcOHJlNBzw==
X-Google-Smtp-Source: ABdhPJzdVVxf02BXR7PIuSQT+kyZRuUJblmquJ4qYEcQWg5gKY3LxjPlLc4HUVuf+hgJX/XZtNG5tA==
X-Received: by 2002:a17:90b:1e08:: with SMTP id pg8mr10710235pjb.3.1630875151207;
        Sun, 05 Sep 2021 13:52:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x189sm5581946pfx.30.2021.09.05.13.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 13:52:30 -0700 (PDT)
Date:   Sun, 5 Sep 2021 13:52:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithp@keithp.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [GIT PULL] overflow updates for v5.15-rc1
Message-ID: <202109051257.29B29745C0@keescook>
References: <202109022012.756B6B5B79@keescook>
 <CAHk-=wiPOXS2f90Ykk3V76sJLx0wMVywke8pc=88r1trmDuhmw@mail.gmail.com>
 <45312958-B844-4B4C-9808-8205866675A1@chromium.org>
 <CAHk-=widUkzjVMW99L6OZpJc1wDnZbBbnOOzgXOMypOPoV6mjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=widUkzjVMW99L6OZpJc1wDnZbBbnOOzgXOMypOPoV6mjg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 05, 2021 at 10:36:22AM -0700, Linus Torvalds wrote:
> This is actually just bog-standard gcc-11.2 from F34, and an allmodconfig build.

I've checked this on F32 now, and I still wasn't seeing the testsuite
warnings. I did see this, though, unrelated to (but certainly thematically
associated with) the overflow series:

fs/qnx4/dir.c: In function 'qnx4_readdir':
fs/qnx4/dir.c:51:32: warning: 'strnlen' specified bound 48 exceeds source size 16 [-Wstringop-overread]
   51 |                         size = strnlen(de->di_fname, size);
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from fs/qnx4/qnx4.h:3,
                 from fs/qnx4/dir.c:16:
./include/uapi/linux/qnx4_fs.h:45:25: note: source object declared here
   45 |         char            di_fname[QNX4_SHORT_NAME_MAX];
      |                         ^~~~~~~~


> Three errors due to "-Werror=unused-value", but 17 each of variations on

These are just side-effects of the actual warning going "missing".

>     error: call to ‘__read_overflow’ declared with attribute error:
> detected read beyond size of object (1st parameter)
> 
> and
> 
>     warning: unsafe xyz() usage lacked '__read_overflow' warning
> 
> warnings.

The latter is complaining about not seeing the former... O_o

Oh... I found it:

>     error: call to ‘__read_overflow’ declared with attribute error:
                     ^               ^
vs:

      error: call to '__read_overflow' declared with attribute error:
                     ^               ^

Looks like it's LANG biting me! Ugh.

LANG=en.US.UTF-8 is '
LANG=C           is '
LANG=C.UTF-8     is `

Fedora uses C.UTF-8 by default, but my build tooling (and seemingly many
others) are using LANG=en_US.UTF-8 or LANG=C. Specifically, this appears
to be LC_NAME? Fixing now...

-- 
Kees Cook
