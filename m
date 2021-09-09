Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A9E40603F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 01:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhIIXwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 19:52:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhIIXwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 19:52:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CFE3961101;
        Thu,  9 Sep 2021 23:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631231458;
        bh=DQNK28TOeDI5KHJpmRRR0Z4mB4pizyslewVn/qlEKPo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QRrio1fzenwWgX6Chhm0F9E6aA/MLYtTo/Gf9lc2XRxuYjHai/9/11KSIM3Hdx7Z+
         7fQ/ZDn/4Wq9jYQVu4OUoOOv+sQ3c2VmXdgtz1u+RrTZ6sRuLP/8ZD0qC7WV14Dw3c
         XvbN6ZZddtTBir/x6x+ZSRsBuB5JIpM3T76vl6COdqCfX/UY102tPl+mBdkkJqI3Au
         +l59v3N4bp3SXEQED1e/z2g+VDyw1mTdeGa8Kc0YMTKxVJPJz2TI3WyTGCQFvQT2jx
         D/yVRXXT+sDctnL5HeZfIwPWWxYU/DjZVopU4Hj3Nj2mfSIlGQa0N3d8UNlUCtmJqZ
         M6ulAt/tmp71Q==
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: introduce fragment allocation mode
 mount option
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
References: <20210902172404.3517626-1-daeho43@gmail.com>
 <9ab17089-accc-c3a3-a5dc-007fc4eeaa20@kernel.org>
 <CACOAw_yovM592K3-2fQzA6M29XqWu8s_2f+zXawKo-QpNSXq0w@mail.gmail.com>
 <8f8e4695-4062-60c4-0f91-2a1f6a5b0a11@kernel.org>
 <CACOAw_yBYZzUVGV-A7K57zqrcAaZv7nFSk9mSj9AC6jTTeU7Vw@mail.gmail.com>
 <f64cb941-2bb7-eed2-732d-c9537f46f67c@kernel.org>
 <CACOAw_zxq=SX0OdXV77HyFytJc6aCMbYuS6KZAR_JoQeGZ26Sw@mail.gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <a59d23b9-961f-4129-7491-59f88923366a@kernel.org>
Date:   Fri, 10 Sep 2021 07:50:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACOAw_zxq=SX0OdXV77HyFytJc6aCMbYuS6KZAR_JoQeGZ26Sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/8 2:12, Daeho Jeong wrote:
> On Fri, Sep 3, 2021 at 11:45 PM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2021/9/4 12:40, Daeho Jeong wrote:
>>>> As a per curseg field.
>>>>
>>>>> Maybe, we run into the same race condition issue you told before for
>>>>> fragment_remained_chunk.
>>>>> Could you clarify this more?
>>>>
>>>> e.g.
>>>>
>>>> F2FS_OPTION(sbi).fs_mode = FS_MODE_FRAGMENT_FIXED_BLK
>>>> fragment_chunk_size = 384
>>>> fragment_hole_size = 384
>>>>
>>>> When creating hole:
>>>>
>>>> - f2fs_allocate_data_block
>>>>     - __refresh_next_blkoff
>>>>       chunk locates in [0, 383] of current segment
>>>>       seg->next_blkoff = 384
>>>>       sbi->fragment_remained_chunk = 0
>>>>       then we will reset sbi->fragment_remained_chunk to 384
>>>>       and move seg->next_blkoff forward to 768 (384 + 384)
>>>>     - __has_curseg_space() returns false
>>>>     - allocate_segment() allocates new current segment
>>>>
>>>> So, for such case that hole may cross two segments, hole size may be truncated
>>>> to left size of previous segment.
>>>
>>> First, sbi->fragment_remained_chunk should be seg->fragment_remained_chunk.
>>
>> Oh, correct.
>>
>>> I understand what you mean, so you mean we need to take the leftover
>>> "hole" size over to the next segment?
>>> In the example, the leftover hole size will be (384 - (512-384)). Do
>>> you want to take this over to the next segment?
>>
>> Yes, the left 256 block-sized hole should be created before next chunk
>> in next opened segment.
>>
> 
> Chao,
> 
> Do you have any decent idea to pass the left hole size to the next
> segment which will be allocated?

Daeho,

I guess we can record left hole size in seg->fragment_remained_hole.

Thanks,

> 
> Thanks,
> 
>> Thanks,
>>
>>>
