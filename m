Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AF545B7F6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 11:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240997AbhKXKFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 05:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbhKXKFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 05:05:04 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE676C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 02:01:54 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mpp69-00058w-A3; Wed, 24 Nov 2021 11:01:53 +0100
Message-ID: <ed60649f-db15-db1d-f7b5-a0878f639d64@leemhuis.info>
Date:   Wed, 24 Nov 2021 11:01:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: Linux regressions report for mainline [2021-11-24]
Content-Language: en-BS
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <163774583541.221636.5062449110647587402@leemhuis.info>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <163774583541.221636.5062449110647587402@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1637748114;0a9648b1;
X-HE-SMSGID: 1mpp69-00058w-A3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lo! This was the first report sent by regzbot, my Linux kernel
regression tracking bot, so I guess it might be a good idea to highlight
a few of it's aspects:

On 24.11.21 10:25, Regzbot (on behalf of Thorsten Leemhuis) wrote:
> From: Regzbot (for Thorsten Leemhuis) <regressions@leemhuis.info>
> 
> Hi, this is regzbot, the Linux kernel regression tracking bot.
> 
> Currently I'm aware of 15 regressions in linux-mainline. Find the
> current status below and the latest on the web:
> 
> https://linux-regtracking.leemhuis.info/regzbot/mainline/
> 
> Bye bye, hope to see you soon for the next report.
>    Regzbot (on behalf of Thorsten Leemhuis)

From now on I plan to make regzbot send such reports on Monday mornings,
e.g. usually a few hours after Linus released a new RC.

Let me know what you think about the format.

A few random thoughts and explanations about the current format:

- next weeks report will highlight regressions that get added to regzbot
over the next few days

- I chose to categorize the regressions by identification status and by
version line. Those where the culprit is identified come first, as they
are the ones which most of the time can be solved by reverting the culprit

- the entries in each section are ordered by time of last activity,
which makes it easy to spot those where nothing happened recently, as
they are near the end of a section.

