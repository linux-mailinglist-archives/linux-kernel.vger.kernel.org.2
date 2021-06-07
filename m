Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA6A39DEEE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 16:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhFGOix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 10:38:53 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39616 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230331AbhFGOiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:38:50 -0400
X-UUID: 2ec045152949476aac7fcedb83dce133-20210607
X-UUID: 2ec045152949476aac7fcedb83dce133-20210607
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1650789154; Mon, 07 Jun 2021 22:36:54 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 7 Jun 2021 22:36:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Jun 2021 22:36:53 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <mark-pk.tsai@mediatek.com>
CC:     <catalin.marinas@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mingo@redhat.com>, <rostedt@goodmis.org>, <will@kernel.org>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH] arm64: ftrace: don't dereference a probably invalid address
Date:   Mon, 7 Jun 2021 22:36:53 +0800
Message-ID: <20210607143653.3385-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210607141522.3281-1-mark-pk.tsai@mediatek.com>
References: <20210607141522.3281-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Mon, 7 Jun 2021 11:23:30 +0800
> > Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
> > 
> > > Address in __mcount_loc may be invalid if somthing goes wrong.
> > > On our arm64 platform, the bug in recordmcount make kernel
> > > crash in ftrace_init().
> > 
> > How did it crash? The link below doesn't show any crash.
> 
> Below is the crash log:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at kernel/trace/ftrace.c:2008 ftrace_bug+0x9c/0x38c
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Tainted: G        W         5.4.61-350609-gf78fedda5a5e #1
> Hardware name: MediaTek MT5896 (DT)
> pstate: 60400089 (nZCv daIf +PAN -UAO)
> pc : ftrace_bug+0x9c/0x38c
> lr : ftrace_process_locs+0x314/0x3b8
> sp : ffffffc011743ef0
> x29: ffffffc011743f00 x28: 0000000000000001
> x27: ffffff818e401b80 x26: 0000000000000000
> x25: ffffff818e480008 x24: ffffffc011749000
> x23: 0000000000000008 x22: 0000000000000000
> x21: ffffffc010084ac0 x20: 0000000000000024
> x19: ffffff818e480000 x18: ffffffc011759c20
> x17: ffffffc01133dcf8 x16: 0000000000000068
> x15: ffffffc01133dcf8 x14: 0000000000000000
> x13: 0000000000000000 x12: ffffffc010084ae4
> x11: ffffffc011749000 x10: ffffffc011749000
> x9 : 0000000000000001 x8 : ffffffc011749000
> x7 : 0000000000000000 x6 : 000000000000003f
> x5 : 000000000008e93d x4 : 0000000000000000
> x3 : 0000000000000101 x2 : ffffffc010084ac0
> x1 : ffffff818e480000 x0 : ffffffc01127621c
> Call trace:
>  ftrace_bug+0x9c/0x38c
>  ftrace_process_locs+0x314/0x3b8
>  ftrace_init+0x8c/0xbc
>  start_kernel+0x180/0x40c
> ---[ end trace 59db467eb74a6604 ]---
> ftrace failed to modify
> [<0000000000000024>] 0x24
>  actual:
> "Unable to handle kernel read from unreadable memory at virtual address 0000000000000024
> "Mem abort info:

I'm sorry that the last reply I only post the warning log before crash.
Below is the panic log right after this warning.

"Unable to handle kernel read from unreadable memory at virtual address 0000000000000024
"Mem abort info:
"  ESR = 0x96000005
"  EC = 0x25: DABT (current EL), IL = 32 bits
"  SET = 0, FnV = 0
"  EA = 0, S1PTW = 0
"Data abort info:
"  ISV = 0, ISS = 0x00000005
"  CM = 0, WnR = 0
"[0000000000000024] user address but active_mm is swapper
Internal error: Oops: 96000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Tainted: G        W         5.4.61-350609-gf78fedda5a5e #1
pstate: 60400089 (nZCv daIf +PAN -UAO)
pc : ftrace_bug+0xd8/0x38c
lr : ftrace_bug+0xd8/0x38c
sp : ffffffc011743ef0
x29: ffffffc011743f00 x28: 0000000000000001
x27: ffffff818e401b80 x26: 0000000000000000
x25: ffffff818e480008 x24: ffffffc011749000
x23: 0000000000000008 x22: 0000000000000000
x21: ffffffc010084ac0 x20: 0000000000000024
x19: ffffff818e480000 x18: ffffffc011759c20
x17: 0000000000000031 x16: ffffffc010d40c38
x15: ffffffc0114ad9ef x14: 000000000000004e
x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 00000000ffffffff
x9 : 0000000000000000 x8 : 0000000000000000
x7 : 000000000000000b x6 : ffffffc01188720b
x5 : 000000000000000b x4 : ffffffc0118848ce
x3 : 0000000000000020 x2 : 000000000000000b
x1 : ffffffc0118848d9 x0 : 000000000000000b
Call trace:
 ftrace_bug+0xd8/0x38c
 ftrace_process_locs+0x314/0x3b8
 ftrace_init+0x8c/0xbc
 start_kernel+0x180/0x40c
Code: f00085a1 9120d000 913e4421 97fdef85 (39400282)
---[ end trace 59db467eb74a6605 ]---
Kernel panic - not syncing: Attempted to kill the idle task!

> 
> And the crash is becuase kernel trying to read *rec->ip in print_ip_ins() if
> ftrace_bug() get error code -EINVAL.
> 
> > 
> > > 
> > > https://lore.kernel.org/lkml/20210607023839.26387-1-mark-pk.tsai@mediatek.com/
> > > 
> > > Return -EFAULT if we are dealing with out-of-range condition
> > > to prevent dereference the invalid address in ftrace_bug(),
> > > then the kernel can disable ftrace safely for problematic
> > > __mcount_loc.
> > 
> > !mod is not an out-of-range condition. It just happened that the other
> > bug caused this strange side-effect. A !mod does not mean a fault
> > happened. Just because it may have been caused by a fault in your use
> > case does not mean that it's a fault in all use cases. That's like
> > saying that your dog is a poodle, so all dogs are poodles.
> > 
> > A return of -EINVAL should not cause a crash. If it does, then that
> > needs to be fixed.
> 
> I understand.
> Keep -EINVAL here make more sense.
> So maybe we should handle this case in ftrace_bug() by checking the rec->ip?
> 
> > 
> > -- Steve
> > 
> > 
> > > 
> > > Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> > > ---
> > >  arch/arm64/kernel/ftrace.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> > > index b5d3ddaf69d9..98bec8445a58 100644
> > > --- a/arch/arm64/kernel/ftrace.c
> > > +++ b/arch/arm64/kernel/ftrace.c
> > > @@ -201,7 +201,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
> > >  			preempt_enable();
> > >  
> > >  			if (WARN_ON(!mod))
> > > -				return -EINVAL;
> > > +				return -EFAULT;
> > >  		}
> > >  
> > >  		/*
> 
