Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1239F314800
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 06:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhBIFTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 00:19:36 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8523 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhBIFTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 00:19:34 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60221b3e0001>; Mon, 08 Feb 2021 21:18:54 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 05:18:53 +0000
Received: from MacBook-Pro-10.local (172.20.145.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb 2021
 05:18:53 +0000
Subject: Re: [PATCH v2] mm: cma: support sysfs
To:     Minchan Kim <minchan@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <surenb@google.com>,
        <joaodias@google.com>, <willy@infradead.org>
References: <20210208180142.2765456-1-minchan@kernel.org>
 <e01c111b-fb20-0586-c7a9-dd6d922c0e57@nvidia.com>
 <YCHLAdabGmm7kqSH@google.com>
 <43cd6fc4-5bc5-50ec-0252-ffe09afd68ea@nvidia.com>
 <YCINNpA09FTwr63U@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <3cf67381-9b5a-56ee-2a8f-047955c84128@nvidia.com>
Date:   Mon, 8 Feb 2021 21:18:52 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YCINNpA09FTwr63U@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612847934; bh=L8BK9D+uuYU7ZhrW2feVoLIu8IHxKir02v9HrkdcSyQ=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=B/QqkRE6/oM+57E2Rs9HLW6n93XxcfSSDlZGkgrlo1H0SYqiAZcLql1cTJG2z1YNU
         y0p9JTd6Ia8zC303LeT3YE6aC1Co6buUcI2BEgeyMES7sxqH3v5mRqKkzzUxFGkmeH
         mIgjNftb7E+r3gNe+y4FTqpF5vxPawP1j2IRozglnAgaUrdfHVzFgNE2J456mZnEfY
         iX/ibQmDHUU4xvvyONbcuof9GEIkEJdBRmNKKwx+ESaM9qQnyCCcwsOEQngdMMkStD
         KSmhxOoBogx2hhFj6+IRyK/NDI9qsdi1y7U2q/A9Zh7W+qw/fXEU/bd0cc3A9Guhd4
         MDnbsAc2EhyeA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/21 8:19 PM, Minchan Kim wrote:
> On Mon, Feb 08, 2021 at 05:57:17PM -0800, John Hubbard wrote:
>> On 2/8/21 3:36 PM, Minchan Kim wrote:
>> ...
>>>>>     	char name[CMA_MAX_NAME];
>>>>> +#ifdef CONFIG_CMA_SYSFS
>>>>> +	struct cma_stat	*stat;
>>>>
>>>> This should not be a pointer. By making it a pointer, you've added a bunch of pointless
>>>> extra code to the implementation.
>>>
>>> Originally, I went with the object lifetime with struct cma as you
>>> suggested to make code simple. However, Greg KH wanted to have
>>> release for kobj_type since it is consistent with other kboject
>>> handling.
>>
>> Are you talking about the kobj in your new struct cma_stat? That seems
>> like circular logic if so. I'm guessing Greg just wanted kobj methods
>> to be used *if* you are dealing with kobjects. That's a narrower point.
>>
>> I can't imagine that he would have insisted on having additional
>> allocations just so that kobj freeing methods could be used. :)
> 
> I have no objection if Greg agree static kobject is okay in this
> case. Greg?
> 

What I meant is, no kobject at all in the struct cma_stat member
variable. The lifetime of the cma_stat member is the same as the
containing struct, so no point in putting a kobject into it.

thanks,
-- 
John Hubbard
NVIDIA
