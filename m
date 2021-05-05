Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481F1373C9E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 15:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhEENpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 09:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbhEENpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 09:45:14 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3318AC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 06:44:17 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so1163184wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 06:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vGo0uaSeiqRbiJJntV4YHGdCi4Vglm15Og8RJv5hdxw=;
        b=lsT4c7fW2seoHEFcWqi/EUlaK275+SUmcNtHI0rmOwZRAKk9Ye4JeWKvH5JfLO1njt
         QEclKu7HioMy1tz34u9sRkmJq+AG4C64Y5G/RsUPGKRlgOQkiVQehMZdaOrVfh7hvKdG
         cjkzAHUc5JwPhsEN9K6xr8TwckkR9XBVV27oIgT3F8lRt0OQNvWl59ZIgSKINcNMElxH
         3UJ3qAZhGCmc3G//TmihejZd+U41Q3tlS7nsOMh0ZML3SC/3l3axwfHYGGHNXIaJ9Hw1
         OdExjplypD/AQyL3bE9YPKVL4EzYVuvpyS3nZ9bAKeiNhoxiWyBMYjXzJ3p10RwwK2+2
         E0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vGo0uaSeiqRbiJJntV4YHGdCi4Vglm15Og8RJv5hdxw=;
        b=DblokUM0kxwD5GbrURuuzPoGGL4zc2tkhs6NZWs5VqpzhfIQzm86HWZ4T4NXugwOxe
         fjjWKiCxN4ndU6Uv0O0xntSXB+l7vf874nH3ouCRjfAu8v5K6NlXecoQkU8fK2gEntQR
         yOV8eN0pibajXfj8paficilQD2NFDnwdFxgorTRV382SDAhZlFKw/QGE007MCpK3NLfP
         qqJOVEtMlSAB0FbWRSvcvg/+v8EFRfEJKUoqCVfSdvIrEDxQvkgNsNH61x0cIEs4bAoi
         F5LIdPF2DjAW+6XauWnWGWy2JPLhYJZp3rl6rv49c63B8B6vGaQECL1ZvCnKOwJd9jR8
         vu5w==
X-Gm-Message-State: AOAM532LQxeq9LBc0oBZ+A5qt365WUh8p7NAGW4UNJ2PAI91CaxqtKRw
        sv0Ko1WlhxwkG4LgkYaGAoa4XA==
X-Google-Smtp-Source: ABdhPJyho5v4PcTDt2yquNRz4vDJr02BBkkodow6e4p+jtNKl8kVY8kr+HIhXSwGVtuGl+rfgIEC1w==
X-Received: by 2002:a1c:f705:: with SMTP id v5mr8280704wmh.69.1620222255832;
        Wed, 05 May 2021 06:44:15 -0700 (PDT)
Received: from [192.168.228.233] ([37.163.176.75])
        by smtp.gmail.com with ESMTPSA id f4sm20206274wrz.33.2021.05.05.06.44.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 May 2021 06:44:14 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] bfq: silence lockdep for bfqd/ioc lock inversion
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20210415104722.GB25217@quack2.suse.cz>
Date:   Wed, 5 May 2021 15:35:55 +0200
Cc:     Khazhy Kumykov <khazhy@google.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5E86EBD7-9996-4429-8531-3BBED535FE33@linaro.org>
References: <20210319060015.3979352-1-khazhy@google.com>
 <20210414095455.GA29760@quack2.suse.cz>
 <CACGdZYJAoTjE3bbXS8ATRT6R3WHdY8P+q989RjKM_z_J7wpvyg@mail.gmail.com>
 <20210415104722.GB25217@quack2.suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan, Khazhy,
sorry for my super delay.  Thanks Khazy for spotting this, and Jan for
proposing alternative solutions.

