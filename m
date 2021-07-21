Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180293D0EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 14:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbhGULk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 07:40:59 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54496 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbhGULk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 07:40:57 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 33802224F6;
        Wed, 21 Jul 2021 12:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626870092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NAuK0otPRZbyLm5W/rcnbQCEv6qxy3LDKAfiQ5AIMwY=;
        b=Uld4XLB/SDNYu+Mw61UAzPS+VQ4oIoeHROMrXfevNsGlmmohc15SJ6nvxm6a5amGt4rUs5
        juSvzaT3maQg5YgRzwsJlE4XMIoP7lm+K+Mss4WRIKiHL6VU9Uznjg9q6Jc3CRmgzPWULE
        A++JCQuJ1SHmIJBW/AKE6xplQPn9YPU=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EE5ABA3BAE;
        Wed, 21 Jul 2021 12:21:31 +0000 (UTC)
Date:   Wed, 21 Jul 2021 14:21:31 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 5/6] printk: convert @syslog_lock to mutex
Message-ID: <20210721122131.dlmkv7jsk2exj22y@pathway.suse.cz>
References: <20210715193359.25946-1-john.ogness@linutronix.de>
 <20210715193359.25946-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715193359.25946-6-john.ogness@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-07-15 21:39:58, John Ogness wrote:
> @syslog_lock was a raw_spin_lock to simplify the transition of
> removing @logbuf_lock and the safe buffers. With that transition
> complete, and since all uses of @syslog_lock are within sleepable
> contexts, @syslog_lock can become a mutex.
> 
> Note that until now register_console() would disable interrupts
> using irqsave, which implies that it may be called with interrupts
> disabled. And indeed, there is one possible call chain on parisc
> where this happens:
> 
> handle_interruption(code=1) /* High-priority machine check (HPMC) */
>   pdc_console_restart()
>     pdc_console_init_force()
>       register_console()
> 
> However, register_console() calls console_lock(), which might sleep.
> So it has never been allowed to call register_console() from an
> atomic context and the above call chain is a bug.
> 
> Note that the removal of read_syslog_seq_irq() is slightly changing
> the behavior of SYSLOG_ACTION_READ by testing against a possibly
> outdated @seq value. However, the value of @seq could have changed
> after the test, so it is not a new window. A follow-up commit closes
> this window.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
