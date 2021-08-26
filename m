Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466A83F8C9A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 19:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243149AbhHZRBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 13:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbhHZRBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 13:01:38 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7101C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 10:00:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d26so6240694wrc.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 10:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XYb3AsU1mSZdxv9NlAgbla/nP8+WfPQLQ4TnEHlmLLY=;
        b=id6LCVcQxMi4aa/U/qzx0Jb/1IqrGzRR+z9L8vLJKIiHxz3le6+hOXmPk0t3zQIq8u
         P+Mpl6IWI39iMMpcWgzAqgNn+VHkZx3OYKf2a4CQa9pMUMD5KPPmrLXvCn11tXtsePjt
         kuh5uh4dyWHB8xlX64Ju1ZbELuHcSM/P6lb+cU2VTfaflR2RNUBoi1yrGiAaB2GwtiNG
         8RsIXT+lhNw9RLDuyXA8lszXQajN7GJiRB141OmA+0gQRaIdQUQbA0OqQ85FXBSzenSJ
         8cUVlpmXsYT1M89Ch37QlwRY3MHPtVnE1WLPWpnWbRCgjfgpkADdxg1Uq8Vvae8SR9GV
         pnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XYb3AsU1mSZdxv9NlAgbla/nP8+WfPQLQ4TnEHlmLLY=;
        b=EohpMExuihNQJieekhiO66cOnPue+LPzkQ1GuwEej5tQ9NqtqBfS7pHNmT2n0TGDfw
         GzI1oehqCXVvmnQkGiQTRsTHYaJv1bzYfsJCSBi92DPpEhVyy8TdMLOu6NJREkXEk7A6
         7HWY8H//l9dnXyLCdoXK+JJoTSWSDldBtlCMJb+5K7FqZIenxgKHWPcJY09Ye8LmUwty
         dWlwqNoYpJgYRxzaZFkpFxmDo7Cvx7tC28Mo5/AtgOpaEuEVjgyC6AmbGnBg5Ppygfa5
         NeQtD9CW0Hf6VnJsRssp4OdztKUCCZeCj+G5Lkzc6nz0QbeKGG7Bv0J3XRkD6dB5xjhi
         cTCQ==
X-Gm-Message-State: AOAM5315hhZWtElorH2HoWKjoS93Ag8P7vClbrDQwHMHA9cyoGZ8FCKP
        gtANzl4SI+qarLA474JHIyhk6Q==
X-Google-Smtp-Source: ABdhPJwgfcQtXUSgDk5SlLHvkrnGI15ErMlobM+zjslsBIhtkGj1V8Q1f3IJHgdF8faNFHnARznCUg==
X-Received: by 2002:adf:c513:: with SMTP id q19mr4797708wrf.20.1629997249285;
        Thu, 26 Aug 2021 10:00:49 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id t5sm2552698wra.95.2021.08.26.10.00.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Aug 2021 10:00:48 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 4/4] block, bfq: consider request size in
 bfq_asymmetric_scenario()
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20210806020826.1407257-5-yukuai3@huawei.com>
Date:   Thu, 26 Aug 2021 19:00:47 +0200
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <8601F280-2F16-446A-95BA-37A07D1A1055@linaro.org>
References: <20210806020826.1407257-1-yukuai3@huawei.com>
 <20210806020826.1407257-5-yukuai3@huawei.com>
To:     Yu Kuai <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 6 ago 2021, alle ore 04:08, Yu Kuai <yukuai3@huawei.com> ha =
scritto:
>=20
> There is a special case when bfq do not need to idle when more than
> one groups is active:
>=20

Unfortunately, there is a misunderstanding here.  If more than one
group is active, then idling is not needed only if a lot of symmetry
conditions also hold:
- all active groups have the same weight
- all active groups contain the same number of active queues
- all active queues have the same weight
- all active queues belong to the same I/O-priority class
- all dispatched requests have the same size

Similarly, if only one group is active, then idling is not needed only
if the above last three conditions hold.

The current logic, including your changes up to your previous patch,
is simply ignoring the last condition above.

So, unfortunately, your extra information about varied request size
should be used in the opposite way than how you propose to use it.

Thanks,
Paolo

> 1) all active queues have the same weight,
> 2) all active queues have the same request size.
> 3) all active queues belong to the same I/O-priority class,
>=20
> Each time a request is dispatched, bfq can switch in service queue
> safely, since the throughput of each active queue is guaranteed to
> be equivalent.
>=20
> Test procedure:
> run "fio -numjobs=3D1 -ioengine=3Dpsync -bs=3D4k -direct=3D1 =
-rw=3Drandread..." in
> different cgroup(not root).
>=20
> Test result: total bandwidth(Mib/s)
> | total jobs | before this patch | after this patch      |
> | ---------- | ----------------- | --------------------- |
> | 1          | 33.8              | 33.8                  |
> | 2          | 33.8              | 65.4 (32.7 each job)  |
> | 4          | 33.8              | 106.8 (26.7 each job) |
> | 8          | 33.8              | 126.4 (15.8 each job) |
>=20
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> block/bfq-iosched.c | 13 ++++++++++++-
> 1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 7df3fc0ef4ef..e5a07bd1fd84 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -268,6 +268,16 @@ static struct kmem_cache *bfq_pool;
>  */
> #define BFQ_RATE_SHIFT		16
>=20
> +/*
> + * 1) bfq keep dispatching requests with same size for at least one =
second.
> + * 2) bfq dispatch at lease 1024 requests
> + *
> + * We think bfq are dispatching request with same size if the above =
two
> + * conditions hold true.
> + */
> +#define VARIED_REQUEST_SIZE(bfqd) ((bfqd)->dispatch_count < 1024 ||\
> +		time_before(jiffies, (bfqd)->dispatch_time + HZ))
> +
> /*
>  * When configured for computing the duration of the weight-raising
>  * for interactive queues automatically (see the comments at the
> @@ -724,7 +734,8 @@ static bool bfq_asymmetric_scenario(struct =
bfq_data *bfqd,
> 	bool multiple_classes_busy;
>=20
> #ifdef CONFIG_BFQ_GROUP_IOSCHED
> -	if (bfqd->num_groups_with_pending_reqs > 1)
> +	if (bfqd->num_groups_with_pending_reqs > 1 &&
> +	    VARIED_REQUEST_SIZE(bfqd))
> 		return true;
>=20
> 	if (bfqd->num_groups_with_pending_reqs &&
> --=20
> 2.31.1
>=20

