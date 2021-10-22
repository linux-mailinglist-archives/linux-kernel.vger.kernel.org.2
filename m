Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42FE437549
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 12:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhJVKOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 06:14:52 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:49554 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbhJVKOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 06:14:51 -0400
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 19MACWKf029068;
        Fri, 22 Oct 2021 19:12:32 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Fri, 22 Oct 2021 19:12:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 19MACQsO029030
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Oct 2021 19:12:32 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] kernel/hung_task.c: add error info when failed to start
 khungtaskd
To:     Weitao Hou <houweitao@didiglobal.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        lukas.bulwahn@gmail.com, sfr@canb.auug.org.au,
        linux@rasmusvillemoes.dk, peterz@infradead.org,
        andriy.shevchenko@linux.intel.com
References: <20211022084755.25215-1-houweitao@didiglobal.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <248ee8f9-7834-6d12-1d71-193f178c7d56@i-love.sakura.ne.jp>
Date:   Fri, 22 Oct 2021 19:12:26 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211022084755.25215-1-houweitao@didiglobal.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On 2021/10/22 17:47, Weitao Hou wrote:
> we need add necessary error info when core thread started failed

This message is little useful. If kthread_run() from built-in modules' __init
functions is failing (due to e.g. out of memory), the system is already unusable.

> 
> Signed-off-by: Weitao Hou <houweitao@didiglobal.com>
> ---
>  kernel/hung_task.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 8cc07e7f29aa..8a95997a693e 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -354,6 +354,10 @@ static int __init hung_task_init(void)
>  	pm_notifier(hungtask_pm_notify, 0);
>  
>  	watchdog_task = kthread_run(watchdog, NULL, "khungtaskd");
> +	if (IS_ERR(watchdog_task)) {
> +		pr_err("Failed to start khungtaskd\n");
> +		watchdog_task = NULL;
> +	}
>  
>  	return 0;
>  }
> 
