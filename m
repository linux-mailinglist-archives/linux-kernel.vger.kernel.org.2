Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E73398C8E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhFBOVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:21:46 -0400
Received: from mail1.perex.cz ([77.48.224.245]:39570 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231660AbhFBOVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:21:08 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id C304AA0042;
        Wed,  2 Jun 2021 16:19:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz C304AA0042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1622643562; bh=t6iwHzWxaZURGvRkNNG6PD03fsxL4O2Nu2eQKG2T8Tc=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=n1Cn3L0XrZwFTsCJyIEPXafWyWLVRQuFfem59YOdeD51dXu8Z0CY8Vqbuuwvd3YT8
         pN7SQdm0Mof50fxryJwyRS2xPn0/gxhxCokpw/Q+NQXr1mz7krNXX94cBV6+wAOA3j
         2HUO/1g1Wqvem/g9DlafVtAYnHMvqJ1kkzp2kJHk=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Wed,  2 Jun 2021 16:19:13 +0200 (CEST)
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in snd_timer_user_ccallback
To:     Dongliang Mu <mudongliangabcd@gmail.com>, allen.lkml@gmail.com,
        alsa-devel@alsa-project.org, Joe Perches <joe@perches.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        pierre-louis.bossart@linux.intel.com, romain.perier@gmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>, tiwai@suse.com
References: <CAD-N9QUDYbzkZXnDzf2P4b4Qk_kBQ_9ZVL3B4jhe9Xf2rgtpGA@mail.gmail.com>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <5c3fbdf8-bfa3-a50e-edb9-81fbce84d9cb@perex.cz>
Date:   Wed, 2 Jun 2021 16:19:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAD-N9QUDYbzkZXnDzf2P4b4Qk_kBQ_9ZVL3B4jhe9Xf2rgtpGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 06. 21 15:18, Dongliang Mu wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit: 5ff2756a Merge tag 'nfs-for-5.13-2' of git://git.linux-nfs..
>> git tree: upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=17872d5bd00000
>> kernel config: https://syzkaller.appspot.com/x/.config?x=770708ea7cfd4916
>> dashboard link: https://syzkaller.appspot.com/bug?extid=d102fa5b35335a7e544e
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+d102fa...@syzkaller.appspotmail.com
>>
>> ================================================================================
>> UBSAN: shift-out-of-bounds in sound/core/timer.c:1376:23
>> shift exponent 105 is too large for 32-bit type 'int'
>> CPU: 1 PID: 10368 Comm: syz-executor.1 Not tainted 5.13.0-rc3-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> Call Trace:
>> __dump_stack lib/dump_stack.c:79 [inline]
>> dump_stack+0x141/0x1d7 lib/dump_stack.c:120
>> ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
>> __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:327
>> snd_timer_user_ccallback.cold+0x19/0x1e sound/core/timer.c:1376
>>
>> snd_timer_notify1+0x243/0x3b0 sound/core/timer.c:525
> 
> The root cause of this bug is in the snd_timer_notify1 [1]. At the end
> of this function, it calls "ts->ccallback(ts, event + 100, &tstamp,
> resolution)".
> 
> Here the variable event is 5. It adds 100 and is passed as 2nd
> argument of snd_timer_user_ccallback.
> 
>>From the variable naming, the 2nd argument should an event, and in the
> range of event enumeration. In fact, 105 (event + 100) is out of this
> range. I don't quite understand the meaning of adding 100. Any thought
> here?

It seems that the original intent was to move the event to the M... events:

     SNDRV_TIMER_EVENT_MSTART = SNDRV_TIMER_EVENT_START + 10,

So the added value should be 10 which should not break the shift range (8
/resume/ + 10 = 18).

					Jaroslav

> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/core/timer.c?id=5ff2756afde08b266fbb673849899fec694f39f1#n497
> 
> --
> My best regards to you.
> 
>      No System Is Safe!
>      Dongliang Mu
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
