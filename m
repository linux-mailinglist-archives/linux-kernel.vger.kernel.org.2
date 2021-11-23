Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162F1459D28
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 08:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhKWHyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 02:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbhKWHyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 02:54:15 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B406CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 23:51:07 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso32558929otf.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 23:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rR4B622+i9Ys9aZnitq1fCVmk8hfdVagcPZ0hfODFqc=;
        b=owRjYh+4B/5zl9PKK737xyc1gi0E5KflM/Q4OkJCkuFOgFFkGPoNIc9Kw33wBYVcH2
         0/i+lcshYxh3pXsR4NSF+nZENi7LaHPx46V+8TAuFbFdVsQkCVMqF7iCDc0+k48avC6N
         iCzTJAKFZVHxXDp6spC5Xhv+I5EWjEsUIvkSPsEAsnPxQlkHTqrzYc9XsDQITaMr/zGf
         pnhE4ScuQIdPtNxT9EC5uKW31SDwnTuRHh2M4Qtap7UxPgpu9JdxreHRcrXGxIrU38sT
         Yv3QV5js2QwZQJOxLxTuJFEJMh8eqmjJq9FBydyn+oGbRatLC/+x1w3DzSS1XpoHAeNW
         cruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rR4B622+i9Ys9aZnitq1fCVmk8hfdVagcPZ0hfODFqc=;
        b=qMOaJhl3DBuqxgPin1PoI/Tz2l6r0cTv57hzGCX6J8NL/xC4azX6aUjpwyj8Txp6Mf
         notXFESsszIOB4ny06ZS3mn3LpjNjOy5DQxN1iy/Aw0Ft8j5ugdbnfAUF3vqCz/70OYU
         +hhX/Li41xSPgoFXc1yTDY9CcN/0F66gJuZ0f/Zzd7Peeh3dp9YeJmwt0ZUWp/Knvnma
         pU+UL20X5esuQEi8ktv7beA/7MG0ugXo3TxuJpaUMv5sHruyYhO9n9WZBlt6rml4wzX5
         D8ElTXY8An9SxtwppfODRMBYUlzp/N5dYUPHAivmhIp77kzmvQdOL+eGVOZ5+Z3NuteW
         KrhQ==
X-Gm-Message-State: AOAM533KFOse5tWUXX2EcWXYlcz7gVcoN0RHxuelT69EWwHzKHQjwgA1
        mbTyvqENFgLc4KrgXWUeYSX1j5RNmSuRxuQvhork3g==
X-Google-Smtp-Source: ABdhPJwYYIBg4f36PR3CHkgvf63SbiJJ6fLqj/C6mSHj5dv4FTy7xpBnF0TwRN2GWlMG4pE2VDTasnzp3OXbCAI09FI=
X-Received: by 2002:a05:6830:1356:: with SMTP id r22mr2498846otq.196.1637653866804;
 Mon, 22 Nov 2021 23:51:06 -0800 (PST)
MIME-Version: 1.0
References: <20211123051658.3195589-1-pcc@google.com> <20211123051658.3195589-2-pcc@google.com>
In-Reply-To: <20211123051658.3195589-2-pcc@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 23 Nov 2021 08:50:55 +0100
Message-ID: <CACT4Y+bNA7NocP_wG+FKVPKEygWWbq4E0Zrw5bn47KvCwgQXAg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] fs: use raw_copy_from_user() to copy mount() data
To:     Peter Collingbourne <pcc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Colin Ian King <colin.king@canonical.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 at 06:17, Peter Collingbourne <pcc@google.com> wrote:
>
> With uaccess logging the contract is that the kernel must not report
> accessing more data than necessary, as this can lead to false positive
> reports in downstream consumers. This generally works out of the box
> when instrumenting copy_{from,to}_user(), but with the data argument
> to mount() we use copy_from_user() to copy PAGE_SIZE bytes (or as
> much as we can, if the PAGE_SIZE sized access failed) and figure out
> later how much we actually need.
>
> To prevent this from leading to a false positive report, use
> raw_copy_from_user(), which will prevent the access from being logged.
> Recall that it is valid for the kernel to report accessing less
> data than it actually accessed, as uaccess logging is a best-effort
> mechanism for reporting uaccesses.
>
> Link: https://linux-review.googlesource.com/id/I5629b92a725c817acd9a861288338dd605cafee6
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> ---
>  fs/namespace.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 659a8f39c61a..695b30e391f0 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3197,7 +3197,12 @@ static void *copy_mount_options(const void __user * data)
>         if (!copy)
>                 return ERR_PTR(-ENOMEM);
>
> -       left = copy_from_user(copy, data, PAGE_SIZE);
> +       /*
> +        * Use raw_copy_from_user to avoid reporting overly large accesses in
> +        * the uaccess buffer, as this can lead to false positive reports in
> +        * downstream consumers.
> +        */
> +       left = raw_copy_from_user(copy, data, PAGE_SIZE);

This will skip KASAN/etc checks as well, right? I guess it is fine b/c
this affects just this place and the code looks safe (famous last
words :)) and we can refine it in future.
But I wonder about false positives under KMSAN. However, we probably
can add an explicit KMSAN annotation to mark it as initialised.
Alex?

>         /*
>          * Not all architectures have an exact copy_from_user(). Resort to
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>
