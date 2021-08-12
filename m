Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97D83EA9E8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 20:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237171AbhHLSFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 14:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbhHLSFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 14:05:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364E5C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 11:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=Ftw90dPaEqgSrJdTlLkw3EVnPPRTs0+WPe4ZirGAf1Y=; b=rledo3PV656TjXu2nzO6eu3HIO
        uwTvYVrKVM4eNq1FyV2dGXmO8wLDSJII8T4BWcb/O4JwAwgkrBqarIIGiU+ednogWyCx/VqHraJgQ
        3hzXyxRzSKjog5yRUpeoSNsbO8u0qkreazkw8pAqegwg/BVOs3jpoXWIikqKefmVle4pm36ugjcAq
        ZM8MVExPCycl1oz5aIKbpbWXKYbObW60Q99inx0dsCO2VnFUPKJFmnwSKizAWe/az1s1xE50K1uPw
        w6lmVFwtL1Y+wh8eVvGfEe87El9QY9/tmterT8rGRNJvIX/OApzEdKbgWPkG+M2vYIwl0XO+eZoiK
        wzDfe2Iw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEF4K-00Ap0r-3r; Thu, 12 Aug 2021 18:04:40 +0000
Subject: Re: [GIT PULL] tracing: Fixes and clean ups for v5.14
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20210812112938.3748c7f5@oasis.local.home>
 <CAHk-=whHxeUjaNrWOLb0qx=-nibRZzQomwkw9xMPH_aHCf=BWQ@mail.gmail.com>
 <20210812133306.1c480741@oasis.local.home>
 <CAHk-=wj=8xh+AcwQ+w62-QHfVU6wXC2xW8L17VvVBaR6dR6Ttg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cef5b624-b5f8-7729-3b05-3543578c6e3e@infradead.org>
Date:   Thu, 12 Aug 2021 11:04:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wj=8xh+AcwQ+w62-QHfVU6wXC2xW8L17VvVBaR6dR6Ttg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/21 10:54 AM, Linus Torvalds wrote:
> On Thu, Aug 12, 2021 at 7:33 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>> That was my take too, when this was first addressed:
>>
>>    https://lore.kernel.org/lkml/20210730204050.46975ae2@oasis.local.home/
>>
>>>
>>> The commit message talks about "some compilers/analyzers" without any
>>> explanation, and the "Link:" thing doesn't link to anything useful
>>> either.

Yes, Steven wanted to use -Wno-main or whatever it is called from
the start.

>> I should have added the above link. :-/
> 
> Even the above link doesn't explain it to me.
> 
> What is it that gives this crazy garbage warning?
>
Some tool called gcc.

> It looks like Randy Dunlap compiles with the '-Wmain' flag, and then
> complains about it hurting.

I just used some default settings. I didn't choose to use -Wmain.

> It's a classic case of "Doctor, doctor, it hurts when I hit myself in
> the head with an ice pick".
> 
> The solution is not to take some Ibuprofen.
> 
> The solution is DON'T DO THAT THEN.
> 
> People who build with W=2 or some other crazy thing need to understand
> that the bad warnings it exposes are not kernel problems, they are
> THEIR problems.

Nah, it's a tooling problem.

-- 
~Randy

