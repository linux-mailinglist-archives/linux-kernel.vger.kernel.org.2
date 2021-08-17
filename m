Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A8A3EEC25
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 14:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239807AbhHQMIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 08:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236902AbhHQMHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 08:07:54 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E640C061764;
        Tue, 17 Aug 2021 05:07:20 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id qe12-20020a17090b4f8c00b00179321cbae7so5997252pjb.2;
        Tue, 17 Aug 2021 05:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+5n9TqAiu1H4FcQtrL8rLL2Jy8NntZP6iTPwMf+KVbM=;
        b=s9/P3WSuqf+kJmX92+mfrdwRXNaltWf7BqWIPNrFMJnxpJts3rjfzc788xZ2ZtGjkT
         27/3Et7/WvsCW/SlmDJl+ry7DVJX9pOyU0Iemi7Ar0hnlumvRgycuUSLNNrRR68Yqv+g
         UiboG8pZl370G26VILEUmTvz1Flju2d8qDYhG0Kdib6sdAZuJYpRed2DeEThQdYDOCqL
         5z/qO1tIWmliuTkNytf7yWHAVPypakXJ+g5vtRfee/KrMLqJejfKFBdg38FlYttTCElG
         jQEk9TFOFSt4yH2aPE6eeBE7IUn15ZuZmZWbQDgx4c6WqTToo+G1ZO5tzasQdeu9xsZP
         IbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=+5n9TqAiu1H4FcQtrL8rLL2Jy8NntZP6iTPwMf+KVbM=;
        b=UOCCBAFGIAgez7A+XKmYplT2BpCXZQvcyM7yt2XKN3e14TdlWnNWJ0Cd/Wowikz0bM
         OIbAnbyBddvUlznTeLNxAyVlZxxNxkeO+ICQN8mmfC0cbN37nNUCFL4g8acRwgFIkL5M
         F+mLrylEAxnxUQ0mJMwIwjQzBXECkRzPRBWevzqT1GhPUlKRq8Yl4LIpR+9Ffuk+hrTx
         oOaWHT+6lidCbQoaYPkVtG5+GcQIyK7VIDYwHFVh0D5orWkAdz4U6D0tvi5zVkWdiGQ5
         1LlmJwczdTDphY+O0s6OFB3gToom08Uajy2XcsDq8mZj/DG+YPrAMRC3VhTjH1/KXYPh
         eiqg==
X-Gm-Message-State: AOAM5326ndUn6pTDMhtXYz7su7dyCYUFyAlTswc90G2DNUSqe3ObLM0T
        NIuHSIXs/0ymJ+XsNBr92b4=
X-Google-Smtp-Source: ABdhPJxxP0uPnQpjKT9PatWHS5w+rXQPKa30fSNuq7jRU7zz16Fz+/6BGvFo6GzLOm4lOJU83Gxwjw==
X-Received: by 2002:a17:90a:f98f:: with SMTP id cq15mr3379942pjb.74.1629202040024;
        Tue, 17 Aug 2021 05:07:20 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id w18sm2317365pjg.50.2021.08.17.05.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 05:07:18 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        guoren@kernel.org, linux-csky@vger.kernel.org, x86@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/5] kprobes: Bugfix and improvements
References: <20210727133426.2919710-1-punitagrawal@gmail.com>
        <20210728083913.bcf0fa991e4a2b819f457543@kernel.org>
Date:   Tue, 17 Aug 2021 21:07:16 +0900
In-Reply-To: <20210728083913.bcf0fa991e4a2b819f457543@kernel.org> (Masami
        Hiramatsu's message of "Wed, 28 Jul 2021 08:39:13 +0900")
Message-ID: <87fsv8s2a3.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu <mhiramat@kernel.org> writes:

> Hi Punit,
>
> Thanks for resending this series.
>
> Ingo, could you pick this patch too?
> I'll resend my series on this series.

I couldn't find the patches on any of the branches in tip - have they
been queued?

Please let me know if there anything else I need to do in order for them
to be picked up.

Thanks,
Punit

>
> Thank you,
>
> On Tue, 27 Jul 2021 22:34:21 +0900
> Punit Agrawal <punitagrawal@gmail.com> wrote:
>
>> Hi,
>> 
>> This is the second posting of patches previously posted at
>> [0]. Although the patches were reviewed / acked in the previous cycle
>> but for some didn't end up getting picked up for this cycle.
>> 
>> This posting rebases the patches to 5.14-rc3 and makes some minor
>> improvements to the commit log in Patch 1. I've also added the tags as
>> appropriate from the previous posting.
>> 
>> It would be great if the patches can be picked up this time around.
>> 
>> Thanks,
>> Punit
>> 
>> 
>> [0] https://lore.kernel.org/linux-csky/20210609105019.3626677-1-punitagrawal@gmail.com/
>> 
>> Punit Agrawal (5):
>>   kprobes: Do not use local variable when creating debugfs file
>>   kprobes: Use helper to parse boolean input from userspace
>>   kprobe: Simplify prepare_kprobe() by dropping redundant version
>>   csky: ftrace: Drop duplicate implementation of
>>     arch_check_ftrace_location()
>>   kprobes: Make arch_check_ftrace_location static
>> 
>>  arch/csky/kernel/probes/ftrace.c |  7 ----
>>  include/linux/kprobes.h          |  7 ++--
>>  kernel/kprobes.c                 | 58 ++++++++++----------------------
>>  3 files changed, 23 insertions(+), 49 deletions(-)
>> 
>> -- 
>> 2.30.2
>> 
