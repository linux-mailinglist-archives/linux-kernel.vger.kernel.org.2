Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09DF34AF6D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 20:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCZTkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 15:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhCZTkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 15:40:11 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F1EC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 12:40:11 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id y18so6387942qky.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 12:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=lKfOyLCVjbHs1Ab/RB7KSnKCc/W4r3mLxRkus0LCKtY=;
        b=dVP9BnaDUsFWcr+Srf69Cbr1D3k1uS4mqMNecyArvF8Zj4Z78L6ARHZaeqmhMPzK6K
         7CCuvOgYR9ufk/kQ4V3cykaA6a0Ha6nL0LwuvbHGHA9MENbPPz7oELSJCdEq87VnxG2e
         bgSJzEwXS5Ljn8ytkpuvBgAZs9diDuGPpFpWYRiMpnq7ctdpf3GPkq+5fP13odWtYUEo
         RtfoLIbeQAsmtdK8hXtnS1UC37KM2g0tFTUuBgczVcqk5Db0vkZG/xioTFVKE38HFsfl
         snu/BBoAXlwIDVX4E1QxwLcXxMsf2V1Xd4kYs8/5jhspj0Uhl6te1WdxYr72avt7Qgr2
         E2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=lKfOyLCVjbHs1Ab/RB7KSnKCc/W4r3mLxRkus0LCKtY=;
        b=TNGEDH9rYXVEWWwlvS5iV2h72OH9t/cYsa7JwCi7UIFzYqgSw7gZAn/4/eFl5+R9PD
         F2v8FU1hv8P2w9V2u4Bg/uPXZ5iiPYX71ocmdZUki6WT/Pd/mrqQt3GBplVMMqpqf9xC
         leVoHpM9JSYFHHZHVuINQjSdh5m+mALqRC5N3L+0ji1wKxah6xclsHzkUxHxNjYrV/OK
         LAe87Jx3hFUfs0CclAc4H0a3FudBYD8jCZDa5GO0YdmSVKZJohK5UuJ8Vj3Ct3J2KlVA
         vfbPo9FWOy7o3dFDuggxUiaaoK3nVPtlVSCEqoMJuhD5ien4AW2WSQ0SA9W1qmlzArI3
         RxVg==
X-Gm-Message-State: AOAM530T6W5llT7OM3a72YBBhyIjUYctP5OwQwrBrwxeKwuRr0C4m1L5
        SP+qPGyHrwELyndeeouCIvI=
X-Google-Smtp-Source: ABdhPJx7MhcetMeYD379FQcIKoLTpar5GGQep3CgZ3yDC/j67fuwShMt/kNNupPDPVbkWxk7ZuNabQ==
X-Received: by 2002:a37:638f:: with SMTP id x137mr14356910qkb.199.1616787610561;
        Fri, 26 Mar 2021 12:40:10 -0700 (PDT)
Received: from Gentoo ([156.146.58.30])
        by smtp.gmail.com with ESMTPSA id n24sm5896935qtr.21.2021.03.26.12.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 12:40:09 -0700 (PDT)
Date:   Sat, 27 Mar 2021 01:09:58 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] sched/psi.c: Rudimentary typo fixes
Message-ID: <YF44jiYiAVkuwE0P@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
References: <20210326124233.7586-1-unixbhaskar@gmail.com>
 <YF4hMn4rCftcdsSm@cmpxchg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cDW3VKXgXHD/EH0o"
Content-Disposition: inline
In-Reply-To: <YF4hMn4rCftcdsSm@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cDW3VKXgXHD/EH0o
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 14:00 Fri 26 Mar 2021, Johannes Weiner wrote:
>On Fri, Mar 26, 2021 at 06:12:33PM +0530, Bhaskar Chowdhury wrote:
>>
>> s/possible/possible/
>> s/ exceution/execution/
>> s/manupulations/manipulations/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  kernel/sched/psi.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>> index 967732c0766c..316ebc57a115 100644
>> --- a/kernel/sched/psi.c
>> +++ b/kernel/sched/psi.c
>> @@ -59,7 +59,7 @@
>>   * states, we would have to conclude a CPU SOME pressure number of
>>   * 100%, since *somebody* is waiting on a runqueue at all
>>   * times. However, that is clearly not the amount of contention the
>> - * workload is experiencing: only one out of 256 possible exceution
>> + * workload is experiencing: only one out of 256 possible execution
>
>I thought this was the french spelling.
>
>Joking aside, the corrections look right, but I also had no trouble
>understanding what those sentences mean. Typos happen, plus we have a
>lot of non-native speakers who won't use perfect spelling or grammar.
>
>So for me, the bar is "this can be easily understood", not "needs to
>be perfect English", and I'd say let's skip patches like these unless
>they fix something truly unintelligble.
>

OH gosh! For fuck's sake please don't misinterpret. I have had no intension to
pick on others hard work. I was just merely trying to make other work good and
beautiful.



--cDW3VKXgXHD/EH0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBeOIsACgkQsjqdtxFL
KRXipAgArCDPpFXWIPeqPZAyfcqbwR4/E/UKss3k3/3rLA1XrRwMMY46JMhmCTBD
qsbZhhr5cDqvPiT1ucfGFZtzgbpb0drKpUp8GsKGrMFwkfaYelOe4ipb4FHw8f34
JYF1LGxbKzJpmYmGCXYQ7evILoodulvR9dY9iC23WLNn8ewZUU+0WlnDhQDX8o8i
wOPEndy/sqOdi0yKdi1jNgxZw6bi1uFhAnn3w5+CMrxpwNtdebIOcOcx7RdA8Gra
GrX97/Raj5R2hRv6yElOTcjbLm6r2Z7TH+Ti+Yr1IOxAiA52Or4mIkQyLwtFNMUp
GV90YswuX3s1NmbsNgZOw1CGDUfYDQ==
=TGa0
-----END PGP SIGNATURE-----

--cDW3VKXgXHD/EH0o--
