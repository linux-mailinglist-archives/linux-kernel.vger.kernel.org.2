Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B58E3A3912
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 02:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhFKBBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 21:01:53 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:54864 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhFKBBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 21:01:51 -0400
Received: by mail-pj1-f41.google.com with SMTP id g24so4699443pji.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 17:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JMNbRt76MbxK8nmL3vwvLg5vVzCDFp0Z+1ubon5t/n8=;
        b=p7Oe6ll9sIjZX5upUiw48FrvCa2WuEEluSFkHHWg5H4Pp16AN3CQo5mhZTUaipasYb
         Q/MpRl1GubzJuY4DmJOsuJAIn5rOzj7n51/eAFzBP2DcKQQpIFQIimqQrVRZFJ9x0nYc
         gtZ1YiJIhT2ptVsPuOO4zXpq/omRhtBCrGtqcGsPPJfDr09k1GdVMkfpcSCrPgsZWmOZ
         HSTLDOrZ2Rb2lUF2H9wbY9cOx5lOcsxuvP9Ccl9oXiH+jnnoCcjpoKhS8VAEBKYkdBbG
         F6OGPOMNDLAls4H0cBq/4u2hkg66bfvUTUiyxvW5A7YVd1nUPE+yo4XzupGGcqUO3KmP
         FkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JMNbRt76MbxK8nmL3vwvLg5vVzCDFp0Z+1ubon5t/n8=;
        b=uiyKgUGVr9dcyBSj0QTx9IcHG1zwoR/8K3xLdAz4pWn5qJDD7r1OGf07wybwFsol2n
         ylqPvFTPJm6/Skcl4z03mYGubQK1GXupxQQ+ytjQOgW6/BFDZ8WNfWbKmKgFYF0f2azC
         ZXAWK7Qw76IlPswHI2xjPUjTEmZ9cMUE1h6jPmBOxomQoIY6vfOQuCNfkXEQ/jc3scJl
         LKTc9v0hOF3gJ/db9SV2KqYkfDw4BVSwlzXxYtRUp0oGNjmdNZpVRLqoE5fmV/CNyAp+
         Rj2W4wNe2r0I+159w7ds8S5AtdPMtJ87ckC7Ds3Ic//bilQJ/PwKWoFCltjROTIbUyhG
         VAQQ==
X-Gm-Message-State: AOAM533nsiSyjqeRPcBNv0uD0kk7FF7Uvc6sTzCttlHQ8jSPlThFotbl
        kOv1/mNLPOybsUi2d2w/5vs=
X-Google-Smtp-Source: ABdhPJxIcw0Re//3ZixIzTQmC2RVFIKLqOvLJtaEXxV9LsubKGcc7slTsZhkI1cOB/6GvpOzfFp2Jw==
X-Received: by 2002:a17:902:8c91:b029:f3:b4da:4600 with SMTP id t17-20020a1709028c91b02900f3b4da4600mr1439738plo.30.1623373134421;
        Thu, 10 Jun 2021 17:58:54 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id r11sm3563778pgl.34.2021.06.10.17.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 17:58:54 -0700 (PDT)
Subject: Re: [PATCH] rcu/doc: Add a quick quiz to explain further why we need
 smp_mb__after_unlock_lock()
To:     paulmck@kernel.org
Cc:     boqun.feng@gmail.com, frederic@kernel.org, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, neeraju@codeaurora.org,
        urezki@gmail.com
References: <20210610165710.GT4397@paulmck-ThinkPad-P17-Gen-1>
 <41a783b3-db66-a30d-4ff1-d1fa77135db0@gmail.com>
 <20210611004813.GA4397@paulmck-ThinkPad-P17-Gen-1>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <65757b94-ce6c-4680-327d-086e3ebe4788@gmail.com>
