Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73DA382718
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbhEQIde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:33:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:48064 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230011AbhEQIda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:33:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 51ACBAF0E;
        Mon, 17 May 2021 08:32:13 +0000 (UTC)
Date:   Mon, 17 May 2021 10:32:13 +0200
From:   Borislav Petkov <bp@suse.de>
To:     James Feeney <james@nurealm.net>
Cc:     linux-smp@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: linux 5.12 - fails to boot - soft lockup - CPU#0 stuck for 23s!
 - RIP smp_call_function_single
Message-ID: <YKIqDdFNaXYd39wz@zn.tnic>
References: <8a9599b2-f4fe-af9b-90f5-af39c315ec2f@nurealm.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a9599b2-f4fe-af9b-90f5-af39c315ec2f@nurealm.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ lkml.

On Mon, May 17, 2021 at 02:13:45AM -0600, James Feeney wrote:
> I re-ran my git bisect, this time with a full power-down and cold boot, and more thorough testing, running a web browser.  My second bisect went from good to bad.
> 
> So now, instead, git bisect ended here:
> 
> 4f432e8bb15b352da72525144da025a46695968f is the first bad commit
> commit 4f432e8bb15b352da72525144da025a46695968f
> Author: Borislav Petkov <bp@suse.de>
> Date:   Thu Jan 7 13:23:34 2021 +0100
> 
>     x86/mce: Get rid of mcheck_intel_therm_init()
> 
>     Move the APIC_LVTTHMR read which needs to happen on the BSP, to
>     intel_init_thermal(). One less boot dependency.
> 
>     No functional changes.
> 
>     Signed-off-by: Borislav Petkov <bp@suse.de>
>     Tested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>     Link: https://lkml.kernel.org/r/20210201142704.12495-2-bp@alien8.de
> 
>  arch/x86/include/asm/mce.h            |  6 ------
>  arch/x86/kernel/cpu/mce/core.c        |  1 -
>  arch/x86/kernel/cpu/mce/therm_throt.c | 15 ++++-----------
>  3 files changed, 4 insertions(+), 18 deletions(-)
> 
> 
> Please let me know if that makes more sense.

Not really - this is the first time I'm seeing this and I highly doubt
your bisection is correct. But we'll see.

> 
> Again:
> 
> Arch Linux
> linux 5.12.arch1-1

Can you reproduce with the upstream 5.12 kernel to rule out influence by
any distro-specific patches?

> Intel Core2 T7200
> Mobile Intel 945PM Express Chipset
> ICH7-M
> Mobility Radeon X1600

Can you send full dmesg from a working kernel and the .config you're
using with 5.12?

> Generally, on failure, the system will not boot past "Loading initial ramdisk...", or, when it does, the boot process will hang, and the console will eventually show:
> 
> watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [systemd-udevd: 241]
> ...
> RIP: 0010:smp_call_function_single+0xf7/0x140
> 
> The top of the call trace variously shows either "__flush_tlb_all" or "tlbflush_read_file", with the "soft lockup" repeating indefinitely.
> 

I'm presuming there's no way to connect your box over serial cable to
another one so that you can catch the full bad dmesg when it hangs? It
would be good if you could...

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
