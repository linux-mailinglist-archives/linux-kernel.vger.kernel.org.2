Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2971439AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 17:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhJYPnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 11:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbhJYPnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:43:00 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DFAC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 08:40:37 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id u69so16108451oie.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 08:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yao+vOBrwNRRjSUxcGy7vU3OiBNSPZUpEsnrU7IGtu0=;
        b=UZZ+Y9EcZaz4rUHgxRZefwqptopRIpdFZaG7dRnsTm598Nosj2exHVVpj9NanhlfP7
         eJr7ynyJ4aAsm7i10whOp6/u2Ud0e/Han/PfPnNxqmMrtYWk2QJPz+tfyBbu34EQi2mZ
         JYxuBZ9hekUhOHcbphBDZFxt1u5NRgw3G0g0Awa1vDB0krKxfpVPJeTfOK5c1yVSbcwR
         BWjIO4ibMZx6GnhWYV87y0xMX0OfpBh3o6LscmTPKpeJA8oHmHdBMlcaQgnt/ArRimUw
         2mf73sNWP86LAnQIfGKHx8Q1+HJXBISvikZyfhRze9DAN0848JQC725meBeknfsntD5n
         DI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yao+vOBrwNRRjSUxcGy7vU3OiBNSPZUpEsnrU7IGtu0=;
        b=KqMvWlUlSYbNJD9y5Vbyg8fH1euFS8BV7ZqWyenjJy8J230RainrY+ppU32mME2H+P
         iwuIu2D+nQZG0Az+GQWcn9QZN3TLYBQJtgC3PfngXyQtSH5Sph/l40sFDsciWWWhW0a3
         QQPNdD5p3CLvWEzlQ+kv+DXj3BGThIGTvts2eGgSXTqeACz9ZdIGFhwjF9XPDBumVcKo
         DtGiDIDEhoE/a4fa9sptXNKFu4cxU8tgYLuBn3UG+g7/8mKavzKhioIbt6rpYP4eEqit
         oLJHgP1NefixBG0MSi1bAVmxYYOZKeq/Djs1lPrI77o+wF7IkNri6NUsf4mq8WeNxmnV
         qK4A==
X-Gm-Message-State: AOAM532q4xNSD/o7/rbSK/VpdJSY1kNP/s9NSOIkXaCpEp/vDTK0bbWV
        cAy5Ao5qI00f43cqWFWa86kqzA==
X-Google-Smtp-Source: ABdhPJwNAtup2ewmJtJ7rC5id2ZgCXFsSGhiD1g0XlTwLyDEjtOvtGXgGXzvZwyAAneXyl4MtHpGaQ==
X-Received: by 2002:a05:6808:118c:: with SMTP id j12mr12524481oil.65.1635176437161;
        Mon, 25 Oct 2021 08:40:37 -0700 (PDT)
Received: from ?IPv6:2600:380:602d:d087:5bee:e9ee:c67d:4ccf? ([2600:380:602d:d087:5bee:e9ee:c67d:4ccf])
        by smtp.gmail.com with ESMTPSA id s39sm3732172otv.18.2021.10.25.08.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 08:40:36 -0700 (PDT)
Subject: Re: [syzbot] KCSAN: data-race in sbitmap_queue_clear /
 sbitmap_queue_clear (3)
To:     Marco Elver <elver@google.com>
Cc:     syzbot <syzbot+4f8bfd804b4a1f95b8f6@syzkaller.appspotmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <00000000000089871905cf2b7d09@google.com>
 <f37aa186-8820-451f-6fa2-eee45799a428@kernel.dk>
 <CANpmjNO1kTswzGp03o_=wMiFekXoq-kvDCy+zKSP3r5+EeOvMg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b5dd012d-531e-a2ae-18b0-dc2300246298@kernel.dk>
