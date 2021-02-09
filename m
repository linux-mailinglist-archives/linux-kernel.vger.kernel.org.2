Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471573148FA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 07:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhBIGhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 01:37:47 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16655 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhBIGfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 01:35:41 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60222d0c0000>; Mon, 08 Feb 2021 22:34:52 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 06:34:52 +0000
Received: from [10.2.50.67] (172.20.145.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb 2021
 06:34:51 +0000
Subject: Re: [PATCH v2] mm: cma: support sysfs
From:   John Hubbard <jhubbard@nvidia.com>
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
 <7cc229f4-609c-71dd-9361-063ef1bf7c73@nvidia.com>
Message-ID: <cd33f8b9-89e0-05bd-2b16-85855f7541bb@nvidia.com>
Date:   Mon, 8 Feb 2021 22:34:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <7cc229f4-609c-71dd-9361-063ef1bf7c73@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612852492; bh=7wQ8mWS6cW2YEXFTB8AqiROB1gkp1bSnRoEhFMdaxfE=;
        h=Subject:From:To:CC:References:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=CNd1JzwwkAR7h5CPMTmCRnAErttwqaT/QE1c5UxltA6Oy/pJE8sTpRmUm/8AFaaAX
         ghxbUDJKrB17gSmhfDB8Jsx2wdjoXFaqmkRz1MgCAbo93ImML9YR4qVD2EtkCpcZYN
         +kQQvyY+X0GYCtoJVIfPHLvyjQjL23L+LWKcz9JOvlqNLaGLhB4peuKL9LQShtjaN5
         a9ctGBlP7plDy+88/+glPGd751r6nqoCFo3rGDJ/+0C0KJ5ETPKCc7HdY2qqKxBbnd
         VMfCZbBU+lstKtevvWIJCCcTVfsBUTVyl0i5bwCUedkYdFjKK/zCSArb1QRvokRV9v
         Wofg+yQigrVMw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/21 10:27 PM, John Hubbard wrote:
> On 2/8/21 10:13 PM, Greg KH wrote:
>> On Mon, Feb 08, 2021 at 05:57:17PM -0800, John Hubbard wrote:
>>> On 2/8/21 3:36 PM, Minchan Kim wrote:
>>> ...
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char name[CMA_MAX_NAME];
>>>>>> +#ifdef CONFIG_CMA_SYSFS
>>>>>> +=C2=A0=C2=A0=C2=A0 struct cma_stat=C2=A0=C2=A0=C2=A0 *stat;
>>>>>
>>>>> This should not be a pointer. By making it a pointer, you've added a =
bunch of pointless
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
>> Um, yes, I was :)
>>
>> You can not add a kobject to a structure and then somehow think you can
>> just ignore the reference counting issues involved.=C2=A0 If a kobject i=
s
>> part of a structure then the kobject is responsible for controling the
>> lifespan of the memory, nothing else can be.
>>
>> So by making the kobject dynamic, you properly handle that memory
>> lifespan of the object, instead of having to worry about the lifespan of
>> the larger object (which the original patch was not doing.)
>>
>> Does that make sense?
>>
> That part makes sense, yes, thanks. The part that I'm trying to straighte=
n
> out is, why was kobject even added to the struct cma_stat in the first
> place? Why not just leave .stat as a static member variable, without
> a kobject in it, and done?
>=20

Sorry, I think I get it now: this is in order to allow a separate lifetime
for the .stat member. I was sort of implicitly assuming that the "right"
way to do it is just have the whole object use one lifetime management,
but as you say, there is no kobject being added to the parent.

I still feel odd about the allocation and freeing of something that seems
to be logically the same lifetime (other than perhaps a few, briefly pendin=
g
sysfs reads, at the end of life). So I'd still think that the kobject shoul=
d
be added to the parent...

thanks,
--=20
John Hubbard
NVIDIA
