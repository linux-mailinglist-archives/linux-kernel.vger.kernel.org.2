Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6491310196
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 01:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhBEA0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:26:36 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17909 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbhBEA0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:26:32 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601c90900000>; Thu, 04 Feb 2021 16:25:52 -0800
Received: from [10.2.60.31] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 00:25:51 +0000
Subject: Re: [PATCH] mm: cma: support sysfs
To:     Suren Baghdasaryan <surenb@google.com>
CC:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Dias <joaodias@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <20210203155001.4121868-1-minchan@kernel.org>
 <7e7c01a7-27fe-00a3-f67f-8bcf9ef3eae9@nvidia.com>
 <YBxT9XFE6QAQ4T9N@google.com>
 <cda5547b-0c78-756b-bd0c-f3e534d04bff@nvidia.com>
 <CAJuCfpG_J_XkaK=1z2oHkTpq7Pw1qvZLKuYrs7aG5b9yVwvEag@mail.gmail.com>
 <CAJuCfpFAsM86cKbBrhZx0WPFH5HGCYW4gK_EPtDU=gnhkiDSPw@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <9900858e-4d9b-5111-e695-fd2bb7463af9@nvidia.com>
Date:   Thu, 4 Feb 2021 16:25:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CAJuCfpFAsM86cKbBrhZx0WPFH5HGCYW4gK_EPtDU=gnhkiDSPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612484752; bh=1kcjylQrdkg3Sq5H+JinBAhi/j6dIB7tX+xGXHh1grk=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=pmDqpChmd3D6ub12ZuJGl5eyDx87uPRPh3KZJvYJdj0pXWvEFoYbXB/YX1g0GCBbD
         Y+ZeLRH92bVTHrYJ945E6f9/oSGGc2EUoypJwlEAs5kSz4/Bpw4oEUgAsyv8i5xzCV
         /PFwqOtM6wb2fT6fwLd8nQz/IxeuvKKoSxRSkgDdQdN6gzigZ+Q1GixI5lLCY8atQP
         YTHpWO5Dz+WxH1mLcFZ54l2scTtEEssftD+TpZPpd6KRM7MIXJ2Nit3w7fEVdCtGcf
         O3oUx72CLj38Q3BPMht2EwEakvxZF7U/VUY/J+TFAApBDLgm2GFqRrelsthgr6+c5C
         9Fd8Ie4ohkpDA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 3:45 PM, Suren Baghdasaryan wrote:
...
>>>>> 2) The overall CMA allocation attempts/failures (first two items above) seem
>>>>> an odd pair of things to track. Maybe that is what was easy to track, but I'd
>>>>> vote for just omitting them.
>>>>
>>>> Then, how to know how often CMA API failed?
>>>
>>> Why would you even need to know that, *in addition* to knowing specific
>>> page allocation numbers that failed? Again, there is no real-world motivation
>>> cited yet, just "this is good data". Need more stories and support here.
>>
>> IMHO it would be very useful to see whether there are multiple
>> small-order allocation failures or a few large-order ones, especially
>> for CMA where large allocations are not unusual. For that I believe
>> both alloc_pages_attempt and alloc_pages_fail would be required.
> 
> Sorry, I meant to say "both cma_alloc_fail and alloc_pages_fail would
> be required".

So if you want to know that, the existing items are still a little too indirect
to really get it right. You can only know the average allocation size, by
dividing. Instead, we should provide the allocation size, for each count.

The limited interface makes this a little awkward, but using zones/ranges could
work: "for this range of allocation sizes, there were the following stats". Or,
some other technique that I haven't thought of (maybe two items per file?) would
be better.

On the other hand, there's an argument for keeping this minimal and simple. That
would probably lead us to putting in a couple of items into /proc/vmstat, as I
just mentioned in my other response, and calling it good.


thanks,
-- 
John Hubbard
NVIDIA
