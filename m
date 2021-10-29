Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C919440197
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 19:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhJ2R7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 13:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhJ2R7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 13:59:23 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7D8C061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 10:56:55 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id h20so11491957ila.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 10:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VxWfNzwxHP6X/eSV+XFshjqFN8w1JslFltrlX9Ls2xc=;
        b=72hL3Q+VMbQGapkYWjLPjr2Idk1YZwJesQeF7QkJzMqgYe5vr8dwS/lTI23JUVkEWR
         AKECchbYfuRH+sm2hhalUiErCa86tvFGAxsycIKvNZOORROe6zlptN7+9lSHtME8Ogrq
         BU9FsAGjXvctfZ0fv0CXQXdNLpd1KtZ4Fje7EG4BxtgAxAk8470zQfXNjyjD5MBsGB2S
         kfm5a/Wh8XzbB4hGauBrifJ0cFrRlGaPMlB+CHcnIUvCXUsOGEdolmcarWu3nsJHbkvp
         zR87VLRA9uUZEU4Xs8WgVx9lXgnxmjumMC0LmtmB2KBnE+Jcc5YF3S2dhn+tm/pcqBNl
         IS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VxWfNzwxHP6X/eSV+XFshjqFN8w1JslFltrlX9Ls2xc=;
        b=LKSnJu1Pc8rdBCHrmIYncsFKbCqk/9EaLZgtkLXfxXTiHLnaC3EhFPf/epbrYxUcjQ
         Yinlr9PCr1gUzE6JtghGjxG6YVTufzkYngHj3xv7YC7Y1pUMyvxahJJ+0rrNd7ZiA75h
         v8gGMceXDOxXyO/Qq+mcEvm3S8Xfwkh+lmdRaM+joRW5kGwgggkDeY3RTUiG50avrPRZ
         BDuZzxois740fR4tuqUPPhOiTMrutCZzp45w4k7HBkufLe07OSPn3kbZChKoHKiSH9Ru
         1kDPG/t3k4eqbMF931064wzTcLeO0i5gPM3JRIATX5z3AMo6NqHCUfeYdMI/oZNgYadx
         PMDw==
X-Gm-Message-State: AOAM532OBOE+PWFMEJqhSDQBgQrHvkZEU4ZpnxLgnPBENLusJsMArRZF
        Pc8Sa4/5fd1TszyVk8XNEDffBoufa2ZxJQ==
X-Google-Smtp-Source: ABdhPJxDAx/+daKphe9ij09gOFZ/07scEi70E60lR4CHrlIoCFF3ME9acqnQhhq393U779KueQhygg==
X-Received: by 2002:a05:6e02:1c21:: with SMTP id m1mr2710215ilh.90.1635530214210;
        Fri, 29 Oct 2021 10:56:54 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k16sm3475680ior.50.2021.10.29.10.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 10:56:53 -0700 (PDT)
Subject: Re: [BUG] About "io_uring: add more uring info to fdinfo for debug"
To:     Hao Xu <haoxu@linux.alibaba.com>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <9ac22d4d-c841-651a-fdd5-9fb3a65c57ab@gmail.com>
 <e72cdd44-c027-e51c-8b57-24f39bf21d87@kernel.dk>
 <3b7dbb90-7fd5-d30f-cfe0-dd83f2cd4482@kernel.dk>
 <CANn89iJv6cRbK95Gwj=rrz2+X+Q4KQ7EtEcpz0Md0Vs1_iABPw@mail.gmail.com>
 <30b7018d-f60d-0c57-b3d6-92c1cf0762b9@kernel.dk>
 <03e9b953-a9c2-c3bc-c265-b3fff76d7739@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7c6ec470-0985-2ee8-4cbd-1f9649c7b69c@kernel.dk>
Date:   Fri, 29 Oct 2021 11:56:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <03e9b953-a9c2-c3bc-c265-b3fff76d7739@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/21 11:54 AM, Hao Xu wrote:
> Hi Jens,
> I was thinking that print all the entries including the unused ones
> would make the list very long(real product use hundreds or thousands
> while there may be just several useful sqes). And that may be confused,
> a example is: sq_array[0-999] = 0, we have only one sqe sqes[0] in use.
> then we'll print sqe[0] 1000 times, though we can get to know the real
> useful one by sq_head and tail info after calculation.
> And if only print the useful ones, exposing the original counters will
> make the loop condition a bit simpler than exposing the ring index(since
> the original counters depend on natural overflow) though we cannot do
> that now since realizing issues like what Eric reports.

We can revisit in the merge window, I wrote up the pull requests for
this branch (among others) already. The most important part was fixing
the looping to appropriately cap it.

-- 
Jens Axboe

