Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B18B3102FD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 03:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhBECwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 21:52:47 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16409 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhBECwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 21:52:45 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601cb2d50000>; Thu, 04 Feb 2021 18:52:05 -0800
Received: from [10.2.60.31] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 02:52:01 +0000
Subject: Re: [PATCH] mm: cma: support sysfs
To:     Minchan Kim <minchan@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <gregkh@linuxfoundation.org>, <surenb@google.com>,
        <joaodias@google.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <20210203155001.4121868-1-minchan@kernel.org>
 <7e7c01a7-27fe-00a3-f67f-8bcf9ef3eae9@nvidia.com>
 <YBxT9XFE6QAQ4T9N@google.com>
 <cda5547b-0c78-756b-bd0c-f3e534d04bff@nvidia.com>
 <YByNU4Q7cc7gYwPh@google.com>
 <87d7ec1f-d892-0491-a2de-3d0feecca647@nvidia.com>
 <YByi/gdaGJeV/+8b@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <71c4ce84-8be7-49e2-90bd-348762b320b4@nvidia.com>
Date:   Thu, 4 Feb 2021 18:52:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <YByi/gdaGJeV/+8b@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612493525; bh=EFGmCq6+o/4jbrE2ZvC8hiPkxQbACUZQsML002ws050=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=g2QOHbQ0N890F6gbCZkj++EyGuTFxlzgBh1rLcjJsco77879cxG6Udm9zwd9mdlwE
         k8sCdOHbS1/2UBw3oEdjMRQYqZXn1LS2VbcthharGxaxdSmPU7vDwfpYQywvZZQoG9
         yl2lrBQMoa5SH0BJX13ucA7wJZ83EWIdBil15SWpw4eTfJ2eA7qeRQJUFPv0+y+gQy
         pHGlYMD6Fk3aR2E5dMQSczZCS+qSJ6uO2L3IhTLic2AVb5RlSi9h8X3zFHQ6CsWeKL
         K+TAHyo7MVT1JI8b6azbaFFcaL7QsFffKnWNU2Jixzbx9yQoJ9PDAqVlM/OS9imYQ/
         tLiEzQZgRYwMg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 5:44 PM, Minchan Kim wrote:
> On Thu, Feb 04, 2021 at 04:24:20PM -0800, John Hubbard wrote:
>> On 2/4/21 4:12 PM, Minchan Kim wrote:
>> ...
>>>>> Then, how to know how often CMA API failed?
>>>>
>>>> Why would you even need to know that, *in addition* to knowing specific
>>>> page allocation numbers that failed? Again, there is no real-world motivation
>>>> cited yet, just "this is good data". Need more stories and support here.
>>>
>>> Let me give an example.
>>>
>>> Let' assume we use memory buffer allocation via CMA for bluetooth
>>> enable of  device.
>>> If user clicks the bluetooth button in the phone but fail to allocate
>>> the memory from CMA, user will still see bluetooth button gray.
>>> User would think his touch was not enough powerful so he try clicking
>>> again and fortunately CMA allocation was successful this time and
>>> they will see bluetooh button enabled and could listen the music.
>>>
>>> Here, product team needs to monitor how often CMA alloc failed so
>>> if the failure ratio is steadily increased than the bar,
>>> it means engineers need to go investigation.
>>>
>>> Make sense?
>>>
>>
>> Yes, except that it raises more questions:
>>
>> 1) Isn't this just standard allocation failure? Don't you already have a way
>> to track that?
>>
>> Presumably, having the source code, you can easily deduce that a bluetooth
>> allocation failure goes directly to a CMA allocation failure, right?

Still wondering about this...

>>
>> Anyway, even though the above is still a little murky, I expect you're right
>> that it's good to have *some* indication, somewhere about CMA behavior...
>>
>> Thinking about this some more, I wonder if this is really /proc/vmstat sort
>> of data that we're talking about. It seems to fit right in there, yes?
> 
> Thing is CMA instance are multiple, cma-A, cma-B, cma-C and each of CMA
> heap has own specific scenario. /proc/vmstat could be bloated a lot
> while CMA instance will be increased.
> 

Yes, that would not fit in /proc/vmstat...assuming that you really require
knowing--at this point--which CMA heap is involved. And that's worth poking
at. If you get an overall indication in vmstat that CMA is having trouble,
then maybe that's all you need to start digging further.

It's actually easier to monitor one or two simpler items than it is to monitor
a larger number of complicated items. And I get the impression that this is
sort of a top-level, production software indicator.

thanks,
-- 
John Hubbard
NVIDIA
