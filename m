Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C052933F116
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 14:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhCQNWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 09:22:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230493AbhCQNWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 09:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615987328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c7PX0Ouqc0wpf5nfLiEOChbTdIbo+J19ZguBEuOi78Q=;
        b=CgjFQH1CA+tU+RBqM7TnwxsVT5KHsTHW3uMaS9fVKJyL3Tme1hqpGFbZHIPM1ZctgB5+n1
        MJCVMcyGNR5HObYAAYkjxjJJtJJzuUetYgDbGlOuPMPV6CKiB+TFpiyjteZbENOkFiD12Q
        HyhKrU4O2RBBFJlt3U94GbFrKp0hYyc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-p0MDTkMaNn6ID8k-MxtV2w-1; Wed, 17 Mar 2021 09:22:03 -0400
X-MC-Unique: p0MDTkMaNn6ID8k-MxtV2w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F15D0E845A;
        Wed, 17 Mar 2021 13:21:51 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-171.rdu2.redhat.com [10.10.117.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C4175C1CF;
        Wed, 17 Mar 2021 13:21:51 +0000 (UTC)
Subject: Re: [PATCH 4/4] locking/locktorture: Fix incorrect use of
 ww_acquire_ctx in ww_mutex test
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
References: <20210316153119.13802-1-longman@redhat.com>
 <20210316153119.13802-5-longman@redhat.com>
 <20210317051605.popetodgwbr47ha2@offworld>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <ae20c4a1-1591-4b09-6de2-e55c30297d24@redhat.com>
Date:   Wed, 17 Mar 2021 09:21:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317051605.popetodgwbr47ha2@offworld>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 1:16 AM, Davidlohr Bueso wrote:
> On Tue, 16 Mar 2021, Waiman Long wrote:
>
>> The ww_acquire_ctx structure for ww_mutex needs to persist for a 
>> complete
>> lock/unlock cycle. In the ww_mutex test in locktorture, however, both
>> ww_acquire_init() and ww_acquire_fini() are called within the lock
>> function only. This causes a lockdep splat of "WARNING: Nested lock
>> was not taken" when lockdep is enabled in the kernel.
>>
>> To fix this problem, we need to move the ww_acquire_fini() after the
>> ww_mutex_unlock() in torture_ww_mutex_unlock(). In other word, we need
>> to pass state information from the lock function to the unlock function.
>
> Right, and afaict this _is_ the way ww_acquire_fini() should be called:
>
>  * Releases a w/w acquire context. This must be called _after_ all 
> acquired w/w
>  * mutexes have been released with ww_mutex_unlock.
>
>> Change the writelock and writeunlock function prototypes to allow that
>> and change the torture_ww_mutex_lock() and torture_ww_mutex_unlock()
>> accordingly.
>
> But wouldn't just making ctx a global variable be enough instead? That 
> way
> we don't deal with memory allocation for every lock/unlock operation 
> (yuck).
> Plus the ENOMEM would need to be handled/propagated accordingly - the 
> code
> really doesn't expect any failure from ->writelock().

The ctx should be per-thread to track potential locking conflict. Since 
there are as many locking threads as the number of cpus, we can't use 
one global variable to do that. I was thinking about using per-cpu 
variable but locktorture kthreads are cpu-bound. That led me to use the 
current scheme of allocation at lock and free at unlock.

Another alternative is to add a per-thread init/fini methods to allow 
setting up per-thread context that is passed to the locking functions. 
By doing that, we only need one kmalloc/kfree pair per running 
locktorture kthread.

Cheers,
Longman


