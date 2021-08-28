Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5D73FA33F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 04:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhH1CmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 22:42:05 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:41527 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbhH1CmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 22:42:04 -0400
Received: by mail-pj1-f46.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so6186628pjt.0;
        Fri, 27 Aug 2021 19:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RBlOsPc5PIE1Z++YIqnJC6Ew2ez3y5YwEaBnkJvgVmE=;
        b=EHmU8Xla7+7KkyihFu4uVYK67wOZi2QXYTAIQt63Nu1mOSOqpepSVTRjhlwdOF7Qfk
         meAoeyJ1qTV/Mk5+a6y4RsvCfNsEG6qz9BahYUevQu8tBk/ynH1zQLEucOIMtlzpBWfQ
         Ab4RtOYRtjIPNNqqMEwOUtE9PBe1hIy5XX+xyxLm3HRYi/5s9KOAfE48Zr7B53G3/gDv
         xhifr9XA5DTyay3GS9TUllgz6/eSplPgW2i68UN8SiKTL3c7HqJlth803gnJcNSBcTf1
         LTtRoqX0DwCBOHduknmFru+RXLX70unXARPyXm1ixiLh3EMGPui6N8QpxtRLThqF7T0F
         1vDw==
X-Gm-Message-State: AOAM531Rod8UFO7PVefy7XK9Q5Dt/hQDZV09l2PGis3TBYYp0jvgF3Ez
        g4Y10P0zb+ReIyrajeBS6/A=
X-Google-Smtp-Source: ABdhPJyvTsRGcqgV2GdVSvGBSrwrNN91pTFIjGddMe356NYxcMRXzoQz80U+YKpZnNSMdkLXaFjTHA==
X-Received: by 2002:a17:90a:bc47:: with SMTP id t7mr27064255pjv.19.1630118474413;
        Fri, 27 Aug 2021 19:41:14 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:7c18:2fe1:2126:c371? ([2601:647:4000:d7:7c18:2fe1:2126:c371])
        by smtp.gmail.com with ESMTPSA id t12sm8818779pgo.56.2021.08.27.19.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 19:41:13 -0700 (PDT)
Subject: Re: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority
 requests
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@wdc.com>
References: <20210826144039.2143-1-thunder.leizhen@huawei.com>
 <fc1f2664-fc4f-7b3e-5542-d9e4800a5bde@acm.org>
 <b653a431-997b-0d94-2823-779f877c314f@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <03d78b73-4208-2234-c85c-7ef34c799ce5@acm.org>
Date:   Fri, 27 Aug 2021 19:41:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <b653a431-997b-0d94-2823-779f877c314f@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/21 6:59 PM, Leizhen (ThunderTown) wrote:
>>> @@ -711,6 +712,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>>>  
>>>  	prio = ioprio_class_to_prio[ioprio_class];
>>>  	dd_count(dd, inserted, prio);
>>> +	per_prio = &dd->per_prio[prio];
>>> +	per_prio->nr_queued++;
>>>  
>>>  	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
>>>  		blk_mq_free_requests(&free);
>>
>> I think the above is wrong - nr_queued should not be incremented if the
>> request is merged into another request. Please move the code that increments
>> nr_queued past the above if-statement.
> 
> So dd_count(dd, inserted, prio) needs to be moved behind "if-statement" as well?

dd_insert_request() is called if a request is inserted and also if it is
requeued. dd_finish_request() is called once per request. Keeping
dd_count() before blk_mq_sched_try_insert_merge() is fine since
blk_mq_free_requests() will call dd_finish_request() indirectly if a
request is merged. However, dd_count() must only happen once per request
and must not be used if a request is requeued.

Additionally, since dd_insert_request() is called with dd->lock held and
since dd_finish_request() is called directly from inside
dd_insert_request() if a request is merged, acquiring dd->lock from
inside dd_finish_request() may trigger a deadlock. A convenient way to
trigger this code path is by running test block/015 from
https://github.com/osandov/blktests/.

Bart.
