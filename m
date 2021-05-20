Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D55A38B5DC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 20:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbhETSRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 14:17:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:57610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231848AbhETSRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 14:17:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A8BEFABEA;
        Thu, 20 May 2021 18:16:15 +0000 (UTC)
Date:   Thu, 20 May 2021 11:16:00 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH for-next] futex: deduplicate resched in futex_wake_op()
Message-ID: <20210520181600.oupnaspukteh7dsk@offworld>
References: <9b2588c1fd33c91fb01c4e348a3b647ab2c8baab.1621258128.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9b2588c1fd33c91fb01c4e348a3b647ab2c8baab.1621258128.git.asml.silence@gmail.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2021, Pavel Begunkov wrote:

>After pagefaulting in futex_wake_op() both branches do cond_resched()
>before retry. Help to deduplicate it as many compilers can't cope with
>it.
>

LGTM:

Reviewed-by: Davidlohr Bueso <dbueso@suse.de>

>Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>---
> kernel/futex.c | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)
>
>diff --git a/kernel/futex.c b/kernel/futex.c
>index c98b825da9cf..54ed232b2553 100644
>--- a/kernel/futex.c
>+++ b/kernel/futex.c
>@@ -1728,12 +1728,9 @@ futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
> 				return ret;
> 		}
>
>-		if (!(flags & FLAGS_SHARED)) {
>-			cond_resched();
>-			goto retry_private;
>-		}
>-
> 		cond_resched();
>+		if (!(flags & FLAGS_SHARED))
>+			goto retry_private;
> 		goto retry;
> 	}
>
>-- 
>2.31.1
>
