Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7922E3E9CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 04:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbhHLCzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 22:55:54 -0400
Received: from mail-m17656.qiye.163.com ([59.111.176.56]:63478 "EHLO
        mail-m17656.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbhHLCzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 22:55:53 -0400
Received: from [172.25.45.51] (unknown [58.250.176.229])
        by mail-m17656.qiye.163.com (Hmail) with ESMTPA id 1A1E6C400FE;
        Thu, 12 Aug 2021 10:55:25 +0800 (CST)
Subject: Re: [f2fs-dev] f2fs do DIO write make file corruption
To:     Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <5b68208b-fd94-bf4e-fc4b-d79d13abf1c6@vivo.com>
 <6519b8b7-1eb0-f286-7593-5c5ebbfb5554@kernel.org>
 <86e53ee7-13b5-5e8e-7c81-acb1736ebc8b@vivo.com>
 <aa5f3225-6409-bc62-1021-107a18040384@kernel.org>
From:   Wu Bo <bo.wu@vivo.com>
Message-ID: <df31a4be-55af-5944-77c8-a09daba02ccb@vivo.com>
Date:   Thu, 12 Aug 2021 10:55:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <aa5f3225-6409-bc62-1021-107a18040384@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRpMTh9WSx5DT0pDT05ISx
        pIVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktITUpVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NUk6PAw4IT9CLSEhPTFPOQEN
        IR4aCi1VSlVKTUlDTEhNQklOTUhCVTMWGhIXVRkUVQwOOw0SDRRVGBQWRVlXWRILWUFZTkNVSU5L
        VUpMTVVJSUJZV1kIAVlBTkpKTjcG
X-HM-Tid: 0a7b38492e16da02kuws1a1e6c400fe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/8/11 20:57, Chao Yu 写道:
> On 2021/8/11 11:28, Wu Bo wrote:
>>
>> 在 2021/8/11 11:03, Chao Yu 写道:
>>> On 2021/8/11 10:48, Wu Bo wrote:
>>>> I use the following command to create a file, the file may got
>>>> corruption:
>>>>      f2fs_io write 2 0 512 inc_num dio $path
>>>>
>>>> And when I use bio or to set the chunk size to 1 block, the file is
>>>> normal. The commands as following:
>>>>      f2fs_io write 2 0 512 inc_num buffered $path
>>>>      f2fs_io write 1 0 512 inc_num dio $path
>>>>
>>>> I find this bug on old kernel version 4.14.117, and not find on version
>>>> 4.19.152. So this bug is fixed. Can anyone can tell me which patch 
>>>> fixed
>>>> this bug?
>>>
>>> Not sure,
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-4.19.y&id=7bae8b6b73e46c307fa355ce086800b7ad6610f8 
>>>
> 
> I didn't see this patch in 4.14 stable kernel of mailine, so do you mean 
> 4.14 kernel
> maintained by Android?
> 
> If so, f2fs codes in between 4.14 and 4.19 Android kernel are almost the 
> same,
> see below link:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-stable.git/
> 

Sorry, it's our old Android project code.So the kernel version may have 
no reference value.
This project code last sync to Android common kernel is:
	9f892496fc0b:f2fs: readahead encrypted block during GC[2018-09-05]
The code link is:
https://android.googlesource.com/kernel/common/+/9f892496fc0b
And after that, we applied some fixup patches.

> Thanks,
> 
>>>
>>
>> This patch is applied. The issue occurs when f2fs dio try to preallocate
>> multiple blocks and got scattered disk blocks. The log as following:
>>         my_f2fs_io-13425 [002] ....   395.583637: el0_irq_naked:
>> 1:type:1,ino:40132,off:768,old_blk:0,new_blk:185764
>>         my_f2fs_io-13425 [002] ....   395.583710: el0_irq_naked:
>> 1:type:1,ino:40132,off:769,old_blk:0,new_blk:205824
>>         my_f2fs_io-13425 [002] ....   395.583721: f2fs_map_blocks: dev =
>> (259,23), ino = 40132, file offset = 768, start blkaddr = 0x2d5a4, len =
>> 0x2, err = 0
>>         my_f2fs_io-13425 [002] ....   395.583735: f2fs_map_blocks: dev =
>> (259,23), ino = 40132, file offset = 768, start blkaddr = 0x2d5a4, len =
>> 0x1, err = 0
>>         my_f2fs_io-13425 [002] ....   395.583741: f2fs_map_blocks: dev =
>> (259,23), ino = 40132, file offset = 769, start blkaddr = 0x32400, len =
>> 0x1, err = 0
>>
>> And if the blocks are continuously, the file data is normal:
>>       my_f2fs_io-13425 [002] ....   395.584037: el0_irq_naked:
>> 1:type:1,ino:40132,off:770,old_blk:0,new_blk:205825
>>         my_f2fs_io-13425 [002] ....   395.584066: el0_irq_naked:
>> 1:type:1,ino:40132,off:771,old_blk:0,new_blk:205826
>>         my_f2fs_io-13425 [002] ....   395.584077: f2fs_map_blocks: dev =
>> (259,23), ino = 40132, file offset = 770, start blkaddr = 0x32401, len =
>> 0x2, err = 0
>>         my_f2fs_io-13425 [002] ....   395.584091: f2fs_map_blocks: dev =
>> (259,23), ino = 40132, file offset = 770, start blkaddr = 0x32401, len =
>> 0x2, err = 0
>>
>>>
>>> Thanks,
>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> Linux-f2fs-devel mailing list
>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>>
>>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>
> 
