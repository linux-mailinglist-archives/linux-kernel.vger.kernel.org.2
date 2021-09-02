Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8603FF7E6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 01:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345767AbhIBXda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 19:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345449AbhIBXdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 19:33:19 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537A4C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 16:32:20 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id n24so4672432ion.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 16:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hDXsOVX4DWQRKSpmXZqpCzSQEfu3SkuGOqTbKiVrB8g=;
        b=TqhzCjpycKGXatL/8fIxvn/iokhpSnk/TnLoqE0c9vcqalDD0DvENDuQPuaqtc5kxm
         MXV1OwcRNpSIaRljpRDzsxl1KNp0RrURqiLrmxsFUV1XsBmTWxM1AHpubB62o7ECm+PR
         Pe419Qiy6GHamVSExTKqDsuIaM6z5PoSQdCOdixH0ryto0QBFyemm6H0thysycIWOUEm
         OGZTccLd98rcEQRyaD6GQXhVwYcrnk6g0vrG3vhxJjE+uSYEhMxV4a5+Vz+ZD4IPCikt
         f+V16symS4Z/XTg8GmPqK4cksJohvjNVB286snis49yiYioLm4s8CqhkyjJGpuTn7gXP
         LkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hDXsOVX4DWQRKSpmXZqpCzSQEfu3SkuGOqTbKiVrB8g=;
        b=Dj+UbdSywDh9/qPZPKm4YsopK5UkU3md3Y1vbYS/66jnyhBdqZkHZrGkyzXk0rsvuK
         aj9o4VyPqHCgFwaDt34Xelt4f+ixaQ8OznEIuIjYZ6BBuJTE6Ea1T7BqnLQg3Y01wV00
         N84Vmz5RmPT9DoNGe0L2VXq2J0TIOKSEvy1F55ujtTtG0y/oUSLZeLecpDNbPfakRicW
         laqVASRC9cBKLfYuqJbBGm2UbAvVTNDupcq5rbPEi0ouGGPx4WPnO7R+laQ87TD7LhZ7
         HYazMurXNEs/zwpVtqGZO5HjqzZlXjiEl1fQy2N+eTonOAT5LIlL+I5+okHDtAghCgwM
         Re/A==
X-Gm-Message-State: AOAM530edOSphqkPpjY9OS08R76jnzm97SZ9QPAVCL1SHZvxH5juxyWf
        gTDwhSJiGOcv8VZ5/LJH2N36zw==
X-Google-Smtp-Source: ABdhPJxDKCuUUOT/96isH2RL+4xF7761TzATr8C7ea51+Y578l0+KGRxSyHVA+fum9oZZlFcjvK2+g==
X-Received: by 2002:a02:9542:: with SMTP id y60mr209790jah.87.1630625539626;
        Thu, 02 Sep 2021 16:32:19 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j5sm1670277ilu.11.2021.09.02.16.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 16:32:19 -0700 (PDT)
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.14+ merge window
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
References: <fc14fbbf0d7c27b7356bc6271ba2a5599d46af58.camel@HansenPartnership.com>
 <CAHk-=wi99u+xj93-pLG0Na7SZmjvWg6n60Pq9Wt9PgO6=exdUA@mail.gmail.com>
 <26c12f13870a2276f41aebfea6e467d576f70860.camel@HansenPartnership.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <18fc05ae-d167-9eee-de16-55223705819d@kernel.dk>
Date:   Thu, 2 Sep 2021 17:32:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <26c12f13870a2276f41aebfea6e467d576f70860.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/21 5:23 PM, James Bottomley wrote:
> On Thu, 2021-09-02 at 15:38 -0700, Linus Torvalds wrote:
>> On Thu, Sep 2, 2021 at 9:50 AM James Bottomley
>> <James.Bottomley@hansenpartnership.com> wrote:
>>> We also picked up a non trivial conflict with the already upstream
>>> block tree in st.c
>>
>> Hmm. Resolving that conflict, I just reacted to how the st.c code
>> passes in a NULL gendisk to scsi_ioctl() and then on to
>> blk_execute_rq().
>>
>> Just checking that was fine, and I notice how *many* places do that.
>>
>> Should the blk_execute_rq() function even take that "struct gendisk
>> *bd_disk" argument at all?
>>
>> Maybe the right thing to do would be for the people who care to just
>> set rq->rq_disk before starting the request..
>>
>> But I guess it's traditional, and nobody cares.
> 
> It's certainly traditional, but Christoph has been caring a lot about
> cleaning up our gendisks recently, so he might be interested in seeing
> if he can fix it ...

It's trivially doable, it's more a question of whether it's a good idea
or not... At least when passed in you have to make a conscious decision
on it being NULL. And just like Linus did, it's something you'll notice
and see what other callers are doing.

As I said, I don't feel that strongly about it. Hopefully most cases
that would forget to set it would trigger a NULL defer when they test
their code, and the core does initialize ->rq_disk to NULL. It's less
risky now than earlier, where the request alloc path was less
streamlined.

-- 
Jens Axboe

