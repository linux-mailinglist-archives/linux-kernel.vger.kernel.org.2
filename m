Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B744030A884
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhBANTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:19:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:45394 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231875AbhBANSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:18:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612185438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5lqS3u+NhmZnlbr2J2yI9qILI3OSg7IBw22MBGIPeSs=;
        b=BfrKchf81WLzvoeZVSbFZNoqSgmkDG24zj5z5dv3v82jlRVYWUCsT3CmSCF0qhLM/dloXx
        WkqDZbXEheO99V6KOVKwcbEeGG+WJOmHgkOcblnIOSm1+NoU4rgmA7QwqdrQry/N+c+yj7
        i+KvEcAcEJDEUzgZ6fpqQVcVC/J+vWo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 13216AB92;
        Mon,  1 Feb 2021 13:17:18 +0000 (UTC)
Date:   Mon, 1 Feb 2021 14:17:17 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 08/12] printk: introduce a kmsg_dump
 iterator
Message-ID: <YBf/XUmgflhMHtBx@alley>
References: <20210126211551.26536-1-john.ogness@linutronix.de>
 <20210126211551.26536-9-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126211551.26536-9-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-01-26 22:21:47, John Ogness wrote:
> Rather than store the iterator information into the registered
> kmsg_dump structure, create a separate iterator structure. The
> kmsg_dump_iter structure can reside on the stack of the caller,
> thus allowing lockless use of the kmsg_dump functions.
> 
> This is in preparation for removal of @logbuf_lock.

> diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
> index 76cc4122d08e..ecc98f549d93 100644
> --- a/include/linux/kmsg_dump.h
> +++ b/include/linux/kmsg_dump.h
> @@ -29,6 +29,18 @@ enum kmsg_dump_reason {
>  	KMSG_DUMP_MAX
>  };
>  
> +/**
> + * struct kmsg_dumper_iter - iterator for kernel crash message dumper
> + * @active:	Flag that specifies if this is currently dumping
> + * @cur_seq:	The record to dump (private)
> + * @next_seq:	The first record of the next block (private)

Just to be sure. This description should get update if you agree with
the alternative one in the 1st patch.

> + */
> +struct kmsg_dumper_iter {
> +	bool	active;
> +	u64	cur_seq;
> +	u64	next_seq;
> +};
> +

Otherwise, I like this change.

Best Regards,
Petr
