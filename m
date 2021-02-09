Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56D3315B90
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbhBJAr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:47:29 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:39991 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233908AbhBIVDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 16:03:19 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 17DB65802F3;
        Tue,  9 Feb 2021 16:00:50 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Tue, 09 Feb 2021 16:00:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        mime-version:message-id:date:from:to:cc:subject:content-type; s=
        fm2; bh=iFjNgbuGaC/X5QDUBosgkvaVocivJZjnnGRVwwGOhC0=; b=WUhkjtUJ
        tKwSH2mlC/LoLfEO16hfMs4VDHoAqvSrZQHYC1fvwzREgKaOkATjYcCzjq64IOmd
        6EJ4/AlO1wBtdsUAZajeq+L7sSmOvGJsVZcAzrKmhFHYWbxxK8jhvKp0htSyQcFS
        xIepa+Y9Tjq+MN1fiNEbE5hSgGRmfs4CgK++PKJ6jgCtpHC0IlWerpTZOezwLbg/
        jlW25wv30nZuFoFOAOuleOtvHrJikX14lwVcTX3rDiUO5LGhTj4wKkIhSMaFCaGF
        8hOEOpp7XV+rbK73I/tE/8ks9/4sMh0e6ug72LOZEGEbYJ5YQV80e+IXf/9K65ZZ
        4DdmyZKjUISuFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=iFjNgbuGaC/X5QDUBosgkvaVocivJ
        ZjnnGRVwwGOhC0=; b=tQ6KeXV99Wg8Vbojd99RVXxFPskUbYPNMpcG3apLP/q6H
        JI+Z6S8PNnalmTqkOvz4c0jtOOI0+pSW10QFQkwtVxaZqEQJ7ZJDKrZgcfEpVprw
        mB86NvXglMGIioC7xuiguFLIh4X1DBNrN4cdQRIorlGoSriLHFZHq/B2GLN4y76v
        AIGW6NEA45mfiTWi9gYeHNsLG1rK6ow2dyYGLYgmwN8RlPJBb46IZP41+QqMjsNz
        VFRuMQXPA93f6zmJaytqqnq1BRJ+BvhcNzr63ujmnRml6s93TaPyQ3RrFYuTKwjP
        VmKPDA1QqwciNEfOiYhMVWE7EvzHUuGuNt0JMPEYQ==
X-ME-Sender: <xms:_vciYJ07wvkgUg4y6vr32vho-LlJNTGsSCgqybk40dgfT70joZ0p4A>
    <xme:_vciYAGM9DurupXrIzt2gJZcjz_5cE9tdWLQ9BdhUptTWz1ldcd6I425n7ZyoL_LQ
    yBm0a0xs8iY_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrheehgddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erreejnecuhfhrohhmpehnnhgvthcuoehnnhgvthesfhgrshhtmhgrihhlrdhfmheqnecu
    ggftrfgrthhtvghrnhepteduudejhfdttdevheevvdeiudfhleeuieeugfeuudfhgeffue
    euhfdtueeigeeinecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnnhgvthesfhgrshhtmhgrih
    hlrdhfmh
X-ME-Proxy: <xmx:_vciYJ7aNCOk9Wnrn4EeYs3te3H7h6QyatL4bxHiL_3BPiEkL8F9PA>
    <xmx:_vciYG11dkzGGceffhvrsamyQeYHGU87yQWdTtK04PYqmHdSonzI4g>
    <xmx:_vciYMGxr_6mo2oo4R19M96LrnCfXAaX2BhLiKy7frzcjDkTvFN4Xg>
    <xmx:AvgiYJePa8aC9iwEpNFnLjWR9mdS1J3GvCwcdpDZhPPIJxzICccVdQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BA7F9A00060; Tue,  9 Feb 2021 16:00:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-93-gef6c4048e6-fm-20210128.002-gef6c4048
Mime-Version: 1.0
Message-Id: <d59ba191-43db-4b7b-b201-62a60ca752c0@www.fastmail.com>
Date:   Tue, 09 Feb 2021 13:00:26 -0800
From:   nnet <nnet@fastmail.fm>
To:     pali@kernel.org
Cc:     a.heider@gmail.com, andrew@lunn.ch, gerald@gk2.net,
        gregory.clement@bootlin.com, kabel@kernel.org, kostap@marvell.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, luka.perkov@sartura.hr,
        miquel.raynal@bootlin.com, mturquette@baylibre.com,
        rmk+kernel@armlinux.org.uk, sboyd@kernel.org, tmn505@gmail.com,
        vladimir.vid@sartura.hr
Subject: =?UTF-8?Q?Re:_[PATCH_mvebu_v2_00/10]_Armada_37xx:_Fix_cpufreq_changing_b?=
 =?UTF-8?Q?ase_CPU_speed_to_800_MHz_from_1000_MHz?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If you have other Armada 3720 boards (Espressobin v5/v7, uDPU, Devel Board, ...) then it will be nice to do an additional tests and check if instability issues are finally fixed.

These patches applied to the 5.4.96 in OpenWrt (98d61b5) work fine so far on an Espressobin v7 AFAICT per changing values in /sys/devices/system/cpu/cpufreq/policy0.

Are these changes intended to work @1.2 GHz on the v7?

I have the beige case and heat-sinks with paste on the board, and the power adapter is the Fairway for 2.0A. 

However, the device hangs fairly quickly under load with firmware flashed of the built as below:

diff --git a/package/boot/arm-trusted-firmware-mvebu/Makefile b/package/boot/arm-trusted-firmware-mvebu/Makefile
index c4669edb52..20899c29e7 100644
--- a/package/boot/arm-trusted-firmware-mvebu/Makefile
+++ b/package/boot/arm-trusted-firmware-mvebu/Makefile
@@ -72,7 +72,7 @@ define Trusted-Firmware-A/espressobin-v7-1gb
   BUILD_DEVICES:=globalscale_espressobin-v7
   UBOOT:=espressobin
   DDR_TOPOLOGY:=5
-  CLOCKSPRESET:=CPU_1000_DDR_800
+  CLOCKSPRESET:=CPU_1200_DDR_750
   PLAT:=a3700
 endef

See: https://github.com/openwrt/openwrt/commit/5fae94d987f2261b148c035130a00350c905a13e
