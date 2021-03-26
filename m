Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B018334AF71
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 20:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhCZTne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 15:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhCZTnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 15:43:13 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE3BC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 12:43:11 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id x14so6403356qki.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=HHhZc0H1bcuOq4TqzUAootSodikhHc5QDYvkxIHTcyA=;
        b=s+FFmV0L0va+wE3NphBvm9R8vUztmdr7/GFaR4G8o0CNRWBPCA59EvvaDtsBnxoffP
         2aKRDTLImEeAVsU0zDkmO360ikklji1NsNI5mx7wpEvPhkCffXwjn+bQJmtQyWoYiwtE
         8ZzHP4TDGyl7nRkrbsMpJ5tS3qI0KB7ssW83AnZ2rYt+hEERFt/ZAkvcDduDKbbTSmMC
         TqQML2roOdlxo1tR2TsYz7qLBQPutbAzmQkq4TciuX8GY2S6570spvb99Kxn09VcVqES
         8ItnIfO3A7iyB92s5/fhfKiTWDxfCK4Om2CYoB087QT+ANMDLIpzxr81WrICt8OkYRLm
         iV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=HHhZc0H1bcuOq4TqzUAootSodikhHc5QDYvkxIHTcyA=;
        b=HzKseE06sOxLn+og3zjH/TDJZcLy9SHFPmaAZdtFZt2moEz68APkfM1kcfQFafb4O+
         3rKmasr2CrkJ6pSm3fV4BwyVedd143ZzMIsAHRic9RMhwpPf6+0hDrraj/KoV5MSDXXo
         XWcL23PzjKqET48DH3FruqcUO+Uio/TfBEwjTEaqf1PaXQpPJBPQ0Lsw3TsqpulWaBJv
         hfNqxHuqKHgc5ORjQYi0fUMmwKPhr3kc0wx8EcrxfP0dojBv6+29FMVjQft7T2uh/jXv
         29Ped6wmK+KlgmMpp6URu8w5FIFpANyFFfzFTIIQ/NRG6XTosyhgp9Gz2Gsc3+wPNv4/
         FEfA==
X-Gm-Message-State: AOAM530IiLWxTj6g7w+XanLPp+i+yFFY78yfDL7XxAyO2WzznR4dpYHw
        h89vUMOGCfX6Kh4bk8b7v5o=
X-Google-Smtp-Source: ABdhPJzPFf8Qh7SHGuZQvkuYmwBjfYBiPm1PVgk0NJkcXL+NJKnt/hDBIYYwOkc2qnJub3fWRDn4dQ==
X-Received: by 2002:ae9:ef89:: with SMTP id d131mr14360541qkg.214.1616787790586;
        Fri, 26 Mar 2021 12:43:10 -0700 (PDT)
Received: from Gentoo ([156.146.58.30])
        by smtp.gmail.com with ESMTPSA id g6sm7601461qkd.62.2021.03.26.12.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 12:43:09 -0700 (PDT)
Date:   Sat, 27 Mar 2021 01:12:58 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] sched/psi.c: Rudimentary typo fixes
Message-ID: <YF45Qi+/eB+/m7y/@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
References: <20210326124233.7586-1-unixbhaskar@gmail.com>
 <YF4hMn4rCftcdsSm@cmpxchg.org>
 <20210326184122.GO4746@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SDFWYu1P5+b3sTpU"
Content-Disposition: inline
In-Reply-To: <20210326184122.GO4746@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SDFWYu1P5+b3sTpU
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 19:41 Fri 26 Mar 2021, Peter Zijlstra wrote:
>On Fri, Mar 26, 2021 at 02:00:18PM -0400, Johannes Weiner wrote:
>> On Fri, Mar 26, 2021 at 06:12:33PM +0530, Bhaskar Chowdhury wrote:
>> >
>> > s/possible/possible/
>> > s/ exceution/execution/
>> > s/manupulations/manipulations/
>> >
>> > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> > ---
>> >  kernel/sched/psi.c | 6 +++---
>> >  1 file changed, 3 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>> > index 967732c0766c..316ebc57a115 100644
>> > --- a/kernel/sched/psi.c
>> > +++ b/kernel/sched/psi.c
>> > @@ -59,7 +59,7 @@
>> >   * states, we would have to conclude a CPU SOME pressure number of
>> >   * 100%, since *somebody* is waiting on a runqueue at all
>> >   * times. However, that is clearly not the amount of contention the
>> > - * workload is experiencing: only one out of 256 possible exceution
>> > + * workload is experiencing: only one out of 256 possible execution
>>
>> I thought this was the french spelling.
>>
>> Joking aside, the corrections look right, but I also had no trouble
>> understanding what those sentences mean. Typos happen, plus we have a
>> lot of non-native speakers who won't use perfect spelling or grammar.
>>
>> So for me, the bar is "this can be easily understood", not "needs to
>> be perfect English", and I'd say let's skip patches like these unless
>> they fix something truly unintelligble.
>
>Ignore this robot, lots of people already have a special mail rule for
>him. On top of that, this spelling mistake was already fixed by Ingo in:
>

Dude, this is a human being and you are suggesting a fucking stupid solution
to others. I know what Ingo did and very appreciable. Please try to be
cooperative and help. Stop spreading FUD ...for fuck's sake ...man..

I am not doing it fun...you need to understand that . ...


..and I have some special rule for some people to ...who the fuck care
...ahhhhhhhhhh
> 3b03706fa621 ("sched: Fix various typos")
>
>Which is part of a series of such patches to head off the endless,
>mindless, stream of this.

--SDFWYu1P5+b3sTpU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBeOUIACgkQsjqdtxFL
KRUVjgf/e+4xxxk4mWEHE2fLi0PaDPg8dG4Zq//UJkxr0ikJzmq8pDFtV6/zt60G
hbl/PkwbMBUdJT++8H+GftBikb5IcCVDd7I4LxOlI08saN8mmCgufl1iraydjgjH
v5xBrAEytLoBoxs2erRAXUvIT0kuGRk2uvdO/gUEoD5IseZzvWcjrU1FP3ZqL4a6
V2bhAvvjLtxbGjzxh6tWbtA/HiQf9Cgp1xCD03Pvo1L0CAbXqnp3lOMSQiMKEpe+
Q0KvGSXA9IvyU09cwuJiUhypPSK8jIC+E9mS2qyxxtisJTV+XT8jTIRgJZaTcl1q
8nrbShao7j2otEYa5c2ctbY/aAlgoQ==
=zHfV
-----END PGP SIGNATURE-----

--SDFWYu1P5+b3sTpU--
