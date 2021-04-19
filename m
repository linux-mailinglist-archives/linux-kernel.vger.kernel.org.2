Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC9B363970
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 04:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbhDSCkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 22:40:25 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59809 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbhDSCkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 22:40:23 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 13J2ce18016877;
        Mon, 19 Apr 2021 11:38:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp);
 Mon, 19 Apr 2021 11:38:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 13J2cdFH016870
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Apr 2021 11:38:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] kernel/hung_task: Add a whitelist and blacklist
 mechanism.
To:     =?UTF-8?B?5ZGo5Lyg6auY?= <zhouchuangao@vivo.com>
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
References: <AHgAiADIDmen--evL59Deart.3.1618798927815.Hmail.zhouchuangao@vivo.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <5571ac2e-0d13-8623-a66a-414b5cc36de5@i-love.sakura.ne.jp>
Date:   Mon, 19 Apr 2021 11:38:36 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <AHgAiADIDmen--evL59Deart.3.1618798927815.Hmail.zhouchuangao@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/04/19 11:22, 周传高 wrote:
> Some SOC vendors' drivers or user-mode processes may be in D state for a long time,
> and normally they do not configure HUNG TASK, so we need to ignore these tasks if
> we use HUNG TASK. 

Isn't that a sign that the quality of the drivers and user-mode processes is poor?
Wait should be killable/interruptible if possible (for better response to e.g. OOM-killer).
