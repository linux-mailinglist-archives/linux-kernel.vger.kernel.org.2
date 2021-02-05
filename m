Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73DE23101B3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 01:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbhBEAfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:35:00 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18558 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbhBEAe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:34:58 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601c928a0000>; Thu, 04 Feb 2021 16:34:18 -0800
Received: from [10.2.60.31] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 00:34:18 +0000
Subject: Re: [PATCH] mm: cma: support sysfs
From:   John Hubbard <jhubbard@nvidia.com>
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
 <9900858e-4d9b-5111-e695-fd2bb7463af9@nvidia.com>
Message-ID: <96bc11de-fe47-c7d3-6e61-5a5a5b6d2f4c@nvidia.com>
Date:   Thu, 4 Feb 2021 16:34:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <9900858e-4d9b-5111-e695-fd2bb7463af9@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612485258; bh=NTqy7B8P6hSTGH18361tq0v8m1sHBP+QMYN9FgAqBkg=;
        h=Subject:From:To:CC:References:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=KoHnZouStLSRj6n3WdCjFTPGAaGHoQ/9TazFgT3+17/wNco0bavtfsDy+pqQTzz14
         ki1nfYyKD9XNO3ASPu8A/+4X+S7BpMbsGuIKzu02etqMQ38zgK3OzqoOyFJa77qtYy
         j4eM30a/YM0Avv0mGol1sd78NTxjjnDsWvLF8eLKJUUtRgG5EKfXVGvwklOnLj/kCW
         imZQkufYuOPOxagKlV4rS/++5XlQ29vyfsRN0y2yHorS0SYMNeCrdoLmB7Wjc2T7eb
         PDPVW1Q/bxKiig8f4607bAi5ACfOyarLhKGU8AHE/vyqZXQH1RWSKppWGDcBLAEa5H
         aHRJUArUec96w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 4:25 PM, John Hubbard wrote:
> On 2/4/21 3:45 PM, Suren Baghdasaryan wrote:
> ...
>>>>>> 2) The overall CMA allocation attempts/failures (first two items above) seem
>>>>>> an odd pair of things to track. Maybe that is what was easy to track, but I'd
>>>>>> vote for just omitting them.
>>>>>
>>>>> Then, how to know how often CMA API failed?
>>>>
>>>> Why would you even need to know that, *in addition* to knowing specific
>>>> page allocation numbers that failed? Again, there is no real-world motivation
>>>> cited yet, just "this is good data". Need more stories and support here.
>>>
>>> IMHO it would be very useful to see whether there are multiple
>>> small-order allocation failures or a few large-order ones, especially
>>> for CMA where large allocations are not unusual. For that I believe
>>> both alloc_pages_attempt and alloc_pages_fail would be required.
>>
>> Sorry, I meant to say "both cma_alloc_fail and alloc_pages_fail would
>> be required".
> 
> So if you want to know that, the existing items are still a little too indirect
> to really get it right. You can only know the average allocation size, by
> dividing. Instead, we should provide the allocation size, for each count.
> 
> The limited interface makes this a little awkward, but using zones/ranges could
> work: "for this range of allocation sizes, there were the following stats". Or,
> some other technique that I haven't thought of (maybe two items per file?) would
> be better.
> 
> On the other hand, there's an argument for keeping this minimal and simple. That
> would probably lead us to putting in a couple of items into /proc/vmstat, as I
> just mentioned in my other response, and calling it good.

...and remember: if we keep it nice and minimal and clean, we can put it into
/proc/vmstat and monitor it.

And then if a problem shows up, the more complex and advanced debugging data can
go into debugfs's CMA area. And you're all set.

If Android made up some policy not to use debugfs, then:

a) that probably won't prevent engineers from using it anyway, for advanced debugging,
and

b) If (a) somehow falls short, then we need to talk about what Android's plans are to
fill the need. And "fill up sysfs with debugfs items, possibly duplicating some of them,
and generally making an unecessary mess, to compensate for not using debugfs" is not
my first choice. :)


thanks,
-- 
John Hubbard
NVIDIA