> Il giorno 15 apr 2021, alle ore 12:47, Jan Kara <jack@suse.cz> ha =
scritto:
>=20
> On Wed 14-04-21 11:33:14, Khazhy Kumykov wrote:
>> On Wed, Apr 14, 2021 at 2:54 AM Jan Kara <jack@suse.cz> wrote:
>>>=20
>>> On Thu 18-03-21 23:00:15, Khazhismel Kumykov wrote:
>>>> lockdep warns of circular locking due to inversion between
>>>> bfq_insert_requests and bfq_exit_icq. If we end freeing a request =
when
>>>> merging, we *may* grab an ioc->lock if that request is the last =
refcount
>>>> to that ioc. bfq_bio_merge also potentially could have this =
ordering.
>>>> bfq_exit_icq, conversely, grabs bfqd but is always called with =
ioc->lock
>>>> held.
>>>>=20
>>>> bfq_exit_icq may either be called from put_io_context_active with =
ioc
>>>> refcount raised, ioc_release_fn after the last refcount was already
>>>> dropped, or ioc_clear_queue, which is only called while queue is
>>>> quiesced or exiting, so the inverted orderings should never =
conflict.
>>>>=20
>>>> Fixes: aee69d78dec0 ("block, bfq: introduce the BFQ-v0 I/O =
scheduler as
>>>> an extra scheduler")
>>>>=20
>>>> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
>>>=20
>>> I've just hit the same lockdep complaint. When looking at this =
another
>>> option to solve this complaint seemed to be to modify =
bfq_bio_merge() like:
>>>=20
>>>        ret =3D blk_mq_sched_try_merge(q, bio, nr_segs, &free);
>>>=20
>>> +       spin_unlock_irq(&bfqd->lock);
>>>        if (free)
>>>                blk_mq_free_request(free);
>>> -       spin_unlock_irq(&bfqd->lock);
>>>=20
>>>        return ret;
>>>=20
>>> to release request outside of bfqd->lock. Because AFAICT there's no =
good
>>> reason why we are actually freeing the request under bfqd->lock. And =
it
>>> would seem a bit safer than annotating-away the lockdep complaint =
(as much
>>> as I don't see a problem with your analysis). Paolo?
>>=20
>> If we can re-order the locking so we don't need the annotation, that
>> seems better ("inversion is OK so long as either we're frozen or we
>> have ioc refcount, and we only grab ioc->lock normally if we drop the
>> last refcount" is a tad "clever"). Though we still need to deal with
>> blk_mq_sched_try_insert_merge which can potentially free a request.
>=20
> I see, right.
>=20

Trying to put pieces together:
1) Moving ahead the invocation of spin_unlock_irq(&bfqd->lock) in
bfq_bio_merge(), as suggested by Jan, seems ok to me as well.  I also
proposed this change several years ago, but received no feedback.  So
I followed the conservative approach of not touching what apparently
works :)
2) If I'm not missing anything, then also what Jan suggests below is
ok.  That is, in blk_mq_sched_try_insert_merge, ioc->lock gets grabbed
only in case blk_mq_free_request is invoked.  So it is ok to simply move
the invocation of blk_mq_free_request outside
blk_mq_sched_try_insert_merge, using the same approach as with
blk_mq_sched_try_merge in bfq_bio_merge.

Thanks,
Paolo

