Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90455417D12
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 23:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347891AbhIXVm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 17:42:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347704AbhIXVmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 17:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632519681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q9awN8YodAjKFTExgIrBwgnrl/KMFGbj7l+opFYMbq8=;
        b=bfU75wJKv2yRD85t73F0YbGVj2QND3POOqEKR8O4HzcC51AWPeEsm9NKjPONbyt1nkP32L
        3eDabx4/vLsqhP8h/V/ycYmMnogmTunCLHokyvnvKOw7grolS9yH5ghGtoT31xeMKPZNbU
        vVWkyhiIR1CQyCkjIGRLEqDBkuVAbos=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-mkF_hjrOOWS6mc1xqgC3Tw-1; Fri, 24 Sep 2021 17:41:20 -0400
X-MC-Unique: mkF_hjrOOWS6mc1xqgC3Tw-1
Received: by mail-qk1-f198.google.com with SMTP id k12-20020a05620a0b8c00b003d5c8646ec2so42693631qkh.20
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Q9awN8YodAjKFTExgIrBwgnrl/KMFGbj7l+opFYMbq8=;
        b=4A11lhNB2SLCibX2KUOp1VPlRIeE18+2Sx/OGMML8Kvf3PS0J2Fw64KroiGPvRRujJ
         1R/f5P1iiOJXRweGjhc3pIQFr1ecT7oPurtJHCVfQjvydN5QErpJOM67gd9TTdqaU386
         oo9QxtYMAD8O0LaE58k/6yHSgu9yrovRSb2EjWvz6BgxAedtP0swIQtGuuLPo8THAdV0
         hDhWR+bcWMrjWrxQXqL3SvjQo7/AXiLzg83YuXR0VtjlFZ4axmHVqgKX8BFi0HbEcM6v
         i/slbKWCxLAkD34YtbGBF2ypxPr2KXWCbAOj9BrhKk2Cqlf4ylMr1z3us87tP8jkfufA
         kYTQ==
X-Gm-Message-State: AOAM531HLjmEO73XDBYUH2nGxsybq9Svd49kM1KeD2dASbR0+kCN3gAA
        ppAARvyRBaUP97S9ScPPLuga6q+OxUuWr3742T5N80oYb5u+nD9W9AXxO7Ql9YdyAKI7taubgev
        gt7+3MqzWXP0WIr8ffaezp1Qb
X-Received: by 2002:a05:6214:726:: with SMTP id c6mr12517750qvz.9.1632519679468;
        Fri, 24 Sep 2021 14:41:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsPvGBDsz3TommORVpM/r64IDIB2WGHFFU+JEsxhh1WD2AT+MSis+4K5Zg/2EMYYa2hPhPaQ==
X-Received: by 2002:a05:6214:726:: with SMTP id c6mr12517732qvz.9.1632519679287;
        Fri, 24 Sep 2021 14:41:19 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id n20sm7376239qkk.135.2021.09.24.14.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 14:41:18 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: Confusing lockdep splat
To:     paulmck@kernel.org, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, richard@nod.at
References: <20210924210247.GA3877322@paulmck-ThinkPad-P17-Gen-1>
Message-ID: <d8cb4445-cb01-4405-8800-a3eefa253af1@redhat.com>
Date:   Fri, 24 Sep 2021 17:41:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210924210247.GA3877322@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/21 5:02 PM, Paul E. McKenney wrote:
> Hello!
>
> I got the lockdep splat below from an SRCU-T rcutorture run, which uses
> a !SMP !PREEMPT kernel.  This is a random event, and about half the time
> it happens within an hour or two.  My reproducer (on current -rcu "dev"
> branch for a 16-CPU system) is:
>
> 	tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 16 --configs "16*SRCU-T" --duration 7200
>
> My points of confusion are as follows:
>
> 1.	The locks involved in this deadlock cycle are irq-disabled
> 	raw spinlocks.	The claimed deadlock cycle uses two CPUs.
> 	There is only one CPU.	There is no possibility of preemption
> 	or interrupts.	So how can this deadlock actually happen?
>
> 2.	If there was more than one CPU, then yes, there would be
> 	a deadlock.  The PI lock is acquired by the wakeup code after
> 	acquiring the workqueue lock, and rcutorture tests the new ability
> 	of the scheduler to hold the PI lock across rcu_read_unlock(),
> 	and while it is at it, across the rest of the unlock primitives.
>
> 	But if there was more than one CPU, Tree SRCU would be used
> 	instead of Tiny SRCU, and there would be no wakeup invoked from
> 	srcu_read_unlock().
>
> 	Given only one CPU, there is no way to complete the deadlock
> 	cycle.
>
> For now, I am working around this by preventing rcutorture from holding
> the PI lock across Tiny srcu_read_unlock().
>
> Am I missing something subtle here?

I would say that the lockdep code just doesn't have enough intelligence 
to identify that deadlock is not possible in this special case. There 
are certainly false positives, and it can be hard to get rid of them.

Cheers,
Longman

