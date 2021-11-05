Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E921D44657A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 16:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbhKEPL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 11:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbhKEPL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 11:11:26 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907C1C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 08:08:46 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id q74so23513266ybq.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 08:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j33KrwjkN+z1uaFwNqXLFBS987taWab4KSTbR7zl0nQ=;
        b=EgBQdFR0adjN8m+uR+wwu1bg46u/fl5WzZ8pQjop9UQiygnlXUvbxnS8E3ZtREyLX8
         dT9p9m2aEHfUpzb6QQr81RX8V99xQXf1BHd7kw1N2dZbs0zRJ27HEmstoHQPGk4+egy2
         AkIrZMOo9oepmLzL100IkPR1eTAAlTMba3dzmhGi6LEcDD1aUtlbDJkYIqbkBCFaOqlo
         AGBmTyrBc5y8/hd4QtlUaSGPG0Ndwrb7tLn8vqk0mUwuWUsatqfItyHOflrXR2PDLdbU
         7owI+ak0q0WuqNh+M8qQAuC02NQIxqtRPUqJ0G/4mGfzR/ctU4LL1AxCaqI6RG1PUJnQ
         wJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j33KrwjkN+z1uaFwNqXLFBS987taWab4KSTbR7zl0nQ=;
        b=TtB2ugrGryKOxfJv+M/xvIOvYUtKrpQ527kSjGG1vUAjLrTVD7ihIAfmn3DKq16Syw
         tfLGk7+wZuo2eS9KiD6zfrmuu/tbLGSqYI8iuc4IPTz2iOKRPuOmowkxMOTm9IVXV8M+
         VCZZe61Kzen6H1wa0Fxoi8MYfEh8Dyh90xHHdCMI1Y+XvZ/QnF6jaOrOgyYMlTFB1CFD
         gP4SWfIkWzXdKYoZggrGjbn+UJVzv7S0+w8h+wxyfb9nO3vrI2j5RhXiO0uZEXNM7rHv
         oYxiCHFc2RnqkJzWW+h5nNlqcsOwBEhoijHxOpLUHBPp6J3mfSdkHYRmICBK9XOmfmGY
         kD/A==
X-Gm-Message-State: AOAM5323d99GMZouE7QlPfSX6c/zeRxLBNgZJBb5jgv8q7uRDtXoHaV5
        IrgaEp7kilEBVOS9MONSppKYOMT6o78SVRnb9CgHFQ==
X-Google-Smtp-Source: ABdhPJx+pUt6t2KemLV43OWTxuZkEHavKAFZU/9i35Ko2oGt9Wn5eg4smtCo0L/S9EdLjtgacHDK97VI9Hmw2VA7EAw=
X-Received: by 2002:a25:10c1:: with SMTP id 184mr59679168ybq.245.1636124924724;
 Fri, 05 Nov 2021 08:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211104175120.857087-1-vincent.donnefort@arm.com>
In-Reply-To: <20211104175120.857087-1-vincent.donnefort@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 5 Nov 2021 16:08:33 +0100
Message-ID: <CAKfTPtAQTCqhbaW90EiyerPM2x-==cX3Xodq+nAymVK_U=45vA@mail.gmail.com>
Subject: Re: [PATCH] sched/core: Mitigate race cpus_share_cache()/update_top_cache_domain()
To:     Vincent Donnefort <Vincent.Donnefort@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        Valentin.Schneider@arm.com, jing-ting.wu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Nov 2021 at 18:52, Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> Nothing protects the access to the per_cpu variable sd_llc_id. When testing
> the same CPU (i.e. this_cpu == that_cpu), a race condition exists with
> update_top_cache_domain(). One scenario being:
>
>               CPU1                            CPU2
>   ==================================================================
>
>   per_cpu(sd_llc_id, CPUX) => 0
>                                     partition_sched_domains_locked()
>                                       detach_destroy_domains()
>   cpus_share_cache(CPUX, CPUX)          update_top_cache_domain(CPUX)
>     per_cpu(sd_llc_id, CPUX) => 0
>                                           per_cpu(sd_llc_id, CPUX) = CPUX
>     per_cpu(sd_llc_id, CPUX) => CPUX
>     return false
>
> ttwu_queue_cond() wouldn't catch smp_processor_id() == cpu and the result
> is a warning triggered from ttwu_queue_wakelist().
>
> Avoid a such race in cpus_share_cache() by always returning true when
> this_cpu == that_cpu.
>
> Fixes: 518cd6234178 ("sched: Only queue remote wakeups when crossing cache boundaries")
> Reported-by: Jing-Ting Wu <jing-ting.wu@mediatek.com>
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

 Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f2611b9cf503..f5ca15cdcff4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3726,6 +3726,9 @@ void wake_up_if_idle(int cpu)
>
>  bool cpus_share_cache(int this_cpu, int that_cpu)
>  {
> +       if (this_cpu == that_cpu)
> +               return true;
> +
>         return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
>  }
>
> --
> 2.25.1
>
