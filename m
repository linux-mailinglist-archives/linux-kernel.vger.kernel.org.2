Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F383816F1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 10:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbhEOIg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 04:36:29 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55424 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhEOIg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 04:36:26 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 14F8XsEA017198;
        Sat, 15 May 2021 17:33:54 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp);
 Sat, 15 May 2021 17:33:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 14F8Xs83017195
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 15 May 2021 17:33:54 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] kernel/hung_task: Report top CPU consumers
To:     zhouchuangao <zhouchuangao@vivo.com>,
        Dmitry Vyukov <dvyukov@google.com>
References: <1620997011-106951-1-git-send-email-zhouchuangao@vivo.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Michal Hocko <mhocko@suse.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Message-ID: <fdef508e-1afc-3b05-76a8-3c2dfc4084f3@i-love.sakura.ne.jp>
Date:   Sat, 15 May 2021 17:33:50 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1620997011-106951-1-git-send-email-zhouchuangao@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/05/14 21:56, zhouchuangao wrote:
> 1. If the task did not get scheduled for more than 2 minutes,
> report top 3(By default) CPU consumers.
> 
> 2. By default, the CPU utilization of each process in one minute
> is calculated.

+		all_cpu_usage(false);
+		show_top_cpu_consumers(false);
+		msleep(1000);
+		all_cpu_usage(true);
+		show_top_cpu_consumers(true);

1 second than 1 minute? Too short to determine top CPU consumers?

> 
> 3. Add a new member last_cpu_time to task_struct to record the CPU
> usage of the process at the beginning of the computation.

Speak of syzbot testing, in many cases the cause of hung task is simply
somebody else was consuming too much CPU resources. Therefore, without
backtraces of top CPU consumer processes, I think it is not different from
calling

  call_usermodehelper("/bin/sh", { "sh", "-c", "exec top -b -d 1 -n 1 > /dev/klog", NULL }, { NULL }, UMH_WAIT_PROC | UMH_KILLABLE);

before panic().

Maybe a hook for executing some userspace commands with some timeout before panic() is more useful?
