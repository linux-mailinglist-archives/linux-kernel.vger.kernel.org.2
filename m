Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DC4349317
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhCYNbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:31:53 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:41594 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhCYNba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:31:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 9C0E83FEFF;
        Thu, 25 Mar 2021 14:31:28 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=Mdg8AKwx;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9qCSgkHCCOe7; Thu, 25 Mar 2021 14:31:26 +0100 (CET)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 2D72E3FFA0;
        Thu, 25 Mar 2021 14:31:23 +0100 (CET)
Received: from [10.249.254.165] (unknown [192.198.151.44])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 1F61C3600A8;
        Thu, 25 Mar 2021 14:31:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1616679083; bh=XL8BQAJQEgz/HLXrzxugZdd/kAGy1RzLvj1mQCzDRCE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Mdg8AKwxGQ6V9ZBKUXVtboLF2eXHKU4JPoHnip24gLaK3C4SzHyvsdQrTgwIx3H12
         //oJQ3EAvuZ6AsyBKb8g7S5z/CB5gVqkdUJoVB9PX/F4eR+WeBp/o12nWyHtUX1mLu
         ZFIriU2fBftCSzwXnUdi8riG3/KApf6l9HFkBiBk=
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <0b984f96-00fb-5410-bb16-02e12b2cc024@shipmail.org>
 <20210324163812.GJ2356281@nvidia.com>
 <08f19e80-d6cb-8858-0c5d-67d2e2723f72@amd.com>
 <730eb2ff-ba98-2393-6d42-61735e3c6b83@shipmail.org>
 <20210324231419.GR2356281@nvidia.com>
 <607ecbeb-e8a5-66e9-6fe2-9a8d22f12bc2@shipmail.org>
 <fb74efd9-55be-9a8d-95b0-6103e263aab8@amd.com>
 <15da5784-96ca-25e5-1485-3ce387ee6695@shipmail.org>
 <20210325113023.GT2356281@nvidia.com>
 <afad3159-9aa8-e052-3bef-d00dee1ba51e@shipmail.org>
 <20210325120103.GV2356281@nvidia.com>
 <a0d0ffd7-3c34-5002-f4fe-cb9d4ba0279e@amd.com>
 <d8c5b688-ede1-b952-1bc9-f2aae870a7a6@shipmail.org>
 <fc548803-7e12-83d7-10b8-4774cae4747f@amd.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <9e924f37-c638-afc7-0354-7258836772b1@shipmail.org>
Date:   Thu, 25 Mar 2021 14:31:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <fc548803-7e12-83d7-10b8-4774cae4747f@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/25/21 2:02 PM, Christian König wrote:
>
>
> Am 25.03.21 um 13:36 schrieb Thomas Hellström (Intel):
>>
>> On 3/25/21 1:09 PM, Christian König wrote:
>>> Am 25.03.21 um 13:01 schrieb Jason Gunthorpe:
>>>> On Thu, Mar 25, 2021 at 12:53:15PM +0100, Thomas Hellström (Intel) 
>>>> wrote:
>>>>
>>>>> Nope. The point here was that in this case, to make sure mmap uses 
>>>>> the
>>>>> correct VA to give us a reasonable chance of alignement, the 
>>>>> driver might
>>>>> need to be aware of and do trickery with the huge page-table-entry 
>>>>> sizes
>>>>> anyway, although I think in most cases a standard helper for this 
>>>>> can be
>>>>> supplied.
>>>> Of course the driver needs some way to influence the VA mmap uses,
>>>> gernally it should align to the natural page size of the device
>>>
>>> Well a mmap() needs to be aligned to the page size of the CPU, but 
>>> not necessarily to the one of the device.
>>>
>>> So I'm pretty sure the device driver should not be involved in any 
>>> way the choosing of the VA for the CPU mapping.
>>>
>>> Christian.
>>>
>> We've had this discussion before and at that time I managed to 
>> convince you by pointing to the shmem helper for this, 
>> shmem_get_umapped_area().
>
> No, you didn't convinced me. I was just surprised that this is 
> something under driver control.
>
>>
>> Basically there are two ways to do this. Either use a standard helper 
>> similar to shmem's, and then the driver needs to align physical 
>> (device) huge page boundaries to address space offset huge page 
>> boundaries. If you don't do that you can just as well use a custom 
>> function that adjusts for you not doing that 
>> (drm_get_unmapped_area()). Both require driver knowledge of the size 
>> of huge pages.
>
> And once more, at least for GPU drivers that looks like the totally 
> wrong approach to me.
>
> Aligning the VMA so that huge page allocations become possible is the 
> job of the MM subsystem and not that of the drivers.
>
Previous discussion here

https://www.spinics.net/lists/linux-mm/msg205291.html

>>
>> Without a function to adjust, mmap will use it's default (16 byte?) 
>> alignment and chance of alignment becomes very small.
>
> Well it's 4KiB at least.
Yes :/ ...
>
> Regards,
> Christian.
>
Thanks,

Thomas


