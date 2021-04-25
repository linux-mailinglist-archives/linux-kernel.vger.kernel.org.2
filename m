Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D2F36A9AA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 00:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhDYW1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 18:27:14 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54318 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhDYW1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 18:27:11 -0400
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 13PMQPR4053479;
        Mon, 26 Apr 2021 07:26:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp);
 Mon, 26 Apr 2021 07:26:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 13PMQO9K053475
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 26 Apr 2021 07:26:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [GIT PULL] a lockdep fix via tomoyo tree for v5.13
Message-ID: <ec57ed59-7498-312c-4fdb-10cd924c5b87@i-love.sakura.ne.jp>
Date:   Mon, 26 Apr 2021 07:26:19 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5dc33592e95534dc8455ce3e9baaaf3dae0fff82:

  lockdep: Allow tuning tracing capacity constants. (2021-04-05 20:33:57 +0900)

are available in the git repository at:

  git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git tags/tomoyo-pr-20210426

for you to fetch changes up to 5dc33592e95534dc8455ce3e9baaaf3dae0fff82:

  lockdep: Allow tuning tracing capacity constants. (2021-04-05 20:33:57 +0900)

----------------------------------------------------------------
This is an irregular pull request for sending a lockdep patch.

Peter Zijlstra asked us to find bad annotation that blows up the lockdep
storage [1][2][3] but we could not find such annotation [4][5], and
Peter cannot give us feedback any more [6]. Since we tested this patch
on linux-next.git without problems, and keeping this problem unresolved
discourages kernel testing which is more painful, I'm sending this patch
without forever waiting for response from Peter.

[1] https://lkml.kernel.org/r/20200916115057.GO2674@hirez.programming.kicks-ass.net
[2] https://lkml.kernel.org/r/20201118142357.GW3121392@hirez.programming.kicks-ass.net
[3] https://lkml.kernel.org/r/20201118151038.GX3121392@hirez.programming.kicks-ass.net
[4] https://lkml.kernel.org/r/CACT4Y+asqRbjaN9ras=P5DcxKgzsnV0fvV0tYb2VkT+P00pFvQ@mail.gmail.com
[5] https://lkml.kernel.org/r/4b89985e-99f9-18bc-0bf1-c883127dc70c@i-love.sakura.ne.jp
[6] https://lkml.kernel.org/r/CACT4Y+YnHFV1p5mbhby2nyOaNTy8c_yoVk86z5avo14KWs0s1A@mail.gmail.com

 kernel/locking/lockdep.c           |    2 -
 kernel/locking/lockdep_internals.h |    8 +++----
 lib/Kconfig.debug                  |   40 +++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 5 deletions(-)

----------------------------------------------------------------
