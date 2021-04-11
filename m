Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0CE35B386
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 13:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbhDKLWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 07:22:33 -0400
Received: from mail.ispras.ru ([83.149.199.84]:41428 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233696AbhDKLWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 07:22:32 -0400
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
        by mail.ispras.ru (Postfix) with ESMTPS id 2C31940D3BFF;
        Sun, 11 Apr 2021 11:22:14 +0000 (UTC)
Date:   Sun, 11 Apr 2021 14:22:14 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
cc:     Joerg Roedel <jroedel@suse.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: Fix extended features logging
In-Reply-To: <e884200f-55a4-59b5-4311-964e6ddc94d1@molgen.mpg.de>
Message-ID: <alpine.LNX.2.20.13.2104111410340.11104@monopod.intra.ispras.ru>
References: <20210410211152.1938-1-amonakov@ispras.ru> <e884200f-55a4-59b5-4311-964e6ddc94d1@molgen.mpg.de>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Apr 2021, Paul Menzel wrote:

> > The second line is emitted via 'pr_cont', which causes it to have a
> > different ('warn') loglevel compared to the previous line ('info').
> > 
> > Commit 9a295ff0ffc9 attempted to rectify this by removing the newline
> > from the pci_info format string, but this doesn't work, as pci_info
> > calls implicitly append a newline anyway.
> 
> Hmm, did I really screw that up during my testing? I am sorry about that.
> 
> I tried to wrap my head around, where the newline is implicitly appended, and
> only found the definitions below.
> 
>     include/linux/pci.h:#define pci_info(pdev, fmt, arg...)
> dev_info(&(pdev)->dev, fmt, ##arg)
> 
>     include/linux/dev_printk.h:#define dev_info(dev, fmt, ...)
> \
>     include/linux/dev_printk.h:     _dev_info(dev, dev_fmt(fmt),
> ##__VA_ARGS__)
> 
>     include/linux/dev_printk.h:__printf(2, 3) __cold
>     include/linux/dev_printk.h:void _dev_info(const struct device *dev, const
> char *fmt, ...);
> 
>     include/linux/compiler_attributes.h:#define __printf(a, b)
> __attribute__((__format__(printf, a, b)))

Yeah, it's not obvious: it happens in kernel/printk/printk.c:vprintk_store
where it does

	if (dev_info)
		lflags |= LOG_NEWLINE;

It doesn't seem to be documented; I think it prevents using pr_cont with
"rich" printk facilities that go via _dev_info.

I suspect it quietly changed in commit c313af145b9bc ("printk() - isolate
KERN_CONT users from ordinary complete lines").

> In the discussion *smpboot: CPU numbers printed as warning* [1] John wrote:
> 
> > It is supported to provide loglevels for CONT messages. The loglevel is
> > then only used if the append fails:
> > 
> >     pr_cont(KERN_INFO "message part");
> > 
> > I don't know if we want to go down that path. But it is supported.

Yeah, I saw that, but decided to go with the 'pr_info("")' solution, because
it is less magic, and already used in two other drivers.

pr_info("") will also prepend 'AMD-Vi:' to the feature list, which is nice.

Best regards,
Alexander
