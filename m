Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F160144DC54
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 20:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbhKKTzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 14:55:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28146 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229710AbhKKTzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 14:55:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636660348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rj4dBkXZNM78ldukFDcDyf4+5HD2eBVeG0uoftbTD2o=;
        b=jBFsqjKtlL4KqZIZIFr8MTswHHMbU0mrwBcFR+SPGUuvk42Rq1TpZw3q6vNuGPbinhhpYR
        IRrSuF4AL6LQBE1Q4bwtn+zwiQqmweWmAk7LZRFKM9hwU5T+6dtYlHFxsH3BIF8gQvZvBQ
        chitOPvreG1PvwxF3d/GYUkW9gSnRNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-EFx1BHRqNMa-dU5aRyVqkw-1; Thu, 11 Nov 2021 14:52:25 -0500
X-MC-Unique: EFx1BHRqNMa-dU5aRyVqkw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B77D18125C0;
        Thu, 11 Nov 2021 19:52:23 +0000 (UTC)
Received: from [10.22.8.202] (unknown [10.22.8.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 261AA56A87;
        Thu, 11 Nov 2021 19:52:20 +0000 (UTC)
Message-ID: <cd5e96e6-fbfd-487a-e308-13800c79ead3@redhat.com>
Date:   Thu, 11 Nov 2021 14:52:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [BUG]locking/rwsem: only clean RWSEM_FLAG_HANDOFF when already
 set
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        =?UTF-8?B?6ams5oyv5Y2O?= <mazhenhua@xiaomi.com>,
        mingo <mingo@redhat.com>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4fafad133b074f279dbab1aa3642e23f@xiaomi.com>
 <20211107090131.1535-1-hdanton@sina.com>
 <13d683ed-793c-b502-44ff-f28114d9386b@redhat.com>
 <02e118c0-2116-b806-2b48-b9c91dc847dd@redhat.com>
 <20211110213854.GE174703@worktop.programming.kicks-ass.net>
 <YY0x55wxO2v5HCOW@hirez.programming.kicks-ass.net>
 <61735528-141c-8d77-592d-b6b8fb75ebaa@redhat.com>
 <YY1s6v9b/tYtNnGv@hirez.programming.kicks-ass.net>
 <e16f9fc2-ce01-192b-065d-460c2ad9b317@redhat.com>
In-Reply-To: <e16f9fc2-ce01-192b-065d-460c2ad9b317@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/11/21 14:36, Waiman Long wrote:
>
> On 11/11/21 14:20, Peter Zijlstra wrote:
>> On Thu, Nov 11, 2021 at 02:14:48PM -0500, Waiman Long wrote:
>>> As for the PHASE_CHANGE name, we have to be consistent in both rwsem 
>>> and
>>> mutex. Maybe a follow up patch if you think we should change the
>>> terminology.
>> Well, that's exactly the point, they do radically different things.
>> Having the same name for two different things is confusing.
>>
>> Anyway, let me go read that patch you sent.
>
> My understanding of handoff is to disable optimistic spinning to let 
> waiters in the wait queue have an opportunity to acquire the lock. 
> There are difference in details on how to do that in mutex and rwsem, 
> though.
>
> BTW, I have decided that we should further simply the trylock for loop 
> in rwsem_down_write_slowpath() to make it easier to read. That is the 
> only difference in the attached v2 patch compared with the previous one.

My bad, I forgot to initialize waiter.handoff_set in 
rwsem_down_write_slowpath(). I will send out an updated version once you 
have finished your review.

Cheers,
Longman

