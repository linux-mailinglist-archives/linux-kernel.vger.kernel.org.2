Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8843EC205
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 12:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237850AbhHNKc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 06:32:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237454AbhHNKcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 06:32:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11D8560F36;
        Sat, 14 Aug 2021 10:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628937116;
        bh=4yn3jzDH5fUFhYZLpX+LAEiOREdU3yayf4aPT9ZvILc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hmh7YnX7E9VrhnyTnN3cXKnfpnCigAT9G8OqQkRDTxH4cqb1ABAAoaPUKSnARWsdf
         a8kZG1FTbW3fW8H5kqugIwVm5JQXqKONLmJnCfJzCsyn6Exy2wuLSaK1DZuwGy3exR
         DnbiI5TZGg2pt0wBxrHQVDbRlNFYc1BRvw/mqUm52IfED4NluJ7Gx39LgLKg6P4Kp5
         u+gCIA1dCuxAWPATzbvB/gATbOW752LCBJuvwNE0zkifLJBL0drc10KBXWrSoRoRb0
         MueuRe1aOQgqp9YfUbKJoMvJ2zLKM8pFGymSwiFZOgkHakdVdGwdfXJby1ggC6cohI
         UsJACacjruffA==
Date:   Sat, 14 Aug 2021 12:31:53 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+59dd63761094a80ad06d@syzkaller.appspotmail.com>,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Write in alloc_ucounts
Message-ID: <20210814103153.rzlgindblymmqcqi@example.org>
References: <000000000000a6b91c05c74bb6ac@google.com>
 <20210814095036.2972-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210814095036.2972-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2021 at 05:50:36PM +0800, Hillf Danton wrote:
> On Thu, 29 Jul 2021 10:15:28 -0700
> > syzbot has found a reproducer for the following issue on:
> > 
> > HEAD commit:    4010a528219e Merge tag 'fixes_for_v5.14-rc4' of git://git...
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=133f4a66300000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=1dee114394f7d2c2
> > dashboard link: https://syzkaller.appspot.com/bug?extid=59dd63761094a80ad06d
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b8851a300000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+59dd63761094a80ad06d@syzkaller.appspotmail.com
> > 
> > ==================================================================
> > BUG: KASAN: use-after-free in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
> > BUG: KASAN: use-after-free in atomic_add_negative include/asm-generic/atomic-instrumented.h:556 [inline]
> > BUG: KASAN: use-after-free in get_ucounts kernel/ucount.c:152 [inline]
> > BUG: KASAN: use-after-free in get_ucounts kernel/ucount.c:150 [inline]
> > BUG: KASAN: use-after-free in alloc_ucounts+0x19b/0x5b0 kernel/ucount.c:188
> > Write of size 4 at addr ffff888017c0f61c by task syz-executor.0/12089

This is outdated report. It was sent before the fix was landed [1]. After
the fix, there were no reports about ucounts.

[1] https://lore.kernel.org/lkml/87a6lvak43.fsf@disp2133/

> In bid to fix the uaf, make get_ucounts() able to detect count underflow in
> addition to overflow by replacing atomic_add_negative() with
> atomic_try_cmpxchg(). Because the cmpxchg itself can not do the job without
> checking xflow, try to bump up count until xflow is detected.

The cmpxchg is much more expensive.

> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 4010a528219e 
> 
> --- x/kernel/ucount.c
> +++ y/kernel/ucount.c
> @@ -149,11 +149,18 @@ static void hlist_add_ucounts(struct uco
>  
>  struct ucounts *get_ucounts(struct ucounts *ucounts)
>  {
> -	if (ucounts && atomic_add_negative(1, &ucounts->count)) {
> -		put_ucounts(ucounts);
> -		ucounts = NULL;
> +	int count;
> +
> +	if (!ucounts)
> +		return NULL;
> +
> +	count = atomic_read(&ucounts->count);
> +
> +	while (count > 0 && count + 1 > count) {
> +		if (atomic_try_cmpxchg(&ucounts->count, &count, count + 1))
> +			return ucounts;
>  	}
> -	return ucounts;
> +	return NULL;
>  }
>  
>  struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
> @@ -184,8 +191,8 @@ struct ucounts *alloc_ucounts(struct use
>  			return new;
>  		}
>  	}
> -	spin_unlock_irq(&ucounts_lock);
>  	ucounts = get_ucounts(ucounts);
> +	spin_unlock_irq(&ucounts_lock);
>  	return ucounts;
>  }

I see that your patch is not for the most recent code. You are using the
old version of code.

-- 
Rgrds, legion

