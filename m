Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB5E371F26
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 20:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhECSGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 14:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhECSGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 14:06:10 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9334CC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 11:05:15 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id p11so4828492iob.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 11:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6l+GaZokB+3n0V9npOEjDroMzYdP3A7ADn0kCwU1InA=;
        b=QuTpiYNKAxQhhtO57BR1PW+i+vPgOeRsETiBd6SwFKARHv6Eg7GINETz2mhlahWXqS
         5XNbXTqStDHzsPIBt7Z9ueB+DUrofch3WvK0NdVEO40JRWpGWnc3GTtWMyyl6a57cCql
         c+w5U1voeoNt0Xf2EraNsBKe13u+81+YurgIzBAzguOtDp1uMv9ZaNoAUwTvuneGO/ao
         KIX9PZ+C7Qpd3k6d1bStEM2WvanYkx3BIbqJ9yuLpz0GRFwE9332ySRvjrmZquYXeo2h
         QawdjmOrpmTjmx2SfnUtNPOitHoY35P5qs9Rw1nnQjRstElqmZ9a9Uea5EeQegolMmvI
         DSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6l+GaZokB+3n0V9npOEjDroMzYdP3A7ADn0kCwU1InA=;
        b=qufCjtV/rFYB1eSDhsgVAipYR+/4HbsYBGtPqWoJoR1pzn01nYMDcsHXmgUs5ecqT8
         wBxvWE8Z8vZlzRI6GwUB/bnBcdk7W3TfxRsLc3DAs1l0W/xcJv1Qjs1qeD4la2Ezt7+a
         wajdxOZy56fNW5wlDYCP34Xjj31nVQNnLODhzvqrqboNIgA1QqP1nwLM3NvQzgMm2nKr
         Dl4urCzTD1wy1ZI6j/i5TMHuZFe8nJjhWPxPaVB4oigpyyZxOwJnKTu901BrW4eGEqNC
         EQbHYG3pCk4WhgJ4TENNCrKpxTxX4IFZKXeJU+u2ms0rYsiZ0OEkI+HO89wNq+K0N3G9
         PMNA==
X-Gm-Message-State: AOAM53119AGByzsgZ1X0ZOYjMSYwACO0R1v04PuxSgfFrRGALWbkzPH7
        Qf+9t/xGtlExnd3n/hL5t2WEWqiOFb0JEg==
X-Google-Smtp-Source: ABdhPJyA1nnCZxPMuSgdVx6qWciYSskyhH8s86UqTUkex8G9i7nXDnAcMtlSRIFf7covbAgUzW/XMw==
X-Received: by 2002:a05:6638:a2c:: with SMTP id 12mr19590919jao.99.1620065114819;
        Mon, 03 May 2021 11:05:14 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e5sm4531633ils.17.2021.05.03.11.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 11:05:14 -0700 (PDT)
Subject: Re: [PATCH] eventfd: convert to using ->write_iter()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Laight <David.Laight@aculab.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <7b98e3c2-2d9f-002b-1da1-815d8522b594@kernel.dk>
 <de316af8f88947fabd1422b04df8a66e@AcuMS.aculab.com>
 <7caa3703-af14-2ff6-e409-77284da11e1f@kernel.dk>
 <20210503180207.GD1847222@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7263c088-22f5-d125-cf80-5ebbd9d110e5@kernel.dk>
Date:   Mon, 3 May 2021 12:05:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210503180207.GD1847222@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/21 12:02 PM, Matthew Wilcox wrote:
> On Mon, May 03, 2021 at 11:57:08AM -0600, Jens Axboe wrote:
>> On 5/3/21 10:12 AM, David Laight wrote:
>>> From: Jens Axboe
>>>> Sent: 03 May 2021 15:58
>>>>
>>>> Had a report on writing to eventfd with io_uring is slower than it
>>>> should be, and it's the usual case of if a file type doesn't support
>>>> ->write_iter(), then io_uring cannot rely on IOCB_NOWAIT being honored
>>>> alongside O_NONBLOCK for whether or not this is a non-blocking write
>>>> attempt. That means io_uring will punt the operation to an io thread,
>>>> which will slow us down unnecessarily.
>>>>
>>>> Convert eventfd to using fops->write_iter() instead of fops->write().
>>>
>>> Won't this have a measurable performance degradation on normal
>>> code that does write(event_fd, &one, 4);
>>
>> If ->write_iter() or ->read_iter() is much slower than the non-iov
>> versions, then I think we have generic issues that should be solved.
> 
> We do!
> 
> https://lore.kernel.org/linux-fsdevel/20210107151125.GB5270@casper.infradead.org/
> is one thread on it.  There have been others.

But then we really must get that fixed, imho ->read() and ->write()
should go away, and if the iter variants are 10% slower, then that should
get fixed up.

I'll go over that thread.

-- 
Jens Axboe

