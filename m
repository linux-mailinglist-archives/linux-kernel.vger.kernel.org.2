Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C36332AF3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhCIPqc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 Mar 2021 10:46:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:37874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231591AbhCIPqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:46:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C2D41AE84;
        Tue,  9 Mar 2021 15:46:19 +0000 (UTC)
Date:   Tue, 9 Mar 2021 07:46:11 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Michal =?utf-8?B?U3VjaMOvwr/CvW5law==?= <msuchanek@suse.de>
Cc:     npiggin@gmail.com, Davidlohr Bueso <dbueso@suse.de>,
        peterz@infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, paulus@samba.org,
        longman@redhat.com, will@kernel.org
Subject: Re: [PATCH 3/3] powerpc/qspinlock: Use generic smp_cond_load_relaxed
Message-ID: <20210309154611.kbxzx65auzvmfqnt@offworld>
References: <20210309015950.27688-1-dave@stgolabs.net>
 <20210309015950.27688-4-dave@stgolabs.net>
 <20210309093912.GW6564@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210309093912.GW6564@kitsune.suse.cz>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Mar 2021, Michal Such�nek wrote:

>On Mon, Mar 08, 2021 at 05:59:50PM -0800, Davidlohr Bueso wrote:
>> 49a7d46a06c3 (powerpc: Implement smp_cond_load_relaxed()) added
>> busy-waiting pausing with a preferred SMT priority pattern, lowering
>> the priority (reducing decode cycles) during the whole loop slowpath.
>>
>> However, data shows that while this pattern works well with simple
>                                              ^^^^^^^^^^^^^^^^^^^^^^
>> spinlocks, queued spinlocks benefit more being kept in medium priority,
>> with a cpu_relax() instead, being a low+medium combo on powerpc.
>...
>>
>> diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
>> index aecfde829d5d..7ae29cfb06c0 100644
>> --- a/arch/powerpc/include/asm/barrier.h
>> +++ b/arch/powerpc/include/asm/barrier.h
>> @@ -80,22 +80,6 @@ do {									\
>>	___p1;								\
>>  })
>>
>> -#ifdef CONFIG_PPC64
>Maybe it should be kept for the simple spinlock case then?

It is kept, note that simple spinlocks don't use smp_cond_load_relaxed,
but instead deal with the priorities in arch_spin_lock(), so it will
spin in low priority until it sees a chance to take the lock, where
it switches back to medium.

Thanks,
Davidlohr
