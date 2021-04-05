Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A456E3541D3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 13:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbhDELpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 07:45:36 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57371 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbhDELpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 07:45:34 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 135Bj15O094730;
        Mon, 5 Apr 2021 20:45:01 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav305.sakura.ne.jp);
 Mon, 05 Apr 2021 20:45:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav305.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 135Bj0sU094716
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 5 Apr 2021 20:45:01 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v5] lockdep: Allow tuning tracing capacity constants.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210208102551.5256-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <CACT4Y+YnHFV1p5mbhby2nyOaNTy8c_yoVk86z5avo14KWs0s1A@mail.gmail.com>
 <3d86eb9c-ab6f-c402-a326-a6376e9ea082@i-love.sakura.ne.jp>
Message-ID: <968067e3-d87b-b04d-c2ba-fad04c439130@i-love.sakura.ne.jp>
Date:   Mon, 5 Apr 2021 20:44:58 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <3d86eb9c-ab6f-c402-a326-a6376e9ea082@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry, I've just sent this patch to tomoyo-test1.git tree, for finding bugs
(which previously could not be found due to lack of this patch) in linux-next.git
will be helpful anyway.

Since this patch should appear in tomorrow's linux-next.git , please prepare
syzkaller for tuning appropriate values (default value + 1 should be OK).

On 2021/03/31 19:58, Tetsuo Handa wrote:
> Peter, are you there?
> 
> If you keep silence, we will assume that applying this patch is the way to go.
> 
> On 2021/03/20 16:34, Dmitry Vyukov wrote:
>> On Mon, Feb 8, 2021 at 11:29 AM Tetsuo Handa
>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>
>>> Since syzkaller continues various test cases until the kernel crashes,
>>> syzkaller tends to examine more locking dependencies than normal systems.
>>> As a result, syzbot is reporting that the fuzz testing was terminated
>>> due to hitting upper limits lockdep can track [1] [2] [3]. Since analysis
>>> via /proc/lockdep* did not show any obvious culprit [4] [5], we have no
>>> choice but allow tuning tracing capacity constants.
>>>
>>> [1] https://syzkaller.appspot.com/bug?id=3d97ba93fb3566000c1c59691ea427370d33ea1b
>>> [2] https://syzkaller.appspot.com/bug?id=381cb436fe60dc03d7fd2a092b46d7f09542a72a
>>> [3] https://syzkaller.appspot.com/bug?id=a588183ac34c1437fc0785e8f220e88282e5a29f
>>> [4] https://lkml.kernel.org/r/4b8f7a57-fa20-47bd-48a0-ae35d860f233@i-love.sakura.ne.jp
>>> [5] https://lkml.kernel.org/r/1c351187-253b-2d49-acaf-4563c63ae7d2@i-love.sakura.ne.jp
>>>
>>> Reported-by: syzbot <syzbot+cd0ec5211ac07c18c049@syzkaller.appspotmail.com>
>>> Reported-by: syzbot <syzbot+91fd909b6e62ebe06131@syzkaller.appspotmail.com>
>>> Reported-by: syzbot <syzbot+62ebe501c1ce9a91f68c@syzkaller.appspotmail.com>
>>> References: https://lkml.kernel.org/r/1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp
>>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>> Acked-by: Dmitry Vyukov <dvyukov@google.com>
>>
>> Peter, ping.
>> Please at least provide some feedback.
>> This is still the top crasher on syzbot and harms testing of the whole
>> kernel. I am periodically thinking of disabling LOCKDEP on syzbot as
>> harming more than helping, but so far talking myself out of it because
>> it will likely be broken more when we try to re-enable it and I still
>> hope for a timely resolution of this issue.
>>
> 

