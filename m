Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C11F4534B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 15:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbhKPOzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 09:55:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237517AbhKPOzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 09:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637074327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GyhFp6+j5PwZ3sXjCgW2k0Bqwg1GAQsXc3GmUOwaBw8=;
        b=ZUahYhbygCSrNXvEY3E3T45r4+uUAt1u+SFQudsO5BcU9G+G67l+htV2VKeRi1p2kKcaDU
        GcPWO5a07vzggOW7V3gUp5PhiWwK0Wma4aqcSIq0f4BmUxQmrw92irTFZ4QY8fnzXHxWRW
        tV1TBKEwohU2I2P9j/7V6PbG72Mjl+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-72-hENH1xvQPaKMymhnhpT8Yw-1; Tue, 16 Nov 2021 09:52:06 -0500
X-MC-Unique: hENH1xvQPaKMymhnhpT8Yw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACAF187D541;
        Tue, 16 Nov 2021 14:52:04 +0000 (UTC)
Received: from [10.22.18.33] (unknown [10.22.18.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 559492AF6D;
        Tue, 16 Nov 2021 14:52:03 +0000 (UTC)
Message-ID: <d62f8864-2f66-b4ab-2c46-87e6c37a0154@redhat.com>
Date:   Tue, 16 Nov 2021 09:52:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5] locking/rwsem: Make handoff bit handling more
 consistent
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        mazhenhua <mazhenhua@xiaomi.com>, Hillf Danton <hdanton@sina.com>
References: <20211116012912.723980-1-longman@redhat.com>
 <32b433a1-31f9-14ba-e8f6-87b69c2c4ac9@quicinc.com>
 <20211116091420.GA174703@worktop.programming.kicks-ass.net>
 <20211116092412.GL174730@worktop.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211116092412.GL174730@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/16/21 04:24, Peter Zijlstra wrote:
> On Tue, Nov 16, 2021 at 10:14:20AM +0100, Peter Zijlstra wrote:
>> On Tue, Nov 16, 2021 at 10:52:42AM +0800, Aiqun(Maria) Yu wrote:
>>> On 11/16/2021 9:29 AM, Waiman Long wrote:
>>>> There are some inconsistency in the way that the handoff bit is being
>>>> handled in readers and writers.
>>>>
>>>> Firstly, when a queue head writer set the handoff bit, it will clear it
>>>> when the writer is being killed or interrupted on its way out without
>>>> acquiring the lock. That is not the case for a queue head reader. The
>>>> handoff bit will simply be inherited by the next waiter.
>>>>
>>>> Secondly, in the out_nolock path of rwsem_down_read_slowpath(), both
>>>> the waiter and handoff bits are cleared if the wait queue becomes empty.
>>>> For rwsem_down_write_slowpath(), however, the handoff bit is not checked
>>>> and cleared if the wait queue is empty. This can potentially make the
>>>> handoff bit set with empty wait queue.
>>>>
>>>> To make the handoff bit handling more consistent and robust, extract
>>>> out handoff bit clearing code into the new rwsem_del_waiter() helper
>>>> function.  The common function will only use atomic_long_andnot() to
>>>> clear bits when the wait queue is empty to avoid possible race condition.
>>> we do have race condition needed to be fixed with this change.
>> Indeed, let me edit the changelog to reflect that. Also, I think, it
>> needs a Reported-by:.
> How's something liks so then?
>
> ---
> Subject: locking/rwsem: Make handoff bit handling more consistent
> From: Waiman Long <longman@redhat.com>
> Date: Mon, 15 Nov 2021 20:29:12 -0500
>
> From: Waiman Long <longman@redhat.com>
>
> There are some inconsistency in the way that the handoff bit is being
> handled in readers and writers that lead to a race condition.
>
> Firstly, when a queue head writer set the handoff bit, it will clear
> it when the writer is being killed or interrupted on its way out
> without acquiring the lock. That is not the case for a queue head
> reader. The handoff bit will simply be inherited by the next waiter.
>
> Secondly, in the out_nolock path of rwsem_down_read_slowpath(), both
> the waiter and handoff bits are cleared if the wait queue becomes
> empty.  For rwsem_down_write_slowpath(), however, the handoff bit is
> not checked and cleared if the wait queue is empty. This can
> potentially make the handoff bit set with empty wait queue.
>
> Worse, the situation in rwsem_down_write_slowpath() relies on wstate,
> a variable set outside of the critical section containing the ->count
> manipulation, this leads to race condition where RWSEM_FLAG_HANDOFF
> can be double subtracted, corrupting ->count.
>
> To make the handoff bit handling more consistent and robust, extract
> out handoff bit clearing code into the new rwsem_del_waiter() helper
> function. Also, completely eradicate wstate; always evaluate
> everything inside the same critical section.
>
> The common function will only use atomic_long_andnot() to clear bits
> when the wait queue is empty to avoid possible race condition.  If the
> first waiter with handoff bit set is killed or interrupted to exit the
> slowpath without acquiring the lock, the next waiter will inherit the
> handoff bit.
>
> While at it, simplify the trylock for loop in
> rwsem_down_write_slowpath() to make it easier to read.
>
> Fixes: 4f23dbc1e657 ("locking/rwsem: Implement lock handoff to prevent lock starvation")
> Reported-by: Zhenhua Ma <mazhenhua@xiaomi.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20211116012912.723980-1-longman@redhat.com
> ---
>
Yes, that looks good to me. Thanks for the editing.

Cheers,
Longman

