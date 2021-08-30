Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5F73FBD51
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 22:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbhH3UNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 16:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhH3UNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 16:13:22 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D55C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 13:12:28 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 6so21444819oiy.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 13:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IcITDjfopAEQf0wLc/UpVTpvTktp1wXpBtTzyWZoS5s=;
        b=cEpEq4oyVznvXppjI6rMzGq1P2FzCNkIHl41EDWrq8M/JjL+PzEv1zKF4SPp/cKZya
         SxnjLH9zf5PRWq3revgF30YFMaeXK19Uh2h0YhiCu1z7MQKQH2iBpWEsGyHpCGOI0By+
         N0Izo6fm17S5VEa4vncA0s10+yBp7LV2hXqDIRvERJ0OX+/RrPYdfDaL1t1xhw8r0oop
         XqUUedO1NzhaZrkiRP3vJ0oGj/C5vr7bE+gv78mofFnf+yXTzJ03djuFs9hEfKVmAbMx
         7/ZNdmetbg0vCYwf8GBegJFXqa6u4YsydwFjmbBiLxmTCss0qWlDfH3Q7oAgkO2AJWVF
         iBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=IcITDjfopAEQf0wLc/UpVTpvTktp1wXpBtTzyWZoS5s=;
        b=gA+2pb3rExD3imdu7VbaQRGCJVTqeJsS/kD4J4DlNpyscTuhiM0uLzGn87tLpRrvBB
         WjsBhOEiAdT8+fo/3Qq/YslixYWk3Rko483D6WUWTjgvC9nTFScmIRA7b3rzzKFMi5N6
         n7988gMNcNVHPPfybILsfAqWmQPJoiHDq7iXOqRKbljX4JrnjWjOB9eebAP8dMRWX4e8
         7hZEy1mjRj7xHp7zwOjQi9BCBKHnUHsPuC+eWg54+0Kmnx6qLbwtSPh35QwpNX3LWrGl
         FTvLgfNXTuRo3pqgB312lsUqVc6fMu1TjO3WVpo8lyA5+7YHpnMBh/KJOVBZAxy7c5kL
         5nlA==
X-Gm-Message-State: AOAM533oLxArMTJU2kj5cLoTouUj0HtL1qNyD5vEdUEH84E/ZuyGhQAn
        Z9XqdlP2HLzRVdrV7hOyess=
X-Google-Smtp-Source: ABdhPJxckCyjY+JT63yl/sqmtG6D+QKPu09FGfEXgcYt6SY6LVuRwTbI9oDXn1qz4SSrhJ/iTL5VQw==
X-Received: by 2002:a05:6808:f90:: with SMTP id o16mr683915oiw.37.1630354347893;
        Mon, 30 Aug 2021 13:12:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f17sm3425097otl.24.2021.08.30.13.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 13:12:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 30 Aug 2021 13:12:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Linux 5.14
Message-ID: <20210830201225.GA2671970@roeck-us.net>
References: <CAHk-=wh75ELUu99yPkPNt+R166CK=-M4eoV+F62tW3TVgB7=4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh75ELUu99yPkPNt+R166CK=-M4eoV+F62tW3TVgB7=4g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2021 at 03:19:23PM -0700, Linus Torvalds wrote:
> So I realize you must all still be busy with all the galas and fancy
> balls and all the other 30th anniversary events, but at some point you
> must be getting tired of the constant glitz, the fireworks, and the
> champagne. That ball gown or tailcoat isn't the most comfortable
> thing, either. The celebrations will go on for a few more weeks yet,
> but you all may just need a breather from them.
> 
> And when that happens, I have just the thing for you - a new kernel
> release to test and enjoy. Because 5.14 is out there, just waiting for
> you to kick the tires and remind yourself what all the festivities are
> about.
> 
> Of course, the poor tireless kernel maintainers won't have time for
> the festivities, because for them, this just means that the merge
> window will start tomorrow. We have another 30 years to look forward
> to, after all. But for the rest of you, take a breather, build a
> kernel, test it out, and then you can go back to the seemingly endless
> party that I'm sure you just crawled out of.
> 

Build results:
	total: 154 pass: 154 fail: 0
Qemu test results:
	total: 479 pass: 479 fail: 0

So far so good, but there is a brand new runtime warning, seen when booting
s390 images.

[    3.218816] ------------[ cut here ]------------
[    3.219010] WARNING: CPU: 1 PID: 0 at kernel/sched/core.c:5779 sched_core_cpu_starting+0x172/0x180
[    3.219548] Modules linked in:
[    3.219948] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.14.0 #1
[    3.220139] Hardware name: QEMU 2964 QEMU (KVM/Linux)
[    3.220312] Krnl PSW : 0400e00180000000 0000000000186e86 (sched_core_cpu_starting+0x176/0x180)
[    3.220593]            R:0 T:1 IO:0 EX:0 Key:0 M:0 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
[    3.220746] Krnl GPRS: 0000000000000000 0000000000000200 0000000000000200 0000000000000200
[    3.220821]            ffffffffffffffff 0000000000000000 000000000161f300 0000000001209c30
[    3.220893]            0000000000000002 00000000019bf418 0000000000000001 000000001fbf2300
[    3.220964]            0000000000000000 0000000000000001 0000000000186dc4 0000038000093c90
[    3.222032] Krnl Code: 0000000000186e7a: af000000		mc	0,0
[    3.222032]            0000000000186e7e: a7f4ff88		brc	15,0000000000186d8e
[    3.222032]           #0000000000186e82: af000000		mc	0,0
[    3.222032]           >0000000000186e86: a7f4ffe7		brc	15,0000000000186e54
[    3.222032]            0000000000186e8a: 0707		bcr	0,%r7
[    3.222032]            0000000000186e8c: 0707		bcr	0,%r7
[    3.222032]            0000000000186e8e: 0707		bcr	0,%r7
[    3.222032]            0000000000186e90: c00400000000	brcl	0,0000000000186e90
[    3.222845] Call Trace:
[    3.222992]  [<0000000000186e86>] sched_core_cpu_starting+0x176/0x180
[    3.223114] ([<0000000000186dc4>] sched_core_cpu_starting+0xb4/0x180)
[    3.223182]  [<00000000001963e4>] sched_cpu_starting+0x2c/0x68
[    3.223243]  [<000000000014f288>] cpuhp_invoke_callback+0x318/0x970
[    3.223304]  [<000000000014f970>] cpuhp_invoke_callback_range+0x90/0x108
[    3.223364]  [<000000000015123c>] notify_cpu_starting+0x84/0xa8
[    3.223426]  [<0000000000117bca>] smp_init_secondary+0x72/0xf0
[    3.223492]  [<0000000000117846>] smp_start_secondary+0x86/0x90
[    3.223614] no locks held by swapper/1/0.
[    3.223713] Last Breaking-Event-Address:
[    3.223762]  [<0000000000000000>] 0x0
[    3.224578] random: get_random_bytes called from __warn+0x11e/0x158 with crng_init=0
[    3.234056] ---[ end trace 5ffbc0f4ab37cea9 ]---

Commit 3c474b3239f12 ("sched: Fix Core-wide rq->lock for uninitialized
CPUs") sems to be the culprit. Indeed, the warning is gone after reverting
this commit.

Guenter
