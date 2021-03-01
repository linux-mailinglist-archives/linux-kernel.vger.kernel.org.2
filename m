Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6BE3292DD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 21:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244025AbhCAUyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 15:54:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:60456 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237154AbhCARKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:10:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614618565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H35nz79U3iTc666xWR8lPmhHegrvhs5FWA9WuA5DkEI=;
        b=RqQ5wOe0/iOPbgkCB6+F3wjB6c0eOIYiAodwUelOlBKkvKla4T6I47dITleDs6+RLWIspc
        Es21DW2KUJVlAfVhSegO/4+EAe2vuEUr39OyN6XxmJfp4q/GBF6Pnh5R6EkEnA3PcrwpfB
        JyUEYKEYJ1KY7x0yNXuizUFDOpdNCiw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8FB08AE3C;
        Mon,  1 Mar 2021 17:09:25 +0000 (UTC)
Date:   Mon, 1 Mar 2021 18:09:23 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jordan Niethe <jniethe5@gmail.com>,
        Alistair Popple <alistair@popple.id.au>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Kees Cook <keescook@chromium.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Wei Li <liwei391@huawei.com>, linuxppc-dev@lists.ozlabs.org,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH next v3 11/15] printk: kmsg_dumper: remove @active field
Message-ID: <YD0fw0DErfsi2ibs@alley>
References: <20210225202438.28985-1-john.ogness@linutronix.de>
 <20210225202438.28985-12-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225202438.28985-12-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-02-25 21:24:34, John Ogness wrote:
> All 6 kmsg_dumpers do not benefit from the @active flag:
> 
>   (provide their own synchronization)
>   - arch/powerpc/kernel/nvram_64.c
>   - arch/um/kernel/kmsg_dump.c
>   - drivers/mtd/mtdoops.c
>   - fs/pstore/platform.c
> 
>   (only dump on KMSG_DUMP_PANIC, which does not require
>   synchronization)
>   - arch/powerpc/platforms/powernv/opal-kmsg.c
>   - drivers/hv/vmbus_drv.c
> 
> The other 2 kmsg_dump users also do not rely on @active:
> 
>   (hard-code @active to always be true)
>   - arch/powerpc/xmon/xmon.c
>   - kernel/debug/kdb/kdb_main.c

Great summary!

> Therefore, @active can be removed.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
