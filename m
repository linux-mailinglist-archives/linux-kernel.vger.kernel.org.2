Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFB333EDE6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhCQKCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhCQKCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:02:25 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E82C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 03:02:25 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id o16so7494881pgu.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 03:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=VRdKUeBJF14EBQDle28LuVLrfRqd1FuunOrC7P4iCGA=;
        b=j8Smgahk11yOIZKXamxJByWrMD4aof3r/P/f11TckO1l/T/dJQI/d16jvc13pvkjcg
         mwI5hlplJgQQKhfB4zH3w3XrX4rF6ye/QTzeBHp3XUD2GDeqO/3G3nKWs+6nEXI4RtfF
         4gH0vJ5iacpxpHo2XjshTWDGmRILPm6nCEVW/gbj32lc7GL8dno2LyozauHkJbtO2k0V
         uYJoCUdNdtafYGQTTWfwkUi7Q2HFpqwf1+Sl+fvsaIs2lTLK39BMBGuwoFTUTqeGyriU
         P9rQWlCo+a1YjnDohp4r0NEi9t31bLpuRCIrzPpNgrvABprwMXMgW7uy1FWfUKBSvr50
         Ygzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=VRdKUeBJF14EBQDle28LuVLrfRqd1FuunOrC7P4iCGA=;
        b=L9a+yY/Y5ic9JTgF4c7EzLfNYz9Xbc2Bh7+wQnr278HmARyDfa4d2Ubv9CvbOWLNf8
         LhHr+psNVEj9ISekxExKEQJS4avgFCuKtGxFGjDt7jda4ogmjiLscCQtW8jCb4hUw0rl
         tanh/NduhcnP4NcqDXua3Uh+wa6thq2bczStTFiguC9ov6fC/SI6n93QhSsTAAzbBlTQ
         l4jV5rmIP1yvZ2Z7M9IRT2siw4AqjiYOnR2P0ywNO8NxXo2pkUdzH1Bcp+qqCFLp7bhc
         WQEstB0uabp+8ROGusJHzrlx6Ko0Uvwqg4SzAv2qjr8ZnmixfJ6lnjdtudV/vcFoKeOX
         wMag==
X-Gm-Message-State: AOAM5312gmbazxY56G4b2eq2tINqyxtJ9Dk2qwrkfYhZcYINCXQMMzc6
        gZ83sNDzL0RdZQfJKk+/Y6A=
X-Google-Smtp-Source: ABdhPJwuZqztzuQ0kxb8UAhQbcX4r9oMUGr4LwbHDSh8zr1SVQk+2misQF3E9987zrPqQKhiz19Ttw==
X-Received: by 2002:aa7:9ecf:0:b029:1f4:f737:12d6 with SMTP id r15-20020aa79ecf0000b02901f4f73712d6mr3659854pfq.8.1615975344555;
        Wed, 17 Mar 2021 03:02:24 -0700 (PDT)
Received: from localhost (58-6-239-121.tpgi.com.au. [58.6.239.121])
        by smtp.gmail.com with ESMTPSA id fa21sm2086178pjb.25.2021.03.17.03.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 03:02:23 -0700 (PDT)
Date:   Wed, 17 Mar 2021 20:02:18 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] Increase page and bit waitqueue hash size
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anton Blanchard <anton@ozlabs.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210317075427.587806-1-npiggin@gmail.com>
        <20210317083830.GC3881262@gmail.com>
