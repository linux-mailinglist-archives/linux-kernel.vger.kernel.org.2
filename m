Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C848C32205B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 20:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbhBVTnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 14:43:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:54720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232963AbhBVTm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 14:42:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B302A64E31;
        Mon, 22 Feb 2021 19:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614022938;
        bh=2P/frDeCW8JTaaEDaSByJHY8gufOSsfYYCYfWdxiliM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=abMh/mOmtWtVl+TIrppLJ6TnbxgQNtb+Blsm8U8HjhRK95RKB0WpCWcPEOQypLEs2
         sOkveT2/mec6BAlJ+ayxsADKdyyT5v2NRok5H9vPtt4iF7xe9KXXCKNTeTGhY3ztUD
         eSAuoNFm/Dky/m90osSAOY0cp9cGJ9ufIN7BzvakR9isjJxh2bPtaeR87xYZ7MGGY/
         Q2USAm9SzepEW6rBi8ZBJr5dO6XKrtkEYbyqBLrV992fNj/0KP9TTlf561Zi41bEXX
         soLxI2NiO01stu2mKXfoGGaHvo7nmV8UPEg0XTc6z8LtFkkNSKyii0YYpOpIvKKiDt
         KknppqcxIkRmw==
Received: by pali.im (Postfix)
        id 35A07C9A; Mon, 22 Feb 2021 20:42:16 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Andre Heider <a.heider@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?G=C3=A9rald=20Kerma?= <gerald@gk2.net>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: [PATCH mvebu v3 00/10] Armada 37xx: Fix cpufreq changing base CPU speed to 800 MHz from 1000 MHz
Date:   Mon, 22 Feb 2021 20:41:48 +0100
Message-Id: <20210222194158.12342-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210114124032.12765-1-pali@kernel.org>
References: <20210114124032.12765-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is third version of patches for Armada 37xx cpufreq driver which
fix CPU scaling with 1 GHz base frequency.

The only change in this third version is modified patch 04/10 with fixes
for 1.2 GHz variant of Espressobin. Minimal CPU voltage in L1 load for
1.2 GHz variant was increased to 1.155V.

Patches are now rebased on top of the kernel version 5.11 with all
collected Acked-by/Tested-by lines and are available also in my git
tree in branch a3720-cpufreq-issues:

https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=a3720-cpufreq-issues

If you have other Armada 3720 boards with 1.2 GHz CPU, including
Espressobin V7, let us know if it is working fine for you.

Marek & Pali

Marek Behún (3):
  arm64: dts: marvell: armada-37xx: add syscon compatible to NB clk node
  cpufreq: armada-37xx: Fix setting TBG parent for load levels
  clk: mvebu: armada-37xx-periph: remove .set_parent method for CPU PM
    clock

Pali Rohár (7):
  cpufreq: armada-37xx: Fix the AVS value for load L1
  clk: mvebu: armada-37xx-periph: Fix switching CPU freq from 250 Mhz to
    1 GHz
  clk: mvebu: armada-37xx-periph: Fix workaround for switching from L1
    to L0
  cpufreq: armada-37xx: Fix driver cleanup when registration failed
  cpufreq: armada-37xx: Fix determining base CPU frequency
  cpufreq: armada-37xx: Remove cur_frequency variable
  cpufreq: armada-37xx: Fix module unloading

 arch/arm64/boot/dts/marvell/armada-37xx.dtsi |   3 +-
 drivers/clk/mvebu/armada-37xx-periph.c       |  83 +++++++-------
 drivers/cpufreq/armada-37xx-cpufreq.c        | 111 +++++++++++++++----
 3 files changed, 135 insertions(+), 62 deletions(-)

-- 
2.20.1

