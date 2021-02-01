Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A168430A368
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 09:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhBAIg7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 Feb 2021 03:36:59 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:58459 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232363AbhBAIg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 03:36:57 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 23757522-1500050 
        for multiple; Mon, 01 Feb 2021 08:36:12 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <871re5jiu3.fsf@intel.com>
References: <871re5jiu3.fsf@intel.com>
Subject: Re: [Intel-gfx] v5.11-rc5 BUG kmalloc-1k (Not tainted): Redzone overwritten
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
To:     Jani Nikula <jani.nikula@intel.com>, linux-kernel@vger.kernel.org
Date:   Mon, 01 Feb 2021 08:36:12 +0000
Message-ID: <161216857247.30865.951745918507946908@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jani Nikula (2021-01-28 13:23:48)
> 
> A number of our CI systems are hitting redzone overwritten errors after
> s2idle, with the errors introduced between v5.11-rc4 and v5.11-rc5. See
> snippet below, full logs for one affected machine at [1].
> 
> Known issue?

Fwiw, I think this should be fixed by

commit 08d60e5999540110576e7c1346d486220751b7f9
Author: John Ogness <john.ogness@linutronix.de>
Date:   Sun Jan 24 21:33:28 2021 +0106

    printk: fix string termination for record_print_text()

    Commit f0e386ee0c0b ("printk: fix buffer overflow potential for
    print_text()") added string termination in record_print_text().
    However it used the wrong base pointer for adding the terminator.
    This led to a 0-byte being written somewhere beyond the buffer.

    Use the correct base pointer when adding the terminator.

    Fixes: f0e386ee0c0b ("printk: fix buffer overflow potential for print_text()")
    Reported-by: Sven Schnelle <svens@linux.ibm.com>
    Signed-off-by: John Ogness <john.ogness@linutronix.de>
    Signed-off-by: Petr Mladek <pmladek@suse.com>
    Link: https://lore.kernel.org/r/20210124202728.4718-1-john.ogness@linutronix.de

din should be rolled forward, but there's yet another regression in rc6
breaking suspend on all machines.
-Chris
