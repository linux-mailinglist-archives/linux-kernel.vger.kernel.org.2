Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D090316957
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhBJOoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 09:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhBJOoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:44:06 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC0EC061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 06:43:25 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id n201so2076880iod.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 06:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UBVWu7Q18E8hxWkUCeiIwi5X9j3a0gfj0DZFPTw18LM=;
        b=gCPMN0NCXBIajb4vmFEm30gI51mciPn7gSX9VBYMHY+Y4YGdqZ+vdo49qrdKBvlNj7
         SELHw87WcukrcFpePjNJ8qFzvIUHA+srT3Nl+nyckp/ER6JkRHLvmXZfPGPRSq9FXf5y
         TPSU0cks01gkMmoZcefN/fChZoVlmmOid2N3/sEbsT+arIWJFqYi/s/fBCRGSZPluTuG
         dB5tonvIr5LrD4oNFJJ2vrmxVxpwFqSDpB9jl8MZZpZi7VqOcSYqFgayDzpgqYx6a5/g
         x/hrtaQ2fDmjgU5n2UtkHoWGfNvRXJHvKHAHnYD/oy82n8Lr4Yp07us8roO6xrBewdJX
         M7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UBVWu7Q18E8hxWkUCeiIwi5X9j3a0gfj0DZFPTw18LM=;
        b=jQxexi9meGy8tDVvqbwJQwfYRR14YNKd2Y5T+VjTXxs4wpIoI/+l3Vi2/olt0G/bnQ
         fjryYxpm8yUHCIbIw62KMyMdFY03V4iqQ3iPfKVUxrVIe7zi3uMlNpn/ee3RyHie5myo
         PLGnoFDy9N5rDgipACI4472Z7zChNuIDkHFe1RYdxIZL91uyghd1ljTw2dZOkK/SJyIS
         8mpxlnnObM1VD5ablL8bxqAm2N7RCk5lZlHF86HDx1d3xARvwNt/EtMyH9g11jUtLo4N
         0Zsww32TRzLj1YwvO1ytyi/ud3csfsaorrPzB2XCVUPLVd0+i1zqpcH9oI9Tef0ooVOA
         Lkhg==
X-Gm-Message-State: AOAM530Luw/a/8tO9wyIYMETJGGmIj1zSi6t/4ZxvY02geOOG7DJuz5O
        4E7EX/mUuZFnZ6+pvHWkMLW8F2U4fEtw3eO1
X-Google-Smtp-Source: ABdhPJwckORcPOBUwD0PsCK0O7CnAPa7U/bF0ZSMR0B7ctVtWv5JegPdxOU7CodQMuWQV6sQuC1IVw==
X-Received: by 2002:a05:6638:450:: with SMTP id r16mr3716920jap.33.1612968204586;
        Wed, 10 Feb 2021 06:43:24 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m4sm1031588iow.1.2021.02.10.06.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 06:43:24 -0800 (PST)
Subject: Re: [PATCH v3 0/3] blk-mq: Don't complete in IRQ, use llist_head
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
References: <20210123201027.3262800-1-bigeasy@linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4007ad55-ed6d-a081-8571-36b146bca5ed@kernel.dk>
Date:   Wed, 10 Feb 2021 07:43:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210123201027.3262800-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/21 1:10 PM, Sebastian Andrzej Siewior wrote:
> Patch 2+3 were applied and then dropped by Jens due to a NOHZ+softirq
> related warning [0]. Turns out a successful wakeup via
> set_nr_if_polling() will not process any softirqs and the CPU may go
> back to idle. This is addressed by patch #1.
> 
> smpcfd_dying_cpu() will also invoke SMP-functions calls via
> flush_smp_call_function_queue() but the block layer shouldn't queue
> anything because the CPU isn't online anymore.
> The two caller of flush_smp_call_function_from_idle() look fine with
> opening interrupts from within do_softirq().

Applied, thanks.

-- 
Jens Axboe

