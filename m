Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0FF3DC7A7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 20:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhGaS0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 14:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhGaS0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 14:26:20 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57585C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 11:26:13 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id c2-20020a0568303482b029048bcf4c6bd9so13228452otu.8
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 11:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hBtKNyxqROYkKFt3WBE7Y4EWrIo+/eGAI501eNvazo8=;
        b=sSg9WjBK53PQztypwJMPVaq3GObjOOuz+Sm55XkTFEVxs71ZxyZ1Rc8jRV3etzMhJS
         3IfURxgFW7FPEK0qhtnNc9669PsPS/SpGHvXQ2Fq8trqsIPIGyJ299QpmgxeBURHCnKk
         LHPL9BKqu5l+fhj3e/tkuyaMDSxrbEeJUCSTKiUtigMPf3g4uLDOARqKm83TlRgGM5Ce
         Xtd95dgulhIH1y3HB7W+cL6hSIZqoPkt+UAQy2doRi2cjTPSEy/z+MGcLwH/d1drSU2x
         plQeK4JIDkLBNArfKK1CSF1KSz5Z3U6EPSMa2NvUgfZMJDk3UeKB8ECyq2RO6x/TNRnh
         SEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=hBtKNyxqROYkKFt3WBE7Y4EWrIo+/eGAI501eNvazo8=;
        b=FkvG2O/0sqBZVtZSSzuRCeh8CP0juyL/xx7EmD43H8VlMBESI9GwLs020hapqhJwRG
         mJ8bQW0x6ZcQbKIGP0lfFVkavqgfly+BvZnAdxNkEKtly+AZo4ZGZ86e2Z+9X9/tO6/J
         +VQwO9MQOqI8tduv5XbYzCtZKXfkNnUEEv8txkqCwAAPFKKnsujoKi4jrTzixyuPb9c9
         FXuplO7ncL1s7Uh0f3POPUV5KNaPfKBjzNI0O9RlhJU7urSLhrwrumWbqNyLtzVJc+Zx
         g2N/ToG22HpJPM0s6+h39MgYhMeXzt8Xla4/oyDK5yly2T1Jy/+ZjM4MMw5V+VWC4m4w
         zsrQ==
X-Gm-Message-State: AOAM532Et/dMxWf7QF9cq1wkhjMGmVWdf3MgPuwPp35JvxqUYGRet8xJ
        jCC3iiEHk4T/KcRpoyv345I=
X-Google-Smtp-Source: ABdhPJzAYOGKzOs20gmQvAnoUIZIaJXa+UkjMe9016BgtBmpjDIaHYvq4A/NDGvKBOKWtsbR7CZIJA==
X-Received: by 2002:a9d:550c:: with SMTP id l12mr6428564oth.169.1627755972617;
        Sat, 31 Jul 2021 11:26:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h2sm987204oti.24.2021.07.31.11.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 11:26:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 31 Jul 2021 11:26:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Claire Chang <tientzu@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 4/4] swiotlb: Free tbl memory in swiotlb_exit()
Message-ID: <20210731182611.GA3792424@roeck-us.net>
References: <20210720133826.9075-1-will@kernel.org>
 <20210720133826.9075-5-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720133826.9075-5-will@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 20, 2021 at 02:38:26PM +0100, Will Deacon wrote:
> Although swiotlb_exit() frees the 'slots' metadata array referenced by
> 'io_tlb_default_mem', it leaves the underlying buffer pages allocated
> despite no longer being usable.
> 
> Extend swiotlb_exit() to free the buffer pages as well as the slots
> array.
> 

This patch causes qemu pseries emulations to crash. Backtrace and bisect
log see below. Reverting it fixes the problem.

Guenter

---
Crash log:

