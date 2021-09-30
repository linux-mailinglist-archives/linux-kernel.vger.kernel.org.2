Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF7841E1AC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 20:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346146AbhI3SxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 14:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346039AbhI3Swx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:52:53 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B41C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:51:10 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id u18so29600649lfd.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IO2yScWcP1V3nkSCAyqfJDaTb8wvqyBUDTytiX1OoYI=;
        b=soIWJ7+oT5oJYc/VTgT4oO8XQJsb/jD0w3MRT9k9qq1A9c1ZaQS3s4W/9o8W3j6V8p
         5pbIutFIOS6cJasSJhN7HM1fbbbS1EZuQNrp1sWV1O/EYelYQ3FYHKZUI1TkQ780sqnT
         u19dcZmAqeTRNMvKdNEa27nspq3S570gqBYkXrfvyQ/U+lKWVVR3vThrLKqp6vrKxPF5
         sLLrcLijrtzLw8qWLTxQ4Fy5SGVDtd2BvWqR/VpkNAGF/kZa9Vf+G36OzHJyJyKeTh6c
         36B8YtmmujuiiddyndiXgPesk2OsxgcSUoo/L4wl9kEpFWvicCQIK4PMFaypYyCPYhNS
         XKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IO2yScWcP1V3nkSCAyqfJDaTb8wvqyBUDTytiX1OoYI=;
        b=p9NF/Az8tszAZ8BUi27uSlcoyVhh2XCXATGQWCovvsWTMF2utxX7RX6/cDfPRdjuJW
         H27E0+FxXvXxkzHv+PkNrbIDvHnGsNG6RzeBqiuHcdN3lzVE5dycqr/Yj6JPohLFqBHi
         v2G/ugkqIbXfUpq/kXMxv0k0LomI/2Rb/4tZ9ar0L21TwvibTJ4WGPAsXd5HqD6lIUhg
         a48p8YtcBmENMSJfLoMwtFrKmUHmBBav0ATA63Acb5MHWYPldCp+L9ne6ewiarY9VX0M
         qRqHVyZaCFodSQIbuye9gvSDh8gPrEXE0ONTv3cfxlbHxD0lt7JFvS/r03gPL3aVkXfz
         B2Uw==
X-Gm-Message-State: AOAM531QDm9lrPihx/kCnt822v3zLSeB1lxX4u7b9xMr7vN/cW6/uTnm
        bWFlRtqzkStEZtiqRPIA7WzgC3jX8iwRFewFn+UkOg==
X-Google-Smtp-Source: ABdhPJwliirpZ6GgdbLM//GKHu/jI+FUv6Eo6sSVuFPqLNLIXYKUMrEJTAvhFCRFN+Qnuok9jzqx8j5kXlYAdUyYD+s=
X-Received: by 2002:a2e:9b98:: with SMTP id z24mr7204666lji.339.1633027868339;
 Thu, 30 Sep 2021 11:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com> <20210930180531.1190642-6-samitolvanen@google.com>
In-Reply-To: <20210930180531.1190642-6-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 30 Sep 2021 11:50:57 -0700
Message-ID: <CAKwvOdnJ6EPPd5UbhZhdggPRzCXmdrnxg_tO=Bq_+Gcgarvw1g@mail.gmail.com>
Subject: Re: [PATCH v4 05/15] tracepoint: Exclude tp_stub_func from CFI checking
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 11:05 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> If allocate_probes fails, func_remove replaces the old function
> with a pointer to tp_stub_func, which is called using a mismatching
> function pointer that will always trip indirect call checks with
> CONFIG_CFI_CLANG. Use DEFINE_CFI_IMMEDATE_RETURN_STUB to define
> tp_stub_func to allow it to pass CFI checking.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  kernel/tracepoint.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 64ea283f2f86..58acc7d86c3f 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c

looking at 4+5/15 together, I wonder if this TU should explicitly
include linux/cfi.h?

> @@ -99,10 +99,7 @@ struct tp_probes {
>  };
>
>  /* Called in removal of a func but failed to allocate a new tp_funcs */
> -static void tp_stub_func(void)
> -{
> -       return;
> -}
> +static DEFINE_CFI_IMMEDIATE_RETURN_STUB(tp_stub_func);
>
>  static inline void *allocate_probes(int count)
>  {
> --
> 2.33.0.800.g4c38ced690-goog
>


-- 
Thanks,
~Nick Desaulniers
