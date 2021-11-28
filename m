Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E069746081C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 18:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243536AbhK1Row (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 12:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344463AbhK1Rmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 12:42:51 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9184BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:39:35 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1mrO9F-0007tr-Dz; Sun, 28 Nov 2021 18:39:33 +0100
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report for mainline [2021-11-28]
Date:   Sun, 28 Nov 2021 17:39:32 +0000
Message-Id: <163812092699.280906.9531609654224685861@leemhuis.info>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1638121175;53c055b4;
X-HE-SMSGID: 1mrO9F-0007tr-Dz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Regzbot (for Thorsten Leemhuis) <regressions@leemhuis.info>

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 17 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


========================================================
current cycle (v5.15.. aka v5.16-rc), culprit identified
========================================================


Regression in v5.16-rc1: Timeout in mlx5_health_wait_pci_up() may try to wait 245 million years
-----------------------------------------------------------------------------------------------
https://lore.kernel.org/regressions/15db9c1d11d32fb16269afceb527b5d743177ac4.camel@linux.ibm.com
By Niklas Schnelle, 9 days ago; 3 activities, latest 8 days ago.
Introduced in 32def4120e48 (v5.16-rc1)
https://linux-regtracking.leemhuis.info/regzbot/regression/15db9c1d11d32fb16269afceb527b5d743177ac4.camel@linux.ibm.com


====================================================
current cycle (v5.15.. aka v5.16-rc), unkown culprit
====================================================


mm: LTP/memcg testcase regression induced by 8cd7c588decf..66ce520bb7c2 series
------------------------------------------------------------------------------
https://lore.kernel.org/lkml/99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de
By Mike Galbraith, 7 days ago; 21 activities, latest 0 days ago.
Introduced in 8cd7c588decf..66ce520bb7c2 (v5.15..v5.16-rc1)
https://linux-regtracking.leemhuis.info/regzbot/regression/99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de

Latest activity with a patch:
* Re: [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to make progress
  https://lore.kernel.org/lkml/252cd5acd9bf6588ec87ce02884925c737b6a8b7.camel@gmx.de
  0 days ago, by Mike Galbraith

Noteworthy links:
* Related regression, likely to be fixed by the same patch
  https://lore.kernel.org/lkml/20211124011954.7cab9bb4@mail.inbox.lv/
  5 days ago, by Alexey Avramov; link later added and described by Thorsten Leemhuis
* [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to make progress
  https://lore.kernel.org/lkml/20211125151853.8540-1-mgorman@techsingularity.net
  3 days ago, by Mel Gorman; thread monitored.


mm: reclaim_throttle leads to stall in near-OOM conditions
----------------------------------------------------------
https://lore.kernel.org/lkml/20211124011954.7cab9bb4@mail.inbox.lv
By Alexey Avramov, 5 days ago; 12 activities, latest 0 days ago.
Introduced in v5.15..v5.16-rc1
https://linux-regtracking.leemhuis.info/regzbot/regression/20211124011954.7cab9bb4@mail.inbox.lv

Latest activity with a patch:
* Re: mm: 5.16 regression: reclaim_throttle leads to stall in near-OOM conditions
  https://lore.kernel.org/lkml/20211126162416.GK3366@techsingularity.net
  2 days ago, by Mel Gorman

Noteworthy links:
* Related regression, likely to be fixed by the same patch
  https://lore.kernel.org/lkml/99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de/
  7 days ago, by Mike Galbraith; link later added and described by Thorsten Leemhuis
* [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to make progress
  https://lore.kernel.org/lkml/20211125151853.8540-1-mgorman@techsingularity.net
  3 days ago, by Mel Gorman; thread monitored.


=========================================================================================
previous cycle (v5.14..v5.15), culprit identified, with activity in the past three months
=========================================================================================


drm/amd: AMD RX 6700 XT - Fails to resume after screen blank [*NEW*]
--------------------------------------------------------------------
https://lore.kernel.org/regressions/99797fb7-76eb-9d86-ad2f-591243eca404@badpenguin.co.uk
By Mark Boddington, 3 days ago; 3 activities, latest 2 days ago.
Introduced in 61d861cf4785 (v5.15-rc1)
https://linux-regtracking.leemhuis.info/regzbot/regression/99797fb7-76eb-9d86-ad2f-591243eca404@badpenguin.co.uk


net: kernel hangs during power down [*NEW*]
-------------------------------------------
https://lore.kernel.org/netdev/20211124144505.31e15716@hermes.local
By Stephen Hemminger, 3 days ago; 6 activities, latest 2 days ago.
Introduced in f32a21376573 (v5.15-rc1)
https://linux-regtracking.leemhuis.info/regzbot/regression/20211124144505.31e15716@hermes.local


drm: CONFIG_SYSFB_SIMPLEFB breaks console scrolling
---------------------------------------------------
https://lore.kernel.org/lkml/e50d5ad5-19fd-07ae-41e4-5a2d26a98bcf@afaics.de
By Harald Dunkel, 12 days ago; 2 activities, latest 3 days ago.
Introduced in 8633ef82f101 (v5.15-rc1)
https://linux-regtracking.leemhuis.info/regzbot/regression/e50d5ad5-19fd-07ae-41e4-5a2d26a98bcf@afaics.de


Kernel 5.15 reboots / freezes upon ifup/ifdown
----------------------------------------------
https://lore.kernel.org/stable/924175a188159f4e03bd69908a91e606b574139b.camel@gmx.de
By Stefan Dietrich, 4 days ago; 10 activities, latest 3 days ago.
Introduced in a90ec8483732 (v5.15-rc1)
https://linux-regtracking.leemhuis.info/regzbot/regression/924175a188159f4e03bd69908a91e606b574139b.camel@gmx.de


==================================================================================
older cycles (..v5.14), culprit identified, with activity in the past three months
==================================================================================


net: wireless: ath10k: 5GHz channels are marked as No-IR [*NEW*]
----------------------------------------------------------------
https://lore.kernel.org/ath10k/1c160dfb-6ccc-b4d6-76f6-4364e0adb6dd@reox.at
By Sebastian Bachmann, 1 days ago; 18 activities, latest 1 days ago.
Introduced in 2dc016599cfa (v5.6-rc1)
https://linux-regtracking.leemhuis.info/regzbot/regression/1c160dfb-6ccc-b4d6-76f6-4364e0adb6dd@reox.at

Noteworthy links:
* Compex WLE600VX AP mode 5GHz doesn't work since kernel 5.6
  https://lore.kernel.org/ath10k/5971a327-d11a-35e6-8295-8dfb8ae3a434@yandex.ru
  595 days ago, by svp; thread monitored.
* Re: Compex WLE600VX AP mode 5GHz doesn't work since kernel 5.6
  https://lore.kernel.org/ath10k/CA+ASDXNNfG3-ra8C2ou457J=Vj5eE83VCXgGsFPQQOixTcu7YA@mail.gmail.com/
  523 days ago, by Brian Norris
* [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
  https://lore.kernel.org/linux-wireless/20200730124923.271429-1-alsi@bang-olufsen.dk
  486 days ago, by Alvin Šipraga; thread monitored.
* [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
  https://lore.kernel.org/ath10k/20201022172113.GA1367233@capeo.gueux.org
  402 days ago, by Félix Sipma; thread monitored.
* Re: [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
  https://lore.kernel.org/ath10k/19e636c1-fdbe-7222-a055-d668e4617070@gmx.de
  342 days ago, by sparks71@gmx.de; thread monitored.
* https://bugs.debian.org/959821
* https://bbs.archlinux.org/viewtopic.php?id=254535


bluetooth: "Query LE tx power on startup" broke Bluetooth on MacBookPro16,1
---------------------------------------------------------------------------
https://lore.kernel.org/regressions/4970a940-211b-25d6-edab-21a815313954@protonmail.com
By Orlando Chamberlain, 60 days ago; 30 activities, latest 2 days ago.
Introduced in 7c395ea521e6 (v5.11-rc1)
https://linux-regtracking.leemhuis.info/regzbot/regression/4970a940-211b-25d6-edab-21a815313954@protonmail.com

Latest activity with a patch:
* Re: [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
  https://lore.kernel.org/lkml/D9375D91-1062-4265-9DE9-C7CF2B705F3F@live.com
  2 days ago, by Aditya Garg


usb: fsl_udc_core: corrupted request list leads to unrecoverable loop
---------------------------------------------------------------------
https://lore.kernel.org/linuxppc-dev/MWHPR2201MB152074F47BF142189365627B91879@MWHPR2201MB1520.namprd22.prod.outlook.com
By Eugene Bordenkircher, 30 days ago; 8 activities, latest 3 days ago.
Introduced in f79a60b8785 (v3.4-rc4)
https://linux-regtracking.leemhuis.info/regzbot/regression/MWHPR2201MB152074F47BF142189365627B91879@MWHPR2201MB1520.namprd22.prod.outlook.com

Noteworthy links:
* Re: bug: usb: gadget: FSL_UDC_CORE Corrupted request list leads to unrecoverable loop.
  https://lore.kernel.org/all/CADRPPNSrhiwr8jmBb2h4cFYqHtuDKK8rL0i6Bkg7+xEyXJPATA@mail.gmail.com/
  29 days ago, by Li Yang
* Re: bug: usb: gadget: FSL_UDC_CORE Corrupted request list leads to unrecoverable loop.
  https://lore.kernel.org/all/2c275adc278477e1e512ea6ecc0c1f4dcc46969d.camel@infinera.com/
  29 days ago, by Joakim Tjernlund


wireless AP (Raspberry Pi with rt2x00usb) crashes every hour or so
------------------------------------------------------------------
https://lore.kernel.org/lkml/20211118132556.GD334428@darkstar.musicnaut.iki.fi
By Aaro Koskinen, 10 days ago; 5 activities, latest 5 days ago.
Introduced in 03c3911d2d67 (v5.14-rc1)
https://linux-regtracking.leemhuis.info/regzbot/regression/20211118132556.GD334428@darkstar.musicnaut.iki.fi

Latest activity with a patch:
* [PATCH 5.16] mac80211: fix rate control for retransmitted frames
  https://lore.kernel.org/linux-wireless/20211122204323.9787-1-nbd@nbd.name
  5 days ago, by Felix Fietkau; thread monitored.


Re: rt2x00 regression
---------------------
https://lore.kernel.org/regressions/87czop5j33.fsf@tynnyri.adurom.net
By Kalle Valo, 58 days ago; 16 activities, latest 9 days ago.
Introduced in e383c70474db (v5.2-rc1)
https://linux-regtracking.leemhuis.info/regzbot/regression/87czop5j33.fsf@tynnyri.adurom.net

Latest activity with a patch:
* [PATCH] rt2x00: do not mark device gone on EPROTO errors during start
  https://lore.kernel.org/regressions/20211111141003.GA134627@wp.pl
  17 days ago, by Stanislaw Gruszka

Noteworthy links:
* rt2x00 regression
  https://lore.kernel.org/linux-wireless/bff7d309-a816-6a75-51b6-5928ef4f7a8c@exuvo.se
  794 days ago, by Anton Olsson; thread monitored.


PCIe regression on APM Merlin (aarch64 dev platform) preventing NVME initialization
-----------------------------------------------------------------------------------
https://lore.kernel.org/linux-pci/CA%2Benf=v9rY_xnZML01oEgKLmvY1NGBUUhnSJaETmXtDtXfaczA@mail.gmail.com
By Stéphane Graber, 9 days ago; 4 activities, latest 9 days ago.
Introduced in 6dce5aa59e0b (v5.5-rc1)
https://linux-regtracking.leemhuis.info/regzbot/regression/CA%2Benf=v9rY_xnZML01oEgKLmvY1NGBUUhnSJaETmXtDtXfaczA@mail.gmail.com

Latest activity with a patch:
* Re: PCIe regression on APM Merlin (aarch64 dev platform) preventing NVME initialization
  https://lore.kernel.org/linux-pci/CAL_JsqKrfpDtQZMMuhA_tURit6fO82FzPbKA40o6_8jWRewm8g@mail.gmail.com
  9 days ago, by Rob Herring


mhi: ath11k resume fails on some devices
----------------------------------------
https://lore.kernel.org/regressions/871r5p0x2u.fsf@codeaurora.org
By Kalle Valo, 73 days ago; 23 activities, latest 9 days ago.
Introduced in 020d3b26c07a (v5.13-rc1)
https://linux-regtracking.leemhuis.info/regzbot/regression/871r5p0x2u.fsf@codeaurora.org


Bug in Memory Layout of rx_desc for QCA6174
-------------------------------------------
https://lore.kernel.org/ath10k/CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_aypR74UvN1uQ@mail.gmail.com
By Francesco Magliocca, 163 days ago; 5 activities, latest 28 days ago.
Introduced in e3def6f7ddf8 (v4.16-rc1)
https://linux-regtracking.leemhuis.info/regzbot/regression/CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_aypR74UvN1uQ@mail.gmail.com

Noteworthy links:
* Bug in Memory Layout of rx_desc for QCA6174
  https://lore.kernel.org/ath10k/CAH4F6uvX=xtTnBDaj1BVHSx_FDSUbpc4TRC2DGTHBmGJSD2oEA@mail.gmail.com
  30 days ago, by Francesco Magliocca; thread monitored.


=============================================================================
older cycles (..v5.14), unkown culprit, with activity in the past three weeks
=============================================================================


Ralink RT2800 kernel deference issue since kernel 5.14
------------------------------------------------------
https://lore.kernel.org/linux-wireless/c07b4142fb725ed87a2cef530bae9ee7@lost-in-the-void.net
By Robert W, 15 days ago; 5 activities, latest 5 days ago.
Introduced in v5.13..v5.14
https://linux-regtracking.leemhuis.info/regzbot/regression/c07b4142fb725ed87a2cef530bae9ee7@lost-in-the-void.net

Latest activity with a patch:
* [PATCH 5.16] mac80211: fix rate control for retransmitted frames
  https://lore.kernel.org/linux-wireless/20211122204323.9787-1-nbd@nbd.name
  5 days ago, by Felix Fietkau; thread monitored.


====================================================================
all others with unkown culprit and activity in the past three months
====================================================================


idle power increased from ~20 to ~28 watts
------------------------------------------
https://lore.kernel.org/lkml/c11d94b4-1701-4e26-efd1-42038342c4aa@kaputniks.org
By Idzibear, 27 days ago; 3 activities, latest 27 days ago.
Introduced in v5.14..v5.15
https://linux-regtracking.leemhuis.info/regzbot/regression/c11d94b4-1701-4e26-efd1-42038342c4aa@kaputniks.org


=============
End of report
=============

-- 
P.S.: Wanna know more about regzbot or how to use it to track regressions
for your subsystem? Then check out the getting started guide or the
reference documentation:

https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The short version: if you see a regression report you want to see
tracked, just send a reply to the report where you Cc
regressions@lists.linux.dev with a line like this, but without the
backslash as first character:

\#regzbot introduced: v5.13..v5.14-rc1

If you want to fix a tracked regression, just do what is expected
anyway: add a 'Link:' tag with the url to the report, e.g.:

Link: https://lore.kernel.org/all/30th.anniversary.repost@klaava.Helsinki.FI/
