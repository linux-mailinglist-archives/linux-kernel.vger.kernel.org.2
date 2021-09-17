Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B68540F865
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244713AbhIQMzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:55:43 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:44650 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238675AbhIQMzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:55:42 -0400
Received: from [192.168.1.3] (ns.gsystem.sk [62.176.172.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id BE7237A0214;
        Fri, 17 Sep 2021 14:54:19 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/iopl: Fake iopl(3) CLI/STI usage
Date:   Fri, 17 Sep 2021 14:54:16 +0200
User-Agent: KMail/1.9.10
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <202109151423.43604.linux@zary.sk> <YUSCDX5QwzTcCPFa@hirez.programming.kicks-ass.net> <87mtob8jqp.ffs@tglx>
In-Reply-To: <87mtob8jqp.ffs@tglx>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202109171454.16362.linux@zary.sk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 September 2021, Thomas Gleixner wrote:
> On Fri, Sep 17 2021 at 13:54, Peter Zijlstra wrote:
> >> [   14.876824] fixup_iopl_exception: 333 callbacks suppressed
> >> [   14.876832] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
> >
> > I'd say...
> >
> > Not sure it's really worth it, but something like the below might
> > help.
> 
> One entry per task is really good enough. Though that wont help for such
> stuff which is started over and over again....

Seems to fine for this case. hpasmd is running as a daemon.

# dmesg | tail
[    6.834639] atyfb: fb0: ATY Mach64 frame buffer device on PCI
[    7.629499] random: crng init done
[    7.629507] random: 7 urandom warning(s) missed due to ratelimiting
[    9.737551] floppy0: no floppy controllers found
[    9.737584] work still pending
[    9.923185] process 'hp/hp-health/bin/hpasmd' started with executable stack
[   10.140055] traps: hpasmd[359] attempts to use CLI/STI, pretending it's a NOP, ip:f7d3709b in mem[f7d37000+3000]
[   15.821726] tg3 0000:03:01.0 enp3s1f0: Link is up at 1000 Mbps, full duplex
[   15.821753] tg3 0000:03:01.0 enp3s1f0: Flow control is on for TX and on for RX
[   15.821786] IPv6: ADDRCONF(NETDEV_CHANGE): enp3s1f0: link becomes ready
# hpasmcli -s "show fans"

Fan  Location        Present Speed  of max  Redundant  Partner  Hot-pluggable
---  --------        ------- -----  ------  ---------  -------  -------------
#1   PROCESSOR_ZONE  Yes     NORMAL  22%     Yes        2        Yes
#2   PROCESSOR_ZONE  Yes     NORMAL  22%     Yes        1        Yes
#3   I/O_ZONE        Yes     NORMAL  11%     Yes        1        Yes
#4   I/O_ZONE        Yes     NORMAL  11%     Yes        1        Yes
#5   PROCESSOR_ZONE  Yes     NORMAL  22%     Yes        1        Yes
#6   PROCESSOR_ZONE  Yes     NORMAL  22%     Yes        1        Yes
#7   POWERSUPPLY_BAY Yes     NORMAL  11%     Yes        1        Yes
#8   POWERSUPPLY_BAY Yes     NORMAL  11%     Yes        1        Yes


-- 
Ondrej Zary
