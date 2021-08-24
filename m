Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB763F6AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 22:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbhHXU6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 16:58:46 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:49210
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230213AbhHXU6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 16:58:45 -0400
Received: from [10.172.193.212] (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8A01B3F0A2;
        Tue, 24 Aug 2021 20:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629838676;
        bh=UR2T7+VU290KEBIKYaxbndu1d8XSCrp/jZUaTkJzux4=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=bArNiwHgppPtpjZWyUAg1Aq0ZkMG3WvCr12yf/6z5n3ef6h7d0vxesTMOOx3iLdQN
         wG8HpuVBHkBypoccweAhC/XlWGgwAAI5dzaqp7+w96wb6Pyk2OF69ly0uqXnzIO0yI
         GXIMfusOL7E/u0OdY38K3tPEe6Ftt+p0Ii4hSbKMcLHGnprto9BbHom75ZICA/Jv2P
         HaB7thI2pkTIeplG39rJ9n2EbvVA0a90yblvJSGWubt+RVUZGN020tKEwjgo4wYTcg
         lCgCPxJ6okcTbE/8e1rP2XCk7cWEX6J2CbzrwTxXZXXB/xGYw5uUNWgRT0IyRaNsDt
         jiRanCgjtb65A==
Subject: Re: [pipe] 3b844826b6: stress-ng.sigio.ops_per_sec -99.3% regression
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Sandeep Patil <sspatil@android.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
References: <20210824151337.GC27667@xsang-OptiPlex-9020>
 <CAHk-=wjEdeNW8bPNhwRCkMu6zLKjE2vQ=WL_6bQtc9YnaKt0bw@mail.gmail.com>
 <CAHk-=wiKAg5QtrQOtvKNwkRUn0b2xufO54GPhUoTWxBgDzXWNA@mail.gmail.com>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <2cad6e66-e255-f52e-706e-100728503a04@canonical.com>
Date:   Tue, 24 Aug 2021 21:57:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiKAg5QtrQOtvKNwkRUn0b2xufO54GPhUoTWxBgDzXWNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2021 18:32, Linus Torvalds wrote:
> [ Added Colin King, as this looks to be related to stress-sigio.c ]

FYI, I've pushed a fix that fixes my assumption that SIGIO occurs on
each write down the pipe. The fix now drains the input size and I've set
the read/write buffers to be the same size.

This will affect the bogo-ops rates for this stressor, so it will mess
up any on-going metrics folks may be using.

Colin

> 
> On Tue, Aug 24, 2021 at 9:22 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Tue, Aug 24, 2021 at 7:56 AM kernel test robot <oliver.sang@intel.com> wrote:
>>>
>>> FYI, we noticed a -99.3% regression of stress-ng.sigio.ops_per_sec due to commit:
>>
>> Well, that's bad.
>>
>>> commit: 3b844826b6c6 ("pipe: avoid unnecessary EPOLLET wakeups under normal loads")
>>
>> You fix one benchmark, you break another..
>>
>> What's a bit odd is that this commit basically reverts commit
>> 3a34b13a88ca ("pipe: make pipe writes always wake up readers") which
>> did *not* result in any kernel test robot report.
> 
> Hmm. I have a possible clue.
> 
> I suspect this may be timing-related, and I wonder if the kernel test
> robot just didn't happen to notice - or report - the other edge of
> this performance regression because it ends up being random enough.
> 
> In particular, I think stress-sigio.c is subtly buggy, and the "send
> SIGIO on every write" may have effectively hidden the bug.
> 
> Here's my theory on what's going on, and why it has tghat odd -99.3% regression:
> 
>  - the child in stress-sigio.c does multiple writes in quick
> succession, while the parent is scheduled away
> 
>  - the pipe was empty at the beginning, but we send just *one* SIGIO
> for all these writes
> 
>  - the parent gets the SIGIO, and goes to stress_sigio_handler(), and
> reads the buffer
> 
> but the parent doesn't necessarily *empty* the buffer, so it won't get
> any more SIGIO signals from subsequent writes.
> 
> The reason this is timing-dependent and about luck is because the
> *read* size is BUFFER_SIZE (4kB), but the write sizes are BUFFER_SIZE
>>> 4 (256 bytes), so 99% of the time if the parent is at all timely,
> it will do that big read and empty the buffer.
> 
> But if the child ends up able to do more than 16 writes in a row
> before the parent wakes up and reads data, the buffer will have more
> than 4kB of data in it, and when the parent SIGIO handler happens it
> won't empty the data, and so it will never see another SIGIO.
> 
> And again - I think this all happened before too (ie before commit
> 3a34b13a88ca) and so 3b844826b6c6 ("pipe: avoid unnecessary EPOLLET
> wakeups under normal loads") isn't a _new_ regression, it just exposed
> the bug in the test-case again, and this time the kernel test robot
> caught it.
> 
> In other words, I think this is very similar to the EPOLLET problem:
> user space expected (perhaps not _intentionally_) that SIGIO would
> happen over and over again when you add new data, even if the pipe
> already had data.
> 
> So then commit 1b6b26ae7053 ("pipe: fix and clarify pipe write wakeup
> logic") came around back in 2019, and only sent SIGIO when the pipe
> buffer status _changed_ (ie went from empty to having data, rather
> than "there's new data") and at that point stress-sigio.c became very
> fragile.
> 
> We could do the same ugly thing for FASYNC that we do for EPOLLET -
> make it always fasync on new data, exactly because the previous SIGIO
> might not have emptied the buffer completely.
> 
> I'm a _bit_ surprised that the kernel test robot didn't catch this
> back in 2019, and also didn't report this when commit 3a34b13a88ca
> ("pipe: make pipe writes always wake up readers") should have sped
> things up again, but I guess the "it's very timing-dependent" might
> explain it.
> 
> Colin, comments?
> 
> Anyway, the above blathering is not based on any actual real data. I'm
> just looking at stress-sigio.c to see what could be going wrong, and
> what would explain the test robot report. It's the only thing I see,
> but maybe somebody else sees anything else..
> 
>                       Linus
> 

