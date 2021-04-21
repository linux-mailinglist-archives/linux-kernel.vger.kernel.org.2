Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7C6366D69
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242008AbhDUOA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbhDUOAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:00:25 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907F1C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 06:59:52 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso16532647otl.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 06:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ojaZEJIsv8ujX9Ndfl290AF0sng1kMHpf6JRlQJX1FA=;
        b=DSVCS4qhhj1LeqnBJPJzjthT+qvuny4MBjIpXIjq0nbKa67gSSoe6qV52+B1DdXX8w
         zS37wHN2hFFxNpwX8KvsAPPcI/luWfI7bIUAICamMqioq+mDkmnOSMIKEQe1RP+GQeh1
         7bxTZR0/6yOzPd4iRfS1M3wAdlqRlkcRX51PPdeQrsF6VVEa8n6nk03N5iXAcyqyK4lw
         NNKh4SLMbLLpjFih6HckbDWZ5RkmSs/FkD21qSVoKulFG/pqP3GMukh32kKO715y/Nft
         re+dxF9tz4cBcZ0lRUe4WRwM8z5E0LHYJjVwE3iN9tj31km0WpIPozm+TAl442b2bNjU
         b08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ojaZEJIsv8ujX9Ndfl290AF0sng1kMHpf6JRlQJX1FA=;
        b=hI8oqovLbRNF4YUTYTBjSpmrxwqTt0Ls3bXbAVAHtyQoSb8rfjvgKjXp0LCt7n+3rC
         M82pjVAFLrzmKW+dPEgJU2pwck5MwUGprGOsdcWC7jVbOlKystFPzOrI+OGSXk5HMCvq
         FRfec+jjw/8bY+dB2aKoyCm5gkfDhAQAOQEyuZHd3J30FBnNy51cFUmcUKqh/q48y4KO
         F2mAvzT1syfL7hGx0wRDQOVeApuXiumfefGogejbs58qn/JMWkq80p8Qbqhf0SvgNQ2E
         mbsQuqzMFOUl3YZdUp/30NKeeu9kDke6271l2e99+EMdzJRj+bKx1LRvOp9sugmjUcjO
         D0hw==
X-Gm-Message-State: AOAM530Z+Ni/i3/rOAprPzRYPAlfRCKnRi7e69WGG1NBcuODInJJWRAm
        OKeLcZMMsXEtMdujvQTiqnv9By9NQS7EppPkDbV13A==
X-Google-Smtp-Source: ABdhPJxAjly8gw/Xl7DUDWkXezmp2Yi+R2D7LDRjv1FOAjGGgSQ6OfjIxyegEOb22bIZRIjJdcZC5Ut2dPKtOFnBx1E=
X-Received: by 2002:a9d:1ea9:: with SMTP id n38mr18788241otn.233.1619013591799;
 Wed, 21 Apr 2021 06:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210421135059.3371701-1-arnd@kernel.org>
In-Reply-To: <20210421135059.3371701-1-arnd@kernel.org>
From:   Marco Elver <elver@google.com>
Date:   Wed, 21 Apr 2021 15:59:40 +0200
Message-ID: <CANpmjNM81K-3GhDmzUVdY32kZ_5XOwrT-4zSUDeRHpCs30fa1g@mail.gmail.com>
Subject: Re: [PATCH] kcsan: fix printk format string
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        David Gow <davidgow@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021 at 15:51, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Printing a 'long' variable using the '%d' format string is wrong
> and causes a warning from gcc:
>
> kernel/kcsan/kcsan_test.c: In function 'nthreads_gen_params':
> include/linux/kern_levels.h:5:25: error: format '%d' expects argument of type 'int', but argument 3 has type 'long int' [-Werror=format=]
>
> Use the appropriate format modifier.
>
> Fixes: f6a149140321 ("kcsan: Switch to KUNIT_CASE_PARAM for parameterized tests")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Marco Elver <elver@google.com>

Thank you!

Normally KCSAN patches go through -rcu, but perhaps in this instance
it should be picked up into -tip/locking/core directly, so it goes out
with "kcsan: Switch to KUNIT_CASE_PARAM for parameterized tests".
Paul, Ingo, do you have a preference?

Thanks,
-- Marco

> ---
>  kernel/kcsan/kcsan_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> index 9247009295b5..a29e9b1a30c8 100644
> --- a/kernel/kcsan/kcsan_test.c
> +++ b/kernel/kcsan/kcsan_test.c
> @@ -981,7 +981,7 @@ static const void *nthreads_gen_params(const void *prev, char *desc)
>                 const long min_required_cpus = 2 + min_unused_cpus;
>
>                 if (num_online_cpus() < min_required_cpus) {
> -                       pr_err_once("Too few online CPUs (%u < %d) for test\n",
> +                       pr_err_once("Too few online CPUs (%u < %ld) for test\n",
>                                     num_online_cpus(), min_required_cpus);
>                         nthreads = 0;
>                 } else if (nthreads >= num_online_cpus() - min_unused_cpus) {
> --
> 2.29.2
