Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E68F31EE82
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhBRSkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:40:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:43474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233244AbhBRQP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 11:15:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613664911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J0NKBCRFWn5alqpNkuoDBrrfu6DDjmvlrvYuUcGThG4=;
        b=JXhHq6gmFS1ebPfmy76358du2DqVPMm7OCVZ11qEdRbraNWTCckn1ZXpBAr2/3TCQpVKpz
        sDmKRnnNXhoq6YSqQtdLxM/6f+c46TTXgF9L44Z96t7mZH5aOJ18BfWRpR4fWm1vUP3pE6
        zXTpaqtiLvVSSw5xihmh6M7L4Wo9vs8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 837BEACD4;
        Thu, 18 Feb 2021 16:15:11 +0000 (UTC)
Date:   Thu, 18 Feb 2021 17:15:10 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 01/14] printk: limit second loop of
 syslog_print_all
Message-ID: <YC6SjvU0iCSeHVVI@alley>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
 <20210218081817.28849-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218081817.28849-2-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-02-18 09:18:04, John Ogness wrote:
> The second loop of syslog_print_all() subtracts lengths that were
> added in the first loop. With commit b031a684bfd0 ("printk: remove
> logbuf_lock writer-protection of ringbuffer") it is possible that
> records are (over)written during syslog_print_all(). This allows the
> possibility of the second loop subtracting lengths that were never
> added in the first loop.
> 
> This situation can result in syslog_print_all() filling the buffer
> starting from a later record, even though there may have been room
> to fit the earlier record(s) as well.
> 
> Fixes: b031a684bfd0 ("printk: remove logbuf_lock writer-protection of ringbuffer")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

It makes sense after all. We reach the limit only when many old
messages has got replaced. It means that there is a flood
of messages. And this limit looks like a reasonable point where
to start filling the provided buffer.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
