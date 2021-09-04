Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9C8400982
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 06:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhIDDeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 23:34:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229596AbhIDDeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 23:34:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C813F6069E;
        Sat,  4 Sep 2021 03:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630726398;
        bh=vDInDMJ4sMJnmqblJcXU0QqfdBm47jpBvsDvYyfEXBk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iraM5xTi9QjL341eo2RxFLV1aclSle5NhZTFsRGheHHVdZTduYXKuNdSs93EzOCVq
         6o6+FQAhLcCmT3W0T8wEK22PEIG7H86pLQ40MeFVSBw9J4Z5FGZ4xhz1B96WQPzce3
         5E2vDC0cVURUDAICMhdjbW0HBHLDiTu/f141xsy+q2kBL9cDHr+A8zZ64+gX1BYHye
         IMUPst2ejWYNR+S/B15UyKj/Qa8LhwCHXK9b9gsVfK6+ZpvqhSEMtHzxvusaldthus
         QsP7gybXytaFUFA7Yj42bC2O+uh1Ok9vWcctFh3+R+N2uc0t7i/iL8sfjaRdkPVBc2
         z4ZPFGIU9cNCg==
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: introduce fragment allocation mode
 mount option
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
References: <20210902172404.3517626-1-daeho43@gmail.com>
 <9ab17089-accc-c3a3-a5dc-007fc4eeaa20@kernel.org>
 <CACOAw_yovM592K3-2fQzA6M29XqWu8s_2f+zXawKo-QpNSXq0w@mail.gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <8f8e4695-4062-60c4-0f91-2a1f6a5b0a11@kernel.org>
Date:   Sat, 4 Sep 2021 11:33:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACOAw_yovM592K3-2fQzA6M29XqWu8s_2f+zXawKo-QpNSXq0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/4 4:33, Daeho Jeong wrote:
>>          if (f2fs_need_seq_seg(sbi))
>>                  return 0;
>>
>> static inline bool f2fs_need_seq_seg(struct f2fs_sb_info *sbi)
>> {
>>          return F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_FIXED_BLK;
>> }
>>
> 
> Do you need this in select_policy(), either?

IMO, for this mode, I prefer to disable background GC and just use newly
written userdata to fragment image, so I think it's fine to keep it as it is
here.

> Like,
>          if (f2fs_need_rand_seg(sbi))
>                  p->offset = prandom_u32() % (MAIN_SECS(sbi) *
> sbi->segs_per_sec);
>          else if (f2fs_need_seq_seg(sbi))
>                  p->offset = 0;
> 
>> One more concern... we'd better to save fragment_remained_hole as well
>> as fragment_remained_chunk,  otherwise, if fragment_chunk_size +
>> fragment_hole_size > 512, fragment hole will be truncated to 512 -
>> fragment_chunk_size due to we won't create hole with enough size as
>> seg->next_blkoff has crossed end of current segment.
>>
> 
> Sorry, I don't get it. You mean making fragment_remained_hole as a
> global variable?

As a per curseg field.

> Maybe, we run into the same race condition issue you told before for
> fragment_remained_chunk.
> Could you clarify this more?

e.g.

F2FS_OPTION(sbi).fs_mode = FS_MODE_FRAGMENT_FIXED_BLK
fragment_chunk_size = 384
fragment_hole_size = 384

When creating hole:

- f2fs_allocate_data_block
  - __refresh_next_blkoff
    chunk locates in [0, 383] of current segment
    seg->next_blkoff = 384
    sbi->fragment_remained_chunk = 0
    then we will reset sbi->fragment_remained_chunk to 384
    and move seg->next_blkoff forward to 768 (384 + 384)
  - __has_curseg_space() returns false
  - allocate_segment() allocates new current segment

So, for such case that hole may cross two segments, hole size may be truncated
to left size of previous segment.

Thanks,

> 
> Thanks,
> 
