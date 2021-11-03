Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B7344402B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 11:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhKCKxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 06:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhKCKxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 06:53:51 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A27C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 03:51:15 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u18so2899018wrg.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 03:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=from:to:cc:references:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gMAIe/HpbfVHf2ikO37SjLuvm/DSngUkGE0Cmmhrzj4=;
        b=lZZcQ0/lo1xHou8Eq1OfN8n9dE7+QrGNGNTxYQJioSe6GWQ4M4LiceK2bxvs7flb2k
         5aHpHrYvwr/u/k04JLJaMKRbx5W916Dh8DX+AAfMJIWuz8efpm7VWriei+2Wrxb26e5Z
         oUHhc1t9/mTqw9svduOJblDGg5XMZfvwRyErdNJmNNQz8yBl/J+wi2HuTE2VCl0AcsOD
         ZZPpiPGBRR8A8lumqUbPS0lnW4Uh1alE9a/FlThYwedKOd0jelr0Cqu/jisl4esFptjU
         hmtie1YtMh16lW59BxFb7PZz2C+txroyD546PGXFkrM7FVL2ZG8hzPb/iqdNd0IhDbL1
         VtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:references:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gMAIe/HpbfVHf2ikO37SjLuvm/DSngUkGE0Cmmhrzj4=;
        b=iSzb9wuOTjDh5aTf6PQB/whWEMgGQXCvXLpqZS/y9jP+GDd8uJFdC0T/Z0uefxlZkK
         qc/VlRUBI8Ij0/0XSbw6xi4ifHB9uybbelJ9O85wci/IuGlqN3uBXGKV5dDuvwRTy93q
         cGGt1VOXPwSQoF2ebzCyKfmO5i4MguDKwyeEtWCtN7FwnwrW05DER9x9KB2/lKXbKINI
         rNNneMVGUZH3W6mhyaJ7CE79+8ir2/6cmarzu9G1zJI2VH23ZDe4wnmXiG4cwnWb4Ye8
         UJR5pd14aNXQM8Pdo/kssBlr8sxFcdrU8DGABsVZTse66e3gM9nnFO2a0oq5Y+U/KSJp
         Obng==
X-Gm-Message-State: AOAM533oB7qQlBsoXbP8wSMQd6UACS6ILfQhp6tF6qtr0X4RTWoWhvEP
        hdPDngJMu+Dw2IZKpe1dsQRkN1CCloxCp4cl
X-Google-Smtp-Source: ABdhPJwQi7inBWUBX7kwZRGQ3UU06CEudfTEShvsMfF79NwzPh4ZWH0AMju5ClFjhwcoRPu8hvVo7Q==
X-Received: by 2002:a5d:64e2:: with SMTP id g2mr55066359wri.253.1635936673469;
        Wed, 03 Nov 2021 03:51:13 -0700 (PDT)
Received: from [192.168.24.132] (pd9fe9a3e.dip0.t-ipconnect.de. [217.254.154.62])
        by smtp.gmail.com with ESMTPSA id o12sm1598509wrc.85.2021.11.03.03.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 03:51:13 -0700 (PDT)
From:   Mathias Krause <minipli@grsecurity.net>
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Odin Ugedal <odin@uged.al>
Cc:     Kevin Tanguy <kevin.tanguy@corp.ovh.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20211011172236.11223-1-mkoutny@suse.com>
 <CAKfTPtAQmqgAiNGqk9xRmiB4_dzHxaKK68+fWwea25mZv0kT2w@mail.gmail.com>
 <20211013142643.GA48428@blackbody.suse.cz>
 <20211102160228.GA57072@blackbody.suse.cz>
 <73b4bddb-335b-1f25-a203-199be546e44a@grsecurity.net>
Subject: Re: task_group unthrottling and removal race (was Re: [PATCH]
 sched/fair: Use rq->lock when checking cfs_rq list) presence
Message-ID: <e2bcfc90-18b6-8da5-517c-023d2242ba97@grsecurity.net>
Date:   Wed, 3 Nov 2021 11:51:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <73b4bddb-335b-1f25-a203-199be546e44a@grsecurity.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heh, sometimes a good night sleep helps unfolding the knot in the head!

Am 03.11.21 um 10:51 schrieb Mathias Krause:
> [snip]
> 
> We tried the below patch which, unfortunately, doesn't fix the issue. So
> there must be something else. :(
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 978460f891a1..afee07e9faf9 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9506,13 +9506,17 @@ void sched_offline_group(struct task_group *tg)
>  {
>  	unsigned long flags;
> 
> -	/* End participation in shares distribution: */
> -	unregister_fair_sched_group(tg);
> -
> +	/*
> +	 * Unlink first, to avoid walk_tg_tree_from() from finding us
> +	 * (via sched_cfs_period_timer()).
> +	 */
>  	spin_lock_irqsave(&task_group_lock, flags);
>  	list_del_rcu(&tg->list);
>  	list_del_rcu(&tg->siblings);
>  	spin_unlock_irqrestore(&task_group_lock, flags);
> +
> +	/* End participation in shares distribution: */

Adding synchronize_rcu() here will ensure all concurrent RCU "readers"
will have finished what they're doing, so we can unlink safely. That
was, apparently, the missing piece.

> +	unregister_fair_sched_group(tg);
>  }
> 
>  static void sched_change_group(struct task_struct *tsk, int type)
> 

Now, synchronize_rcu() is quite a heavy hammer. So using a RCU callback
should be more appropriate. I'll hack up something and post a proper
patch, if you don't beat me to.

Mathias
