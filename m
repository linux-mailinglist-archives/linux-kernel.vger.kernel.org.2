Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454E73A1DE0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 21:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhFIT7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 15:59:25 -0400
Received: from mail-yb1-f182.google.com ([209.85.219.182]:45019 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhFIT7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 15:59:24 -0400
Received: by mail-yb1-f182.google.com with SMTP id p184so37191455yba.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 12:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KZqRAoGYo1BENB9HubvimN8Y/+cn3PuH69zPYdjQx3o=;
        b=hirZ/loS4K2vdyputFDRMEhTuR9bvXOISZO5bgbio6FAVoV3ba8p2sGFISfYa9bA35
         U66n8UD9fKar8yQKhbE+6y8KILTM1u5q1CdEsQJueqObRlPswFndBwx40Xrf+UgscWT5
         P/1kc/lXulx17fc3TgtHMpd0gY9AAQtBHIc30kecERdpcAtdVyIUxKs70KOezoER8qtz
         Ji0SLp8ekpxVOQ0cjxpZOnf5C6K9oQNhff6ZFGSbmVzdBzzdHIkAz2ZIBoakTf1FUgLc
         E+wj0XAn3AxMNXDXl389ltNlqIi7/pVQnNueS59eQQkMOw7DpjWLin/N1d664U5VnZV0
         wwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KZqRAoGYo1BENB9HubvimN8Y/+cn3PuH69zPYdjQx3o=;
        b=oLPA/y9Ahxakb8ERMgNCGyNrOfyqV3kVmuwB8tzemo9KuTM2mTj5I5YNhr3T5IvoFc
         t1fogQK6JuFkNUaZhzC8pOi8AozK1QueX+mhq61/+5T1xxhpccsim/S4DLD2vp8NY/aF
         W2Jd0ZmzMrFIB+jn4QrrJy4ygAyfLczNjmQ0etrbxF/9lqsnSAneCFujH0CZT1chSr+4
         wEX9vlI9Af0M8TrYnM9WRewfZkeVUGeqFoWI/rbegrusZI6o1MOiM0zeIBYY1w+6VOxe
         Dr4PBY2Ocfe0Vn6FEspU5n2NUbb5iRwMNmVe7b1L0r3TSp5syozTBaUYAfy1marZkegT
         Sepw==
X-Gm-Message-State: AOAM533wBvGDSguraQiS25Bc0jTE/ny5posWO/0hN/rSC7yccppcDbrb
        vqc1Vv46DYx9RQJozGevFvpdNAjNANp1biLtehQeSA==
X-Google-Smtp-Source: ABdhPJxZRb4gdCduBzzwvvchZcTffPUf81qT2AJUc7y3yhJAv6CtcBzATfEhvI7SkVQLV64xk093zYjUJecSJ9ICqAw=
X-Received: by 2002:a25:1005:: with SMTP id 5mr2100905ybq.294.1623268572464;
 Wed, 09 Jun 2021 12:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210609150437.3473855-1-weiyongjun1@huawei.com>
In-Reply-To: <20210609150437.3473855-1-weiyongjun1@huawei.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 9 Jun 2021 12:56:01 -0700
Message-ID: <CAJuCfpGTOthDz7a=n=zjaeuwoL7c6=b47TyuPMm7NKcPLAAgAA@mail.gmail.com>
Subject: Re: [PATCH -next] psi: Make symbol 'psi_cgroups_enabled' static
To:     Wei Yongjun <weiyongjun1@huawei.com>, Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 9, 2021 at 7:54 AM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> The sparse tool complains as follows:
>
> kernel/sched/psi.c:151:1: warning:
>  symbol 'psi_cgroups_enabled' was not declared. Should it be static?
>
> This symbol is not used outside of psi.c, so marks it static.
>
> Fixes: 3958e2d0c34e ("cgroup: make per-cgroup pressure stall tracking configurable")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks for reporting!

Tejun, how would to like this to be fixed? Will you take this patch as
is, roll it into my change which introduced this warning
(https://lore.kernel.org/patchwork/patch/1435705/) or would you prefer
me to resent the original patch with this fix?


> ---
>  kernel/sched/psi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index b773cae4c24b..d6e32de2f6af 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -148,7 +148,7 @@
>  static int psi_bug __read_mostly;
>
>  DEFINE_STATIC_KEY_FALSE(psi_disabled);
> -DEFINE_STATIC_KEY_TRUE(psi_cgroups_enabled);
> +static DEFINE_STATIC_KEY_TRUE(psi_cgroups_enabled);
>
>  #ifdef CONFIG_PSI_DEFAULT_DISABLED
>  static bool psi_enable;
>
