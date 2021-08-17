Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D583EEFD6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240376AbhHQP5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240395AbhHQPzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:55:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF23C06114B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 08:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7E55hBkAaWzgDmt/aR9uliB5uw1uxWggq7n5Xe23/mo=; b=DWXaG/9JQJS+HPceJX7RAdDDAn
        qy24xzoY75oAs6MElR5FJ0KNZnwaEA+6mendTYtzpmKJ/WiMCLIQrnsEtIXltxFBP01JtWA+PZBBy
        oFICyRwfa4HgErB9+S9sYctCqxUDUSgcJOSymMfskE3xT22kBTHmiB+gw0JGEBFxJKUuFVWsivOlN
        cG1AzcDb8xJgLyUz1GbxbO6/qQt2s8vZdgj3puG2ry/80RCpg5rSl6zYZojihjHORVsM4BHY2EyRf
        WUmF+Cf9t88BHgNJnRLOEWqmfwEJUpbO8sbgwc9fyWOIog8bjbVeyvhzUvlnTfDJeB1Lccz1cGVt9
        bEixoiAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mG1OP-00AVLS-83; Tue, 17 Aug 2021 15:52:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E1DB6300813;
        Tue, 17 Aug 2021 17:52:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A2EFA2C8F5E0C; Tue, 17 Aug 2021 17:52:43 +0200 (CEST)
Date:   Tue, 17 Aug 2021 17:52:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Christian Brauner <christian.brauner@ubuntu.com>, ldv@strace.io
Subject: Re: [PATCH 18/19] sched: prctl() core-scheduling interface
Message-ID: <YRvbS5ypWhcsBzzU@hirez.programming.kicks-ass.net>
References: <20210422120459.447350175@infradead.org>
 <20210422123309.039845339@infradead.org>
 <20210817151542.GA1665@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817151542.GA1665@asgard.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 05:15:42PM +0200, Eugene Syromiatnikov wrote:
> [76195.611570] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [76195.613059] #PF: supervisor read access in kernel mode
> [76195.614174] #PF: error_code(0x0000) - not-present page
> [76195.615329] PGD 800000005f27e067 P4D 800000005f27e067 PUD 3f7a3067 PMD 0 
> [76195.616801] Oops: 0000 [#67] SMP PTI
> [76195.617586] CPU: 2 PID: 239821 Comm: prctl-sched-cor Tainted: G      D W        --------- ---  5.14.0-0.rc5.20210813gitf8e6dfc64f61.46.fc36.x86_64 #1
> [76195.620374] Hardware name: HP ProLiant BL480c G1, BIOS I14 10/04/2007
> [76195.621771] RIP: 0010:do_raw_spin_trylock+0x5/0x40
> [76195.622821] Code: c6 a4 12 5f 9f 48 89 ef e8 c8 fe ff ff eb a9 89 c6 48 89 ef e8 0c f5 ff ff 66 90 eb a9 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 <8b> 07 85 c0 75 28 ba 01 00 00 00 f0 0f b1 17 75 1d 65 8b 05 fb 98
> [76195.626797] RSP: 0018:ffffa366014abe58 EFLAGS: 00010086
> [76195.627936] RAX: 0000000000000001 RBX: 0000000000000004 RCX: 0000000000000000
> [76195.629470] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [76195.631048] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> [76195.632585] R10: 0000000000000000 R11: ffff98292b21ad48 R12: 0000000000000018
> [76195.634078] R13: 0000000000000000 R14: ffff98292b7ef940 R15: ffff982813938e00
> [76195.635621] FS:  00007f271f8755c0(0000) GS:ffff98292b200000(0000) knlGS:0000000000000000
> [76195.637354] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [76195.638606] CR2: 0000000000000000 CR3: 000000000fdd0000 CR4: 00000000000006e0
> [76195.640144] Call Trace:
> [76195.640706]  _raw_spin_lock_nested+0x37/0x80
> [76195.641645]  ? raw_spin_rq_lock_nested+0x4b/0x80
> [76195.642693]  raw_spin_rq_lock_nested+0x4b/0x80
> [76195.643669]  online_fair_sched_group+0x39/0x240

Urgh... lemme guess, your HP BIOS is funny and reports more possible
CPUs than you actually have resulting in cpu_possible_mask !=
cpu_online_mask. Alternatively, you booted with nr_cpus= or something
daft like that.

That code does for_each_possible_cpus(i) { rq_lock_irq(cpu_rq(i)); },
which, because of core-sched, needs rq->core set-up, but because these
CPUs have never been online, that's not done and *BOOM*.

Or something like that.. I'll try and have a look tomorrow, I'm in dire
need of sleep.
