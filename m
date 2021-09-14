Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABF240AB74
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 12:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhINKMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 06:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhINKMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 06:12:23 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61195C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 03:11:04 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 18so11678202pfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 03:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=v+HvihQ88+3rcrBO8y3dqOMl+9UvluYXt6seefmUvYA=;
        b=RjQsLf+0TEnI9r2RX1x0HCA8NKb87k4SaGuuP3EqDGJggSvrCbKas5yRUoEHWo4KpI
         fmBAQOJNht4PKXoTqiok9yU9P1gGgaRN4toMjTKNkI/bHrqZIIHe1LQdoZtu5UaGLjD7
         1aRV9DkhMZERHqECNki1jZl0uT4fLY+pmOQYuVYQZJJacEjleCklPy5ObJtYIKtWfI1u
         BTlLE9SzPI+4QEq3/jX/fZ9N47sFlZaZJkfn2a3dqqZftbCgzyIvErLomvHALh1ylNU/
         BpXOSFLlOmVZz+U4Wh4qoFEVA/4eA7p4LsJ4sR1NnMAKS7PmmwpIn4lY23Yupka21S1k
         1Plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=v+HvihQ88+3rcrBO8y3dqOMl+9UvluYXt6seefmUvYA=;
        b=uHHb5KYc3Wyjqsmbq6GKJ/2UJfWR434mz8TISxH+LBHD7j+8V66wDzIm0+C+WSZWj3
         Tv1niXDQT7L+o4WcSz9AeeIqPmQYHpkKkYdKqfgDmMAC9aWqgFXIG1wGI1PzIdvlgzXS
         QbA3x1Wmwf2pmEZxEl2bn9P699N4YQxrFzbkDhrodKmDb/dfginTt1ovyqc3YTYJgey7
         9Qn2ZMTc4vZXmcncYwFqiFlW/EkJOKHnYsHJYrCctLwqpJqtWvqKXmYDUEfhwYZJ7hTz
         GBsorpZJREEYJlefUwth1YbZrEhBbIk3RvMuxC3scP+ap3+R8OVYFsl0K7+LXhSNDxwd
         yvsQ==
X-Gm-Message-State: AOAM533Pdb+D0f+TKxGjrMs/n214MpSPo1wxD/usk7qFCa0JTf26XNq9
        n+NE0NzYhRWDmnabP0T4XM8WQPj2BNk=
X-Google-Smtp-Source: ABdhPJzavhsobzYlsMLGf676R+ltWlrPwA3WT7aJpIVN07+WHfesgcCuVQukRiO8xyOOdsRYHa30Qw==
X-Received: by 2002:aa7:8014:0:b029:3cd:b6f3:5dd6 with SMTP id j20-20020aa780140000b02903cdb6f35dd6mr4042791pfi.39.1631614263608;
        Tue, 14 Sep 2021 03:11:03 -0700 (PDT)
Received: from [10.102.0.6] ([85.203.23.52])
        by smtp.gmail.com with ESMTPSA id s26sm9668465pfw.5.2021.09.14.03.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 03:11:03 -0700 (PDT)
Subject: Re: [BUG] android: possible ABBA deadlock in print_binder_proc() and
 binder_get_txn_from_and_acq_inner()
To:     Todd Kjos <tkjos@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        christian@brauner.io, hridya@google.com, surenb@google.com,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <303401d0-25c9-d04b-e96d-3ca2aa0a616d@gmail.com>
 <CAHRSSEy9cYk2cUSQku5fsOjBErj9eEhMuMDQP8SJPJU9UhNOPw@mail.gmail.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <37c6a84a-77ee-449b-a83b-59e378242fcb@gmail.com>
Date:   Tue, 14 Sep 2021 18:10:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHRSSEy9cYk2cUSQku5fsOjBErj9eEhMuMDQP8SJPJU9UhNOPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply :)

On 2021/9/8 3:29, Todd Kjos wrote:
> On Mon, Sep 6, 2021 at 7:30 PM Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>> Hello,
>>
>> My static analysis tool reports a possible ABBA deadlock in the android
>> driver in Linux 5.10:
>>
>> print_binder_proc()
>>     binder_inner_proc_lock()
>>       _binder_inner_proc_lock()
>>         spin_lock(&proc->inner_lock); --> Line 662 (Lock A)
>>     print_binder_thread_ilocked()
>>       print_binder_transaction_ilocked()
>>         spin_lock(&t->lock); --> Line 5531 (Lock B)
>>
>> binder_get_txn_from_and_acq_inner()
>>     binder_get_txn_from()
>>       spin_lock(&t->lock); --> Line 1833 (Lock B)
>>     binder_inner_proc_lock()
>>       _binder_inner_proc_lock()
>>         spin_lock(&proc->inner_lock); --> Line 662 (Lock A)
> Hmm. What kernel version are you looking at? These line numbers don't
> match what I see in mainline.

Linux 5.10

> Also, the sequence for
> binder_get_txn_from_and_acq_inner() looks like this for me:
>
> binder_get_txn_from_and_acq_inner()
>      binder_get_txn_from()
>        spin_lock(&t->lock); --> Line 1427 (Lock B)
>        spin_unlock(&t->lock); --> Line 1431 (Lock B)
>      binder_inner_proc_lock()
>        _binder_inner_proc_lock()
>           spin_lock(&proc->inner_lock); --> Line 256 (Lock A)
>
> Which doesn't have the deadlock hazard.
>

Yes, you are right.
My static tool has several errors in the implementation, and thus 
reported this false positive, sorry...


Best wishes,
Jia-Ju Bai
