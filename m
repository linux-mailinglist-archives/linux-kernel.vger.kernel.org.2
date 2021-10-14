Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4B642DB8E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 16:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhJNObx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 10:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhJNObw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 10:31:52 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599F4C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 07:29:47 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id t184so4757662pfd.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 07:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZscIr80ImXb4UJ7H1Vo//8G5aoS2JEIpFbKo7Ab/iiU=;
        b=CZCerCfuvS4xkcFc84KrMnQYQZiXqC1+Z52x/58+C1KTgiKnH1+P2bzrYDJW8b6rpR
         3PcRGjSgieALgMd2Uu9UsGoxDqtiBTa6bVTgZTzqc/76MAgB4hq0/xndawrXcotmoysZ
         Ruiwe9BEdfYFq2u543Uj7bc43tFf+TECsEBKMNEuKNe2v1bq2m67oFVJXji+DfkEJQgB
         h5yWeMrh+5gOZZUUy/btvngHtOdIy81sl79Nh81pBD9Dl3Rt2gIC2uOPl9ySNOcesk7F
         heLy7yh2CRQdcWLBqM6QjF9+FmPWy6wG+dCvpG9L+Z8/1KEMHzvdT8P108UBixuauWEV
         AaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZscIr80ImXb4UJ7H1Vo//8G5aoS2JEIpFbKo7Ab/iiU=;
        b=EkYaSsD2TJyi0e40axMLXsKaRv0qVzrbY7ygciKBhxGejyPhCpRD2t1GbRPIt2/LK4
         emPs8kZv74yTCTKHG5Qv8huXBWbv2XDA5lk/nExJ1tJ26Y9ENxfLlROnH8fua88yqCYx
         QZ/vSKdaed5PtjNaXRGEMrl5fzy4fxgeCYxkXy2EKk/N/R5iusr8naF3NSJwvD4x7KiD
         E4e9EXkPYrQ0SjXlU3g4iJ2QsnS/Cv7ZBQ5eED9GXp5uo4dqtb+AzYZ87MS2EyMjaJXA
         ttNyqXv+N2R8D0bfllyZqNawAFceibdjwXGSnarbMVe+Irm8iTjswpCgALcL4nkbgxLN
         0YAg==
X-Gm-Message-State: AOAM531Zc3Rzwk+xJleSZOxYYPeiWhbFqKwDD5exEVyvv5Poua3P2S/u
        VHpATBu6LlBwOiB6cW0c6m4=
X-Google-Smtp-Source: ABdhPJxYOhMbaCmv18AiUEZ69vOVFHm8pCXFCZ28zQLmz+FVfKxS+fATGZUoCSBG1rKmIFEEZuaXSg==
X-Received: by 2002:a63:d30e:: with SMTP id b14mr4458950pgg.454.1634221786807;
        Thu, 14 Oct 2021 07:29:46 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id nu16sm2944747pjb.56.2021.10.14.07.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 07:29:46 -0700 (PDT)
Subject: Re: data dependency naming inconsistency
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, paulmck@linux.ibm.com,
        Akira Yokosawa <akiyks@gmail.com>
References: <20211011064233-mutt-send-email-mst@kernel.org>
 <6c362de5-1d79-512c-37d0-81aaf5d335d1@qa2.so-net.ne.jp>
 <20211014013156-mutt-send-email-mst@kernel.org>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <d253958f-b3d7-67c1-4cf6-38f184adabd6@gmail.com>
Date:   Thu, 14 Oct 2021 23:29:43 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211014013156-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[-CC akys: my 2nd address]
On Thu, 14 Oct 2021 01:37:17 -0400, Michael S. Tsirkin wrote:
> On Thu, Oct 14, 2021 at 01:43:24PM +0900, Akira Yokosawa wrote:
>> On Mon, 11 Oct 2021 07:07:08 -0400, Michael S. Tsirkin wrote:
>>> Hello Paul, all!
>>
>> Hello Michael,
>>
>> I thought Paul would respond soon, but looks like he has not
>> done so.
>> So, I'm trying to give some hint to your findings.
>>
>>> I've been reading with interest Paul's posts about Rust interactions with LKMM
>>> https://paulmck.livejournal.com/63316.html
>>> and in particular it states:
>>> 		A data dependency involves a load whose return value directly or
>>> 	indirectly determine the value stored by a later store, which results in
>>> 	the load being ordered before the store.
>>>
>>> This matches the perf book:
>>> 	A data dependency occurs when the value returned by
>>> 	a load instruction is used to compute the data stored by
>>> 	a later store instruction.
>>
>> You might likely be aware, but these concern "data dependency",
>> not a _barrier_.
>>
>>>
>>> however, memory-barriers.txt states:
>>>
>>>      A data dependency barrier is a partial ordering on interdependent loads
>>>      only; it is not required to have any effect on stores, independent loads
>>>      or overlapping loads.
>>>
>>> It also says:
>>> 	A data-dependency barrier is not required to order dependent writes
>>> 	because the CPUs that the Linux kernel supports don't do writes
>>> 	until they are certain (1) that the write will actually happen, (2)
>>> 	of the location of the write, and (3) of the value to be written.
>>
>> These concern the historic "data-dependency barrier", or
>> [smp_]read_barrier_depends(), which existed until Linux kernel v4.14.

Ah... I should have said ", which existed prior to Linux kernel v4.15".
This invited off-by-one error below...

>>
>>>
>>> so the result it the same: writes are ordered without a barrier,
>>> reads are ordered by a barrier.
>>>
>>> However, it would seem that a bit more consistency in naming won't
>>> hurt.
>>
>> So, I don't think the historic term of "data-dependency barrier"
>> can be changed.
>>
>> I guess the right approach would be to further de-emphasize
>> "data-dependency barrier"/"data dependency barrier" in
>> memory-barriers.txt.
>>
>> Rewrite by commit 8ca924aeb4f2 ("Documentation/barriers: Remove
>> references to [smp_]read_barrier_depends()") did some of such
>> changes, but it failed to update the introductory section of
>> "VARIETIES OF MEMORY BARRIER".
>> The part Michael quoted above belongs to it.
>> I don't think it has any merit keeping it around.
>>
>> Also, there remain a couple of ascii-art diagrams concerning
>> <data dependency barrier> in the first part of "EXAMPLES OF MEMORY
>> BARRIER SEQUENCES" section, which, I think, can be removed as well.
>>
>> Hope this helps clarify the circumstances.
> 
> It does, thanks! It might be worth adding a sentence along the lines of
> 
> "NB: a data dependency barrier is distinct from a data dependency: it's
> a barrier that used to be required in the presence of a data dependency.
> Since v4.14 Linux no longer offers an API for a data dependency barrier.

  Since v4.15

> Instead, using READ_ONCE is sufficient for ordering in the presence of a
> data dependency".


Maybe.

But I'm more inclined to get rid of remaining contents related to the
"data dependency barrier".

        Thanks, Akira

> 
> 
>> Paul, what is your take on the naming of "data dependency"/
>> "data dependency barrier"?
>>
>>         Thanks, Akira
>>
>>>
>>> Thanks,
>>>
>>> -- 
>>> MST
> 
