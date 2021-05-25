Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC533390297
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 15:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbhEYNft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 09:35:49 -0400
Received: from foss.arm.com ([217.140.110.172]:56204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233299AbhEYNfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 09:35:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AFC01042;
        Tue, 25 May 2021 06:34:18 -0700 (PDT)
Received: from [10.57.2.8] (unknown [10.57.2.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CBEC3F719;
        Tue, 25 May 2021 06:34:15 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] PM / EM: Skip inefficient OPPs
To:     Quentin Perret <qperret@google.com>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, dietmar.eggemann@arm.com
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <1621616064-340235-4-git-send-email-vincent.donnefort@arm.com>
 <YKzETaPD/Flnz+dz@google.com>
 <20210525094601.GB369979@e124901.cambridge.arm.com>
 <f8a2bbde-47c4-bd7d-96fa-228c9d9e2779@arm.com> <YKz2bz6EiLwISOVV@google.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <d21e69fd-9da5-3e5d-662c-c753b581cab0@arm.com>
Date:   Tue, 25 May 2021 14:34:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <YKz2bz6EiLwISOVV@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On 5/25/21 2:06 PM, Quentin Perret wrote:
> Hi Lukasz,
> 
> On Tuesday 25 May 2021 at 12:03:14 (+0100), Lukasz Luba wrote:
>> That's a few more instructions to parse the 'flags' filed. I'm not sure
>> if that brings speed improvements vs. if we not parse and have bool
>> filed with a simple looping. The out-of-order core might even suffer
>> from this parsing and loop index manipulations...
> 
> I'm not sure what you mean about parsing here? I'm basically suggesting
> to do something along the lines of:

I thought Vincent was going to re-use the 'flags' for it and keep it for
other purpose as well - which would require to parse/map-to-feature.
That's why I commented the patch earlier, pointing out that we shouldn't
prepare the code for future unknown EM_PERF_STATE_*. We can always
modify it when we need to add another feature later.

> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index daaeccfb9d6e..f02de32d2325 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -128,13 +128,11 @@ struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,
> 
>          for (i = 0; i < pd->nr_perf_states; i++) {
>                  ps = &pd->table[i];
> -               if (ps->flags & EM_PERF_STATE_INEFFICIENT)
> -                       continue;
>                  if (ps->frequency >= freq)
>                          break;
>          }
> 
> -       return ps;
> +       return &pd->table[ps->next_efficient_idx];
>   }
> 
> What would be wrong with that?

Until we measure it, I don't know TBH. It looks OK for the first glance.
I like it also because it's self-contained, doesn't require parsing,
doesn't bring any 'generic' variable.

Regards,
Lukasz

> 
> Thanks,
> Quentin
> 
