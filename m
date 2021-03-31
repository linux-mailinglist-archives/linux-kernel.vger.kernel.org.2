Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C794635085F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbhCaUnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:43:32 -0400
Received: from st43p00im-zteg10063401.me.com ([17.58.63.175]:53590 "EHLO
        st43p00im-zteg10063401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236643AbhCaUnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1617223386; bh=YTVxrGb9f/WR/G24ONgmktOocx5EPbXc+W7Hjey81CA=;
        h=From:To:Subject:Date:Message-Id;
        b=lXapwnf6QySvA5Cgh9VNPByHOrQT/3YV89gUZ3XqKMcfseKIQ38MDaRif6Loksrut
         1AsCOLkoUm+j+s5S68oM1MmDhP+o7gyOmehxwXvj6RUIIxsfYEdNvtBzvqsxk36X17
         1RntpCM56Yttg12e/XV1bB5/CGXSrJ7oAHFRN75XR0aqL6QaU72f6nfuEToRWXpcHo
         XFAfKIZR4yX4Da/yrV6LklMyBVPWWBdlwOAUv+HsSYvEF1vTKYIrFGgwKSImZ4gSoq
         LrtAaVu5o3t1clnuijxKC6hZ1L8CYq5rRkQBMOc6Sg8q4qiZfZp7ZQkp55y8wVOBw/
         6EIkwv8J72c2g==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10063401.me.com (Postfix) with ESMTPSA id EE1F34A082C;
        Wed, 31 Mar 2021 20:43:00 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, avolmat@me.com
Subject: [PATCH v3 00/13] Introduction of STiH418 based 4KOpen board
Date:   Wed, 31 Mar 2021 22:42:15 +0200
Message-Id: <20210331204228.26107-1-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-31=5F10:2021-03-30=5F02,2021-03-31=5F10,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103310144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie introduces the 4KOpen (stih418-b2264) board based
on a stih418 soc. Since it is the first board to use the spi-fsm
SPI NOR controller available since stih407, the controller is
also added within the stih407-family DT.
It also contains a fix within the stih418 DT since the rng11 is not
available on this platform and is thus disabled.

sti dts updates related to clocks are also added within the serie in
order to use new sti clock driver compatible to avoid
having to declare clock output names within the device-tree.
Those 9 patches were initially pushed together with the clock driver
updates but have been pulled out of that serie to only push the driver
updates via the clock tree. [1]

For that reason, this serie should be applied on top of the serie 
[clk: st: embed clock outputs within drivers].

[1] https://lore.kernel.org/linux-clk/161706966003.3012082.13602640109563561014@swboyd.mtv.corp.google.com/

Alain Volmat (13):
  ARM: dts: sti: update flexgen compatible within stih418-clock
  ARM: dts: sti: update flexgen compatible within stih407-clock
  ARM: dts: sti: update flexgen compatible within stih410-clock
  ARM: dts: sti: update clkgen-pll entries in stih407-clock
  ARM: dts: sti: update clkgen-pll entries in stih410-clock
  ARM: dts: sti: update clkgen-pll entries in stih418-clock
  ARM: dts: sti: update clkgen-fsyn entries in stih407-clock
  ARM: dts: sti: update clkgen-fsyn entries in stih410-clock
  ARM: dts: sti: update clkgen-fsyn entries in stih418-clock
  ARM: dts: sti: add the spinor controller node within stih407-family
  ARM: dts: sti: disable rng11 on the stih418 platform
  ARM: dts: sti: add the thermal sensor node within stih418
  ARM: dts: sti: Introduce 4KOpen (stih418-b2264) board

v3: update of the stih418-b2264 dts
    addition of stih407/stih410/stih418 clock updates

 arch/arm/boot/dts/Makefile            |   3 +-
 arch/arm/boot/dts/stih407-clock.dtsi  | 128 ++--------------------
 arch/arm/boot/dts/stih407-family.dtsi |  15 +++
 arch/arm/boot/dts/stih410-clock.dtsi  | 138 ++---------------------
 arch/arm/boot/dts/stih418-b2264.dts   | 151 ++++++++++++++++++++++++++
 arch/arm/boot/dts/stih418-clock.dtsi  | 136 ++---------------------
 arch/arm/boot/dts/stih418.dtsi        |  12 ++
 7 files changed, 215 insertions(+), 368 deletions(-)
 create mode 100644 arch/arm/boot/dts/stih418-b2264.dts

-- 
2.17.1

