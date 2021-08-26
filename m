Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1C33F8D9D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 20:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243277AbhHZSJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 14:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243259AbhHZSJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 14:09:48 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C094C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:09:01 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id p15so6728713ljn.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sdk8oq9F9d0RnEa7dfHJHGoL0Z5yyU5Y/fEoZ2o9vEs=;
        b=oFaf1OcBV6BFwvxWMUemdMKSedBA9yLmq2eCG+ad7OwqaD0DiP62OtgHqbIW+StaVP
         VddT4aGeBBKdcB+6YQiOVT6GNI7ARrjOkBRKmAU2/fCGYmPqB7KBFkirU1o2quzVOqyD
         dFYM2M7vmIQanPHyRne5WCpOOnba+vaLR25yr2+x1D2q0IbH1jUFCvTT7LGPdrSqehFb
         KtY+S9RhbII4vMAKnm/Gb63bmnkY8PaCXXIrrHLFrr0+f/JzC/phq3kYrUtwJL/wngqf
         oRGQAzTOeaUoQJtayoEQ4qAuMwS+HkFfmja7WeOMv0YCv2M+JwqoUVHe62GEZLzsyhHd
         hJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sdk8oq9F9d0RnEa7dfHJHGoL0Z5yyU5Y/fEoZ2o9vEs=;
        b=oXo6Lo1BfSROAEI2jxUfJQqckVXot/cOA9/EPaWemnRnZ8o0PIHP5XtotdDxiqVRoc
         orMdSPkmqa4goQGTbEBP0iAKQ7RBljmxyVFSH6tPYg4gxHxDa1bfHEbv3T1StC/4yuuQ
         f0HZVo5IM/zP988p2C9lHkLKgq50AqVgAeaZVCZFHKWzVCYZmAlBcqUN169o464FBlwc
         hhx5GiBbmPBGjAbUZjZ+OHYGnwIJZvoHmV6N5QNbBjFeOquOQP1jkqpP6Qdi1Ak0Rrl3
         /ZTkXLEaKYaMCzi+UarnHi8EJcyONxKMN19NRkRmhodYTDNIG6iypf+Tsx9ja5Bu6VTs
         OJSQ==
X-Gm-Message-State: AOAM532VruD6B9W9lKofsgBAptYQkrzAA4T5k3KrXy1ZbFBUAyTb0FlZ
        cICQCpDKprXbM4iOGW4eWRVRTJ9e3XZG8ZXh9CEDwQ==
X-Google-Smtp-Source: ABdhPJzS/iKs/tjwCArh2Yfh+JVfg8cE0yOVo4BTu9i3Q7phsaRzNSlcZw5F+bAfVa5AUqVC5B4BcEZLW9JJgaQbkq4=
X-Received: by 2002:a2e:a788:: with SMTP id c8mr4240939ljf.116.1630001338932;
 Thu, 26 Aug 2021 11:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210822075122.864511-1-keescook@chromium.org>
 <20210822075122.864511-15-keescook@chromium.org> <CAKwvOdmY2DQbjKutcofN3zsiz_majg6UnhMjMWbamVRhaRPhsw@mail.gmail.com>
 <202108251942.26FC1B8E7@keescook>
In-Reply-To: <202108251942.26FC1B8E7@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 26 Aug 2021 11:08:47 -0700
Message-ID: <CAKwvOdm9GMcR8rAwaEL8Nv7xJ-gAgo1NmmihF=CG72x0qj2MKw@mail.gmail.com>
Subject: Re: [PATCH for-next 14/25] lib/string: Move helper functions out of string.c
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 7:47 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Aug 25, 2021 at 02:48:30PM -0700, Nick Desaulniers wrote:
> > are memset16, memset32, and memset64 worth moving as well? Also,
> > memscan(), check_bytes(), memchr_inv()?
>
> All of these are implementations, so they should stay put.

All of the functions being moved here are definitions. So what's the
difference between moving the definitions of functions like
strrreplace, fortify_panic, etc., but not memscan(), check_bytes(),
memchr_inv(), etc?  ie. it looks to me like a few more functions can
or should be moved as well.  If the point of this patch is to "move
all the helper functions into string_helpers.c so that they gain the
fortification coverage they had been missing" then it looks like you
missed a few.  I don't think the compiler will recognize those
non-libc identifiers for any fortification related transforms (unlike
memcpy and friends which are left in place).
-- 
Thanks,
~Nick Desaulniers