>> (See the first stacktrace). Something simple that I wasn't sure of =
is:
>> could we delay bfq_exit_icq work, then avoid the inversion? Simpler =
to
>> analyze then.
>=20
> That's problematic because ICQ (referencing BFQQs etc.) is going to be
> freed after RCU grace period expires. So we cannot really postpone the
> teardown of bfq_io_cq. What we could do is to modify
> blk_mq_sched_try_insert_merge() so that it returns request to free
> similarly to blk_mq_sched_try_merge().  Then we can free the request =
after
> dropping bfqd->lock.
>=20
> 								Honza
>=20
>>>> ---
>>>> block/bfq-iosched.c | 9 ++++++++-
>>>> 1 file changed, 8 insertions(+), 1 deletion(-)
>>>>=20
>>>> Noticed this lockdep running xfstests (generic/464) on top of a bfq
>>>> block device. I was also able to tease it out w/ binary trying to =
issue
>>>> requests that would end up merging while rapidly swapping the =
active
>>>> scheduler. As far as I could see, the deadlock would not actually =
occur,
>>>> so this patch opts to change lock class for the inverted case.
>>>>=20
>>>> bfqd -> ioc :
>>>> [ 2995.524557] __lock_acquire+0x18f5/0x2660
>>>> [ 2995.524562] lock_acquire+0xb4/0x3a0
>>>> [ 2995.524565] _raw_spin_lock_irqsave+0x3f/0x60
>>>> [ 2995.524569] put_io_context+0x33/0x90.  -> ioc->lock grabbed
>>>> [ 2995.524573] blk_mq_free_request+0x51/0x140
>>>> [ 2995.524577] blk_put_request+0xe/0x10
>>>> [ 2995.524580] blk_attempt_req_merge+0x1d/0x30
>>>> [ 2995.524585] elv_attempt_insert_merge+0x56/0xa0
>>>> [ 2995.524590] blk_mq_sched_try_insert_merge+0x4b/0x60
>>>> [ 2995.524595] bfq_insert_requests+0x9e/0x18c0.    -> bfqd->lock =
grabbed
>>>> [ 2995.524598] blk_mq_sched_insert_requests+0xd6/0x2b0
>>>> [ 2995.524602] blk_mq_flush_plug_list+0x154/0x280
>>>> [ 2995.524606] blk_finish_plug+0x40/0x60
>>>> [ 2995.524609] ext4_writepages+0x696/0x1320
>>>> [ 2995.524614] do_writepages+0x1c/0x80
>>>> [ 2995.524621] __filemap_fdatawrite_range+0xd7/0x120
>>>> [ 2995.524625] sync_file_range+0xac/0xf0
>>>> [ 2995.524642] __x64_sys_sync_file_range+0x44/0x70
>>>> [ 2995.524646] do_syscall_64+0x31/0x40
>>>> [ 2995.524649] entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>>=20
>>>> ioc -> bfqd
>>>> [ 2995.524490] _raw_spin_lock_irqsave+0x3f/0x60
>>>> [ 2995.524498] bfq_exit_icq+0xa3/0xe0 -> bfqd->lock grabbed
>>>> [ 2995.524512] put_io_context_active+0x78/0xb0 -> ioc->lock grabbed
>>>> [ 2995.524516] exit_io_context+0x48/0x50
>>>> [ 2995.524519] do_exit+0x7e9/0xdd0
>>>> [ 2995.524526] do_group_exit+0x54/0xc0
>>>> [ 2995.524530] __x64_sys_exit_group+0x18/0x20
>>>> [ 2995.524534] do_syscall_64+0x31/0x40
>>>> [ 2995.524537] entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>>=20
>>>> Another trace where we grab ioc -> bfqd through bfq_exit_icq is =
when
>>>> changing elevator
>>>>               -> #1 (&(&bfqd->lock)->rlock){-.-.}:
>>>> [  646.890820]        lock_acquire+0x9b/0x140
>>>> [  646.894868]        _raw_spin_lock_irqsave+0x3b/0x50
>>>> [  646.899707]        bfq_exit_icq_bfqq+0x47/0x1f0
>>>> [  646.904196]        bfq_exit_icq+0x21/0x30
>>>> [  646.908160]        ioc_destroy_icq+0xf3/0x130
>>>> [  646.912466]        ioc_clear_queue+0xb8/0x140
>>>> [  646.916771]        elevator_switch_mq+0xa4/0x3c0
>>>> [  646.921333]        elevator_switch+0x5f/0x340
>>>>=20
>>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>>> index 95586137194e..cb50ac0ffe80 100644
>>>> --- a/block/bfq-iosched.c
>>>> +++ b/block/bfq-iosched.c
>>>> @@ -5027,7 +5027,14 @@ static void bfq_exit_icq_bfqq(struct =
bfq_io_cq *bic, bool is_sync)
>>>>      if (bfqq && bfqd) {
>>>>              unsigned long flags;
>>>>=20
>>>> -             spin_lock_irqsave(&bfqd->lock, flags);
>>>> +             /* bfq_exit_icq is usually called with ioc->lock =
held, which is
>>>> +              * inverse order from elsewhere, which may grab =
ioc->lock
>>>> +              * under bfqd->lock if we merge requests and drop the =
last ioc
>>>> +              * refcount. Since exit_icq is either called with a =
refcount,
>>>> +              * or with queue quiesced, use a differnet lock class =
to
>>>> +              * silence lockdep
>>>> +              */
>>>> +             spin_lock_irqsave_nested(&bfqd->lock, flags, 1);
>>>>              bfqq->bic =3D NULL;
>>>>              bfq_exit_bfqq(bfqd, bfqq);
>>>>              bic_set_bfqq(bic, NULL, is_sync);
>>>> --
>>>> 2.31.0.rc2.261.g7f71774620-goog
>>>>=20
>>> --
>>> Jan Kara <jack@suse.com>
>>> SUSE Labs, CR
>=20
>=20
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

