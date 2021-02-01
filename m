Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A6230A8A4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhBANZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:25:31 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:59757 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhBANZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:25:27 -0500
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 111DOIp8071062;
        Mon, 1 Feb 2021 22:24:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp);
 Mon, 01 Feb 2021 22:24:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 111DOHSA071058
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 1 Feb 2021 22:24:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v4 (resend)] lockdep: Allow tuning tracing capacity
 constants.
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
References: <20210120101044.9106-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <CACT4Y+YUQj_G1o3eWFVeL2jsvdayQ0HkYkeVRuSzxOT5Xiu9mw@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <d1bc6d20-4150-0d64-824e-6d469a8a422e@i-love.sakura.ne.jp>
Date:   Mon, 1 Feb 2021 22:24:14 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YUQj_G1o3eWFVeL2jsvdayQ0HkYkeVRuSzxOT5Xiu9mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Andrew and Linus.

We are stuck because Peter cannot respond.
I think it is time to send this patch to linux-next. What do you think?

On 2021/01/20 19:18, Dmitry Vyukov wrote:
> On Wed, Jan 20, 2021 at 11:12 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> Since syzkaller continues various test cases until the kernel crashes,
>> syzkaller tends to examine more locking dependencies than normal systems.
>> As a result, syzbot is reporting that the fuzz testing was terminated
>> due to hitting upper limits lockdep can track [1] [2] [3].
>>
>> Peter Zijlstra does not want to allow tuning these limits via kernel
>> config options, for such change discourages thinking. But analysis via
>> /proc/lockdep* did not show any obvious culprit [4] [5]. It is possible
>> that many hundreds of kn->active lock instances are to some degree
>> contributing to these problems, but there is no means to verify whether
>> these instances are created for protecting same callback functions.
>> Unless Peter provides a way to make these instances per "which callback
>> functions the lock instance will call (identified by something like MD5
>> of string representations of callback functions which each lock instance
>> will protect)" than plain "serial number", I don't think that we can
>> verify the culprit.
>>
>> [1] https://syzkaller.appspot.com/bug?id=3d97ba93fb3566000c1c59691ea427370d33ea1b
>> [2] https://syzkaller.appspot.com/bug?id=381cb436fe60dc03d7fd2a092b46d7f09542a72a
>> [3] https://syzkaller.appspot.com/bug?id=a588183ac34c1437fc0785e8f220e88282e5a29f
>> [4] https://lkml.kernel.org/r/4b8f7a57-fa20-47bd-48a0-ae35d860f233@i-love.sakura.ne.jp
>> [5] https://lkml.kernel.org/r/1c351187-253b-2d49-acaf-4563c63ae7d2@i-love.sakura.ne.jp
>>
>> Reported-by: syzbot <syzbot+cd0ec5211ac07c18c049@syzkaller.appspotmail.com>
>> Reported-by: syzbot <syzbot+91fd909b6e62ebe06131@syzkaller.appspotmail.com>
>> Reported-by: syzbot <syzbot+62ebe501c1ce9a91f68c@syzkaller.appspotmail.com>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Acked-by: Dmitry Vyukov <dvyukov@google.com>
> 
> Thanks for your persistence!
> I still support this. And assessment of lockdep stats on overflow
> seems to confirm it's just a very large lock graph triggered by
> syzkaller.
> 
