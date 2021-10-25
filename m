Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3190F439C00
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 18:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbhJYQtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 12:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbhJYQtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 12:49:50 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AFCC061767
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 09:47:27 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id v77so16420489oie.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 09:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rc4KRqFtlBDRcuNZQIIm48efZsgcaCrAzSCQoNA3Zz0=;
        b=gDutaXM1BkgXJE6HCqz6jGoof4rStejTfIzU78No5IJhBNu57mSek9aesKx971V5fF
         /4VWlGMg12w7LI8ues0qWCku2Zy1JIjCHg2z3dtoiczjppt+Q3HZSvz7q4dh8JoQ2C6b
         Rao54pUhGHZvSVJ1r2FByV8UDGBGalSAvu3+jexQAxtpYqgHU2GIBq6Ensa0F5EJELN8
         6GMyDr42PSsB/est5Tpot4nV8wOtVXSIJafssrvlPF9f4ZLp0jRfy2chf1CS6s/OGJhw
         w8OXuI8gQz3mRPu1cT2udkBctlWJzQF44XP+fX9FceIi1mYHIwDaYZbGuBkaJXC5jorV
         PylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rc4KRqFtlBDRcuNZQIIm48efZsgcaCrAzSCQoNA3Zz0=;
        b=oKiez7rhCJJLqZyMdQUcrXzAKNDDO2FLNYcGS+Eh8udqfXak1eFxx0OxiZt4duArSX
         MLkihfENOP7GSUv2JfY8Qznd1MsR+1HEePw+w0VD75Rysic2uF5toxaGej/8+fc8VAjx
         hiN4oGZsIEnqrXjSA2qcLm0M5NHI3vjlZ8tkazstce/9h5GoA7ymjqnkdOQw/PoNXcRv
         StHodXzN8kfOgUPF6D4j5K68i8GMZabypLbivC3/6ngFXeTTZ2AYFrrND61NSp5GmXqX
         knigsAOQD2cCMEJFTyhZmDNDuKHzA5mGzy5NOtXNV+cHxcDO3dkGp5YmoBdmeOzTMBh1
         h1cA==
X-Gm-Message-State: AOAM533Jhhidj4SdeHiJ8RoZ2q0RSiE2xep37gfaZr9EtQUShY+XOTGg
        jim1aQkW5SKccfpeWhl9Vh4aPg==
X-Google-Smtp-Source: ABdhPJw+96kZ3EcQyHp0AwxZYyCfoDS6mqQPZTUuQ4SHsz/0sjAm8TgvZ3wIPTcBxAffzYMxBUl57A==
X-Received: by 2002:a05:6808:aaa:: with SMTP id r10mr8241169oij.11.1635180446949;
        Mon, 25 Oct 2021 09:47:26 -0700 (PDT)
Received: from ?IPv6:2600:380:602d:d087:5bee:e9ee:c67d:4ccf? ([2600:380:602d:d087:5bee:e9ee:c67d:4ccf])
        by smtp.gmail.com with ESMTPSA id bj14sm4055226oib.3.2021.10.25.09.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 09:47:26 -0700 (PDT)
Subject: Re: [syzbot] KCSAN: data-race in sbitmap_queue_clear /
 sbitmap_queue_clear (3)
To:     Marco Elver <elver@google.com>
Cc:     syzbot <syzbot+4f8bfd804b4a1f95b8f6@syzkaller.appspotmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <00000000000089871905cf2b7d09@google.com>
 <f37aa186-8820-451f-6fa2-eee45799a428@kernel.dk>
 <CANpmjNO1kTswzGp03o_=wMiFekXoq-kvDCy+zKSP3r5+EeOvMg@mail.gmail.com>
 <b5dd012d-531e-a2ae-18b0-dc2300246298@kernel.dk>
 <CANpmjNNVh65W00BBRFWwUDp0F4+8RXnU7azqxbpiLuvuev6xEQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <593a206e-5a02-e518-2913-5042686cc846@kernel.dk>
