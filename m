Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1713291D1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 21:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243599AbhCAUdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 15:33:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:58352 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237307AbhCARIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:08:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614618440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NY6iPETVbQ0YAmOgbep9iwFhhRjHQcDXlRCehKUkjgA=;
        b=eSwzVuAOtwkgmRPk3+H5fL0ounOxpYttJelAWvlmkw4w6bMtueiQFmD68qxxbMCYJBY56H
        UC03GdFjLMB10gIxXEORAbZtTRtiK6D40vFwjpiMxrjuGUeQDkF0KQ2ALhtQBUgaJ8BEp3
        r70KMN6BUNoh87qiJ4QwJW/7QjLw6jM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D89F5AE05;
        Mon,  1 Mar 2021 17:07:19 +0000 (UTC)
Date:   Mon, 1 Mar 2021 18:07:19 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v3 10/15] printk: add syslog_lock
Message-ID: <YD0fRwBUIatXX6sl@alley>
References: <20210225202438.28985-1-john.ogness@linutronix.de>
 <20210225202438.28985-11-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225202438.28985-11-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-02-25 21:24:33, John Ogness wrote:
> The global variables @syslog_seq, @syslog_partial, @syslog_time
> and write access to @clear_seq are protected by @logbuf_lock.
> Once @logbuf_lock is removed, these variables will need their
> own synchronization method. Introduce @syslog_lock for this
> purpose.
> 
> @syslog_lock is a raw_spin_lock for now. This simplifies the
> transition to removing @logbuf_lock. Once @logbuf_lock and the
> safe buffers are removed, @syslog_lock can change to spin_lock.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
