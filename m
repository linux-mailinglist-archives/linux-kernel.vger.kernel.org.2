Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA353B3B69
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 06:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhFYEKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 00:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhFYEKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 00:10:36 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552CBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 21:08:15 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id g7so4419378wri.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 21:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wtb2ef1+Onk4FkYj1WTTNjN9qcUMzBKmdDiK41PBwCo=;
        b=P5ZQzzEtVw32Z7+DdWiYMF9W3ByIMIzM/WNQjjiNvFtNfBECqKgHgrKsuB77VF+vQm
         KrrG+5fMzjNHLvVs54Hi6R2MLmoky8ex8xOYcUT30gFcc999JVt+iKCFgwGlw3ptwQWV
         6wSFWfBP7ycBNvDZmhfN8CekUAVsf2SVHGiCu19QcRQGIbpFgL/Ml4ZdwFb8W7nugqnw
         UIQ/MfwBwmNQGZfdluQeCWzG+OvybfssXsvWT8TXIJsaJXI2xaq90uW/ww1OufxTmDRs
         KUYEUevD3JrB341dc4U6AuxtN6SSavtiOZxfnAiV3GK5w6aYTI0Vb/qr7ihGSKjRR03O
         OrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wtb2ef1+Onk4FkYj1WTTNjN9qcUMzBKmdDiK41PBwCo=;
        b=lCujjWB+BcxjqHkjlzkTAU0L7TSs/opi5+/au7waOrSvJwu3wwJk5nuoi+Zla0XSRE
         xpuJOygSRVKbf8zPqTTLh35Bd7qLsnzQ4M2tTR7AlufmaTzfYvVkAPfeAf5EkbxkgJx1
         KEBk6kDf6d4HhtCYWguqGiwo4vwOUqpeNsY4yj8GRp0GgogcbJsWWAi5FrpO+z5liBXa
         UVk+LAFHNsVsnYtal8UN7aGlzLvK4h7PhBZFRjzcPH5QQWWG5Z49qenuubsrK5aIc3zm
         zhtA8aF3b6oBgMUQDEHgLkMyrxpzM+u+mQ1Ql1IVZ5f8KGvtwzqN1odKu9DdMUajM5Cz
         eoiw==
X-Gm-Message-State: AOAM533nxg4tGXbBeZmXzGVEquIK7zC5XifkwcKHl9KbdhcUS4MLAZiS
        7spUw57C6AE6ihXgwb0T3gNUmf9Wkccnrv0oIa7KTQ==
X-Google-Smtp-Source: ABdhPJxcx1eoU3WmQgAS+epQWrUgX6YHSAX3v4EPioVlfbNsRX//a6JQn2GwTJ0l0p4S+IhH3g+VKja3Yh2iuD8ZFak=
X-Received: by 2002:a5d:480e:: with SMTP id l14mr8651762wrq.33.1624594093763;
 Thu, 24 Jun 2021 21:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210623201721.980348-1-dlatypov@google.com>
In-Reply-To: <20210623201721.980348-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 25 Jun 2021 12:08:02 +0800
Message-ID: <CABVgOSnffgiapw04a-naZZtuzHfcKaZPcqNiPxhYObdbNgJf2Q@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: drop obsolete note about uml_abort
 for coverage
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 4:17 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Commit b6d5799b0b58 ("kunit: Add 'kunit_shutdown' option") changes KUnit
> to call kernel_halt() by default when done testing.
>
> This fixes the issue with not having .gcda files due to not calling
> atexit() handlers, and therefore we can stop recommending people
> manually tweak UML code.
>
> The need to use older versions of GCC (<=6) remains however, due to
> linktime issues, same as before. Note: There also might still be issues
> with .gcda files as well in newer versions.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

This looks good to me, thanks! Now if only we could fix the issues
with newer gcc versions...

Reviewed-by: David Gow <davidgow@google.com>


-- David

>  Documentation/dev-tools/kunit/running_tips.rst | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
> index 7d99386cf94a..d1626d548fa5 100644
> --- a/Documentation/dev-tools/kunit/running_tips.rst
> +++ b/Documentation/dev-tools/kunit/running_tips.rst
> @@ -86,19 +86,7 @@ Generating code coverage reports under UML
>  .. note::
>         TODO(brendanhiggins@google.com): There are various issues with UML and
>         versions of gcc 7 and up. You're likely to run into missing ``.gcda``
> -       files or compile errors. We know one `faulty GCC commit
> -       <https://github.com/gcc-mirror/gcc/commit/8c9434c2f9358b8b8bad2c1990edf10a21645f9d>`_
> -       but not how we'd go about getting this fixed. The compile errors still
> -       need some investigation.
> -
> -.. note::
> -       TODO(brendanhiggins@google.com): for recent versions of Linux
> -       (5.10-5.12, maybe earlier), there's a bug with gcov counters not being
> -       flushed in UML. This translates to very low (<1%) reported coverage. This is
> -       related to the above issue and can be worked around by replacing the
> -       one call to ``uml_abort()`` (it's in ``os_dump_core()``) with a plain
> -       ``exit()``.
> -
> +       files or compile errors.
>
>  This is different from the "normal" way of getting coverage information that is
>  documented in Documentation/dev-tools/gcov.rst.
>
> base-commit: 87c9c16317882dd6dbbc07e349bc3223e14f3244
> --
> 2.32.0.93.g670b81a890-goog
>
