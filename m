Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63523393651
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 21:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbhE0TfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbhE0Tew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:34:52 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241A5C061761
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 12:33:17 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id f84so2317246ybg.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 12:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kdIhgUoE9F3zBlRjdECMCVLSlqqYp+VNMOtcyHqGSuA=;
        b=WRYZgK2UEzOSn6SRrDIbUasTjTX6mvgxpC1gEbRSBhwjIVVJNMjLHjo5nMlKj+I90o
         XsdYo1pdHd9lRTA8xvTVr65F2VHBF04yNmfsFvYrYUgRmf947iw7snsy3ZuKD634vvTu
         ZcKFE2IWx7d8Nw+uKDqrSN6r278x6hAD/3w3OR/ekrwItDcARZ7gfG1vJgw+ZgfFS4bp
         SLAUXd1wSEu8bwrCUhoNkkvI9Pc35eQFLFJX8jJFGG1DfhSHOHrGypFHjPh+/RcAh+Hz
         xj88I49Ndz/3zbgkB3AeYuMhWdQU6MgcLiZwRBPnf+t56fxLS+ncOqcHVzx6Jw+s2/uG
         q1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kdIhgUoE9F3zBlRjdECMCVLSlqqYp+VNMOtcyHqGSuA=;
        b=tz+QF6iVnyRVMnlXyt9Z8ufyQs4MKI1PTRWhV9oKCYVdh/X0s+5XpTIMQ4cSKB1FO9
         KQn5JCEWuewjbYdWGeUyfCyRKkPq97QWia+QoNws2BAiC9tGCywcqpLeE+HxbFE738/B
         Rc5BLxYG7CvdF+QJBe8S+Gn4mfXiyUIsVjpC27G4aGZXts67famtnUuHy6js37a2bpwE
         tJeEiVS99pIaHN56ni4x+J/dm4bI2NAQCMAeMyYJkg+vTg2a/FFL0I5mLLGi6YKOr/JL
         YeGukFzUWUByXoFW/b5EZzY+sxsbSrSYDyfVFgY/BtQ/4t5bXQEQnJb+w+kKA3ZCCxDY
         Jofw==
X-Gm-Message-State: AOAM530fzIxLjYM/3tXfeQBWYCkfVUmDH+9CmINR/gO7EPtOkbymnGHH
        m+RwEnAd4h17PifdYD4PJtJwZNei0AoqSPXU+Hw=
X-Google-Smtp-Source: ABdhPJxWgzyUXbNj+y8XVHSiYubVfLRET5odOuf0he8XPMEXJEML7WP2IwEVwrP8CuBq+e6P58QdggQhDb3pau7NTa8=
X-Received: by 2002:a25:7909:: with SMTP id u9mr6984300ybc.22.1622143996446;
 Thu, 27 May 2021 12:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210527162655.3246381-1-elver@google.com>
In-Reply-To: <20210527162655.3246381-1-elver@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 27 May 2021 21:33:05 +0200
Message-ID: <CANiq72mvSkHULFVSDr6A=pv+2PUzXxzNFpjmKJGt4tJum_LEBQ@mail.gmail.com>
Subject: Re: [PATCH v2] kcov: add __no_sanitize_coverage to fix noinstr for
 all architectures
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Will Deacon <will@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 6:27 PM 'Marco Elver' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> Note: In the Clang case, __has_feature(coverage_sanitizer) is only true
> if the feature is enabled, and therefore we do not require an additional
> defined(CONFIG_KCOV) (like in the GCC case where __has_attribute(..) is

I would put this explanation as a comment.

Other than that:

    Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel
