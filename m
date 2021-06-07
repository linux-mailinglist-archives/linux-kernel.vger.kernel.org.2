Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB3239E649
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 20:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhFGSQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 14:16:00 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58367 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230212AbhFGSP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 14:15:58 -0400
X-UUID: b43cadc9048245d9aaacea593f25c901-20210608
X-UUID: b43cadc9048245d9aaacea593f25c901-20210608
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1890285528; Tue, 08 Jun 2021 02:14:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Jun 2021 02:14:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Jun 2021 02:14:03 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <rostedt@goodmis.org>
CC:     <catalin.marinas@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <mark-pk.tsai@mediatek.com>,
        <matthias.bgg@gmail.com>, <mingo@redhat.com>, <will@kernel.org>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH] arm64: ftrace: don't dereference a probably invalid address
Date:   Tue, 8 Jun 2021 02:14:03 +0800
Message-ID: <20210607181403.4017-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210607105217.772214e5@oasis.local.home>
References: <20210607105217.772214e5@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 7 Jun 2021 22:15:22 +0800
> Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
> 
> > And the crash is becuase kernel trying to read *rec->ip in print_ip_ins() if
> > ftrace_bug() get error code -EINVAL.
> 
> Right, so the actual fix should be something like this:
> 
> [ not tested, nor even compiled ]
> 
> -- Steve
> 

I just test this patch, and turns out it work well.
All my modification is only rename copy_from_kernel_nofault
into probe_kernel_read because the older kernel version
I use.
Then the kernel will show the error mesage instead of panic as following.

[    0.000000] ftrace failed to modify
[    0.000000] [<0000000000000020>] 0x20
[    0.000000] actual:   [FAULT](0000000000000020)

Should I resend this patch as v2?
Or you will upstream this fix?

> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 2e8a3fde7104..72ef4dccbcc4 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1967,12 +1967,18 @@ static int ftrace_hash_ipmodify_update(struct ftrace_ops *ops,
>  
>  static void print_ip_ins(const char *fmt, const unsigned char *p)
>  {
> +	char ins[MCOUNT_INSN_SIZE];
>  	int i;
>  
> +	if (copy_from_kernel_nofault(ins, p, MCOUNT_INSN_SIZE)) {
> +		printk(KERN_CONT "%s[FAULT](%px)", fmt, p);
> +		return;
> +	}
> +
>  	printk(KERN_CONT "%s", fmt);
>  
>  	for (i = 0; i < MCOUNT_INSN_SIZE; i++)
> -		printk(KERN_CONT "%s%02x", i ? ":" : "", p[i]);
> +		printk(KERN_CONT "%s%02x", i ? ":" : "", ins[i]);
>  }
>  
>  enum ftrace_bug_type ftrace_bug_type;
