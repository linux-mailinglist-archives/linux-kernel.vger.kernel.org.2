Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6591232D42F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 14:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241336AbhCDN3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 08:29:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241322AbhCDN3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 08:29:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 168ED64F09;
        Thu,  4 Mar 2021 13:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614864519;
        bh=PlxQOKZoaaVMaVivmUaFdQ1jJjo4ppMmxLiHNzuyqu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ghGFDTbUt5CZzt6wrynBaP2psr88fm7pz6jNYLhlPl6i88exw/WZZAUPflRR6fDxM
         jdcpo20Bwp26NoJjB1DITpcwIPMCzXh1eYFWfsYhiSOn/t/PAk6K6/Kv5XdtMwVlJB
         1lzatQDCW9/DjNbDcuGRhOioGMp+orSUMCK75cC4=
Date:   Thu, 4 Mar 2021 14:28:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     ShaoBo Huang <huangshaobo6@huawei.com>, linux@armlinux.org.uk,
        tixy@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, young.liuyang@huawei.com,
        zengweilin@huawei.com, nixiaoming@huawei.com,
        chenzefeng2@huawei.com, liucheng32@huawei.com,
        kepler.chenxin@huawei.com, xiaoqian9@huawei.com
Subject: Re: [PATCH 4.9.y] arm: kprobes: Allow to handle reentered kprobe on
 single-stepping
Message-ID: <YEDghZHAgdotrax3@kroah.com>
References: <20210303071052.33740-1-huangshaobo6@huawei.com>
 <20210303211827.eeb89c8a9b140152fbcd997c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303211827.eeb89c8a9b140152fbcd997c@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 09:18:27PM +0900, Masami Hiramatsu wrote:
> Hi ShaoBo,
> 
> Thanks for backporting and real bug report!
> 
> On Wed, 3 Mar 2021 15:10:52 +0800
> ShaoBo Huang <huangshaobo6@huawei.com> wrote:
> 
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > commit f3fbd7ec62dec1528fb8044034e2885f2b257941 upstream
> > 
> > This is arm port of commit 6a5022a56ac3 ("kprobes/x86: Allow to
> > handle reentered kprobe on single-stepping")
> > 
> > Since the FIQ handlers can interrupt in the single stepping
> > (or preparing the single stepping, do_debug etc.), we should
> > consider a kprobe is hit in the NMI handler. Even in that
> > case, the kprobe is allowed to be reentered as same as the
> > kprobes hit in kprobe handlers
> > (KPROBE_HIT_ACTIVE or KPROBE_HIT_SSDONE).
> > 
> > The real issue will happen when a kprobe hit while another
> > reentered kprobe is processing (KPROBE_REENTER), because
> > we already consumed a saved-area for the previous kprobe.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> > Fixes: 24ba613c9d6c ("ARM kprobes: core code")
> > Cc: stable@vger.kernel.org #v2.6.25~v4.11
> > Signed-off-by: huangshaobo <huangshaobo6@huawei.com>
> > ---
> >  arch/arm/probes/kprobes/core.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
> > index 3eb018fa1a1f..c3362ddd6c4c 100644
> > --- a/arch/arm/probes/kprobes/core.c
> > +++ b/arch/arm/probes/kprobes/core.c
> > @@ -270,6 +270,7 @@ void __kprobes kprobe_handler(struct pt_regs *regs)
> >  			switch (kcb->kprobe_status) {
> >  			case KPROBE_HIT_ACTIVE:
> >  			case KPROBE_HIT_SSDONE:
> > +			case KPROBE_HIT_SS:
> >  				/* A pre- or post-handler probe got us here. */
> >  				kprobes_inc_nmissed_count(p);
> >  				save_previous_kprobe(kcb);
> > @@ -278,6 +279,11 @@ void __kprobes kprobe_handler(struct pt_regs *regs)
> >  				singlestep(p, regs, kcb);
> >  				restore_previous_kprobe(kcb);
> >  				break;
> > +			case KPROBE_REENTER:
> > +				/* A nested probe was hit in FIQ, it is a BUG */
> > +				pr_warn("Unrecoverable kprobe detected at %p.\n",
> > +					p->addr);
> > +				/* fall through */
> >  			default:
> >  				/* impossible cases */
> >  				BUG();
> > -- 
> > 2.12.3
> > 

Also queued up to 4.4.y as well.

thanks,

greg k-h
