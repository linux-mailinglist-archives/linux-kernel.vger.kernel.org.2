Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BC839DE72
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 16:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhFGORU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 10:17:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60228 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230231AbhFGORT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:17:19 -0400
X-UUID: 113a9878a26848eab2c72452ee82e5d0-20210607
X-UUID: 113a9878a26848eab2c72452ee82e5d0-20210607
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 729966752; Mon, 07 Jun 2021 22:15:24 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 7 Jun 2021 22:15:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Jun 2021 22:15:22 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <rostedt@goodmis.org>
CC:     <catalin.marinas@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <mark-pk.tsai@mediatek.com>,
        <matthias.bgg@gmail.com>, <mingo@redhat.com>, <will@kernel.org>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH] arm64: ftrace: don't dereference a probably invalid address
Date:   Mon, 7 Jun 2021 22:15:22 +0800
Message-ID: <20210607141522.3281-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210607095518.12694437@oasis.local.home>
References: <20210607095518.12694437@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 7 Jun 2021 11:23:30 +0800
> Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
> 
> > Address in __mcount_loc may be invalid if somthing goes wrong.
> > On our arm64 platform, the bug in recordmcount make kernel
> > crash in ftrace_init().
> 
> How did it crash? The link below doesn't show any crash.

Below is the crash log:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/trace/ftrace.c:2008 ftrace_bug+0x9c/0x38c
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Tainted: G        W         5.4.61-350609-gf78fedda5a5e #1
Hardware name: MediaTek MT5896 (DT)
pstate: 60400089 (nZCv daIf +PAN -UAO)
pc : ftrace_bug+0x9c/0x38c
lr : ftrace_process_locs+0x314/0x3b8
sp : ffffffc011743ef0
x29: ffffffc011743f00 x28: 0000000000000001
x27: ffffff818e401b80 x26: 0000000000000000
x25: ffffff818e480008 x24: ffffffc011749000
x23: 0000000000000008 x22: 0000000000000000
x21: ffffffc010084ac0 x20: 0000000000000024
x19: ffffff818e480000 x18: ffffffc011759c20
x17: ffffffc01133dcf8 x16: 0000000000000068
x15: ffffffc01133dcf8 x14: 0000000000000000
x13: 0000000000000000 x12: ffffffc010084ae4
x11: ffffffc011749000 x10: ffffffc011749000
x9 : 0000000000000001 x8 : ffffffc011749000
x7 : 0000000000000000 x6 : 000000000000003f
x5 : 000000000008e93d x4 : 0000000000000000
x3 : 0000000000000101 x2 : ffffffc010084ac0
x1 : ffffff818e480000 x0 : ffffffc01127621c
Call trace:
 ftrace_bug+0x9c/0x38c
 ftrace_process_locs+0x314/0x3b8
 ftrace_init+0x8c/0xbc
 start_kernel+0x180/0x40c
---[ end trace 59db467eb74a6604 ]---
ftrace failed to modify
[<0000000000000024>] 0x24
 actual:
"Unable to handle kernel read from unreadable memory at virtual address 0000000000000024
"Mem abort info:

And the crash is becuase kernel trying to read *rec->ip in print_ip_ins() if
ftrace_bug() get error code -EINVAL.

> 
> > 
> > https://lore.kernel.org/lkml/20210607023839.26387-1-mark-pk.tsai@mediatek.com/
> > 
> > Return -EFAULT if we are dealing with out-of-range condition
> > to prevent dereference the invalid address in ftrace_bug(),
> > then the kernel can disable ftrace safely for problematic
> > __mcount_loc.
> 
> !mod is not an out-of-range condition. It just happened that the other
> bug caused this strange side-effect. A !mod does not mean a fault
> happened. Just because it may have been caused by a fault in your use
> case does not mean that it's a fault in all use cases. That's like
> saying that your dog is a poodle, so all dogs are poodles.
> 
> A return of -EINVAL should not cause a crash. If it does, then that
> needs to be fixed.

I understand.
Keep -EINVAL here make more sense.
So maybe we should handle this case in ftrace_bug() by checking the rec->ip?

> 
> -- Steve
> 
> 
> > 
> > Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> > ---
> >  arch/arm64/kernel/ftrace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> > index b5d3ddaf69d9..98bec8445a58 100644
> > --- a/arch/arm64/kernel/ftrace.c
> > +++ b/arch/arm64/kernel/ftrace.c
> > @@ -201,7 +201,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
> >  			preempt_enable();
> >  
> >  			if (WARN_ON(!mod))
> > -				return -EINVAL;
> > +				return -EFAULT;
> >  		}
> >  
> >  		/*