Date:   Fri, 11 Jun 2021 09:58:50 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210611004813.GA4397@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 17:48:13 -0700, Paul E. McKenney wrote:
> On Fri, Jun 11, 2021 at 09:28:10AM +0900, Akira Yokosawa wrote:
>> On Thu, 10 Jun 2021 09:57:10 -0700, Paul E. McKenney wrote:
>>> On Thu, Jun 10, 2021 at 05:50:29PM +0200, Frederic Weisbecker wrote:
>>>> Add some missing critical pieces of explanation to understand the need
>>>> for full memory barriers throughout the whole grace period state machine,
>>>> thanks to Paul's explanations.
>>>>
>>>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>>>> Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
>>>> Cc: Joel Fernandes <joel@joelfernandes.org>
>>>> Cc: Uladzislau Rezki <urezki@gmail.com>
>>>> Cc: Boqun Feng <boqun.feng@gmail.com>
>>>
>>> Nice!!!  And not bad wording either, though I still could not resist the
>>> urge to wordsmith further.  Plus I combined your two examples, in order to
>>> provide a trivial example use of the polling interfaces, if nothing else.
>>>
>>> Please let me know if I messed anything up.
>>
>> Hi Paul,
>>
>> See minor tweaks below to satisfy sphinx.
>>
>>>
>>> 							Thanx, Paul
>>>
>>> ------------------------------------------------------------------------
>>>
>>> commit f21b8fbdf9a59553da825265e92cedb639b4ba3c
>>> Author: Frederic Weisbecker <frederic@kernel.org>
>>> Date:   Thu Jun 10 17:50:29 2021 +0200
>>>
>>>     rcu/doc: Add a quick quiz to explain further why we need smp_mb__after_unlock_lock()
>>>     
>>>     Add some missing critical pieces of explanation to understand the need
>>>     for full memory barriers throughout the whole grace period state machine,
>>>     thanks to Paul's explanations.
>>>     
>>>     Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>>>     Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
>>>     Cc: Joel Fernandes <joel@joelfernandes.org>
>>>     Cc: Uladzislau Rezki <urezki@gmail.com>
>>>     Cc: Boqun Feng <boqun.feng@gmail.com>
>>>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>>
>>> diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
>>> index 11cdab037bff..3cd5cb4d86e5 100644
>>> --- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
>>> +++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
>>> @@ -112,6 +112,35 @@ on PowerPC.
>>>  The ``smp_mb__after_unlock_lock()`` invocations prevent this
>>>  ``WARN_ON()`` from triggering.
>>>  
>>> ++-----------------------------------------------------------------------+
>>> +| **Quick Quiz**:                                                       |
>>> ++-----------------------------------------------------------------------+
>>> +| But the whole chain of rcu_node-structure locking guarantees that     |
>>> +| readers see all pre-grace-period accesses from the updater and        |
>>> +| also guarantees that the updater to see all post-grace-period         |
>>> +| accesses from the readers.  So why do we need all of those calls      |
>>> +| to smp_mb__after_unlock_lock()?                                       |
>>> ++-----------------------------------------------------------------------+
>>> +| **Answer**:                                                           |
>>> ++-----------------------------------------------------------------------+
>>> +| Because we must provide ordering for RCU's polling grace-period       |
>>> +| primitives, for example, get_state_synchronize_rcu() and              |
>>> +| poll_state_synchronize_rcu().  For example:                           |
>>> +|                                                                       |
>>> +| CPU 0                                     CPU 1                       |
>>> +| ----                                      ----                        |
>>> +| WRITE_ONCE(X, 1)                          WRITE_ONCE(Y, 1)            |
>>> +| g = get_state_synchronize_rcu()           smp_mb()                    |
>>> +| while (!poll_state_synchronize_rcu(g))    r1 = READ_ONCE(X)           |
>>> +|         continue;                                                     |
>>
>> This indent causes warnings from sphinx:
>>
>> Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst:135: WARNING: Unexpected indentation.
>> Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst:137: WARNING: Block quote ends without a blank line; unexpected unindent
>>
>>> +| r0 = READ_ONCE(Y)                                                     |
>>> +|                                                                       |
>>> +| RCU guarantees that that the outcome r0 == 0 && r1 == 0 will not      |
>>> +| happen, even if CPU 1 is in an RCU extended quiescent state (idle     |
>>> +| or offline) and thus won't interact directly with the RCU core        |
>>> +| processing at all.                                                    |
>>> ++-----------------------------------------------------------------------+
>>> +
>>>  This approach must be extended to include idle CPUs, which need
>>>  RCU's grace-period memory ordering guarantee to extend to any
>>>  RCU read-side critical sections preceding and following the current
>>
>> The code block in the answer can be fixed as follows:
>>
>> ++-----------------------------------------------------------------------+
>> +| **Answer**:                                                           |
>> ++-----------------------------------------------------------------------+
>> +| Because we must provide ordering for RCU's polling grace-period       |
>> +| primitives, for example, get_state_synchronize_rcu() and              |
>> +| poll_state_synchronize_rcu().  For example::                          |
>> +|                                                                       |
>> +|  CPU 0                                     CPU 1                      |
>> +|  ----                                      ----                       |
>> +|  WRITE_ONCE(X, 1)                          WRITE_ONCE(Y, 1)           |
>> +|  g = get_state_synchronize_rcu()           smp_mb()                   |
>> +|  while (!poll_state_synchronize_rcu(g))    r1 = READ_ONCE(X)          |
>> +|          continue;                                                    |
>> +|  r0 = READ_ONCE(Y)                                                    |
>> +|                                                                       |
>> +| RCU guarantees that that the outcome r0 == 0 && r1 == 0 will not      |
>> +| happen, even if CPU 1 is in an RCU extended quiescent state (idle     |
>> +| or offline) and thus won't interact directly with the RCU core        |
>> +| processing at all.                                                    |
>> ++-----------------------------------------------------------------------+
>>
>> Hint: Use of "::" and indented code block.
> 
> Thank you!
> 
> As in with the following patch to be merged into Frederic's original,
> with attribution?

Sounds good to me!

        Thanks, Akira

> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> index 3cd5cb4d86e5..bc884ebf88bb 100644
> --- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> +++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> @@ -125,15 +125,15 @@ The ``smp_mb__after_unlock_lock()`` invocations prevent this
>  +-----------------------------------------------------------------------+
>  | Because we must provide ordering for RCU's polling grace-period       |
>  | primitives, for example, get_state_synchronize_rcu() and              |
> -| poll_state_synchronize_rcu().  For example:                           |
> +| poll_state_synchronize_rcu().  For example::                          |
>  |                                                                       |
> -| CPU 0                                     CPU 1                       |
> -| ----                                      ----                        |
> -| WRITE_ONCE(X, 1)                          WRITE_ONCE(Y, 1)            |
> -| g = get_state_synchronize_rcu()           smp_mb()                    |
> -| while (!poll_state_synchronize_rcu(g))    r1 = READ_ONCE(X)           |
> -|         continue;                                                     |
> -| r0 = READ_ONCE(Y)                                                     |
> +|  CPU 0                                     CPU 1                      |
> +|  ----                                      ----                       |
> +|  WRITE_ONCE(X, 1)                          WRITE_ONCE(Y, 1)           |
> +|  g = get_state_synchronize_rcu()           smp_mb()                   |
> +|  while (!poll_state_synchronize_rcu(g))    r1 = READ_ONCE(X)          |
> +|          continue;                                                    |
> +|  r0 = READ_ONCE(Y)                                                    |
>  |                                                                       |
>  | RCU guarantees that that the outcome r0 == 0 && r1 == 0 will not      |
>  | happen, even if CPU 1 is in an RCU extended quiescent state (idle     |
> 
