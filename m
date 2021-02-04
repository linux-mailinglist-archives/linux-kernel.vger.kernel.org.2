Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF0E30F05C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 11:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbhBDKR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbhBDKR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:17:56 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF87CC0613D6;
        Thu,  4 Feb 2021 02:17:00 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DWZGd01GPz1s9Md;
        Thu,  4 Feb 2021 11:16:56 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DWZGc5Htjz1t6pT;
        Thu,  4 Feb 2021 11:16:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id TdOZO1FNesDN; Thu,  4 Feb 2021 11:16:54 +0100 (CET)
X-Auth-Info: R3kUBoT+0FzKZyrjHuZtR30ewrjf9cb/uph0bi8KbkJmEE+Nd464fPDFS1OnqdTo
Received: from igel.home (ppp-46-244-168-92.dynamic.mnet-online.de [46.244.168.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu,  4 Feb 2021 11:16:54 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 23E1A2C3746; Thu,  4 Feb 2021 11:16:54 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     sagar.kadam@sifive.com, devicetree@vger.kernel.org,
        aou@eecs.berkeley.edu, kernel@esmil.dk, anup@brainfault.org,
        linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        yash.shah@sifive.com, robh+dt@kernel.org,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/3] fix macb phy probe failure if phy-reset is not
 handled
References: <1605021732-268521-1-git-send-email-sagar.kadam@sifive.com>
        <mhng-40b3307c-6849-46f4-83c3-ffa1ab92baef@palmerdabbelt-glaptop>
X-Yow:  ..I just walked into th' HOUSE OF REPRESENTATIVES with fourteen WET
 DOLPHINS and an out-of-date MARRIAGE MANUAL...
Date:   Thu, 04 Feb 2021 11:16:54 +0100
In-Reply-To: <mhng-40b3307c-6849-46f4-83c3-ffa1ab92baef@palmerdabbelt-glaptop>
        (Palmer Dabbelt's message of "Wed, 13 Jan 2021 21:01:00 -0800 (PST)")
Message-ID: <87a6skw31l.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 13 2021, Palmer Dabbelt wrote:

> On Tue, 10 Nov 2020 07:22:09 PST (-0800), sagar.kadam@sifive.com wrote:
>> HiFive Unleashed is having VSC8541-01 ethernet phy device and requires a
>> specific reset sequence of 0-1-0-1 in order to use it in unmanaged mode.
>> This series addresses a corner case where phy reset is not handled by boot
>> stages prior to linux.
>> Somewhat similar unreliable phy probe failure was reported and discussed
>> here [1].
>> The macb driver fails to detect the ethernet phy device if the bootloader
>> doesn't provide a proper reset sequence to the phy device or the phy itself
>> is in some invalid state. Currently, the FSBL or u-boot-spl is resetting
>> the phy device, and so there is no issue observed in the linux network
>> setup.
>>
>> The series is based on linux-5.10-rc5.
>> Patch 1: Add the OUI to the phy dt node to fix issue of missing mdio device
>> Patch 2 and 3:
>> 	Resetting phy needs GPIO support so add to dt and defconfig.
>>
>> [1] https://lkml.org/lkml/2018/11/29/154
>>
>> To reproduce the issue:
>> Using FSBL:
>> 1. Comment out VSC8541 reset sequence in fsbl/main.c
>>    from within the freedom-u540-c000-bootloader.
>> 2. Build and flash fsbl.bin to micro sdcard.
>>
>> Using u-boot:
>> 1. Comment out VSC8541 reset sequence in board/sifive/fu540/spl.c
>>    from mainline u-boot source code.
>> 2. Build and flash u-boot binaries to micro sdcard.
>>
>> Boot the board and bootlog will show network setup failure messages as:
>>
>> [  1.069474] libphy: MACB_mii_bus: probed
>> [  1.073092] mdio_bus 10090000.ethernet-ffffffff: MDIO device at address 0
>> 	       is missing
>> .....
>> [  1.979252] macb 10090000.ethernet eth0: Could not attach PHY (-19)
>>
>> 3. Now apply the series build, and boot kernel.
>> 4. MACB and VSC8541 driver get successfully probed and the network is set
>>    without any failure.
>>
>>
>> So irrespective of whether the prior stages handle the phy reset sequence,
>> the probing is successful in both the cases of cold boot and warm boot.
>>
>> Change History:
>> ===============================
>> V2:
>> -Rebased v1 on linux kernel v5.10-rc3.
>>
>> V1:
>> -Ignore 4th patch as suggested and so removed it from the series.
>> -Verified this series on 5.7-rc5.
>>
>> V0: Base RFC patch. Verified on 5.7-rc2
>>
>> Sagar Shrikant Kadam (3):
>>   dts: phy: fix missing mdio device and probe failure of vsc8541-01
>>     device
>>   dts: phy: add GPIO number and active state used for phy reset
>>   riscv: defconfig: enable gpio support for HiFive Unleashed
>>
>>  arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 2 ++
>>  arch/riscv/configs/defconfig                        | 2 ++
>>  2 files changed, 4 insertions(+)
>
> David pointed out I missed these, they're on fixes.  Thanks!

This is now on 5.10.12, and breaks ethernet on the Hifive Unleashed:

[   12.777976] macb 10090000.ethernet: Registered clk switch 'sifive-gemgxl-mgmt'
[   12.784559] macb 10090000.ethernet: GEM doesn't support hardware ptp.
[   12.791629] libphy: MACB_mii_bus: probed
[   12.919728] MACsec IEEE 802.1AE
[   12.984676] macb 10090000.ethernet eth0: Cadence GEM rev 0x10070109 at 0x10090000 irq 16 (70:b3:d5:92:f1:07)
[   14.030319] Microsemi VSC8541 SyncE 10090000.ethernet-ffffffff:00: phy_poll_reset failed: -110
[   14.038986] macb 10090000.ethernet eth0: Could not attach PHY (-110)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
