Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AE33DB782
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 13:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238569AbhG3LAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 07:00:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49500 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238403AbhG3LAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 07:00:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5B9DB221A1;
        Fri, 30 Jul 2021 11:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627642849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vPU3VuVhAbVURPSkKGj0V9r87XsRlWqlHWR0ID/bNdw=;
        b=fL0XBylx5JiM+eWq7EdF4OmuBFZ/ENTjuXnaPABRpmz3EynS69AiaojvrEavO1jnELpyYm
        YDH/Y5KBINWs+tY3QQN5LL+J8wqsD48Hl+AzT/uymkUTraG5jeQHXhd5+SWHAPsEviTNtL
        nVvGbBfCl7DKk8f59uauHbJMfmI+cGE=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3E98FA3B88;
        Fri, 30 Jul 2021 11:00:49 +0000 (UTC)
Date:   Fri, 30 Jul 2021 13:00:48 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 2/2] printk: Add printk.console_verbose boot parameter
Message-ID: <YQPb4LGzj+NuZ7qL@alley>
References: <20210713011511.215808-1-dima@arista.com>
 <20210713011511.215808-3-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713011511.215808-3-dima@arista.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-07-13 02:15:11, Dmitry Safonov wrote:
> console_verbose() increases console loglevel to CONSOLE_LOGLEVEL_MOTORMOUTH,
> which provides more information to debug a panic/oops.
> 
> Unfortunately, in Arista we maintain some DUTs (Device Under Test) that
> are configured to have 9600 baud rate. While verbose console messages
> have their value to post-analyze crashes, on such setup they:
> - may prevent panic/oops messages being printed
> - take too long to flush on console resulting in watchdog reboot
> 
> In all our setups we use kdump which saves dmesg buffer after panic,
> so in reality those extra messages on console provide no additional value,
> but rather add risk of not getting to __crash_kexec().
> 
> Provide printk.console_verbose boot parameter, which allows to switch off
> printk being verbose on oops/panic/lockdep (making it boot parameter
> instead of compile-option suggested-by Petr).
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