In-Reply-To: <20210317083830.GC3881262@gmail.com>
MIME-Version: 1.0
Message-Id: <1615974423.0rc8elykcq.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Ingo Molnar's message of March 17, 2021 6:38 pm:
>=20
> * Nicholas Piggin <npiggin@gmail.com> wrote:
>=20
>> The page waitqueue hash is a bit small (256 entries) on very big systems=
. A
>> 16 socket 1536 thread POWER9 system was found to encounter hash collisio=
ns
>> and excessive time in waitqueue locking at times. This was intermittent =
and
>> hard to reproduce easily with the setup we had (very little real IO
>> capacity). The theory is that sometimes (depending on allocation luck)
>> important pages would happen to collide a lot in the hash, slowing down =
page
>> locking, causing the problem to snowball.
>>=20
>> An small test case was made where threads would write and fsync differen=
t
>> pages, generating just a small amount of contention across many pages.
>>=20
>> Increasing page waitqueue hash size to 262144 entries increased throughp=
ut
>> by 182% while also reducing standard deviation 3x. perf before the incre=
ase:
>>=20
>>   36.23%  [k] _raw_spin_lock_irqsave                -      -
>>               |
>>               |--34.60%--wake_up_page_bit
>>               |          0
>>               |          iomap_write_end.isra.38
>>               |          iomap_write_actor
>>               |          iomap_apply
>>               |          iomap_file_buffered_write
>>               |          xfs_file_buffered_aio_write
>>               |          new_sync_write
>>=20
>>   17.93%  [k] native_queued_spin_lock_slowpath      -      -
>>               |
>>               |--16.74%--_raw_spin_lock_irqsave
>>               |          |
>>               |           --16.44%--wake_up_page_bit
>>               |                     iomap_write_end.isra.38
>>               |                     iomap_write_actor
>>               |                     iomap_apply
>>               |                     iomap_file_buffered_write
>>               |                     xfs_file_buffered_aio_write
>>=20
>> This patch uses alloc_large_system_hash to allocate a bigger system hash
>> that scales somewhat with memory size. The bit/var wait-queue is also
>> changed to keep code matching, albiet with a smaller scale factor.
>>=20
>> A very small CONFIG_BASE_SMALL option is also added because these are tw=
o
>> of the biggest static objects in the image on very small systems.
>>=20
>> This hash could be made per-node, which may help reduce remote accesses
>> on well localised workloads, but that adds some complexity with indexing
>> and hotplug, so until we get a less artificial workload to test with,
>> keep it simple.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  kernel/sched/wait_bit.c | 30 +++++++++++++++++++++++-------
>>  mm/filemap.c            | 24 +++++++++++++++++++++---
>>  2 files changed, 44 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
>> index 02ce292b9bc0..dba73dec17c4 100644
>> --- a/kernel/sched/wait_bit.c
>> +++ b/kernel/sched/wait_bit.c
>> @@ -2,19 +2,24 @@
>>  /*
>>   * The implementation of the wait_bit*() and related waiting APIs:
>>   */
>> +#include <linux/memblock.h>
>>  #include "sched.h"
>> =20
>> -#define WAIT_TABLE_BITS 8
>> -#define WAIT_TABLE_SIZE (1 << WAIT_TABLE_BITS)
>=20
> Ugh, 256 entries is almost embarrassingly small indeed.
>=20
> I've put your patch into sched/core, unless Andrew is objecting.

Thanks. Andrew and Linux might have some opinions on it, but if it's=20
just in a testing branch for now that's okay.


>=20
>> -	for (i =3D 0; i < WAIT_TABLE_SIZE; i++)
>> +	if (!CONFIG_BASE_SMALL) {
>> +		bit_wait_table =3D alloc_large_system_hash("bit waitqueue hash",
>> +							sizeof(wait_queue_head_t),
>> +							0,
>> +							22,
>> +							0,
>> +							&bit_wait_table_bits,
>> +							NULL,
>> +							0,
>> +							0);
>> +	}
>> +	for (i =3D 0; i < BIT_WAIT_TABLE_SIZE; i++)
>>  		init_waitqueue_head(bit_wait_table + i);
>=20
>=20
> Meta suggestion: maybe the CONFIG_BASE_SMALL ugliness could be folded=20
> into alloc_large_system_hash() itself?

I don't like the ugliness and that's a good suggestion in some ways, but=20
having the constant size and table is nice for the small system. I don't=20
know, maybe we need to revise the alloc_large_system_hash API slightly.

Having some kind of DEFINE_LARGE_ARRAY perhaps then you could have both
static and dynamic? I'll think about it.

>=20
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>=20
>>  static wait_queue_head_t *page_waitqueue(struct page *page)
>>  {
>> -	return &page_wait_table[hash_ptr(page, PAGE_WAIT_TABLE_BITS)];
>> +	return &page_wait_table[hash_ptr(page, page_wait_table_bits)];
>>  }
>=20
> I'm wondering whether you've tried to make this NUMA aware through=20
> page->node?
>=20
> Seems like another useful step when having a global hash ...

Yes I have patches for that on the back burner. Just wanted to try one
step at a time, but I think we should be able to justify it (a well=20
NUMAified workload will tend to store mostly to local page waitqueue so=20
keep cacheline contention within the node). We need to get some access=20
to a big system again and try get some more IO on it at some point, so=20
stay tuned for that.

We actually used to have similar to this, but Linux removed it with
9dcb8b685fc30.

The difference now is that the page waitqueue has been split out from
the bit waitqueue. Doing the page waitqueue is much easier because we
don't have the vmalloc problem to deal with. But still it's some
complexity.

We also do have the page contention bit that Linus refers to which takes=20
pressure off the waitqueues (which is probably why 256 entries has held=20
up surprisingly well), but as we can see we do need larger at the high
end.

Thanks,
Nick
