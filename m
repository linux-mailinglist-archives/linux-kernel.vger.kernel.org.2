Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D12403E12
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352359AbhIHREI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbhIHREH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:04:07 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B29C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 10:02:58 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id m11so4191209ioo.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 10:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8vmW8CNo10X/py+rXbtDt1wy95pmiR8tAY7SiBfQ/Qk=;
        b=Ca8/o+q+zwX6BUCib7/O5PrmmLtAtuVpoDKxiTOHiWPfs766esup+LF3LOPz9yzGaa
         K/mIyLLOIP5aN8ZRzf7aNnbe/NEMdx6cCf9/od0Z3TwBwlxj7GkPi6qIt5PTwatwEQ5+
         nvSKOcxwROMu4a5wXOPYxPf4wfRf6fnFPRbnxYGwf2Xn/qs2OvCsjDT6NQIpWSHcjhiW
         no37Bb4HN7vZ7JuXf67dyROOcFOx7YFuUeuRLh9+WglY+Upwd+k8i7VRwbmeaNbk84gw
         bDmKHK2vuAkMoZn0zYsUe9qBVrefPALXod8jKGyHdQH4a1SRtWXQG+v8HB2e9PYzbGWH
         ZlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8vmW8CNo10X/py+rXbtDt1wy95pmiR8tAY7SiBfQ/Qk=;
        b=oVSVOA1DKhrE6qjBYqj9NfVaQcJuEMQ+c67PfKr1z+v074kGXMY0aS0ouaB/mE5ZJK
         xrYY0cLx/GyA46cqDAvcq5QZroaE9wsR8nO7bJStp0ocryoT4gaYZHsNBsvhRH7p5n2D
         6mHi1a4NuLkEJXHQ+mzHAFF+DclJzQ23PjUzMCr6qUWZacAyC7vktMf0kwCCRzGROKpc
         VMM5HRbKP4DIVhByYkf3cISduDBY6OepaO7uGkg3IKmH0jPQtUX2a0MrcXNo+P49DFK7
         ggYZLz3YZ8dq3dSlKAFN6hxN1uWXqi4EQ5rbjP+rLxgLNQ/ZK6s8Z2ey89+IZ8a1i86m
         o4ZQ==
X-Gm-Message-State: AOAM530gxMPUFS5W1PwuGti4NzzNkLbnh16Rd+u6B9Fw9r9VJ98vIE9u
        61FwLC8ZWqNgaNlrJJlpga4ejQ==
X-Google-Smtp-Source: ABdhPJwVoi7TyUjNACJavBsV+ROTtAKQNl/im2ftA49c+o9nq9gO5Ne6g/oMjRt3npgVCFcUa6hMaA==
X-Received: by 2002:a02:c7c6:: with SMTP id s6mr4794312jao.34.1631120578280;
        Wed, 08 Sep 2021 10:02:58 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id t14sm1323364ilu.67.2021.09.08.10.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 10:02:57 -0700 (PDT)
Subject: Re: [syzbot] general protection fault in hrtimer_start_range_ns
To:     Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+b935db3fe409625cca1b@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        io-uring@vger.kernel.org
References: <0000000000009eeadd05cb511b60@google.com> <875yvbf23g.ffs@tglx>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8bbede01-4a97-bf22-92ad-c05a562c9799@kernel.dk>
Date:   Wed, 8 Sep 2021 11:02:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <875yvbf23g.ffs@tglx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/21 10:45 AM, Thomas Gleixner wrote:
> On Mon, Sep 06 2021 at 03:28, syzbot wrote:
>> syzbot found the following issue on:
>>
>> HEAD commit:    835d31d319d9 Merge tag 'media/v5.15-1' of git://git.kernel..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=14489886300000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=d793523866f2daea
>> dashboard link: https://syzkaller.appspot.com/bug?extid=b935db3fe409625cca1b
>> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+b935db3fe409625cca1b@syzkaller.appspotmail.com
>>
>> general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
>> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>> CPU: 0 PID: 12936 Comm: iou-sqp-12929 Not tainted 5.14.0-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> RIP: 0010:lock_hrtimer_base kernel/time/hrtimer.c:173 [inline]
> 
> That's almost certainly deferencing hrtimer->base and as that is NULL
> this looks like a not initialized hrtimer.

Does certainly look like that, I'll take a look. And agree the next one
looks like the same thing.

-- 
Jens Axboe

