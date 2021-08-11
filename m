Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A1F3E9207
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhHKM5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:57:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhHKM5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:57:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71D10601FF;
        Wed, 11 Aug 2021 12:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628686630;
        bh=+CFOKZhQCvP4jIpuALDJ47zPNHlom+tWJ/IiTz1zLDg=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=haVrEXIhoaiy0l5SlTb7FLEhBK6jGOgnxOdZnm/+fKjkcyYBOs8jl4WD8C8KUVgho
         NXx/FwkBYzlxAkzoUA/SGV/Le0ReEPtlOJqShaBRDO5C0tj3/4CEMzyRTHX4JqCES5
         zF2isEQQBixBmnlnF4KQclDre3GehRcx20N4H6KHRMHjHC5QK9i5LCQml27i8z0hEO
         Y9RG4zzpWv5LW09tb/P8xqd63Zbw8Dsx8H6Cg7/sys2uRE8+TEiilSVnwgpoF+I01Q
         dhLfiXcawQnlMd0j6lU6U6m8g7oiZ7gqw7BA2kfmnz9SsFup8mgBcjiJr5oGy57FNs
         p4szhztvNNWmA==
Subject: Re: [f2fs-dev] f2fs do DIO write make file corruption
To:     Wu Bo <bo.wu@vivo.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <5b68208b-fd94-bf4e-fc4b-d79d13abf1c6@vivo.com>
 <6519b8b7-1eb0-f286-7593-5c5ebbfb5554@kernel.org>
 <86e53ee7-13b5-5e8e-7c81-acb1736ebc8b@vivo.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <aa5f3225-6409-bc62-1021-107a18040384@kernel.org>
Date:   Wed, 11 Aug 2021 20:57:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <86e53ee7-13b5-5e8e-7c81-acb1736ebc8b@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/11 11:28, Wu Bo wrote:
> 
> 在 2021/8/11 11:03, Chao Yu 写道:
>> On 2021/8/11 10:48, Wu Bo wrote:
>>> I use the following command to create a file, the file may got
>>> corruption:
>>>      f2fs_io write 2 0 512 inc_num dio $path
>>>
>>> And when I use bio or to set the chunk size to 1 block, the file is
>>> normal. The commands as following:
>>>      f2fs_io write 2 0 512 inc_num buffered $path
>>>      f2fs_io write 1 0 512 inc_num dio $path
>>>
>>> I find this bug on old kernel version 4.14.117, and not find on version
>>> 4.19.152. So this bug is fixed. Can anyone can tell me which patch fixed
>>> this bug?
>>
>> Not sure,
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-4.19.y&id=7bae8b6b73e46c307fa355ce086800b7ad6610f8

I didn't see this patch in 4.14 stable kernel of mailine, so do you mean 4.14 kernel
maintained by Android?

If so, f2fs codes in between 4.14 and 4.19 Android kernel are almost the same,
see below link:

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-stable.git/

Thanks,

>>
> 
> This patch is applied. The issue occurs when f2fs dio try to preallocate
> multiple blocks and got scattered disk blocks. The log as following:
>         my_f2fs_io-13425 [002] ....   395.583637: el0_irq_naked:
> 1:type:1,ino:40132,off:768,old_blk:0,new_blk:185764
>         my_f2fs_io-13425 [002] ....   395.583710: el0_irq_naked:
> 1:type:1,ino:40132,off:769,old_blk:0,new_blk:205824
>         my_f2fs_io-13425 [002] ....   395.583721: f2fs_map_blocks: dev =
> (259,23), ino = 40132, file offset = 768, start blkaddr = 0x2d5a4, len =
> 0x2, err = 0
>         my_f2fs_io-13425 [002] ....   395.583735: f2fs_map_blocks: dev =
> (259,23), ino = 40132, file offset = 768, start blkaddr = 0x2d5a4, len =
> 0x1, err = 0
>         my_f2fs_io-13425 [002] ....   395.583741: f2fs_map_blocks: dev =
> (259,23), ino = 40132, file offset = 769, start blkaddr = 0x32400, len =
> 0x1, err = 0
> 
> And if the blocks are continuously, the file data is normal:
> 	  my_f2fs_io-13425 [002] ....   395.584037: el0_irq_naked:
> 1:type:1,ino:40132,off:770,old_blk:0,new_blk:205825
>         my_f2fs_io-13425 [002] ....   395.584066: el0_irq_naked:
> 1:type:1,ino:40132,off:771,old_blk:0,new_blk:205826
>         my_f2fs_io-13425 [002] ....   395.584077: f2fs_map_blocks: dev =
> (259,23), ino = 40132, file offset = 770, start blkaddr = 0x32401, len =
> 0x2, err = 0
>         my_f2fs_io-13425 [002] ....   395.584091: f2fs_map_blocks: dev =
> (259,23), ino = 40132, file offset = 770, start blkaddr = 0x32401, len =
> 0x2, err = 0
> 
>>
>> Thanks,
>>
>>>
>>>
>>> _______________________________________________
>>> Linux-f2fs-devel mailing list
>>> Linux-f2fs-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>
>>
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