Date:   Mon, 25 Oct 2021 10:47:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CANpmjNNVh65W00BBRFWwUDp0F4+8RXnU7azqxbpiLuvuev6xEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/21 10:03 AM, Marco Elver wrote:
> On Mon, 25 Oct 2021 at 17:40, Jens Axboe <axboe@kernel.dk> wrote:
>> On 10/25/21 8:29 AM, Marco Elver wrote:
>>> On Mon, 25 Oct 2021 at 15:36, Jens Axboe <axboe@kernel.dk> wrote:
>>> [...]
>>>>> write to 0xffffe8ffffd145b8 of 4 bytes by interrupt on cpu 1:
>>>>>  sbitmap_queue_clear+0xca/0xf0 lib/sbitmap.c:606
>>>>>  blk_mq_put_tag+0x82/0x90
>>>>>  __blk_mq_free_request+0x114/0x180 block/blk-mq.c:507
>>>>>  blk_mq_free_request+0x2c8/0x340 block/blk-mq.c:541
>>>>>  __blk_mq_end_request+0x214/0x230 block/blk-mq.c:565
>>>>>  blk_mq_end_request+0x37/0x50 block/blk-mq.c:574
>>>>>  lo_complete_rq+0xca/0x170 drivers/block/loop.c:541
>>>>>  blk_complete_reqs block/blk-mq.c:584 [inline]
>>>>>  blk_done_softirq+0x69/0x90 block/blk-mq.c:589
>>>>>  __do_softirq+0x12c/0x26e kernel/softirq.c:558
>>>>>  run_ksoftirqd+0x13/0x20 kernel/softirq.c:920
>>>>>  smpboot_thread_fn+0x22f/0x330 kernel/smpboot.c:164
>>>>>  kthread+0x262/0x280 kernel/kthread.c:319
>>>>>  ret_from_fork+0x1f/0x30
>>>>>
>>>>> write to 0xffffe8ffffd145b8 of 4 bytes by interrupt on cpu 0:
>>>>>  sbitmap_queue_clear+0xca/0xf0 lib/sbitmap.c:606
>>>>>  blk_mq_put_tag+0x82/0x90
>>>>>  __blk_mq_free_request+0x114/0x180 block/blk-mq.c:507
>>>>>  blk_mq_free_request+0x2c8/0x340 block/blk-mq.c:541
>>>>>  __blk_mq_end_request+0x214/0x230 block/blk-mq.c:565
>>>>>  blk_mq_end_request+0x37/0x50 block/blk-mq.c:574
>>>>>  lo_complete_rq+0xca/0x170 drivers/block/loop.c:541
>>>>>  blk_complete_reqs block/blk-mq.c:584 [inline]
>>>>>  blk_done_softirq+0x69/0x90 block/blk-mq.c:589
>>>>>  __do_softirq+0x12c/0x26e kernel/softirq.c:558
>>>>>  run_ksoftirqd+0x13/0x20 kernel/softirq.c:920
>>>>>  smpboot_thread_fn+0x22f/0x330 kernel/smpboot.c:164
>>>>>  kthread+0x262/0x280 kernel/kthread.c:319
>>>>>  ret_from_fork+0x1f/0x30
>>>>
>>>> This is just a per-cpu alloc hint, it's racy by nature. What's the
>>>> preferred way to silence these?
>>>
>>> That was my guess, but couldn't quite say. We started looking at
>>> write/write races as more likely to be harmful (vs. just read/write),
>>> and are inclined to let syzbot send out more of such reports. Marking
>>> intentional ones would be ideal so we'll be left with the
>>> unintentional ones.
>>>
>>> I would probably use WRITE_ONCE(), just to make sure the compiler
>>> doesn't play games here; or if the code is entirely tolerant to even
>>> the compiler miscompiling things, wrap the thing in data_race().
>>
>> It's entirely tolerant, so something like this would do it?
> 
> Yup, looks reasonable,
> 
> Acked-by: Marco Elver <elver@google.com>

OK thanks, I'll queue it up for 5.16.

-- 
Jens Axboe

