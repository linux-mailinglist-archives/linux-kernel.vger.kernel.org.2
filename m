Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330563F38DE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 07:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhHUFlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 01:41:35 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:37459 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhHUFle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 01:41:34 -0400
Received: from [192.168.1.18] ([90.126.253.178])
        by mwinf5d11 with ME
        id k5gr250033riaq2035grCL; Sat, 21 Aug 2021 07:40:54 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 21 Aug 2021 07:40:54 +0200
X-ME-IP: 90.126.253.178
Subject: Re: [PATCH linux-next] debug:kdb: fix unsigned int win compared to
 less than zero
To:     jing yangyang <cgel.zte@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Will Deacon <will@kernel.org>,
        Stephen Zhang <stephenzhangzsd@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20210820022442.11107-1-jing.yangyang@zte.com.cn>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <473095f9-d04e-1f49-ea5b-f12329fbb435@wanadoo.fr>
Date:   Sat, 21 Aug 2021 07:40:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210820022442.11107-1-jing.yangyang@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 20/08/2021 à 04:24, jing yangyang a écrit :
> Fix coccicheck warning:
> ./kernel/debug/kdb/kdb_support.c:575:3-10:
> WARNING:Unsigned expression compared with zero  p_state < 0
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
> ---
>   kernel/debug/kdb/kdb_support.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
> index c605b17..fb30801 100644
> --- a/kernel/debug/kdb/kdb_support.c
> +++ b/kernel/debug/kdb/kdb_support.c
> @@ -560,7 +560,7 @@ unsigned long kdb_task_state_string(const char *s)
>    */
>   char kdb_task_state_char (const struct task_struct *p)
>   {
> -	unsigned int p_state;
> +	int p_state;

When you make changes in variables which are written in the reverse 
Christmas tree style (i.e. long lines at the top, shorter ones below), 
you should keep this style. Many people prefer it that way.

Also, should your fix be correct, it is likely a bugfix, and a "Fixes:" 
would be needed to help backport.


However, I don't think that your patch is correct here.

Unless I missed something, 'p_state' really needs to be an 'unsigned 
int' because 'p->__state' is an 'unsigned int' since 2f064a59a11f 
("sched: Change task_struct::state")

My *guess* is that:
		(p_state < 0) ? 'U' :
should be turned in:
		(p_state & UNRUNNABLE) ? 'U' :

to match the code in 'kdb_task_state_string(()'.

The 'R' case looks also spurious to me, but I've not looked at it deeper.


Should I be right, comment at line 545 ("/* unrunnable is < 0 */") looks 
somewhat misleading or useless. I would drop it.


Finally, you have the same kind of code in 'show_task()' 
(arch/powerpc/xmon/xmon.c). I also guess that whatever the fix it, it 
should be updated the same way here.

CJ

>   	unsigned long tmp;
>   	char state;
>   	int cpu;
> 