...
[    0.937801][    T1] software IO TLB: tearing down default memory pool
[    0.938939][    T1] ------------[ cut here ]------------
[    0.940331][    T1] kernel BUG at arch/powerpc/kernel/interrupt.c:98!
[    0.940787][    T1] Oops: Exception in kernel mode, sig: 5 [#1]
[    0.940883][    T1] BE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
[    0.940999][    T1] Modules linked in:
[    0.941240][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.14.0-rc3-next-20210729 #1
[    0.941523][    T1] NIP:  c000000000031310 LR: c0000000000312f4 CTR: c00000000000c5f0
[    0.941608][    T1] REGS: c000000008687ac0 TRAP: 0700   Not tainted  (5.14.0-rc3-next-20210729)
[    0.941795][    T1] MSR:  8000000000029032 <SF,EE,ME,IR,DR,RI>  CR: 24002222  XER: 00000000
[    0.942031][    T1] CFAR: c000000000300360 IRQMASK: 3
[    0.942031][    T1] GPR00: c0000000000312f4 c000000008687d60 c0000000022ee300 0000000000000003
[    0.942031][    T1] GPR04: 000000000000033f 0000000000000400 0000000000000000 000000003e5a0000
[    0.942031][    T1] GPR08: 000000003e5a0000 0000000000000001 0000000000000000 0000000000000003
[    0.942031][    T1] GPR12: ffffffffffffffff c000000002fb0000 c0000000000129c0 0000000000000000
[    0.942031][    T1] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    0.942031][    T1] GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000021d8b00
[    0.942031][    T1] GPR24: 0000000000000000 0000000000000000 ffffffffffffffff 0000000000000400
[    0.942031][    T1] GPR28: 000000000000033f 000000000000f134 c00000000176c068 c000000008687e80
[    0.942884][    T1] NIP [c000000000031310] .system_call_exception+0x70/0x2d0
[    0.943399][    T1] LR [c0000000000312f4] .system_call_exception+0x54/0x2d0
[    0.943594][    T1] Call Trace:
[    0.943667][    T1] [c000000008687d60] [c0000000000312f4] .system_call_exception+0x54/0x2d0 (unreliable)
[    0.943919][    T1] [c000000008687e10] [c00000000000c6e4] system_call_common+0xf4/0x258
[    0.944066][    T1] --- interrupt: c00 at .ucall_norets+0x4/0x14
[    0.944172][    T1] NIP:  c000000000079ce0 LR: c0000000000fa274 CTR: 0000000000000000
[    0.944245][    T1] REGS: c000000008687e80 TRAP: 0c00   Not tainted  (5.14.0-rc3-next-20210729)
[    0.944323][    T1] MSR:  8000000002009032 <SF,VEC,EE,ME,IR,DR,RI>  CR: 24002222  XER: 00000000
[    0.944463][    T1] IRQMASK: 0
[    0.944463][    T1] GPR00: c00000000176c068 c000000008687a30 c0000000022ee300 000000000000f134
[    0.944463][    T1] GPR04: 000000000000033f 0000000000000400 ffffffffffffffff 0000000000000000
[    0.944463][    T1] GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    0.944463][    T1] GPR12: 0000000000000000 c000000002fb0000 c0000000000129c0 0000000000000000
[    0.944463][    T1] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    0.944463][    T1] GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000021d8b00
[    0.944463][    T1] GPR24: c0000000017c1088 0000000000000004 c00000000171c450 c000000002338e40
[    0.944463][    T1] GPR28: c0000000017c10b0 c0000000033f0000 0000000000000400 c0000000033f0000
[    0.945188][    T1] NIP [c000000000079ce0] .ucall_norets+0x4/0x14
[    0.945285][    T1] LR [c0000000000fa274] .set_memory_encrypted+0x44/0x80
[    0.945375][    T1] --- interrupt: c00
[    0.945419][    T1] [c000000008687a30] [c00000000176c068] .swiotlb_exit+0xbc/0x180 (unreliable)
[    0.945612][    T1] Instruction dump:
[    0.945745][    T1] 7cbb2b78 7cda3378 7cf93b78 7d184378 482cefd1 60000000 e93f0108 692a0002
[    0.945883][    T1] 794affe2 0b0a0000 69294000 792997e2 <0b090000> e93f0138 792907e0 0b090000
[    0.946751][    T1] ---[ end trace 600e218cfc83c24b ]---
[    0.955185][    T1]
[    1.955805][    T1] BUG: sleeping function called from invalid context at ./include/linux/percpu-rwsem.h:49
[    1.955918][    T1] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
[    1.956024][    T1] INFO: lockdep is turned off.
[    1.956094][    T1] irq event stamp: 14792
[    1.956142][    T1] hardirqs last  enabled at (14791): [<c0000000001f8fe8>] .__up_console_sem+0xc8/0x110
[    1.956269][    T1] hardirqs last disabled at (14792): [<c0000000000312f4>] .system_call_exception+0x54/0x2d0
[    1.956384][    T1] softirqs last  enabled at (10586): [<c000000000efd6d4>] .release_sock+0xb4/0x100
[    1.956497][    T1] softirqs last disabled at (10584): [<c000000000efd654>] .release_sock+0x34/0x100
[    1.956726][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G      D           5.14.0-rc3-next-20210729 #1
[    1.956846][    T1] Call Trace:
[    1.956885][    T1] [c000000008687700] [c0000000009fe088] .dump_stack_lvl+0xa4/0x100 (unreliable)
[    1.957011][    T1] [c000000008687790] [c000000000193060] .___might_sleep+0x2b0/0x2f0
[    1.957130][    T1] [c000000008687820] [c00000000015fba0] .exit_signals+0x50/0x540
[    1.957238][    T1] [c0000000086878e0] [c000000000148dbc] .do_exit+0xec/0xe20
[    1.957335][    T1] [c0000000086879c0] [c000000000029bc4] .oops_end+0x144/0x210
[    1.957441][    T1] [c000000008687a50] [c0000000000095d4] program_check_common_virt+0x2d4/0x320
[    1.957561][    T1] --- interrupt: 700 at .system_call_exception+0x70/0x2d0
[    1.957645][    T1] NIP:  c000000000031310 LR: c0000000000312f4 CTR: c00000000000c5f0
[    1.957715][    T1] REGS: c000000008687ac0 TRAP: 0700   Tainted: G      D            (5.14.0-rc3-next-20210729)
[    1.957799][    T1] MSR:  8000000000029032 <SF,EE,ME,IR,DR,RI>  CR: 24002222  XER: 00000000
[    1.957919][    T1] CFAR: c000000000300360 IRQMASK: 3
[    1.957919][    T1] GPR00: c0000000000312f4 c000000008687d60 c0000000022ee300 0000000000000003
[    1.957919][    T1] GPR04: 000000000000033f 0000000000000400 0000000000000000 000000003e5a0000
[    1.957919][    T1] GPR08: 000000003e5a0000 0000000000000001 0000000000000000 0000000000000003
[    1.957919][    T1] GPR12: ffffffffffffffff c000000002fb0000 c0000000000129c0 0000000000000000
[    1.957919][    T1] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    1.957919][    T1] GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000021d8b00
[    1.957919][    T1] GPR24: 0000000000000000 0000000000000000 ffffffffffffffff 0000000000000400
[    1.957919][    T1] GPR28: 000000000000033f 000000000000f134 c00000000176c068 c000000008687e80
[    1.958633][    T1] NIP [c000000000031310] .system_call_exception+0x70/0x2d0
[    1.958720][    T1] LR [c0000000000312f4] .system_call_exception+0x54/0x2d0
[    1.958803][    T1] --- interrupt: 700
[    1.958842][    T1] [c000000008687e10] [c00000000000c6e4] system_call_common+0xf4/0x258
[    1.958961][    T1] --- interrupt: c00 at .ucall_norets+0x4/0x14
[    1.959055][    T1] NIP:  c000000000079ce0 LR: c0000000000fa274 CTR: 0000000000000000
[    1.959127][    T1] REGS: c000000008687e80 TRAP: 0c00   Tainted: G      D            (5.14.0-rc3-next-20210729)
[    1.959210][    T1] MSR:  8000000002009032 <SF,VEC,EE,ME,IR,DR,RI>  CR: 24002222  XER: 00000000
[    1.959337][    T1] IRQMASK: 0
[    1.959337][    T1] GPR00: c00000000176c068 c000000008687a30 c0000000022ee300 000000000000f134
[    1.959337][    T1] GPR04: 000000000000033f 0000000000000400 ffffffffffffffff 0000000000000000
[    1.959337][    T1] GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    1.959337][    T1] GPR12: 0000000000000000 c000000002fb0000 c0000000000129c0 0000000000000000
[    1.959337][    T1] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    1.959337][    T1] GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000021d8b00
[    1.959337][    T1] GPR24: c0000000017c1088 0000000000000004 c00000000171c450 c000000002338e40
[    1.959337][    T1] GPR28: c0000000017c10b0 c0000000033f0000 0000000000000400 c0000000033f0000
[    1.960042][    T1] NIP [c000000000079ce0] .ucall_norets+0x4/0x14
[    1.960137][    T1] LR [c0000000000fa274] .set_memory_encrypted+0x44/0x80
[    1.960219][    T1] --- interrupt: c00
[    1.960257][    T1] [c000000008687a30] [c00000000176c068] .swiotlb_exit+0xbc/0x180 (unreliable)
[    1.960845][    T1] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000005
qemu-system-ppc64: OS terminated: OS panic: Attempted to kill init! exitcode=0x00000005

