Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A32397569
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 16:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbhFAO1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 10:27:44 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59880 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhFAO1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:27:42 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 218531FD2A;
        Tue,  1 Jun 2021 14:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622557560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XwLt0s00SGQEA1X7LJbheGbmhazQbAseZMTcMpe6nbY=;
        b=BXG1jaUg+QMV9345uAeMc4nBLx/1qWFi2uZE9CUD8Jasq82A7HKhczfrmM9I0/r3c1zdTd
        Ac8Zl5eNmhTMuf5AXWTD3Zo2Bab2dLLNwPCrx2vNwr5FY56RgsbhzQp4sOzXuwv/XNrVbV
        GVAQxJOXwks1MJwshwu+9vQO5PmrFt8=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D7239A3B89;
        Tue,  1 Jun 2021 14:25:59 +0000 (UTC)
Date:   Tue, 1 Jun 2021 16:25:59 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH next v1 2/2] nmi_backtrace: use the printk cpu lock for
 show_regs()
Message-ID: <YLZDd+Jo42yBWa9L@alley>
References: <20210531162051.2325-1-john.ogness@linutronix.de>
 <20210531162051.2325-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531162051.2325-3-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-05-31 18:20:51, John Ogness wrote:
> dump_stack() uses the printk cpu lock to synchronize the stacktrace,
> but this can also be used for dumping the banner and regs.
> 
> Since the cpu lock allows recursive locking, it is not an issue to
> call dump_stack() with the printk cpu lock held.

This does not explain why it is serialized only in nmi_cpu_backtrace().

It would be better to serialize all show_regs() calls. But it would
require updating all the arch-specific implementations.

I know that this patch is a pre-requisite for another patchset
removing printk_safe(). Where printk_safe() is serializing
the backtraces from all CPUs at the moment.

IMHO, it is perfectly fine synchronize only nmi_cpu_backtrace() for
now. It is the most important use-case where show_regs() calls could
get messed easily. But I suggest to do it in the patchset removing
printk_safe(). Also we need to explain in the commit message the relation
to printk_safe().

Best Regards,
Petr
