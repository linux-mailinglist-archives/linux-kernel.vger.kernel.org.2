Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F58C3148EB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 07:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhBIGdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 01:33:32 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12059 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhBIG2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 01:28:16 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60222b4d0000>; Mon, 08 Feb 2021 22:27:25 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 06:27:24 +0000
Received: from [10.2.50.67] (172.20.145.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb 2021
 06:27:24 +0000
Subject: Re: [PATCH v2] mm: cma: support sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, <surenb@google.com>,
        <joaodias@google.com>, <willy@infradead.org>
References: <20210208180142.2765456-1-minchan@kernel.org>
 <e01c111b-fb20-0586-c7a9-dd6d922c0e57@nvidia.com>
 <YCHLAdabGmm7kqSH@google.com>
 <43cd6fc4-5bc5-50ec-0252-ffe09afd68ea@nvidia.com>
 <YCIoHBGELFWAyfMi@kroah.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <7cc229f4-609c-71dd-9361-063ef1bf7c73@nvidia.com>
Date:   Mon, 8 Feb 2021 22:27:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <YCIoHBGELFWAyfMi@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612852045; bh=X0aIckYSF9wc/TONr7/whXV7WyEI3S3ZRv/IkzFkkzw=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=KRzOE4v0vMuGPLYxhNQn2OXAeSmuSgrbctCSIrCIKYpZd2sc41twl/ibfplX4GxTO
         TzMElz0s24BeSyr43v3+hgD9C3s81a9Lv/iHYMhLUYTaRth/8+iWd9IjLQNC+ZTc33
         bvl7ZxZQoH+STN6yc8HYgKPdEG2otJ3DXdP4DqhTp5hu6ig0/jdhyCD+ucg5FB7+Y8
         +kheXPXiU453iApKBzQ2wN4g4qMAM4QimxGYbLYFd5VYV1QHJmRvldWyQS4WySJ+j5
         fB5pIBKtY9cqSX0e1nDF8hXLZVEyazk8lQmWCBHul7/NM0VxmDWAILvC5SfcT22lGm
         yEI007isKxtMA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/21 10:13 PM, Greg KH wrote:
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
> Um, yes, I was :)
> 
> You can not add a kobject to a structure and then somehow think you can
> just ignore the reference counting issues involved.  If a kobject is
> part of a structure then the kobject is responsible for controling the
> lifespan of the memory, nothing else can be.
> 
> So by making the kobject dynamic, you properly handle that memory
> lifespan of the object, instead of having to worry about the lifespan of
> the larger object (which the original patch was not doing.)
> 
> Does that make sense?
> 
That part makes sense, yes, thanks. The part that I'm trying to straighten
out is, why was kobject even added to the struct cma_stat in the first
place? Why not just leave .stat as a static member variable, without
a kobject in it, and done?

thanks,
-- 
John Hubbard
NVIDIA
