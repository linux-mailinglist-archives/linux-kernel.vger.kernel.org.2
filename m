Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8541447B9F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 09:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbhKHIOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 03:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbhKHIOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 03:14:52 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9498DC061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 00:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U4mTTJb6i/blYyrscgM74QGvIFAfksSxGPBnkYKnOms=; b=mRBCZfR7D6wQOnUZkcNoH+YN5j
        xHsk3ps0zpw8hF3V+QF3ZJj/N6h57I3Jv3SG8C6o23AieQyQBB5xmqmhFzSsDwD7Isk8dKNco60XX
        wMNTMK/UJ4ObNI8AxEi4nZWlWKWteXWH6JfZ2LL+PSdmlG1yONF7olBAjbd75ML6O3m/HXXwclo9/
        lhdYDgA33fI3NVCf9w+K9VsbK1+foQI8DYoZ4ImyleUp2w2e8dgNWWFy9NfutjcN4CPfNCQg/Tqgx
        M8rlFVaY9UCVKc/Lwxh7zNLI3XfzrdZ3H3DtykZaRrwVF4n1v2XdvpH1FkrBpm8JPq/SOOgLc8RyS
        X8QLB7QA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjzl4-00Eqot-Ep; Mon, 08 Nov 2021 08:12:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2CD183000DD;
        Mon,  8 Nov 2021 09:12:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0773F2CD0FE87; Mon,  8 Nov 2021 09:12:01 +0100 (CET)
Date:   Mon, 8 Nov 2021 09:12:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Colin King (gmail)" <colin.i.king@googlemail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: DEAD callback error for CPU, WARNING: CPU: 3 PID: 1134 at
 kernel/cpu.c:1163 _cpu_down+0x20a/0x3a0
Message-ID: <YYjb0OZxlDJpA6wr@hirez.programming.kicks-ass.net>
References: <f6a0f4be-ad53-489c-0036-09dead99f368@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6a0f4be-ad53-489c-0036-09dead99f368@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2021 at 11:59:17AM +0000, Colin King (gmail) wrote:
> On a SMP system in a VM, a deadlock callback error can be reproduced with
> 5.15, tested from head at commit d4439a1189f93d0ac1eaf0197db8e6b3e197d5c7
> 
> Didn't see this issue on 5.13
> 
> How to reproduce:
> 
> git clone https://github.com/ColinIanKing/stress-ng
> cd stress-ng
> make -j $(nproc)
> sudo ./stress-ng --cpu-online 0 -t 15 --pathological
> 
> Tested on a 8 thread virtual machine, 4MB of memory.
> 
> [ 2239.378724] smpboot: CPU 6 is now offline
> [ 2239.379443] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 2239.380169] kvm-clock: cpu 6, msr 79201181, secondary cpu clock
> [ 2239.401652] ------------[ cut here ]------------
> [ 2239.401658] DEAD callback error for CPU6
> [ 2239.401721] WARNING: CPU: 3 PID: 1134 at kernel/cpu.c:1163
> _cpu_down+0x20a/0x3a0

Can you do the same with whatever magic is required to get the
pr_debug() output from cpuhp_down_callbacks() included?

