Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAB131FC7C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 16:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhBSP5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 10:57:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:54406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229587AbhBSP5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 10:57:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613750205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WEjAB90PWGl0pwkzP8XedyQKv9drco4Ks/OZICKN/dQ=;
        b=ZetWJIQSR+VkCNPrgq7b3DZKP66hj4+aH+UGWSu9FYjvb9FyI+mE2QDVujY7nnHmrb2/VA
        Q3/gNWHzhUr8AFGVFIHF1Pbi7nEG5vNS416I/W9W1mpeRKFgtWwy956LvN/3B1Sh/lPcpE
        MD11LfckT65CvTBMPPx5jhUraF5Vo6Y=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0DA1FAC6E;
        Fri, 19 Feb 2021 15:56:45 +0000 (UTC)
Date:   Fri, 19 Feb 2021 16:56:44 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 09/14] printk: introduce a kmsg_dump
 iterator
Message-ID: <YC/fvJbl0mJdm/VH@alley>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
 <20210218081817.28849-10-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218081817.28849-10-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-02-18 09:18:12, John Ogness wrote:
> Rather than store the iterator information into the registered

s/store/storing/ ?

> kmsg_dump structure, create a separate iterator structure. The
> kmsg_dump_iter structure can reside on the stack of the caller,
> thus allowing lockless use of the kmsg_dump functions.
> 
> This is in preparation for removal of @logbuf_lock.
> 
> diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
> index 4095a34db0fa..2fdb10ab1799 100644
> --- a/include/linux/kmsg_dump.h
> +++ b/include/linux/kmsg_dump.h
> @@ -29,6 +29,18 @@ enum kmsg_dump_reason {
>  	KMSG_DUMP_MAX
>  };
>  
> +/**
> + * struct kmsg_dumper_iter - iterator for kernel crash message dumper
> + * @active:	Flag that specifies if this is currently dumping
> + * @cur_seq:	Points to the oldest message to dump (private)
> + * @next_seq:	Points after the newest message to dump (private)

"(private)" might be removed.

Anyway, the issues are only cosmetic:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