Date:   Mon, 25 Oct 2021 09:40:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CANpmjNO1kTswzGp03o_=wMiFekXoq-kvDCy+zKSP3r5+EeOvMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/21 8:29 AM, Marco Elver wrote:
> On Mon, 25 Oct 2021 at 15:36, Jens Axboe <axboe@kernel.dk> wrote:
> [...]
>>> write to 0xffffe8ffffd145b8 of 4 bytes by interrupt on cpu 1:
>>>  sbitmap_queue_clear+0xca/0xf0 lib/sbitmap.c:606
>>>  blk_mq_put_tag+0x82/0x90
>>>  __blk_mq_free_request+0x114/0x180 block/blk-mq.c:507
>>>  blk_mq_free_request+0x2c8/0x340 block/blk-mq.c:541
>>>  __blk_mq_end_request+0x214/0x230 block/blk-mq.c:565
>>>  blk_mq_end_request+0x37/0x50 block/blk-mq.c:574
>>>  lo_complete_rq+0xca/0x170 drivers/block/loop.c:541
>>>  blk_complete_reqs block/blk-mq.c:584 [inline]
>>>  blk_done_softirq+0x69/0x90 block/blk-mq.c:589
>>>  __do_softirq+0x12c/0x26e kernel/softirq.c:558
>>>  run_ksoftirqd+0x13/0x20 kernel/softirq.c:920
>>>  smpboot_thread_fn+0x22f/0x330 kernel/smpboot.c:164
>>>  kthread+0x262/0x280 kernel/kthread.c:319
>>>  ret_from_fork+0x1f/0x30
>>>
>>> write to 0xffffe8ffffd145b8 of 4 bytes by interrupt on cpu 0:
>>>  sbitmap_queue_clear+0xca/0xf0 lib/sbitmap.c:606
>>>  blk_mq_put_tag+0x82/0x90
>>>  __blk_mq_free_request+0x114/0x180 block/blk-mq.c:507
>>>  blk_mq_free_request+0x2c8/0x340 block/blk-mq.c:541
>>>  __blk_mq_end_request+0x214/0x230 block/blk-mq.c:565
>>>  blk_mq_end_request+0x37/0x50 block/blk-mq.c:574
>>>  lo_complete_rq+0xca/0x170 drivers/block/loop.c:541
>>>  blk_complete_reqs block/blk-mq.c:584 [inline]
>>>  blk_done_softirq+0x69/0x90 block/blk-mq.c:589
>>>  __do_softirq+0x12c/0x26e kernel/softirq.c:558
>>>  run_ksoftirqd+0x13/0x20 kernel/softirq.c:920
>>>  smpboot_thread_fn+0x22f/0x330 kernel/smpboot.c:164
>>>  kthread+0x262/0x280 kernel/kthread.c:319
>>>  ret_from_fork+0x1f/0x30
>>
>> This is just a per-cpu alloc hint, it's racy by nature. What's the
>> preferred way to silence these?
> 
> That was my guess, but couldn't quite say. We started looking at
> write/write races as more likely to be harmful (vs. just read/write),
> and are inclined to let syzbot send out more of such reports. Marking
> intentional ones would be ideal so we'll be left with the
> unintentional ones.
> 
> I would probably use WRITE_ONCE(), just to make sure the compiler
> doesn't play games here; or if the code is entirely tolerant to even
> the compiler miscompiling things, wrap the thing in data_race().

It's entirely tolerant, so something like this would do it?


diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index c6e2f1f2c4d2..2709ab825499 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -631,7 +631,7 @@ EXPORT_SYMBOL_GPL(sbitmap_queue_wake_up);
 static inline void sbitmap_update_cpu_hint(struct sbitmap *sb, int cpu, int tag)
 {
 	if (likely(!sb->round_robin && tag < sb->depth))
-		*per_cpu_ptr(sb->alloc_hint, cpu) = tag;
+		data_race(*per_cpu_ptr(sb->alloc_hint, cpu) = tag);
 }
 
 void sbitmap_queue_clear_batch(struct sbitmap_queue *sbq, int offset,

-- 
Jens Axboe