- the webui (https://linux-regtracking.leemhuis.info/regzbot/mainline/ )
links to the latest five activities regzbot noticed (an activity most of
the time will be a mail send in reply to the report or a related thread
that regzbot monitors). I for now chose to not do that in the report, as
it would make it much longer and might be something that spam filters
consider suspicious.

That's it from my side. Let me know what you think.

Ciao, Thorsten

> ========================================================
> current cycle (v5.15.. aka v5.16-rc), culprit identified
> ========================================================
> 
> 
> Regression in v5.16-rc1: Timeout in mlx5_health_wait_pci_up() may try to wait 245 million years
> -----------------------------------------------------------------------------------------------
> https://lore.kernel.org/regressions/15db9c1d11d32fb16269afceb527b5d743177ac4.camel@linux.ibm.com
> By Niklas Schnelle, 4 days ago; 3 activities, latest 3 days ago.
> Introduced in 32def4120e48 (v5.16-rc1)
> https://linux-regtracking.leemhuis.info/regzbot/regression/15db9c1d11d32fb16269afceb527b5d743177ac4.camel@linux.ibm.com
> 
> 
> =========================================================================================
> previous cycle (v5.14..v5.15), culprit identified, with activity in the past three months
> =========================================================================================
> 
> 
> CONFIG_SYSFB_SIMPLEFB breaks console scrolling
> ----------------------------------------------
> https://lore.kernel.org/lkml/e50d5ad5-19fd-07ae-41e4-5a2d26a98bcf@afaics.de
> By Harald Dunkel, 8 days ago; 1 activities, latest 8 days ago.
> Introduced in 8633ef82f101 (v5.15-rc1)
> https://linux-regtracking.leemhuis.info/regzbot/regression/e50d5ad5-19fd-07ae-41e4-5a2d26a98bcf@afaics.de
> 
> 
> ==================================================================================
> older cycles (..v5.14), culprit identified, with activity in the past three months
> ==================================================================================
> 
> 
> wireless AP (Raspberry Pi with rt2x00usb) crashes every hour or so
> ------------------------------------------------------------------
> https://lore.kernel.org/lkml/20211118132556.GD334428@darkstar.musicnaut.iki.fi
> By Aaro Koskinen, 5 days ago; 5 activities, latest 1 days ago.
> Introduced in 03c3911d2d67 (v5.14-rc1)
> https://linux-regtracking.leemhuis.info/regzbot/regression/20211118132556.GD334428@darkstar.musicnaut.iki.fi
> 
> Latest activity with a patch:
> * [PATCH 5.16] mac80211: fix rate control for retransmitted frames
>   https://lore.kernel.org/linux-wireless/20211122204323.9787-1-nbd@nbd.name
>   1 days ago, by Felix Fietkau; thread monitored.
> 
> 
> Bluetooth: Query LE tx power on startup broke Bluetooth on MacBookPro16,1
> -------------------------------------------------------------------------
> https://lore.kernel.org/regressions/4970a940-211b-25d6-edab-21a815313954@protonmail.com
> By Orlando Chamberlain, 56 days ago; 30 activities, latest 4 days ago.
> Introduced in 7c395ea521e6 (v5.11-rc1)
> https://linux-regtracking.leemhuis.info/regzbot/regression/4970a940-211b-25d6-edab-21a815313954@protonmail.com
> 
> Latest activity with a patch:
> * Re: [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
>   https://lore.kernel.org/lkml/CABBYNZLjSfcG_KqTEbL6NOSvHhA5-b1t_S=3FQP4=GwW21kuzg@mail.gmail.com
>   18 days ago, by Luiz Augusto von Dentz
> 
> Noteworthy links:
> * Re: [PATCH] Bluetooth: add quirk disabling query LE tx power
>   https://lore.kernel.org/lkml/43fb97ad-69eb-95ad-d50a-b8f1113dbee6@leemhuis.info
>   54 days ago, by Thorsten Leemhuis; thread monitored.
> * [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
>   https://lore.kernel.org/lkml/20211001083412.3078-1-redecorating@protonmail.com
>   54 days ago, by Orlando Chamberlain; thread monitored.
> 
> 
> Re: rt2x00 regression
> ---------------------
> https://lore.kernel.org/regressions/87czop5j33.fsf@tynnyri.adurom.net
> By Kalle Valo, 54 days ago; 16 activities, latest 4 days ago.
> Introduced in e383c70474db (v5.2-rc1)
> https://linux-regtracking.leemhuis.info/regzbot/regression/87czop5j33.fsf@tynnyri.adurom.net
> 
> Latest activity with a patch:
> * [PATCH] rt2x00: do not mark device gone on EPROTO errors during start
>   https://lore.kernel.org/regressions/20211111141003.GA134627@wp.pl
>   12 days ago, by Stanislaw Gruszka
> 
> Noteworthy links:
> * rt2x00 regression
>   https://lore.kernel.org/linux-wireless/bff7d309-a816-6a75-51b6-5928ef4f7a8c@exuvo.se
>   789 days ago, by Anton Olsson; thread monitored.
> 
> 
> PCIe regression on APM Merlin (aarch64 dev platform) preventing NVME initialization
> -----------------------------------------------------------------------------------
> https://lore.kernel.org/linux-pci/CA%2Benf=v9rY_xnZML01oEgKLmvY1NGBUUhnSJaETmXtDtXfaczA@mail.gmail.com
> By Stéphane Graber, 5 days ago; 4 activities, latest 5 days ago.
> Introduced in 6dce5aa59e0b (v5.5-rc1)
> https://linux-regtracking.leemhuis.info/regzbot/regression/CA%2Benf=v9rY_xnZML01oEgKLmvY1NGBUUhnSJaETmXtDtXfaczA@mail.gmail.com
> 
> Latest activity with a patch:
> * Re: PCIe regression on APM Merlin (aarch64 dev platform) preventing NVME initialization
>   https://lore.kernel.org/linux-pci/CAL_JsqKrfpDtQZMMuhA_tURit6fO82FzPbKA40o6_8jWRewm8g@mail.gmail.com
>   5 days ago, by Rob Herring
> 
> 
> mhi: ath11k resume fails on some devices
> ----------------------------------------
> https://lore.kernel.org/regressions/871r5p0x2u.fsf@codeaurora.org
> By Kalle Valo, 69 days ago; 23 activities, latest 5 days ago.
> Introduced in 020d3b26c07a (v5.13-rc1)
> https://linux-regtracking.leemhuis.info/regzbot/regression/871r5p0x2u.fsf@codeaurora.org
> 
> 
> bug: usb: gadget: FSL_UDC_CORE Corrupted request list leads to unrecoverable loop.
> ----------------------------------------------------------------------------------
> https://lore.kernel.org/linuxppc-dev/MWHPR2201MB152074F47BF142189365627B91879@MWHPR2201MB1520.namprd22.prod.outlook.com
> By Eugene Bordenkircher, 25 days ago; 7 activities, latest 7 days ago.
> Introduced in f79a60b8785 (v3.4-rc4)
> https://linux-regtracking.leemhuis.info/regzbot/regression/MWHPR2201MB152074F47BF142189365627B91879@MWHPR2201MB1520.namprd22.prod.outlook.com
> 
> Noteworthy links:
> * https://lore.kernel.org/all/CADRPPNSrhiwr8jmBb2h4cFYqHtuDKK8rL0i6Bkg7+xEyXJPATA@mail.gmail.com/
>   22 days ago, by Thorsten Leemhuis
> * https://lore.kernel.org/all/2c275adc278477e1e512ea6ecc0c1f4dcc46969d.camel@infinera.com/
>   22 days ago, by Thorsten Leemhuis
> 
> 
> Bug in Memory Layout of rx_desc for QCA6174
> -------------------------------------------
> https://lore.kernel.org/ath10k/CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_aypR74UvN1uQ@mail.gmail.com
> By Francesco Magliocca, 159 days ago; 5 activities, latest 24 days ago.
> Introduced in e3def6f7ddf8 (v4.16-rc1)
> https://linux-regtracking.leemhuis.info/regzbot/regression/CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_aypR74UvN1uQ@mail.gmail.com
> 
> Noteworthy links:
> * Bug in Memory Layout of rx_desc for QCA6174
>   https://lore.kernel.org/ath10k/CAH4F6uvX=xtTnBDaj1BVHSx_FDSUbpc4TRC2DGTHBmGJSD2oEA@mail.gmail.com
>   25 days ago, by Francesco Magliocca; thread monitored.
> 
> 
> ====================================================
> current cycle (v5.15.. aka v5.16-rc), unkown culprit
> ====================================================
> 
> 
> mm: reclaim_throttle leads to stall in near-OOM conditions
> ----------------------------------------------------------
> https://lore.kernel.org/lkml/20211124011954.7cab9bb4@mail.inbox.lv
> By Alexey Avramov, 0 days ago; 1 activities, latest 0 days ago.
> Introduced in v5.15..v5.16-rc1
> https://linux-regtracking.leemhuis.info/regzbot/regression/20211124011954.7cab9bb4@mail.inbox.lv
> 
> 
> mm: LTP/memcg testcase regression induced by 8cd7c588decf..66ce520bb7c2 series
> ------------------------------------------------------------------------------
> https://lore.kernel.org/lkml/99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de
> By Mike Galbraith, 2 days ago; 8 activities, latest 0 days ago.
> Introduced in 8cd7c588decf..66ce520bb7c2 (v5.15..v5.16-rc1)
> https://linux-regtracking.leemhuis.info/regzbot/regression/99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de
> 
> 
> ====================================================================================
> previous cycle (v5.14..v5.15), unkown culprit, with activity in the past three weeks
> ====================================================================================
> 
> 
> Kernel 5.15 reboots / freezes upon ifup/ifdown
> ----------------------------------------------
> https://lore.kernel.org/stable/924175a188159f4e03bd69908a91e606b574139b.camel@gmx.de
> By Stefan Dietrich, 0 days ago; 5 activities, latest 0 days ago.
> Introduced in v5.14..v5.15
> https://linux-regtracking.leemhuis.info/regzbot/regression/924175a188159f4e03bd69908a91e606b574139b.camel@gmx.de
> 
> 
> kernel 5.15.1: AMD RX 6700 XT - Fails to resume after screen blank
> ------------------------------------------------------------------
> https://lore.kernel.org/stable/dbadfe41-24bf-5811-cf38-74973df45214@badpenguin.co.uk
> By Mark Boddington, 13 days ago; 7 activities, latest 11 days ago.
> Introduced in v5.14..v5.15
> https://linux-regtracking.leemhuis.info/regzbot/regression/dbadfe41-24bf-5811-cf38-74973df45214@badpenguin.co.uk
> 
> 
> =============================================================================
> older cycles (..v5.14), unkown culprit, with activity in the past three weeks
> =============================================================================
> 
> 
> Ralink RT2800 kernel deference issue since kernel 5.14
> ------------------------------------------------------
> https://lore.kernel.org/linux-wireless/c07b4142fb725ed87a2cef530bae9ee7@lost-in-the-void.net
> By Robert W, 11 days ago; 5 activities, latest 1 days ago.
> Introduced in v5.13..v5.14
> https://linux-regtracking.leemhuis.info/regzbot/regression/c07b4142fb725ed87a2cef530bae9ee7@lost-in-the-void.net
> 
> Latest activity with a patch:
> * [PATCH 5.16] mac80211: fix rate control for retransmitted frames
>   https://lore.kernel.org/linux-wireless/20211122204323.9787-1-nbd@nbd.name
>   1 days ago, by Felix Fietkau; thread monitored.
> 
> 
> ====================================================================
> all others with unkown culprit and activity in the past three months
> ====================================================================
> 
> 
> idle power increased from ~20 to ~28 watts
> ------------------------------------------
> https://lore.kernel.org/lkml/c11d94b4-1701-4e26-efd1-42038342c4aa@kaputniks.org
> By Idzibear, 22 days ago; 3 activities, latest 22 days ago.
> Introduced in v5.14..v5.15
> https://linux-regtracking.leemhuis.info/regzbot/regression/c11d94b4-1701-4e26-efd1-42038342c4aa@kaputniks.org
> 
> 
> =============
> End of report
> =============
> 
