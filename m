Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71713417E9E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 02:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhIYAcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 20:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33573 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229575AbhIYAb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 20:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632529824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LSfWBp7aEuRw32cBv/2ZxfQ/Vo2SZYOYdv6FBtLZkb8=;
        b=Il8v89mCZCwDB/bXWDqHzSHZPPSJfsCaZqILeLaZCrEMRBi2NXt3JDOynr6xQy4gcotltx
        wDkr6FWvWyC7q28mRsqdi4DJS7qLu3LarTqrC2V/KFqEI4re/6fEwK4BxzsQTvRXWqntj/
        Im0RufOzhPPyusfRaPf6hD4HE64wyd4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-X-Yb1ei9M3O92teH1mwreA-1; Fri, 24 Sep 2021 20:30:22 -0400
X-MC-Unique: X-Yb1ei9M3O92teH1mwreA-1
Received: by mail-qv1-f70.google.com with SMTP id h18-20020ad446f2000000b0037a7b48ba05so42413926qvw.19
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 17:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LSfWBp7aEuRw32cBv/2ZxfQ/Vo2SZYOYdv6FBtLZkb8=;
        b=yYJqaKkF9Hiv1/eoUqgqhWxbC09XYyj4v91yRMk30wfLLETU2F65iFKCSd8DXKg2VW
         9tU50piA8vyixK/KQl15EZSzPcNRflxcxwTgXZILLMQ/4YJry0bW+JLzEVOiCzGs7sk6
         oLEHnxs2o70PBIy5VZw77AyYaaKwbD/+sZb/lySeuSz0x4NGwjtZrOlmE4us3Xsd2JcL
         jU+NfI+hPhbzdrw+r2OE8doQcX33JMp1AkxZVNDBDddEjCKMM4YGJOWJxbwWU/NN2Ad6
         c6m4IlufXKF3c4cnlMUDj743p5Z/SggWLByCzcouxBpfzRtDQ6wzETMrTg+dQiDOALhY
         mDUQ==
X-Gm-Message-State: AOAM530L+rT8mZZ6qvzYUjlh7GhR4JnK9g/EAqJhwV1boVo9/8Q5yvZi
        fVX2unkciDLF5syys/PfDlsotbP1PYIP+WLcwOewdFjU3279vNup/iYpdbh4b+npZ3//wb4W/Yp
        w80DgKtDUR5d8rCgRuJI5A3BN
X-Received: by 2002:a37:48c:: with SMTP id 134mr12807082qke.233.1632529822301;
        Fri, 24 Sep 2021 17:30:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZ6hKoql5YNrypDpDeY/5mad2FlvkBeJBnqMFQV7YpktD4hsyxv/68aKcG0r9HCFgGxQa8rQ==
X-Received: by 2002:a37:48c:: with SMTP id 134mr12807069qke.233.1632529822083;
        Fri, 24 Sep 2021 17:30:22 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id x9sm7289962qko.125.2021.09.24.17.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 17:30:21 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: Confusing lockdep splat
To:     paulmck@kernel.org, Waiman Long <llong@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org, richard@nod.at
References: <20210924210247.GA3877322@paulmck-ThinkPad-P17-Gen-1>
 <d8cb4445-cb01-4405-8800-a3eefa253af1@redhat.com>
 <20210924224337.GL880162@paulmck-ThinkPad-P17-Gen-1>
Message-ID: <ce4e1130-203b-095d-be4e-5b3a05a08ba7@redhat.com>
Date:   Fri, 24 Sep 2021 20:30:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210924224337.GL880162@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/21 6:43 PM, Paul E. McKenney wrote:
> On Fri, Sep 24, 2021 at 05:41:17PM -0400, Waiman Long wrote:
>> On 9/24/21 5:02 PM, Paul E. McKenney wrote:
>>> Hello!
>>>
>>> I got the lockdep splat below from an SRCU-T rcutorture run, which uses
>>> a !SMP !PREEMPT kernel.  This is a random event, and about half the time
>>> it happens within an hour or two.  My reproducer (on current -rcu "dev"
>>> branch for a 16-CPU system) is:
>>>
>>> 	tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 16 --configs "16*SRCU-T" --duration 7200
>>>
>>> My points of confusion are as follows:
>>>
>>> 1.	The locks involved in this deadlock cycle are irq-disabled
>>> 	raw spinlocks.	The claimed deadlock cycle uses two CPUs.
>>> 	There is only one CPU.	There is no possibility of preemption
>>> 	or interrupts.	So how can this deadlock actually happen?
>>>
>>> 2.	If there was more than one CPU, then yes, there would be
>>> 	a deadlock.  The PI lock is acquired by the wakeup code after
>>> 	acquiring the workqueue lock, and rcutorture tests the new ability
>>> 	of the scheduler to hold the PI lock across rcu_read_unlock(),
>>> 	and while it is at it, across the rest of the unlock primitives.
>>>
>>> 	But if there was more than one CPU, Tree SRCU would be used
>>> 	instead of Tiny SRCU, and there would be no wakeup invoked from
>>> 	srcu_read_unlock().
>>>
>>> 	Given only one CPU, there is no way to complete the deadlock
>>> 	cycle.
>>>
>>> For now, I am working around this by preventing rcutorture from holding
>>> the PI lock across Tiny srcu_read_unlock().
>>>
>>> Am I missing something subtle here?
>> I would say that the lockdep code just doesn't have enough intelligence to
>> identify that deadlock is not possible in this special case. There are
>> certainly false positives, and it can be hard to get rid of them.
> Would it make sense for lockdep to filter out reports involving more
> than one CPU unless there is at least one sleeplock in the cycle?
>
> Of course, it gets more complicated when interrupts are involved...

Actually, lockdep keeps track of all the possible lock orderings and put 
out a splat whenever these lock orderings suggest that a circular 
deadlock is possible. It doesn't keep track if a lock is sleepable or 
not. Also lockdep deals with lock classes each of which can have many 
instances. So all the pi_lock's in different task_struct's are all 
treated as the same lock from lockdep's perspective. We can't treat all 
different instances separately or we will run out of lockdep table space 
very quickly.

Cheers,
Longman

