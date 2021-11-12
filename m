Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492BB44E374
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 09:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbhKLIsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 03:48:10 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57178 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbhKLIsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 03:48:08 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 801D021B2A;
        Fri, 12 Nov 2021 08:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636706717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PGUvzC73zFVV7sac1WafnOJVQ5GmzjfWEgRcmV4nMos=;
        b=gI5FyuFmNwhi8dHwWPnH3x6qfoG2mpFsomZeqOX5UNj0gWU+7Ywdl/BBn6sPIJA4Gvk33x
        EMxOw89IIATZR6iWIj4QYCHGLyKtRfa6gOEgFsLj60TbmLHDLQubUNW5eql70UDuXZ2i/L
        lKa5t8Ddkr+fvolgi2OYDd90C5D4ISE=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 25E36A3B81;
        Fri, 12 Nov 2021 08:45:17 +0000 (UTC)
Date:   Fri, 12 Nov 2021 09:45:15 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2 1/1] printk: suppress rcu stall warnings caused by
 slow console devices
Message-ID: <YY4pmySR3VVHAtYy@alley>
References: <20211111195904.618253-1-wander@redhat.com>
 <20211111195904.618253-2-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111195904.618253-2-wander@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-11-11 16:59:04, Wander Lairson Costa wrote:
> If we have a reasonable large dataset to flush in the printk ring
> buffer in the presence of a slow console device (like a serial port
> with a low baud rate configured), the RCU stall detector may report
> warnings.
> 
> This patch suppresses RCU stall warnings while flushing the ring buffer
> to the console.

I have mixed feelings about this patch.

We already touch watchdogs in several situations to avoid this type
of reports. So, there is a precedent.

On the other hand, it hides a real problem. printk() might cause
softlockups, livelockups, and even deadlocks. It might really stall
other processes and CPUs. And the stall report might help to
understand that the system is not longer responsive because of
printk().

John Ogness is working on the proper solution, handling consoles
in a kthread. It is not that easy because we need to handle situations
when kthreads do not work, for example, during early boot, panic(),
suspend, reboot, kexec. But I believe that we will have it rather
sooner than later.

A workaround, is to lower console_loglevel and show only the most
important messages. Sometimes, a reasonable solution is to ratelimit
repeated messages.

Which brings the question. What is the motivation for this patch,
please?

Is it motivated by a particular bug report?
Or does the experience shows that this report causes more harm than
good?

Best Regards,
Petr
