Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE96E41CD56
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 22:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346673AbhI2UYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 16:24:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23899 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346369AbhI2UYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 16:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632946942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h1YDbeKNkR/SfFng7S6/uUGNhxN7dH9ZJMLAguI9LOc=;
        b=MvdAg0PLjvaGR2xBvusQzr5QM21zg5m/ECli29bdpM0evvSl+y4s0PgmZ0a0Hr+Z8lYTAA
        x8w1XLjEr+QG2J8kwwrsbozs9CtCJnGqRrsusyIUKEduy9z8t1r1YAdeqD8lmrJXxP8Cl9
        ITRIY5vLFoaiFoSRKOnehdUFZBUYwQA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-Z_pTe7l9NFKHzuOWVLvlNw-1; Wed, 29 Sep 2021 16:22:21 -0400
X-MC-Unique: Z_pTe7l9NFKHzuOWVLvlNw-1
Received: by mail-qk1-f197.google.com with SMTP id m1-20020a05620a290100b0045e5e0b11e6so10808134qkp.23
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 13:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h1YDbeKNkR/SfFng7S6/uUGNhxN7dH9ZJMLAguI9LOc=;
        b=4qiNMVw7PHhSBtKVLuQcOZMCdUouBa8859Cz6e1c5EIqTn+xvFSrw5yE2dGmD9swpv
         39MHVrLOL++5ColnLii9ypTyTbQZaDNybLXYbLQgoACzclz2u/pEoXMSM3l3Usgi+mg4
         KU0WpMOdtLzRfbFGTOJsEboPS2JbtiL96ijxJMXFx4NmNnapOLKQAWjDvNdtdpxuHbhP
         mASUFGTQm1JJO4sGS6EfIiokeMlj2Fax//KOwUyXHgC5eQ4aVjKguf43pT23as4KBEHL
         4Rzp9vF+q2hAjNdzNT3nBv/EpboFakLVgfbREuEk/mfWlHggpxzjhbvuUNH/SR4N+nvP
         8xyw==
X-Gm-Message-State: AOAM532RvyasiKMikZTqH0QGPXWX5zhbWoxTdDcdTI0fuxxlhPsP1w+E
        lCe3DchF36wRpMtTeBjlZSt3X2cz/iMxpnnzQf95hNfrPcSPDfI+XfpZlH+ha4jELxtqqAR57yI
        708nnylr2malTaxBaEJL3aBCg
X-Received: by 2002:ac8:610f:: with SMTP id a15mr2111281qtm.387.1632946940746;
        Wed, 29 Sep 2021 13:22:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgSJiKHfyve2Id7NzFZd6j3APLWB51B1bG2ULV+4Y+3pd4karwoxbU1muZ5ifiwhUfvQWnLw==
X-Received: by 2002:ac8:610f:: with SMTP id a15mr2111261qtm.387.1632946940518;
        Wed, 29 Sep 2021 13:22:20 -0700 (PDT)
Received: from [192.168.1.86] (pool-98-118-8-30.bstnma.fios.verizon.net. [98.118.8.30])
        by smtp.gmail.com with ESMTPSA id a3sm585261qta.48.2021.09.29.13.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 13:22:20 -0700 (PDT)
Message-ID: <dc6926ac-4b8f-4421-088b-94436bdc3bad@redhat.com>
Date:   Wed, 29 Sep 2021 16:22:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 1/2] perf script: Fix PERF_SAMPLE_WEIGHT_STRUCT support
Content-Language: en-US
To:     kan.liang@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
References: <1632929894-102778-1-git-send-email-kan.liang@linux.intel.com>
 <YVSaT54dsMjJV4dF@kernel.org> <YVSzjzV+Jb7loGxI@krava>
From:   Joe Mario <jmario@redhat.com>
In-Reply-To: <YVSzjzV+Jb7loGxI@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/21 2:42 PM, Jiri Olsa wrote:
> On Wed, Sep 29, 2021 at 01:54:39PM -0300, Arnaldo Carvalho de Melo wrote:
>> Em Wed, Sep 29, 2021 at 08:38:13AM -0700, kan.liang@linux.intel.com escreveu:
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> -F weight in perf script is broken.
>>>
>>>   # ./perf mem record
>>>   # ./perf script -F weight
>>>   Samples for 'dummy:HG' event do not have WEIGHT attribute set. Cannot
>>> print 'weight' field.
>>>
>>> The sample type, PERF_SAMPLE_WEIGHT_STRUCT, is an alternative of the
>>> PERF_SAMPLE_WEIGHT sample type. They share the same space, weight. The
>>> lower 32 bits are exactly the same for both sample type. The higher 32
>>> bits may be different for different architecture. For a new kernel on
>>> x86, the PERF_SAMPLE_WEIGHT_STRUCT is used. For an old kernel or other
>>> ARCHs, the PERF_SAMPLE_WEIGHT is used.
>>>
>>> With -F weight, current perf script will only check the input string
>>> "weight" with the PERF_SAMPLE_WEIGHT sample type. Because the commit
>>> ea8d0ed6eae3 ("perf tools: Support PERF_SAMPLE_WEIGHT_STRUCT") didn't
>>> update the PERF_SAMPLE_WEIGHT_STRUCT sample type for perf script. For a
>>> new kernel on x86, the check fails.
>>>
>>> Use PERF_SAMPLE_WEIGHT_TYPE, which supports both sample types, to
>>> replace PERF_SAMPLE_WEIGHT.
>>>
>>> Reported-by: Joe Mario <jmario@redhat.com>
>>> Fixes: ea8d0ed6eae3 ("perf tools: Support PERF_SAMPLE_WEIGHT_STRUCT")
>>
>> Hey Joe, Jiri,
>>
>> 	Can I have your Tested-by?
> 
> Acked/Tested-by: Jiri Olsa <jolsa@redhat.com>
> 
> thanks,
> jirka

 Acked/Tested-by: Joe Mario <jmario@redhat.com>

 The "perf script -F weight" command works correctly.

 And I also verified that when just issuing "perf script", that the weight (cycle latency) 
 column that was missing with this bug, is now fixed and working properly.

 Thanks,
 Joe
> 
>>
>> Thanks,
>>
>> - Arnaldo
>>
>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>> ---
>>>  tools/perf/builtin-script.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>>> index 6211d0b..9f62ac6 100644
>>> --- a/tools/perf/builtin-script.c
>>> +++ b/tools/perf/builtin-script.c
>>> @@ -459,7 +459,7 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
>>>  		return -EINVAL;
>>>  
>>>  	if (PRINT_FIELD(WEIGHT) &&
>>> -	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT, "WEIGHT", PERF_OUTPUT_WEIGHT))
>>> +	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT_TYPE, "WEIGHT", PERF_OUTPUT_WEIGHT))
>>>  		return -EINVAL;
>>>  
>>>  	if (PRINT_FIELD(SYM) &&
>>> -- 
>>> 2.7.4
>>
>> -- 
>>
>> - Arnaldo
>>
> 

