Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EE4386CCC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 00:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343583AbhEQWQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 18:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbhEQWQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 18:16:11 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DF8C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 15:14:53 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so372542wmk.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 15:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PWN1WItjgfpwNNExxSXg/UvnZdinVz4r4AKKqG/ffZU=;
        b=VWY1dEd7BtexQnuOwejE+P+Exo0JXCmteFsy515eaKNyt2MTOUrAupiQEN3CxC+5Go
         Dp99Xg0Rah3ogE7wjGwBXCulCVuJA/36Uhe3qa1tUIJ5gFD/Bh42p/KN26CxVzj/t4Vu
         7gJUbb7qXlYBOecEX4sUdVHQsgwZTJvBlw8dnMrStG1jpZYVyp8DDJWopNBAEueueaIe
         5qUmnznvUFDZtWzD6Wos5Mowmr1zl2rgYuX73JhqEVy/98Qy31tpcS62hL4/QvyYQLLs
         YgOmqtVnxgtqc3ZGGvr7XNT1ue/9Pw0yrcqhIAY1buwaRzlg/0x/gAp8jQZ3hPBUXEAQ
         m2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PWN1WItjgfpwNNExxSXg/UvnZdinVz4r4AKKqG/ffZU=;
        b=CLQhBbgVdC32kt2gQgabUM2v0YYHnSNL8uSnVHL+Gh4qqDfkuykAblFuoND6zrqf1i
         qomm/vOcZStJHRusgu3y0iV7B3vV5mSywY3+QtLGZMKo8z/k1BfX5/tGnrGQU/cYrlJD
         69xWbXKnM1Uybcv7QqpHK3QtOUZNBKYLZP/xBKtLxgN5h4DnAqcbx/sjid6zlc9VBKG0
         KfbRfcXYqStg5ynxk8Ut9fwMwX2RgEGXlxtboQWa6atfzFZqpCG6BM92OC7dkk47fLwS
         hRjMCyG6KaunKEEepW4AZ/34P6w3MznW+rri4+N7IQfMlWLowu5NEIy70u6lQO5iwXB9
         oGmg==
X-Gm-Message-State: AOAM531y1IODjcTyGb6Il11l7Aua1CqH+nejPb8du3vLf6Q1s+eTPFKq
        zFkj6bfPVu1JqGXbjTav2aU=
X-Google-Smtp-Source: ABdhPJxa85AkMwuXv2rgqCuTAjNvnfUu4bkd8QI4zaeY099BcGmqnGKw2UTtzVspZx7Ix7TKAOQIXQ==
X-Received: by 2002:a1c:9d43:: with SMTP id g64mr1719179wme.181.1621289691880;
        Mon, 17 May 2021 15:14:51 -0700 (PDT)
Received: from [192.168.8.197] ([148.252.128.8])
        by smtp.gmail.com with ESMTPSA id s7sm663922wmh.35.2021.05.17.15.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 15:14:51 -0700 (PDT)
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
References: <a068c25c4c08aa8dbc1141a77614711f80f74b65.1621245687.git.asml.silence@gmail.com>
 <m1o8d95l8a.fsf@fess.ebiederm.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH] signal: optimise signal_pending()
Message-ID: <391a43c9-3605-6010-55a4-87108628d9aa@gmail.com>
Date:   Mon, 17 May 2021 23:14:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <m1o8d95l8a.fsf@fess.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/21 6:22 PM, Eric W. Biederman wrote:
> Pavel Begunkov <asml.silence@gmail.com> writes:
> 
>> Optimise signal_pending() by checking both TIF_SIGPENDING and
>> TIF_NOTIFY_SIGNAL at once. Saves quite a bit of generated instructions,
>> e.g. sheds 240B from io_uring alone, some including ones in hot paths.
>>
>>    text    data     bss     dec     hex filename
>>   84087   12414       8   96509   178fd ./fs/io_uring.o
>>   83847   12414       8   96269   1780d ./fs/io_uring.o
> 
> I believe the atomic test_bit is pretty fundamental, especially with
> it's implied barriers.  I believe you are optimizing out the code
> that will makes signal_pending work in a loop.

Hmm, does it? I agree that at least it should volatile, but unlike
set_bit(), which is in atomic.h and has a non atomic __set_bit()
counter part, test_bit() is bitops/non-atomic.h, and I don't see
any implementation of test_bit() or arch_test_bit() having any
barriers.

READ_ONCE() should cover volatile, would it be better?

or test_mask() operating withing one word?

> I have tried looking and I really don't understand why TIF_NOTIFY_SIGNAL
> was added.  Perhaps instead of trying to optimize the test, you should
> optimize by combining TIF_NOTIFY_SIGNAL with TIF_SIGPENDING.

I'm speculating, but it looks to me that TIF_NOTIFY_SIGNAL was
specifically added to not rely on and separate from TIF_SIGPENDING
for task_work notification delivery.

> 
> Perhaps set_notify_signal could be optimized to set both.  I think I
> only see 4 calls in the tree.
> 
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>
>> Suggestions on how to make it less disruptive to abstractions are most
>> welcome, as even the one below fails to generated anything sane because
>> of test_bit()
>>
>> return unlikely(test_ti_thread_flag(ti, TIF_SIGPENDING) |
>> 		test_ti_thread_flag(ti, TIF_SIGPENDING));
>>
>>  include/linux/sched/signal.h | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
>> index 3f6a0fcaa10c..97e1963a13fc 100644
>> --- a/include/linux/sched/signal.h
>> +++ b/include/linux/sched/signal.h
>> @@ -361,14 +361,14 @@ static inline int task_sigpending(struct task_struct *p)
>>  
>>  static inline int signal_pending(struct task_struct *p)
>>  {
>> +	struct thread_info *ti = task_thread_info(p);
>> +
>>  	/*
>>  	 * TIF_NOTIFY_SIGNAL isn't really a signal, but it requires the same
>>  	 * behavior in terms of ensuring that we break out of wait loops
>>  	 * so that notify signal callbacks can be processed.
>>  	 */
>> -	if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)))
>> -		return 1;
>> -	return task_sigpending(p);
>> +	return unlikely(ti->flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL));
>>  }
>>  
>>  static inline int __fatal_signal_pending(struct task_struct *p)

-- 
Pavel Begunkov
