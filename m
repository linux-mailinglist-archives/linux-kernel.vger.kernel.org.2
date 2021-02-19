Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A7C31F98C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 13:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhBSMox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 07:44:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:36784 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230257AbhBSMov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 07:44:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613738645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8wt+VswIQhwTg06WDe+v0ejj0Btujcc6yJVDWuuFRng=;
        b=Prge6z4qL9/tYI4JRPuUCjul0pzkUa3ke2O4fASRQXj6pi4m+TEG1U6nWwtWzA/18t5Fjl
        nG4gxkFA7wniE9H2xPESDEtIGdbaIccLeCEOedTIRcWgkB+nR+oLc7ju61TWW7HIVesWmL
        KhGLcNGAHEIJHhfSJi5gCRvF76s7rB0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9097CAFDF;
        Fri, 19 Feb 2021 12:44:05 +0000 (UTC)
Date:   Fri, 19 Feb 2021 13:44:05 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 05/14] printk: introduce CONSOLE_LOG_MAX
 for improved multi-line support
Message-ID: <YC+ylZ3scs0cZfmt@alley>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
 <20210218081817.28849-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218081817.28849-6-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-02-18 09:18:08, John Ogness wrote:
> Instead of using "LOG_LINE_MAX + PREFIX_MAX" for temporary buffer
> sizes, introduce CONSOLE_LOG_MAX. This represents the maximum size
> that is allowed to be printed to the console for a single record.
> 
> Rather than setting CONSOLE_LOG_MAX to "LOG_LINE_MAX + PREFIX_MAX"
> (1024), increase it to 4096. With a larger buffer size, multi-line
> records that are nearly LOG_LINE_MAX in length will have a better
> chance of being fully printed. (When formatting a record for the
> console, each line of a multi-line record is prepended with a copy
> of the prefix.)
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

The logic is correct. I am just slightly afraid that people
developing small devices might cry. And nobody reported problems
with the small buffer.

OK, let's try the change. We could always revert the size increase
when anyone complains.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