---
Bisect log:

# bad: [8d4b477da1a807199ca60e0829357ce7aa6758d5] Add linux-next specific files for 20210730
# good: [ff1176468d368232b684f75e82563369208bc371] Linux 5.14-rc3
git bisect start 'HEAD' 'v5.14-rc3'
# bad: [8f3eb1f5c702ef868d89799b03c21d122f2fe197] Merge remote-tracking branch 'bpf-next/for-next'
git bisect bad 8f3eb1f5c702ef868d89799b03c21d122f2fe197
# good: [02afbb8f68dc8b37c07e457d2f69d440781af23a] Merge remote-tracking branch 'cifsd/cifsd-for-next'
git bisect good 02afbb8f68dc8b37c07e457d2f69d440781af23a
# good: [3e12361b6d23f793580a50a6008633501c56ea1d] bcm63xx_enet: delete a redundant assignment
git bisect good 3e12361b6d23f793580a50a6008633501c56ea1d
# good: [78d788681492abe4980d5cc9b93b70df9f028880] Merge remote-tracking branch 'jc_docs/docs-next'
git bisect good 78d788681492abe4980d5cc9b93b70df9f028880
# good: [266234e7659f731cf471a1bdc4fd1ead4caa8303] Merge remote-tracking branch 'v4l-dvb-next/master'
git bisect good 266234e7659f731cf471a1bdc4fd1ead4caa8303
# bad: [be1841fe3ca0010139fe4fb44dd42dea7c0e3401] Merge remote-tracking branch 'swiotlb/linux-next'
git bisect bad be1841fe3ca0010139fe4fb44dd42dea7c0e3401
# good: [7b8798617c7975d10678d99dcc59d103e237b4cd] Merge remote-tracking branch 'ieee1394/for-next'
git bisect good 7b8798617c7975d10678d99dcc59d103e237b4cd
# good: [463e862ac63ef27fca423782536f6465abc3f180] swiotlb: Convert io_default_tlb_mem to static allocation
git bisect good 463e862ac63ef27fca423782536f6465abc3f180
# good: [2dc6b1158c28c3a5e86d162628810312f98d5e97] fs: dlm: introduce generic listen
git bisect good 2dc6b1158c28c3a5e86d162628810312f98d5e97
# good: [62699b3f0a62435fceb8debf295e90a5ea259e04] fs: dlm: move receive loop into receive handler
git bisect good 62699b3f0a62435fceb8debf295e90a5ea259e04
# bad: [ad6c00283163cb7ad52cdf97d2850547446f7d98] swiotlb: Free tbl memory in swiotlb_exit()
git bisect bad ad6c00283163cb7ad52cdf97d2850547446f7d98
# good: [1efd3fc0ccf52e1aa5f0bf5b0d82847180d20951] swiotlb: Emit diagnostic in swiotlb_exit()
git bisect good 1efd3fc0ccf52e1aa5f0bf5b0d82847180d20951
# first bad commit: [ad6c00283163cb7ad52cdf97d2850547446f7d98] swiotlb: Free tbl memory in swiotlb_exit()
