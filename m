Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C29644C286
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 14:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhKJN4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 08:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhKJN4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 08:56:20 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD3CC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 05:53:33 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id y196so2231664wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 05:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=Vr45SFc+9+udJetnkqyd71Q/qqzbM6ere0fs3nkFeUo=;
        b=d2H+dANySdmhGfqgAi+7Pd5snllScX7vRx7iN9/BWErIqk4SNhMoummg4iDN2FRD6d
         201afSmUDjUGvzU3Cv+2UMFlL7lTCxbvaHJR4IP/QoPujMuiQWMDv5ltAAErYm3qTzqZ
         7UmkPZ/lUxWYP07NRE3bHt2stIcEkVFAJtANncII/MfbK/eAbMq7J69bKlYy+D11tfLT
         LOCNMbVzbkMs2ne0ezIhlYtxpHHKWG5E9i5EW53bPxyF1m3lNhKDjkfG02qmZdgn+aE4
         tcKH4Td9MF+gaPaWSHIEkjU5856l1QNHhBsAv4O/rgzLMo2L+RxZou8hfX3E9YA2yvdz
         hvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=Vr45SFc+9+udJetnkqyd71Q/qqzbM6ere0fs3nkFeUo=;
        b=lNdPqBj12DptowV/33mchm1B7Tyci/QTDg8UUI1qoAMeDxpjTA4JpMTjUB+sBctjR0
         p2nl0T63pfQFEfwAqM+3niIRyziXJzI2N9ABBet3vFZsQ+Wc6i9otvGb3YIV7NP1yrJZ
         ZM8lN+ydfHek9rE8p3BEklBrNtRX/apnK5VaZjpVGX9DVgXnjhmdb+Yo7clztl5Y2Mm+
         OClbnl6E+qZx6FZxNeCziXUUAxlJVrLA5s3Lt7TDmvSmYsoKNArqpeS+LOksOex4QGtV
         ON6u9I1USLS14g6SaLdg6R5cEEOLoDRhhCo4CG9jeKqWEkqhNtB/dxxM2ZLxhqEhpwfi
         CIzg==
X-Gm-Message-State: AOAM533CG9rpMr4ZQoeC5G0SfzKpTm7juA0a7MzDkcO48xmEZMdTBW1l
        kBWwPhBkY579YavhyNFmjIw=
X-Google-Smtp-Source: ABdhPJzwXBeMlP4JTorjY05dnfOD+YZxbeviZ0UEahzw/Fpttnbzww1ibbbrnaMNeeaqWeUicDhuNQ==
X-Received: by 2002:a05:600c:3584:: with SMTP id p4mr16321030wmq.109.1636552411510;
        Wed, 10 Nov 2021 05:53:31 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1a:f00:c11:ce4b:a3b1:5565? (p200300ea8f1a0f000c11ce4ba3b15565.dip0.t-ipconnect.de. [2003:ea:8f1a:f00:c11:ce4b:a3b1:5565])
        by smtp.googlemail.com with ESMTPSA id m17sm15721266wrz.22.2021.11.10.05.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 05:53:31 -0800 (PST)
Message-ID: <a1e75119-bf60-8dff-71c5-29d1a137587d@gmail.com>
Date:   Wed, 10 Nov 2021 14:53:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <8f13ba8d-03b5-76de-4d59-4ca8786afb83@gmail.com>
 <20211110124821.GZ641268@paulmck-ThinkPad-P17-Gen-1>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] clocksource: Improve cs_watchdog_read()
In-Reply-To: <20211110124821.GZ641268@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.11.2021 13:48, Paul E. McKenney wrote:
> On Tue, Nov 09, 2021 at 09:55:08PM +0100, Heiner Kallweit wrote:
>> If max_cswd_read_retries is set to 0 or 1 then the current warning
>> behavior doesn't seem to make too much sense to me.
>> If set to 0, then we'd warn with each watchdog run.
>> If set to 1, then we'd warn at the first retry, even though the commit
>> description of db3a34e17433 states that one retry is expected behavior.
>> If printing a message at all in this case, then it should be debug
>> level.
> 
> The behavior for max_cswd_read_retries==1 is exactly what you want when
> you are checking to see whether or not your system would retry at all
> for the duration of a given run.
> 
> The behavior for max_cswd_read_retries==0 is exactly what you want when
> you are testing the ability to print that message on a system that will
> not do a retry in a reasonable period of time.
> 
> Or am I missing something here?
> 
For me this mixes production warning and debug features.
To support your debug use cases, maybe use something like this?

if (nretries > 1)
	pr_warn()
else if (nretries >= max_cswd_read_retries)
	pr_debug()


>> Whilst being at it, move declaration of wd_end and wd_delta into the
>> loop and remove not needed braces.
> 
> I am OK with moving those two variables into the "for" loop.
> 
> I am personally OK removing the braces, but if I remember correctly,
> my upstream maintainer asked that I add them due to the statement being
> split across two lines.
> 
> 							Thanx, Paul
> 
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  kernel/time/clocksource.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
>> index f29d1a524..8c0be9c02 100644
>> --- a/kernel/time/clocksource.c
>> +++ b/kernel/time/clocksource.c
>> @@ -208,10 +208,11 @@ module_param(verify_n_cpus, int, 0644);
>>  static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
>>  {
>>  	unsigned int nretries;
>> -	u64 wd_end, wd_delta;
>>  	int64_t wd_delay;
>>  
>>  	for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
>> +		u64 wd_end, wd_delta;
>> +
>>  		local_irq_disable();
>>  		*wdnow = watchdog->read(watchdog);
>>  		*csnow = cs->read(cs);
>> @@ -222,10 +223,9 @@ static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
>>  		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult,
>>  					      watchdog->shift);
>>  		if (wd_delay <= WATCHDOG_MAX_SKEW) {
>> -			if (nretries > 1 || nretries >= max_cswd_read_retries) {
>> +			if (nretries > 1)
>>  				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
>>  					smp_processor_id(), watchdog->name, nretries);
>> -			}
>>  			return true;
>>  		}
>>  	}
>> -- 
>> 2.33.1
>>

