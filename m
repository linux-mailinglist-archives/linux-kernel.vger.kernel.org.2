Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC253C77E5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 22:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhGMUZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 16:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbhGMUZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 16:25:02 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065B9C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 13:22:12 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so116606otp.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 13:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3SJYzIMZume2KNriSWijNRDiLHtG1WzjjPHKuOZ9Ue8=;
        b=arhAHpMrM4XdjNZA/usB70Edlw9HGL6wxogv6gPW2m+onzP1OMZZopdjU/qB/cIE8Z
         wSMYdviN4Lc73GYN3Ms+N5Nrae73gA8KBAYYVjG4nkqtp6TOkFo1IrRAWd7RmwgmDmJL
         FMMc17efx4LQm778xSmzffP4xqzHXml9L87i/9uCblpjsFXhqEYb6j63JDHzFstZtMiZ
         E9xWDGp1lBriq/YrGp+ouKHb1YmFbkAk0HL2SAOmUo0kVQFz/PlUpij9LFyb3Y+zTaVA
         GY8g704LNe/3+2uvCrupRdnhmTmI8rOvR0GRptPFZzx8dWCvZGNuL4EOJmUwdEtQoCvG
         MpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3SJYzIMZume2KNriSWijNRDiLHtG1WzjjPHKuOZ9Ue8=;
        b=LHSYQc1y0n2msMGG39SiR1Ll+Yc1cgrcdA8aK+H46+OxmnuvmW2cN7Z31ObXNRPgh/
         4EO5Dg1TykfEs/KlHvkmtKrWqyeQE+7x2SBZs71RcXtHWG1XV2OWobHvPzN6N55foowI
         IYfVWweeJx4e8whYvwMa7IoBWVQWPOAKsbsGB6R88Jx0SQ73jDObKcER1DDdRBdMmaQL
         a9boMJgEZLVtrX1YagVZC/n2Xj6LTVM0VHzHo+/0zWygAU5lqD9sbXFZdtlL1kR/FuRJ
         Yvf1fXyTqBXqZ35auQqB3MhFur7g60On43Ra7C+ASa7tB+trHkdBAouP8AluVKh4fcHJ
         VMiA==
X-Gm-Message-State: AOAM532Zg+3RMsGl9hasnfQzGO7AfNnwZVJFI0U9r7QEQRoywA+NnxMr
        fD2BgG1pyiNTU8qiZsAjqqdtVQ==
X-Google-Smtp-Source: ABdhPJxz1Kp6IEgHumpUtK9F6J0K5qKM7sOS0384OjFoJs+3nO2UuPTIyueghDMIM6NBmIoQUtz6Uw==
X-Received: by 2002:a9d:4112:: with SMTP id o18mr2972304ote.128.1626207731276;
        Tue, 13 Jul 2021 13:22:11 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id x20sm3166160otq.62.2021.07.13.13.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 13:22:10 -0700 (PDT)
Subject: Re: [PATCH] task_work: return -EBUSY when adding same work
To:     David Laight <David.Laight@ACULAB.COM>,
        yaozhenguo <yaozhenguo1@gmail.com>,
        "oleg@redhat.comm" <oleg@redhat.comm>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yaozhenguo@jd.com" <yaozhenguo@jd.com>
References: <20210709122712.42844-1-yaozhenguo1@gmail.com>
 <872612b5-b9c6-43aa-a167-1c204d0f1c5a@kernel.dk>
 <3079d213543c4d398d96031e6da26c82@AcuMS.aculab.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eddfda56-bfd7-8e5a-1abd-13a162e90d35@kernel.dk>
Date:   Tue, 13 Jul 2021 14:22:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3079d213543c4d398d96031e6da26c82@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/21 4:41 AM, David Laight wrote:
> From: Jens Axboe
>> Sent: 09 July 2021 15:18
> ...
>>>   */
>>>  int task_work_add(struct task_struct *task, struct callback_head *work,
>>>  		  enum task_work_notify_mode notify)
>>> @@ -41,6 +41,8 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
>>>  		head = READ_ONCE(task->task_works);
>>>  		if (unlikely(head == &work_exited))
>>>  			return -ESRCH;
>>> +		if (unlikely(head == work))
>>> +			return -EBUSY;
>>>  		work->next = head;
>>>  	} while (cmpxchg(&task->task_works, head, work) != head);
>>
>> I don't think there's anything conceptually wrong with this patch, but
>> it makes me think that you hit this condition. It's really a bug in the
>> caller, of course, is a WARN_ON_ONCE() warranted here? And who was the
>> caller?
> 
> How can the caller know that the task is on the queue?

It's similar to double adding a list entry to a list. It's the callers
responsibility to make sure that doesn't happen. The item happens to be
per-task here, but that doesn't really change the mechanics of it.

> There will be a race condition just before the work function
> is called and/or just after it returns that the caller
> can't detect.
> The check needs to be done atomically with the code that
> removes the work item from the list.

We're not polluting task_work with caller specific code like that, as
far as I'm concerned. Fix it in the caller. By the time ->func is run,
the item is off the original list and it can get re-added just fine. If
the event triggers after removing from the list but before ->func is
called, I don't see a problem with that. The caller just wants to ensure
that func is run, which it will be.

If the caller needs stronger guarantees than that, then it should
implement them separately on top of task_work.

-- 
Jens Axboe

