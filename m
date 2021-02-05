Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A94310190
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 01:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhBEAZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:25:03 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:7158 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhBEAZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:25:02 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601c90340000>; Thu, 04 Feb 2021 16:24:20 -0800
Received: from [10.2.60.31] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 00:24:20 +0000
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
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <87d7ec1f-d892-0491-a2de-3d0feecca647@nvidia.com>
Date:   Thu, 4 Feb 2021 16:24:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <YByNU4Q7cc7gYwPh@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612484660; bh=QNpWoAKqjfuTsV9sOzKjWbFc+zyBhskLyL0+eKYeBw0=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=JFVYRuwIetZniAxx9W5UDUvlhp6apu+NHHU+KBR5So6iHs2wQRuMlS5qWmdQmat5j
         9w+4UjNQ/Q5bbFN522YUAEknwyRFRRYb1Mb2089uxoXFIcP7jufEYvCSe8VA/nSAoB
         zDgYUh/f2a7vDSSR8ahUG8geXv/CQRRfAnMA8gIdXlognCxgDqMS/06ntVDKMkL7y6
         m4RH+BiTEsiT7Z0E7w4lSx1LSMecI/aNwzaUMnU2fBCwqbsoqiLjnKZtj6+Vq08G46
         ChVJci1xJx1Tqq8Zk28+LADmH4+EJjAxFdwY1EoJ7oNQylzWElZ6h6ubch294qlakI
         tHbylihqugikA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 4:12 PM, Minchan Kim wrote:
...
>>> Then, how to know how often CMA API failed?
>>
>> Why would you even need to know that, *in addition* to knowing specific
>> page allocation numbers that failed? Again, there is no real-world motivation
>> cited yet, just "this is good data". Need more stories and support here.
> 
> Let me give an example.
> 
> Let' assume we use memory buffer allocation via CMA for bluetooth
> enable of  device.
> If user clicks the bluetooth button in the phone but fail to allocate
> the memory from CMA, user will still see bluetooth button gray.
> User would think his touch was not enough powerful so he try clicking
> again and fortunately CMA allocation was successful this time and
> they will see bluetooh button enabled and could listen the music.
> 
> Here, product team needs to monitor how often CMA alloc failed so
> if the failure ratio is steadily increased than the bar,
> it means engineers need to go investigation.
> 
> Make sense?
> 

Yes, except that it raises more questions:

1) Isn't this just standard allocation failure? Don't you already have a way
to track that?

Presumably, having the source code, you can easily deduce that a bluetooth
allocation failure goes directly to a CMA allocation failure, right?

Anyway, even though the above is still a little murky, I expect you're right
that it's good to have *some* indication, somewhere about CMA behavior...

Thinking about this some more, I wonder if this is really /proc/vmstat sort
of data that we're talking about. It seems to fit right in there, yes?


thanks,
-- 
John Hubbard
NVIDIA
