Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B2F3420F9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 16:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhCSPaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 11:30:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60485 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230113AbhCSP3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616167794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y2Hh+ZOEXqlhe5CW9lR4XeJK2O5j49qZPg7bwfxiYhE=;
        b=XFe6zgMvO/w7WaVDTFl7QKmGOz09n6z9LyRp1Hx+V1mo3sGRTBjGnRiLENqHJe4WCSIsi0
        qwmARE07PZKky5dgVQoo+DH2peAX8suldKapvMd4l+PCyxF1m6apPTs+rcKI0GiPaYOT3x
        5n5GhSQc5EzFTK0MDGtHVRf2nSYAPYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-0Ckpx81WPUO0LbYLr8CAQQ-1; Fri, 19 Mar 2021 11:29:46 -0400
X-MC-Unique: 0Ckpx81WPUO0LbYLr8CAQQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7746B19251A3;
        Fri, 19 Mar 2021 15:29:45 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-18.rdu2.redhat.com [10.10.118.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CC1B1C94B;
        Fri, 19 Mar 2021 15:29:41 +0000 (UTC)
Subject: Re: [PATCH-tip 0/5] locking/locktorture: Fix locktorture ww_mutex
 test problems
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
References: <20210318172814.4400-1-longman@redhat.com>
 <20210319111629.GB4029764@gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <2e195484-e011-faab-f6b0-1cfeecc5f3bf@redhat.com>
Date:   Fri, 19 Mar 2021 11:29:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210319111629.GB4029764@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/21 7:16 AM, Ingo Molnar wrote:
> * Waiman Long <longman@redhat.com> wrote:
>
>> This is a follow-up patch series for the previous patchset on fixing
>> locktorture ww_mutex test problem [1]. The first 3 patches of that
>> series were merged into tip. It turns out that the last one of the
>> three wasn't quite right. So this patch series revert the last patch.
>>
>> The rests of the patch series fix the ww_mutex testing problem in
>> locktorture as well as removing the DEFINE_WW_MUTEX() macro from
>> include/linux/ww_mutex.h.
>>
>> [1] https://lore.kernel.org/lkml/20210316153119.13802-1-longman@redhat.com/
>>
>> Waiman Long (5):
>>    locking/ww_mutex: Revert "Treat ww_mutex_lock() like a trylock"
>>    locking/locktorture: Fix false positive circular locking splat in
>>      ww_mutex test
>>    locking/ww_mutex: Remove DEFINE_WW_MUTEX() macro
>>    locking/locktorture: Pass thread id to lock/unlock functions
>>    locking/locktorture: locking/locktorture: Fix incorrect use of
>>      ww_acquire_ctx in ww_mutex test
> Applied, thanks Waiman.
>
> I kept these two fixes in locking/urgent, for a v5.12 merge:
>
>    bee645788e07: ("locking/ww_mutex: Fix acquire/release imbalance in ww_acquire_init()/ww_acquire_fini()")
>    5de2055d31ea: ("locking/ww_mutex: Simplify use_ww_ctx & ww_ctx handling")
>
> As this bug could affect actual ww_mutex users.
>
> And queued up these four in locking/core, for a v5.13 merge:
>
>    8c52cca04f97: ("locking/locktorture: Fix incorrect use of ww_acquire_ctx in ww_mutex test")
>    aa3a5f31877e: ("locking/locktorture: Pass thread id to lock/unlock functions")
>    5261ced47f8e: ("locking/ww_mutex: Remove DEFINE_WW_MUTEX() macro")
>    2ea55bbba23e: ("locking/locktorture: Fix false positive circular locking splat in ww_mutex test")
>
> As these bugs are basically limited to a debugging facility.
>
> ( But we could also merge them into v5.12, if you think it's
>    justified. No strong opinions either way. )

I think v5.13 merge is fine. This problem exists for quite a while and 
no one notices it. So it is not really that urgent.

Thank a lot for the quick action.

Cheers,
Longman

