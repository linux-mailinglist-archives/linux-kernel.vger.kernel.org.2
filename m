Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17FF3AB26D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhFQLZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:25:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34180 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbhFQLZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:25:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5D47E1FDD5;
        Thu, 17 Jun 2021 11:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623929001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HX1faego5vfkn9CY9e5adLzo+Nz153gQ8o/qvgIZ4QI=;
        b=nRRU/oL51WtuiFHZRbFzQEfpDS5qHd56zU5QuZ24VdJteb+n8GqUv4ho7kVJHE75HCcauz
        LB6ewQkBxZt9mcFxyHV8KFIFNGriE1rqiGPMHvrwBRxx18CPe6ZT+5JJzNNpaJ4sU3s5u6
        Ky6Q3FIVHFyehA3xMHvgkc4JwzH+fKY=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D514BA3BB8;
        Thu, 17 Jun 2021 11:23:20 +0000 (UTC)
Date:   Thu, 17 Jun 2021 13:23:20 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH next v4 0/2] introduce printk cpu lock
Message-ID: <YMswqJ7sV5RCxNim@alley>
References: <20210617095051.4808-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617095051.4808-1-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-06-17 11:56:49, John Ogness wrote:
> Hello,
> 
> While working on removing the safe buffers for printk [0] we
> stumbled on a cpu-reentrant spinning lock used by dump_stack(). This
> type of lock (dubbed a cpu lock) will cause deadlock risks once we
> introduce atomic consoles because atomic consoles also need such a
> lock.
> 
> Although we are not yet ready to introduce atomic consoles, this is
> an appropriate time to provide an official cpu lock to be used for
> all things relating to printk (including the atomic consoles, once
> they are introduced).
> 
> An example of cpu lock usage for atomic consoles can be found in the
> PREEMPT_RT tree, such as the serial8250 implementation [1] of an
> atomic console. (In PREEMPT_RT the printk cpu lock function was
> named console_atomic_lock/_unlock.)
> 
> This series is against next-20210616.
> 
> John Ogness (2):
>   lib/dump_stack: move cpu lock to printk.c
>   printk: fix cpu lock ordering

For both patches:

Reviewed-by: Petr Mladek <pmladek@suse.com>

The patchset is ready for linux-next from my POV. We are getting close
to the merge window so I am going to push it tomorrow. We could always
remove it when anyone has comments the following week.

Best Regards,
Petr
