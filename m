Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025F73229A0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 12:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhBWLpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 06:45:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:34692 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232396AbhBWLp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 06:45:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614080683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+kK10yoG2irjSdFkL2yWY8vClAAwl/2I649w+BMdE18=;
        b=hp6jDeuoAMGib81AFoKi0+y0ICBfMdCipA59OuFdkJ2jEIu4AQ2tQbV9C3NhC3SEu06h1t
        pwEQ4i1WW99T5p02d8BLb2Jth+C3xMz80xf6WxCYfMBKKtZb8lrVqbD8IrM9BQiabI2MOS
        NwYx7n3jQY7axF2ov5wchPKZ6i9Y2Pk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1D8CCAC69;
        Tue, 23 Feb 2021 11:44:43 +0000 (UTC)
Date:   Tue, 23 Feb 2021 12:44:42 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 11/14] printk: remove logbuf_lock
Message-ID: <YDTqqklNWi9K5oQv@alley>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
 <20210218081817.28849-12-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218081817.28849-12-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-02-18 09:18:14, John Ogness wrote:
> Since the ringbuffer is lockless, there is no need for it to be
> protected by @logbuf_lock. Remove @logbuf_lock.
> 
> This means that printk_nmi_direct and printk_safe_flush_on_panic()
> no longer need to acquire any lock to run.
> 
> @console_seq, @exclusive_console_stop_seq, @console_dropped are
> protected by @console_lock.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
