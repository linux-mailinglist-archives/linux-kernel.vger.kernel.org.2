Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8487B44FEEF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 08:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhKOHDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 02:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhKOHDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 02:03:23 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5120EC061766
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 23:00:27 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id b5-20020a9d60c5000000b0055c6349ff22so25795689otk.13
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 23:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=//m9Q4+cuEgELvadHIoGYR2QVZ4qU+OxipLUtFZQsco=;
        b=EM7CmmPryWS84RRpANqlpUaXAMgknyV64IIvvSNalYAJunqNwGxIt9bFL6VlLoqHen
         oUhFb5niOYgDqzKfM6SgpTeU/G0hyDuAB0YDa8hdaqD+/4+8/+hfQtTYfrFdlzff3kkO
         YUpse8OkAELMMkqzlBAUa4gdT0B1ntBvz4Yw5dKyiNZ6msGfVg7oPOxaESLiD2PjLczE
         clOE9FmJlsYOl2z6XBEVmuQC98GuVe7PiV0V9jULIfENNQ9KDSNWsG2dx6WfqePZDWpJ
         6Okw5YIQvnYVhqrXg5hL4Wt4uEh2nGMvE4Va2PMcLjWewVqnr6M2VP5DYo6d0AiKDm0A
         L2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=//m9Q4+cuEgELvadHIoGYR2QVZ4qU+OxipLUtFZQsco=;
        b=KqOCjzUhKIMK0RpxXdI2Q7dcv7GI94P1TW5A/XijImjcL6ZMb/SmThy2R+n5OtIs8O
         2CECazsIIWP0FWHCF5lahOyH8QsN8f/sbHbw+qD4jgAHH4MqLIM2mN0xpDRNRG25L23/
         JXxEKXyZGBjVRB9j8UUqciRaEsgL7rFA+H5rEkbkXBUYFWDZ/UVqJTquuqKM1+WVkjoR
         qQf6A7ZGV/ASgtkCKhBkqhusQCOzvWtQ7nwHVdorVmLamiCfGhe7h7/jaZFy/gSdLO8w
         0zbKITCIXXkKF7GvVe+yNRWYYJLmhmb3DOVSUryS4VV4xuYrjnoYo8IpLj2ZuyT+SVKl
         8VGg==
X-Gm-Message-State: AOAM532/ycnqrfkUpvKTsi3d0llT+aIXZrpYG8dl0wOUvKp65Btm/H9Y
        g7T2P6Ov1PonLqCkesSjwuxKOiFgnSpggH09+fbKpg==
X-Google-Smtp-Source: ABdhPJz/PJUCZohjw5FTNCfkw90umtTQK0mLXtfjjVEKSUztmKAhmY5zTQe7Q6lC44dDMd7IxWdslT9MXMkvIsdJyR8=
X-Received: by 2002:a9d:7548:: with SMTP id b8mr28740314otl.92.1636959625057;
 Sun, 14 Nov 2021 23:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20211112185203.280040-1-valentin.schneider@arm.com> <20211112185203.280040-3-valentin.schneider@arm.com>
In-Reply-To: <20211112185203.280040-3-valentin.schneider@arm.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 15 Nov 2021 08:00:00 +0100
Message-ID: <CANpmjNMh=_oxuViL_WcTZX=UG6=QmFTuNOLYe6eNs84Rb8MTOA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] preempt/dynamic: Introduce preemption model accessors
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kbuild@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2021 at 19:52, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> CONFIG_PREEMPT{_NONE, _VOLUNTARY} designate either:
> o The build-time preemption model when !PREEMPT_DYNAMIC
> o The default boot-time preemption model when PREEMPT_DYNAMIC
>
> IOW, using those on PREEMPT_DYNAMIC kernels is meaningless - the actual
> model could have been set to something else by the "preempt=foo" cmdline
> parameter. Same problem applies to CONFIG_PREEMPTION.
>
> Introduce a set of helpers to determine the actual preemption model used by
> the live kernel.
>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Looks sane.

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  include/linux/sched.h | 41 +++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/core.c   | 12 ++++++++++++
>  2 files changed, 53 insertions(+)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 5f8db54226af..e8e884ee6e8b 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2073,6 +2073,47 @@ static inline void cond_resched_rcu(void)
>  #endif
>  }
>
> +#ifdef CONFIG_PREEMPT_DYNAMIC
> +
> +extern bool preempt_model_none(void);
> +extern bool preempt_model_voluntary(void);
> +extern bool preempt_model_full(void);
> +
> +#else
> +
> +static inline bool preempt_model_none(void)
> +{
> +       return IS_ENABLED(CONFIG_PREEMPT_NONE);
> +}
> +static inline bool preempt_model_voluntary(void)
> +{
> +       return IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY);
> +}
> +static inline bool preempt_model_full(void)
> +{
> +       return IS_ENABLED(CONFIG_PREEMPT);
> +}
> +
> +#endif
> +
> +static inline bool preempt_model_rt(void)
> +{
> +       return IS_ENABLED(CONFIG_PREEMPT_RT);
> +}
> +
> +/*
> + * Does the preemption model allow non-cooperative preemption?
> + *
> + * For !CONFIG_PREEMPT_DYNAMIC kernels this is an exact match with
> + * CONFIG_PREEMPTION; for CONFIG_PREEMPT_DYNAMIC this doesn't work as the
> + * kernel is *built* with CONFIG_PREEMPTION=y but may run with e.g. the
> + * PREEMPT_NONE model.
> + */
> +static inline bool preempt_model_preemptible(void)
> +{
> +       return preempt_model_full() || preempt_model_rt();
> +}
> +
>  /*
>   * Does a critical section need to be broken due to another
>   * task waiting?: (technically does not depend on CONFIG_PREEMPTION,
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 97047aa7b6c2..e2502b8643b4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6638,6 +6638,18 @@ static void __init preempt_dynamic_init(void)
>         }
>  }
>
> +#define PREEMPT_MODEL_ACCESSOR(mode) \
> +       bool preempt_model_##mode(void)                                          \
> +       {                                                                        \
> +               WARN_ON_ONCE(preempt_dynamic_mode == preempt_dynamic_undefined); \
> +               return preempt_dynamic_mode == preempt_dynamic_##mode;           \
> +       }                                                                        \
> +       EXPORT_SYMBOL_GPL(preempt_model_##mode)
> +
> +PREEMPT_MODEL_ACCESSOR(none);
> +PREEMPT_MODEL_ACCESSOR(voluntary);
> +PREEMPT_MODEL_ACCESSOR(full);
> +
>  #else /* !CONFIG_PREEMPT_DYNAMIC */
>
>  static inline void preempt_dynamic_init(void) { }
> --
> 2.25.1
>
