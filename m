Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89AA731483C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 06:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBIF1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 00:27:50 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7947 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhBIF1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 00:27:49 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60221d2d0000>; Mon, 08 Feb 2021 21:27:09 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 05:27:08 +0000
Received: from MacBook-Pro-10.local (172.20.145.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb 2021
 05:27:08 +0000
Subject: Re: [PATCH v2] mm: cma: support sysfs
From:   John Hubbard <jhubbard@nvidia.com>
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
 <3cf67381-9b5a-56ee-2a8f-047955c84128@nvidia.com>
Message-ID: <6e3bb5a3-9634-6a1b-f2fd-cbbcb6c8ed66@nvidia.com>
Date:   Mon, 8 Feb 2021 21:27:07 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <3cf67381-9b5a-56ee-2a8f-047955c84128@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612848429; bh=qh8VL+gYOXWaYImmhix9zNj5sivO32KEAX2o+472W64=;
        h=Subject:From:To:CC:References:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=I9TyyKrYmOKlqvb5YAsMK5B7xuGirT/raaKBsXyFOWliYoz1TV8rKNZwTmWUrRfHx
         B+1RBmcx/XI/P+K6LTJeO0iou8jBCg1yPNF9bR9136jR5B6fl0yh/slSAeunN86mSq
         3u+GpLHdNtTS36mvo7/tkUz8Uxm2kw5ec4TeCc/N93wljxuem/V9PvHh2dc3EGXbnR
         JNGtcKnBMSh78znZF9RlE/O9Bo9FSTbR8TC7FBxP42xJ9+WPKYhJ69ueBnjnIE3+ig
         BF8hgN7hETKPrQvSGM1ulL8k49jZedhsQkudNlK/cknT0UnaDBkDZ7uobp81NzSwP3
         CfqvXr4KdrCbg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/21 9:18 PM, John Hubbard wrote:
> On 2/8/21 8:19 PM, Minchan Kim wrote:
>> On Mon, Feb 08, 2021 at 05:57:17PM -0800, John Hubbard wrote:
>>> On 2/8/21 3:36 PM, Minchan Kim wrote:
>>> ...
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char name[CMA_MAX_NAME];
>>>>>> +#ifdef CONFIG_CMA_SYSFS
>>>>>> +=C2=A0=C2=A0=C2=A0 struct cma_stat=C2=A0=C2=A0=C2=A0 *stat;
>>>>>
>>>>> This should not be a pointer. By making it a pointer, you've added a =
bunch of=20
>>>>> pointless
>>>>> extra code to the implementation.
>>>>
>>>> Originally, I went with the object lifetime with struct cma as you
>>>> suggested to make code simple. However, Greg KH wanted to have
>>>> release for kobj_type since it is consistent with other kboject
>>>> handling.
>>>
>>> Are you talking about the kobj in your new struct cma_stat? That seems
>>> like circular logic if so. I'm guessing Greg just wanted kobj methods
>>> to be used *if* you are dealing with kobjects. That's a narrower point.
>>>
>>> I can't imagine that he would have insisted on having additional
>>> allocations just so that kobj freeing methods could be used. :)
>>
>> I have no objection if Greg agree static kobject is okay in this
>> case. Greg?
>>
>=20
> What I meant is, no kobject at all in the struct cma_stat member
> variable. The lifetime of the cma_stat member is the same as the
> containing struct, so no point in putting a kobject into it.
>=20

...unless...are you actually *wanting* to keep the lifetimes separate?
Hmmm, given the short nature of sysfs reads, though, I'd be inclined
to just let the parent object own the lifetime. But maybe I'm missing
some design point here?

thanks,
--=20
John Hubbard
NVIDIA
