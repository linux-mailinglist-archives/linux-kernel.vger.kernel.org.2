Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E461B341A49
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhCSKne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:43:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:41638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhCSKna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:43:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616150609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZT2adM0gNwyX88EY+QJuSIq0ePg4+xBf6yJNZwGZd6c=;
        b=Mk4ByWwjP0NzIKO8YEwm+xBBE4yeEjZp1YDIZ/0mug5i6tc5+JQ3t2yNq/LS1bMeO0hygv
        Ye8B/muhVJ+CrwJomkcn+ZgPCKvM7eKON3hAqhMfuPzHkHapdxfRvRQ06bFLgwjqGZxdtj
        ty9VXooPxQH21acLUtPwnUpIfacagxg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3D8A9AE05;
        Fri, 19 Mar 2021 10:43:29 +0000 (UTC)
Date:   Fri, 19 Mar 2021 11:43:28 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update Senozhatsky email address
Message-ID: <YFSAUCZbOg7oBk/9@alley>
References: <20210319054508.124762-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319054508.124762-1-senozhatsky@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-03-19 14:45:08, Sergey Senozhatsky wrote:
> I don't check my @gmail.com addresses often enough these days.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  MAINTAINERS | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b2baeb5e4a68..01b000cd5774 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14433,7 +14433,7 @@ F:	kernel/sched/psi.c
>  
>  PRINTK
>  M:	Petr Mladek <pmladek@suse.com>
> -M:	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> +M:	Sergey Senozhatsky <senozhatsky@chromium.org>
>  R:	Steven Rostedt <rostedt@goodmis.org>
>  R:	John Ogness <john.ogness@linutronix.de>
>  S:	Maintained

The patch is comitted in printk/linux.git, branch for-5.13.

Now I have to remember using the new address, for example,  when
calling git send-email from bash history ;-)

Best Regards,
Petr
