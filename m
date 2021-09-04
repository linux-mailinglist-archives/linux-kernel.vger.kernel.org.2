Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75EA400A32
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 09:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbhIDGqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 02:46:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231984AbhIDGqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 02:46:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C19AF600AA;
        Sat,  4 Sep 2021 06:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630737908;
        bh=MVOIlssJq/adoFt1cVqsv0+pamI8JoDpoucmm2TnnT8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ov4Hln9BpfKu0DjBJI3KZqVqJJNzWRI0yJIK37hm/aBrNMiJmsy0ImSH8jnst4IDW
         7ank/wzMZ8keOv+hFx/QH7uh200t43fUUVA/1lZQFL82zEJZb+frtukVPTsy4ar9y9
         3kVhWWim0ug1ewDrty4aAdTW0HQmsGJUmPxMnOJKx2u2gznG/rCxaNWgQeuf0gZj3d
         /7VTXWoSylVtg5H4ef5ckVvakvW2mo6mLekI6jMs7mzmfTqKOtGIzg/2dVDnHvMOgX
         diBu8DiXcVTFGCOYYI3EPinoJ+qqMt3oNOFg7hlcFcDvsg6FY1OO4C6UAZJHW3hE3v
         sHRsiRyrnWbXg==
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
From:   Chao Yu <chao@kernel.org>
Message-ID: <f64cb941-2bb7-eed2-732d-c9537f46f67c@kernel.org>
Date:   Sat, 4 Sep 2021 14:45:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACOAw_yBYZzUVGV-A7K57zqrcAaZv7nFSk9mSj9AC6jTTeU7Vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/4 12:40, Daeho Jeong wrote:
>> As a per curseg field.
>>
>>> Maybe, we run into the same race condition issue you told before for
>>> fragment_remained_chunk.
>>> Could you clarify this more?
>>
>> e.g.
>>
>> F2FS_OPTION(sbi).fs_mode = FS_MODE_FRAGMENT_FIXED_BLK
>> fragment_chunk_size = 384
>> fragment_hole_size = 384
>>
>> When creating hole:
>>
>> - f2fs_allocate_data_block
>>    - __refresh_next_blkoff
>>      chunk locates in [0, 383] of current segment
>>      seg->next_blkoff = 384
>>      sbi->fragment_remained_chunk = 0
>>      then we will reset sbi->fragment_remained_chunk to 384
>>      and move seg->next_blkoff forward to 768 (384 + 384)
>>    - __has_curseg_space() returns false
>>    - allocate_segment() allocates new current segment
>>
>> So, for such case that hole may cross two segments, hole size may be truncated
>> to left size of previous segment.
> 
> First, sbi->fragment_remained_chunk should be seg->fragment_remained_chunk.

Oh, correct.

> I understand what you mean, so you mean we need to take the leftover
> "hole" size over to the next segment?
> In the example, the leftover hole size will be (384 - (512-384)). Do
> you want to take this over to the next segment?

Yes, the left 256 block-sized hole should be created before next chunk
in next opened segment.

Thanks,

> 
