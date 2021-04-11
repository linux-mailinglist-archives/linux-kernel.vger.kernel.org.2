Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7D035B6E3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 22:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbhDKUoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 16:44:13 -0400
Received: from mail.ispras.ru ([83.149.199.84]:49486 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233822AbhDKUoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 16:44:11 -0400
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
        by mail.ispras.ru (Postfix) with ESMTPS id 1A99340D3BFF;
        Sun, 11 Apr 2021 20:43:53 +0000 (UTC)
Date:   Sun, 11 Apr 2021 23:43:53 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     John Ogness <john.ogness@linutronix.de>
cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Joerg Roedel <jroedel@suse.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] iommu/amd: Fix extended features logging
In-Reply-To: <87o8ekioo4.fsf@jogness.linutronix.de>
Message-ID: <alpine.LNX.2.20.13.2104112326460.11104@monopod.intra.ispras.ru>
References: <20210410211152.1938-1-amonakov@ispras.ru> <e884200f-55a4-59b5-4311-964e6ddc94d1@molgen.mpg.de> <alpine.LNX.2.20.13.2104111410340.11104@monopod.intra.ispras.ru> <87o8ekioo4.fsf@jogness.linutronix.de>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Apr 2021, John Ogness wrote:

> > pr_info("") will also prepend 'AMD-Vi:' to the feature list, which is
> > nice.
> 
> I'd rather fix dev_info callers to allow pr_cont and then fix any code
> that is using this workaround.

Note that existing two users of pr_info("") that I found are not using that
as a workaround: efi.c is using that when it announced a list of EFI tables:

efi: ACPI=0xadffe000 ACPI 2.0=0xadffe014 TPMFinalLog=0xadf2d000 ESRT=0xab70d618 SMBIOS=0xab70b000 SMBIOS 3.0=0xab709000 RNG=0xab707b98 TPMEventLog=0x9602c018

and uvesafb.c similarly uses it to print a list of conditionally-present
strings. In both cases it is really a standalone message, not a continuation
for something previously printed.

In contrast, my patch deals with a continuation line. I wouldn't really like
the decoded feature list to appear on the same line as the previous message,
because it would end up quite long:

[    0.266332] pci 0000:00:00.2: AMD-Vi: Extended features (0x206d73ef22254ade):
[    0.266334] AMD-Vi:  PPR X2APIC NX GT IA GA PC GA_vAPIC

I think a good compromise is to change the first line from pci_info to pr_info,
losing the pci bus address. I'll send a v2.

Alexander
