Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9ED3F1C17
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 16:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240635AbhHSPAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 11:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240563AbhHSPAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 11:00:22 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAF2C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 07:59:46 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id p2so6057299oif.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 07:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=og+zBJlllyGan515OS7/bGP63jFRXlmdtpY4vNLiQ9U=;
        b=yALVBtrCet2QsHG5aVrXktHtXAVcPQRc84R5uOS9LUVEqCCmihMo4104uG9knxAloT
         Gp4/lkL74yntmjT8oRkrCC7EwxHGDGANnz79AJ4eOrp9/Rsdc5D7Y4Doio2WmAfJvodQ
         aYVr5UCMb2FDBwsltFPhoib+ZirkIDUanbk/8Q4neerpNmlVyz788sFtXoeANpSiksb+
         syTD+fBqxLuOZgUmNGNhhbSY7ASWZlgGdmWYWdZ2stmCOJUHxPmUN+JNV7pQTmkUyxL3
         2XAR++fkFinJDf8p2ZyXkqh2rXO7T4TojF9NVm62SsLrcLDL/8NA4DWfKo4D2wtXBIGs
         haOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=og+zBJlllyGan515OS7/bGP63jFRXlmdtpY4vNLiQ9U=;
        b=DR8CPsG8/XptjWWbpUZjWLkr+2x2FvsOv41DcoeLxKBAVaxV6l9Fts8hbzLVW9Dt/L
         7tfN45tCo9y5jOzPtZSVfclIZghBv64eptPAbSKcktiQYdgd9uI++DzYIDDgv1sIC95U
         3VLrEQGdi/eygLIhZ2oHtbtyKFHgCWPsBx9gwfVmwUVc25ZOn7uON5kHyrP6SjckA3Mr
         2POAZjy3reByGWlJRRMBtWjei9H/ct68WGvNZlifrPoDRHRMc68sf4AKFtwT/veoU1K/
         /VYTRg9xhEvTFIMVuiTIyOB4zA9PUHbGDGbwHnVO2ls52sp2v1JrRah/2+S/yCTn003I
         6vrQ==
X-Gm-Message-State: AOAM530NKn0HehoeQb85yQDt9FBJKxVlhdglf2PzYcDmTwZu9D9tnVth
        oJPiyetCVxs5HV9KzR0HQFiyyA==
X-Google-Smtp-Source: ABdhPJxGAvppgm0WdETn6aRwCgzxqRXfL5eggD6c5xzQGCC6sbZJsJ87OXv+GvJguLhaEwDV8I3hBg==
X-Received: by 2002:a05:6808:17a5:: with SMTP id bg37mr2917345oib.151.1629385185473;
        Thu, 19 Aug 2021 07:59:45 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id h19sm746652otr.75.2021.08.19.07.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 07:59:45 -0700 (PDT)
Subject: Re: [PATCH] kernel: make TIF_NOTIFY_SIGNAL and core dumps co-exist
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Olivier Langlois <olivier@trillion01.com>,
        Tony Battersby <tonyb@cybernetics.com>
References: <76d3418c-e9ba-4392-858a-5da8028e3526@kernel.dk>
 <CAHk-=wgBMNC1ePTgqM6f0iBH94KE5_oHQYD2sqCbjev0KaZ6Kw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7fb2d8a6-951c-092c-ccaa-15522ae2ed01@kernel.dk>
Date:   Thu, 19 Aug 2021 08:59:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgBMNC1ePTgqM6f0iBH94KE5_oHQYD2sqCbjev0KaZ6Kw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/21 8:57 PM, Linus Torvalds wrote:
> On Tue, Aug 17, 2021 at 8:06 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> task_work being added with notify == TWA_SIGNAL will utilize
>> TIF_NOTIFY_SIGNAL for signaling the targeted task that work is available.
>> If this happens while a task is going through a core dump, it'll
>> potentially disturb and truncate the dump as a signal interruption.
> 
> This patch seems (a) buggy and (b) hacky.
> 
>> --- a/kernel/task_work.c
>> +++ b/kernel/task_work.c
>> @@ -41,6 +41,12 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
>>                 head = READ_ONCE(task->task_works);
>>                 if (unlikely(head == &work_exited))
>>                         return -ESRCH;
>> +               /*
>> +                * TIF_NOTIFY_SIGNAL notifications will interfere with
>> +                * a core dump in progress, reject them.
>> +                */
>> +               if (notify == TWA_SIGNAL && (task->flags & PF_SIGNALED))
>> +                       return -ESRCH;
> 
> This basically seems to check task->flags with no serialization.
> 
> I'm sure it works 99.9% of the time in practice, since you'd be really
> unlucky to hit any races, but I really don't see what the
> serialization logic is.
> 
> Also, the main user that actually triggered the problem already has
> 
>         if (unlikely(tsk->flags & PF_EXITING))
>                 goto fail;
> 
> just above the call to task_work_add(), so this all seems very hacky indeed.
> 
> Of course, I don't see what the serialization for _that_ one is either.
> 
> Pls explain. You can't just randomly add tests for random flags that
> get modified by other random code.

You're absolutely right. On the io_uring side, in the current tree,
there's only one check where current != task being checked - and that's
in the poll rewait arming. That one should likely just go away. It may
be fine as it is, as it just pertains to ring exit cancelations. We want
to ensure that we don't rearm poll requests if the process is canceling
and going away. I'll take a closer look at that one.

For this particular patch, I agree it's racy. I'll see if I can come up
with something better...

-- 
Jens Axboe

