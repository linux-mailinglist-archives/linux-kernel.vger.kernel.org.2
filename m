Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2515382C01
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 14:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbhEQMXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 08:23:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:53820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235036AbhEQMXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 08:23:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1B6C8B1C2;
        Mon, 17 May 2021 12:22:28 +0000 (UTC)
Subject: Re: [PATCH 0/9] arm64: dts: rockchip: Initial Toybrick TB-RK1808M0
 support
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
References: <20210516230551.12469-1-afaerber@suse.de>
 <87im3hvikv.wl-maz@kernel.org>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <e633c5ac-7cd6-c733-a295-6dca8ba9c605@suse.de>
Date:   Mon, 17 May 2021 14:22:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <87im3hvikv.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 17.05.21 11:02, Marc Zyngier wrote:
> On Mon, 17 May 2021 00:05:42 +0100,
> Andreas Färber <afaerber@suse.de> wrote:
>> Patches are based on the shipping toybrick.dtb file.

>> http://t.rock-chips.com/en/wiki.php?mod=view&id=110 gives instructions for

>> compiling sources, but no source download or link is actually provided.

>> 

>> I encountered a hang: earlycon revealed it being related to KVM and
>> vGIC.  Disabling KVM in Kconfig works around it, as does removing
>> the vGIC irq in DT.  I've already tried low and high for the vGIC
>> interrupt, so no clue what might cause it. On an mPCIe card with 1
>> GiB of RAM I figured KVM is not going to be a major use case, so if
>> we find no other solution, we could just delete the interrupts
>> property in its .dts, as demonstrated here.
> 
> I think you figured it out wrong,

Did I? I identified that an issue resulting in no serial console was
dependent on CONFIG_KVM being enabled and specifically to the vGIC
interrupt being specified in my DT. That's all I said.

I never claimed KVM code was to blame, you should know me better by now!

> for a number of reasons:
> 
> - KVM hanging is usually a sign that you have described the platform
>   the wrong way. Either you are stepping over reserved memory regions,
>   or you have badly described the GIC itself.

This whole series is about a new DT hardware description, so yes, that
is the most likely source of the problem I'm observing. Without further
hints how to verify what may cause it, you're just stating the obvious.

The only /reserved-memory entries in the shipping DTB are drm-logo of
size 0 and ramoops - the latter I could try to test, but I'd assume that
to just be a software convention that for lack of oops should not affect
KVM here?

And why would reserved memory affect the vGIC but no other driver doing
allocations? Any way to narrow it down, does vGIC allocate specially?

Only other issue I'm seeing is Debian failing to mount partitions that I
checked I do have drivers built in for and ends up failing to provide an
emergency shell. In order to boot a clean openSUSE rootfs for comparison
I'd first need to figure out adding any USB host nodes and clocks.

> 
> - It could also be a bug in KVM, which will need to be fixed. If
>   that's because the HW is broken, we need to be able to detect it.
> 
> - You cannot be prescriptive of what a user is going to run. People
>   have been running KVM on systems with less memory than that.
> 
> So no, we don't paper over these issues.

As you can see in patch 3, it does include the vGIC interrupt, so that
anyone with access to the TB-96AIoT or any EVB can test KVM and report
success or failure. Thus I don't see me as papering over something here.

However, patch 5 is needed to test this patchset on at least M0 - to
have serial and eMMC rootfs working - until a better fix is found.

> We work out what is going
> wrong and we fix it.

Thanks. You were specifically copied to advise on
how to figure out what might cause it, so that we/I can fix it properly. :)

As I mentioned, I already tried changing the interrupt between high and
low (which was a likely bug source on Realtek RK1319 (where I'm still
waiting on them to confirm a ~year later...)).
I don't have a data source other than the downstream .dtb to check the
interrupt number - mainline PX30/RK3308/RK3328/RK3368/RK3399 do all use
9 and high consistently though, so I figured it's likely correct.

What I was wondering is whether the vGIC, similar to arch timer, might
need some initialization in the bootloader? (Note: No U-Boot sources
either at the link.)
Unfortunately I'm seeing a recurring pattern (cf. Realtek) that vendors
in their BSPs don't enable KVM and thus don't validate their hardware
description against KVM; their shipping 4.4 based kernel here does not
seem to have KVM enabled.

Or is it possible for vendors to actually have a Cortex-A35 without the
Armv8 Virtualization Extensions in silicon? If so, how could one verify?

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
