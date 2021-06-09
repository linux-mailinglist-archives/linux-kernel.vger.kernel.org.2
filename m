Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55253A1747
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbhFIOcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:32:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236007AbhFIOb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:31:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5EDC61364;
        Wed,  9 Jun 2021 14:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623249003;
        bh=D31J9ARRh9ELvjX6pTEQbRNy1KIC+gmUtHCUZpQK0L4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CRydjYwiIPrKLvOX29Gc54/BO66vTFutfDGmAXbX5CRU17WwQ3mh5c058fnTOER0I
         orTMXUh1siwzdHwiP97n35NtVbPEbHbNWO4RtnkvtE4ACgAvRMgpjt8X06fTtv2bDw
         SHLRYS3E5BycmrCYaPMtxbF2O9WSjHIMGCEfNh3oAYjB+SiI9kp4dioJVGWnxh+j1z
         1KlfD3Mm8CoVDiLPgnSX9V1v1YdgQmLZTilID96JIdzGouxjoi4bAunfVJvYKTDMc9
         dS27HrR15U20Xgtj7FhqpPA2pZFhsVe88Mdr+Y9lr/iKyyzjqhbpxGBHe7gYxb3viO
         LEY3gtTLECeXw==
Date:   Wed, 9 Jun 2021 23:29:59 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [RFC PATCH 4/5] csky: ftrace: Drop duplicate implementation of
 arch_check_ftrace_location()
Message-Id: <20210609232959.3b94659c00ad66a602653bde@kernel.org>
In-Reply-To: <CAJF2gTS_tmOYFNaLYQmJvbwZwksMctPPbE6GAGgUYTwvLLwE=w@mail.gmail.com>
References: <20210609105019.3626677-1-punitagrawal@gmail.com>
        <20210609105019.3626677-5-punitagrawal@gmail.com>
        <CAJF2gTS_tmOYFNaLYQmJvbwZwksMctPPbE6GAGgUYTwvLLwE=w@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo,

On Wed, 9 Jun 2021 20:33:18 +0800
Guo Ren <guoren@kernel.org> wrote:

> csky using -mcount not -fpatchable-function-entry, so
>                 /* Given address is not on the instruction boundary */
>                 if ((unsigned long)p->addr != ftrace_addr)
>                         return -EILSEQ;
> all right?

Even if -mcount is used, that check is still needed since the
ftrace hooked address will be the ftrace_addr. If user tries to
probe the second instruction in mcount code, kprobes needs to stop it.

Thank you,

> 
> On Wed, Jun 9, 2021 at 6:51 PM Punit Agrawal <punitagrawal@gmail.com> wrote:
> >
> > The csky specific arch_check_ftrace_location() shadows a weak
> > implementation of the function in core code that offers the same
> > functionality but with additional error checking.
> >
> > Drop the architecture specific function as a step towards further
> > cleanup in core code.
> >
> > Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> > Cc: Guo Ren <guoren@linux.alibaba.com>
> > ---
> >  arch/csky/kernel/probes/ftrace.c | 7 -------
> >  1 file changed, 7 deletions(-)
> >
> > diff --git a/arch/csky/kernel/probes/ftrace.c b/arch/csky/kernel/probes/ftrace.c
> > index ef2bb9bd9605..b388228abbf2 100644
> > --- a/arch/csky/kernel/probes/ftrace.c
> > +++ b/arch/csky/kernel/probes/ftrace.c
> > @@ -2,13 +2,6 @@
> >
> >  #include <linux/kprobes.h>
> >
> > -int arch_check_ftrace_location(struct kprobe *p)
> > -{
> > -       if (ftrace_location((unsigned long)p->addr))
> > -               p->flags |= KPROBE_FLAG_FTRACE;
> > -       return 0;
> > -}
> > -
> >  /* Ftrace callback handler for kprobes -- called under preepmt disabled */
> >  void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> >                            struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > --
> > 2.30.2
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 
> ML: https://lore.kernel.org/linux-csky/


-- 
Masami Hiramatsu <mhiramat@kernel.org>
