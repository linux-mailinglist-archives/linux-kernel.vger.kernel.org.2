Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B43C3630B5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 16:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbhDQOqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 10:46:31 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53884 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbhDQOq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 10:46:29 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 13HEijbk042837;
        Sat, 17 Apr 2021 23:44:45 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp);
 Sat, 17 Apr 2021 23:44:45 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 13HEiiAf042828
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 17 Apr 2021 23:44:44 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] kernel/hung_task: Add a whitelist and blacklist
 mechanism.
To:     zhouchuangao <zhouchuangao@vivo.com>
References: <1618668783-39601-1-git-send-email-zhouchuangao@vivo.com>
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
        Michal Hocko <mhocko@suse.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <2d990915-0e1e-1c10-1736-7061d753f912@i-love.sakura.ne.jp>
Date:   Sat, 17 Apr 2021 23:44:40 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <1618668783-39601-1-git-send-email-zhouchuangao@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/04/17 23:13, zhouchuangao wrote:
> The main purpose of this patch is to add a whitelist and blacklist
> mechanism to the hung task thread.

We stopped using the term 'whitelist'/'blacklist' for new code in Linux kernel,
and what you are proposing is something like 'ignorelist'/'fatallist'.

I think that matching based on comm name is poor, for comm name is subjected to
impersonation by malicious user processes.

Moreover, speak of syzkaller testing, most of hang task reports are reaction to
somebody else consuming too much CPU resources (e.g. printk() flooding, too many
pending workqueue requests). Even if some process is in 'ignorelist', it is
possible that some problem that should be reported is already happening. Even if
some process is in 'fatallist', it is possible that the cause of hang is simply
somebody else is consuming too much CPU.

By the way, I wish that khungtaskd can report recent top CPU consumers, for it is
rare that the cause of hung is locking dependency problems / hardware problems.

