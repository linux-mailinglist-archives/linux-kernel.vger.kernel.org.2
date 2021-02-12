Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2088319C1D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 10:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhBLJsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 04:48:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:50284 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229928AbhBLJrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 04:47:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613123226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MRHvqshruqvs3aOgQUWLKWvnflNOmOtBfIlkGvC280w=;
        b=JoS4EFB8kxyJDBNuOH8c7mCafhgaAwHMyt3Q9WWEi3p2biR2Nlw0CAWMTOG8x2KDqzVnZ3
        UYZvA5HUxVT9yDKHjla4OxbbYL36LszQ9vg+O25hlOV+gnuDtgr98M7REk6tN7v6LMDtxE
        ZoMD2sfCd4U8UEbsE+0/myALBQuq+jM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 36B87B176;
        Fri, 12 Feb 2021 09:47:06 +0000 (UTC)
Date:   Fri, 12 Feb 2021 10:47:05 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "J. Avila" <elavila@google.com>,
        kernel test robot <oliver.sang@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk: avoid prb_first_valid_seq() where possible
Message-ID: <YCZOmajTizYrDSm5@alley>
References: <20210211173152.1629-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211173152.1629-1-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-02-11 18:37:52, John Ogness wrote:
> If message sizes average larger than expected (more than 32
> characters), the data_ring will wrap before the desc_ring. Once the
> data_ring wraps, it will start invalidating descriptors. These
> invalid descriptors hang around until they are eventually recycled
> when the desc_ring wraps. Readers do not care about invalid
> descriptors, but they still need to iterate past them. If the
> average message size is much larger than 32 characters, then there
> will be many invalid descriptors preceding the valid descriptors.
> 
> The function prb_first_valid_seq() always begins at the oldest
> descriptor and searches for the first valid descriptor. This can
> be rather expensive for the above scenario. And, in fact, because
> of its heavy usage in /dev/kmsg, there have been reports of long
> delays and even RCU stalls.
> 
> For code that does not need to search from the oldest record,
> replace prb_first_valid_seq() usage with prb_read_valid_*()
> functions, which provide a start sequence number to search from.
> 
> Fixes: 896fbe20b4e2333fb55 ("printk: use the lockless ringbuffer")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Reported-by: J. Avila <elavila@google.com>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

I am going to push the patch later today. I would prefer to do it
later and give a chance others to react. But the merge window
will likely start the following week and Sergey was fine
with this approach.

Best Regard,
Petr
