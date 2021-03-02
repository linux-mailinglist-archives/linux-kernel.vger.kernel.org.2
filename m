Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B2032A630
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578388AbhCBOKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 09:10:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:56438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1444798AbhCBMem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:34:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614687329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ix/stVvXOmSDYShZsbyJV8k0vX63VBVeKfjBdYcmCIE=;
        b=rNDOAXspTySHb4x9mtbYwMoG4W9YJbi2RPoxzCJAHTYg1N9jrsW/JO41AqmRv8cHO1XtpH
        6o/AL1vHpm5+LLqbgs/olSuJSW70zz4PCkbVmLplJoE6l+SVm8H+x3GcJNGm9uyDFNDS94
        uA9CZBKkEnQvVL9+3bElBbXYOz1QKXo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 056CCABF4;
        Tue,  2 Mar 2021 12:15:29 +0000 (UTC)
Date:   Tue, 2 Mar 2021 13:15:28 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v3 13/15] printk: remove logbuf_lock
Message-ID: <YD4sYDECPTPcN1eI@alley>
References: <20210225202438.28985-1-john.ogness@linutronix.de>
 <20210225202438.28985-14-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225202438.28985-14-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-02-25 21:24:36, John Ogness wrote:
> Since the ringbuffer is lockless, there is no need for it to be
> protected by @logbuf_lock. Remove @logbuf_lock.
> 
> @console_seq, @exclusive_console_stop_seq, @console_dropped are
> protected by @console_lock.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
