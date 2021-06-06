Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4560A39D1D3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 00:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhFFWPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 18:15:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47083 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230514AbhFFWPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 18:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623017644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iosAm+f1XXquGfWTgQDxbtIMOzIFmMntfY/zG8ojX8Q=;
        b=BHzUo2xOSU3yOkBedgMd+dc/1wR4EZkEoSKIDBzaFBpfF75p5+Q26e7fmHwy89yr2zpuZi
        s3q7srTJUA5wAzE6wlaMbZaeLqRfZJK9efMF2WDeZMRtEMf/U+MgeEsCLENWuBdCFLbVQQ
        tfWJeotO/lyYK70HTCeRdc+m8XZ5FGQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-alAEH6gHN22ru9udyKJkZw-1; Sun, 06 Jun 2021 18:14:02 -0400
X-MC-Unique: alAEH6gHN22ru9udyKJkZw-1
Received: by mail-qv1-f70.google.com with SMTP id z93-20020a0ca5e60000b02901ec19d8ff47so11736527qvz.8
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 15:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iosAm+f1XXquGfWTgQDxbtIMOzIFmMntfY/zG8ojX8Q=;
        b=mNfS4OwH0rrymX/jBh/sc/FrMVlmlr6NSfOO3XzKu8UGKSzdXOQN+ktWqzdq0NPJRO
         D6kEEdyiBTAlfoJT28I1HPqUeXjsgo9Iw9TlwaDqmbCg0n1KbIViM6Rj8MbsM9NM7pod
         9PLdSFo1sVYKt08KKX9+vGAc+ns6S8imb8ZXLGTziqk5fVFpMv2Wvdi8Y0mOTpvdJQ8o
         mdDSsuHuMTTgc3Y/wLkJ+eX+CM3jGeFXyh9KhDxeg5wZ2KWV4dHQ/gcbs9nVXDH9DvXO
         FU179HUofIkbX70LSzNKkuCkJlE6gJHDYbATdASqONIJsdT7tneyKxW3WxFoC/+jO1IT
         aIYg==
X-Gm-Message-State: AOAM532IsRjG8qmJQmS4E0PqJaJYdICxu6sSp+8y9SEJ1VI9l3gdmHbz
        rBIS/0tRvFnG4FXMa2+5Vd+VoZ/wQqQQsftBgLLnt/BT+qBr5vTXM0lNID/U9cmAIYEzmkiPpBP
        0bDjn0PwFyaHKz0EO9x8kMVwF
X-Received: by 2002:a05:6214:207:: with SMTP id i7mr15432191qvt.10.1623017642242;
        Sun, 06 Jun 2021 15:14:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwy/sMs941k9DrojA+k9lXG7El+mHynHHIcmf6djQWNk7XRx5yFUA9+SJ4HyWHhpmqAy+ujxg==
X-Received: by 2002:a05:6214:207:: with SMTP id i7mr15432173qvt.10.1623017642009;
        Sun, 06 Jun 2021 15:14:02 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id c68sm8481746qkd.112.2021.06.06.15.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 15:14:01 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [mm/gup] 57efa1fe59: will-it-scale.per_thread_ops -9.2%
 regression
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Feng Tang <feng.tang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        kernel test robot <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>, zhengjun.xing@intel.com
References: <20210525031636.GB7744@xsang-OptiPlex-9020>
 <CAHk-=whTEC_GVYu=WfvUagNvHdoTALEDg8uqK3V6aMDwg2KMRA@mail.gmail.com>
 <20210604070411.GA8221@shbuild999.sh.intel.com>
 <20210604075220.GA40621@shbuild999.sh.intel.com>
 <CAHk-=wg=LX1WKioiA_Cn-5hp6Hce_kTZg23uksSjNWgV_Ofj1Q@mail.gmail.com>
 <20210606101623.GA48020@shbuild999.sh.intel.com>
 <CAHk-=whoqV=cX5VC80mmR9rr+Z+yQ6fiQZm36Fb-izsanHg23w@mail.gmail.com>
Message-ID: <d0506f70-81a3-80b6-e47a-8986b3d62733@redhat.com>
Date:   Sun, 6 Jun 2021 18:13:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whoqV=cX5VC80mmR9rr+Z+yQ6fiQZm36Fb-izsanHg23w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/21 3:20 PM, Linus Torvalds wrote:
> [ Adding Waiman Long to the participants, because this seems to be a
> very specific cacheline alignment behavior of rwsems, maybe Waiman has
> some comments ]
>
> On Sun, Jun 6, 2021 at 3:16 AM Feng Tang <feng.tang@intel.com> wrote:
>> * perf-c2c: The hotspots(HITM) for 2 kernels are different due to the
>>    data structure change
>>
>>    - old kernel
>>
>>      - first cacheline
>>          mmap_lock->count (75%)
>>          mm->mapcount (14%)
>>
>>      - second cacheline
>>          mmap_lock->owner (97%)
>>
>>    - new kernel
>>
>>      mainly in the cacheline of 'mmap_lock'
>>
>>      mmap_lock->count (~2%)
>>      mmap_lock->owner (95%)
> Oooh.
>
> It looks like pretty much all the contention is on mmap_lock, and the
> difference is that the old kernel just _happened_ to split the
> mmap_lock rwsem at *exactly* the right place.
>
> The rw_semaphore structure looks like this:
>
>          struct rw_semaphore {
>                  atomic_long_t count;
>                  atomic_long_t owner;
>                  struct optimistic_spin_queue osq; /* spinner MCS lock */
>                  ...
>
> and before the addition of the 'write_protect_seq' field, the mmap_sem
> was at offset 120 in 'struct mm_struct'.
>
> Which meant that count and owner were in two different cachelines, and
> then when you have contention and spend time in
> rwsem_down_write_slowpath(), this is probably *exactly* the kind of
> layout you want.
>
> Because first the rwsem_write_trylock() will do a cmpxchg on the first
> cacheline (for the optimistic fast-path), and then in the case of
> contention, rwsem_down_write_slowpath() will just access the second
> cacheline.
>
> Which is probably just optimal for a load that spends a lot of time
> contended - new waiters touch that first cacheline, and then they
> queue themselves up on the second cacheline. Waiman, does that sound
> believable?

Yes, I think so.

The count field is accessed when a task tries to acquire the rwsem or 
when a owner releases the lock. If the trylock fails, the writer will go 
into the slowpath doing optimistic spinning on the owner field. As a 
result, a lot of reads to owner are issued relative to the read/write of 
count. Normally, there should only be one spinner that has the OSQ lock 
spinning on owner and the 9% performance degradation seems a bit high to 
me. In the rare case that the head waiter in the wait queue sets the 
handoff flag, the waiter may also spin on owner causing a bit more 
contention on the owner cacheline. I will do further investigation on 
this possibility when I have time.

Cheers,
Longman

