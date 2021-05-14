Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD3D3805BF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 10:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbhENJBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 05:01:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25893 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229544AbhENJA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 05:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620982788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uHHdZRj+IUb7JeWXnl6L+YoOqF4PMKN1l/DvgHVBRRo=;
        b=AJDXSL7p1wFWVXRnR98iSsOGR3qPAO/AsSNMLRjhvM8QK8duwLdeAdOAZ4iqBoZhpXy6zp
        MWSanftaFubLKvlFPQVXkop3kGF7b1A2U0diabR5XhaF4RoyosXS6pS4qubNTnpKQ1JUSU
        mB6qwjKnaFsv1xRGzz7MpNj+8sC2qxg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-VLtAthVBPMOblx13puVXnQ-1; Fri, 14 May 2021 04:59:44 -0400
X-MC-Unique: VLtAthVBPMOblx13puVXnQ-1
Received: by mail-ej1-f69.google.com with SMTP id nd10-20020a170907628ab02903a324b229bfso9400855ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 01:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uHHdZRj+IUb7JeWXnl6L+YoOqF4PMKN1l/DvgHVBRRo=;
        b=rAjiFJ7YaeeVPmLNnyktEFOEGOK4afFKtIcKTiya9tzfUPbZAhJYJl+Qtjrkt1wNzZ
         VIAeqQpHafVU0EXthIH2pZqbez/9kaf7Y1yn1ljytt2cZFZT/5q8UepH+waEOgbUIR7M
         O8PrTOfCs7iSpqCsJnRRJHD9ntSQOIvAEdGR2d/OFvYf4KoWF0mtJAGkvWdpQi/2+mXU
         nx31qyOi63Xu47LuKqOqaodIe3UI86s/tGZBoDn2fHlhyIhmIGyce7luavFxu0kJQXzC
         W9NkKCn5zg5arFv0ng0s79LojxzWPJXU8hbRxuRFtHzxcqUTHoHo19H0G4YUGn5CuQJA
         aliQ==
X-Gm-Message-State: AOAM53053mlhvy8ookcb29l5vwY+OJVbCcUalbp3kNXLRzqhmPO2eeFR
        8KlKRJMvssLEHxaqLkZUhQH8rk0PYnVI8W/OPNeJpz/CdBe3Y/ybo4IsdBFK2FoYxoUFmJUMfgT
        nkMK+/DWqdx0g147UqlkF5BVD
X-Received: by 2002:a50:ab16:: with SMTP id s22mr12554771edc.323.1620982783478;
        Fri, 14 May 2021 01:59:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbHzKPptQuaaax4koD1wMpjMJEFq7M/LzJ7igQfcDFxcMxcHYQVz8KIa7v8exjQBQGjVcL/g==
X-Received: by 2002:a50:ab16:: with SMTP id s22mr12554755edc.323.1620982783321;
        Fri, 14 May 2021 01:59:43 -0700 (PDT)
Received: from x1.bristot.me (host-87-19-51-73.retail.telecomitalia.it. [87.19.51.73])
        by smtp.gmail.com with ESMTPSA id u8sm3932538edo.71.2021.05.14.01.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 01:59:43 -0700 (PDT)
Subject: Re: [RFC PATCH V2 9/9] tracing: Add timerlat tracer
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-doc@vger.kernel.org
References: <cover.1619210818.git.bristot@redhat.com>
 <1f3b97ca52e6a4eec58f18bf190218bdbfe30f20.1619210818.git.bristot@redhat.com>
 <YJ47Gc6ej9jeAsoK@localhost.localdomain>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <154ce81c-0a65-1639-740d-a506fd8cdaef@redhat.com>
Date:   Fri, 14 May 2021 10:59:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJ47Gc6ej9jeAsoK@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/21 10:55 AM, Juri Lelli wrote:
> Hi Daniel,
> 
> Just a couple of things I noticed while playing with this nice additon.
> 
> On 23/04/21 23:05, Daniel Bristot de Oliveira wrote:
> 
> ...
> 
>> +/**
>> + * tlat_var_reset - Reset the values of the given timerlat_variables
>> + */
>> +static inline void tlat_var_reset(void)
>> +{
>> +	struct timerlat_variables *tlat_var;
>> +	int cpu;
>>  	/*
>>  	 * So far, all the values are initialized as 0, so
>>  	 * zeroing the structure is perfect.
>>  	 */
>> -	memset(osn_var, 0, sizeof(struct osnoise_variables));
>> +	for_each_cpu(cpu, cpu_online_mask) {
>> +		memset(tlat_var, 0, sizeof(struct timerlat_variables));
>> +		tlat_var = per_cpu_ptr(&per_cpu_timerlat_var, cpu);
> 
> Think these two above want to be the other way around?

Arrrggg! :-) you are right...

>> +	}
>>  }
> 
> ...
> 
>> +#ifdef CONFIG_TIMERLAT_TRACER
>> +static void timerlat_tracer_start(struct trace_array *tr)
>> +{
>> +	int retval;
>> +
>> +	if (osnoise_busy)
>> +		return;
>> +
>> +	retval = __osnoise_tracer_start(tr);
>> +	if (retval)
>> +		goto out_err;
>> +
>> +	osnoise_data.timerlat_tracer = 1;
> 
> It seems this needs to be set before calling __osnoise_tracer_start()?

Yep, my bad! two last minute cleanups that broke things...

I will change these two things in the v3.

Thanks!
-- Daniel

> Thanks!
> 
> Juri
> 

