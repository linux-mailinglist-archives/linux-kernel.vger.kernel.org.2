Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD0132C2B4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349278AbhCDAB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:01:57 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51990 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387983AbhCCUJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 15:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614802193; x=1646338193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MbkB+pidnFlT+lkjs/WTIQAzRmvF8TaNvXIHT9jYWmo=;
  b=pjyLbm5OM4rEdNAxk0pQTivSliLuprwE+KVhpCCv9KtOt0BGjOs6qv45
   rtMOsUibLZxL8B9qO0dtIP/TCW0uAMPSqtjWhgpz6/RYx+/C4qxNRu51Q
   70yW4qUXCDBYY5t7kBsVcUlmdf97KAXkYs549Gjw3XAYET+jgEqk52YdB
   9zPz3ivpCgmyR+kD25ZIZm2gO+VdalYULD7NERo80myusfSVhUkcBIVyn
   JDiIhTMUXpMRKdZ0Er1ciccMsLzCoaayB7AoL8zARf8wnjHs8gqY4qUgy
   zmjDvG+W+/JJaJTQYy2Mwg3qm7jcBxuh2mBVRKZjLGBm/jplKyquMtm9P
   g==;
IronPort-SDR: lUalWc11nS68a15D0k3jzEwnWA3Awz0pavVfDqTctt252dSrz15+fbr6+CfF146B7NhPwRfPeg
 mASlIc1uU8JderN3ST7F38rgjuZKvtzm+2U5oDk64i0Sic+Dclm8X6at+7QcGFtpapXS6ltReZ
 107eeCe0ydForQLHKgR1N3AmNLLPOdZedKuQvt66vJQLcEFZWyiUopisn8zXBA6kYmt/X/vzOi
 pc83sFz/Rx0i/AIxouMiq4alTy3BS5RFdjA+BY+vgp7mmkp3/ztF+aANF8EeNUSdoxnkwLN8dG
 EAk=
X-IronPort-AV: E=Sophos;i="5.81,220,1610380800"; 
   d="scan'208";a="161271865"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2021 04:06:59 +0800
IronPort-SDR: QD/DcWbr/tAox8ECSUruRCEQtt76zybnBsQrP1qB8qFu3urMyh+HPe8EBIL/0jhW4CDqoivjYf
 u6Rajoj5Muhh+1BgHK3hwONEtA1tQw7IsIXTL0VYuiTlDqK2+HlFDH8y+szgJZAOZr1opV/BVQ
 Gw611O4oKJ2ZLTWzOgJqybb4n8BK4P99jpJpAjwjh7kKnmmkqMJfE3ZAZhH48n7qxvtfjTBBec
 7RsFVVrMSC8I1IzBftXWgczDk92oYZw8MtxdfJS/c8YlYgibfU45O9NhTdcpEtvW7vVDamedq0
 xq0+tDbMDkGica1S3vjpE9E6
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 11:50:04 -0800
IronPort-SDR: 4MXPqalwVpAnMLzVq/qqbDyC/BDbt7t44EQFJFZNWY5qeccrK+Jz6B3ZGMt74YPkgFGnbfsRba
 Sb7iv5frJlYiIU9mHlKhU130l8yJMFHRzkzKATZJhoiHLRxkVqxDKS+Ajn3ZMjriZ/rdgckjHW
 g7Js5kJXiKYJSCzL7RfTXbXEXdgjbu/gWjd2pX6WXTFwYqIJgIvpPvyTPGHlWcy2fIVdcd2Gcc
 1NFtk42f+5eWm4UDshdiBjFaSH+i2sVfAH/O0HuRaJmLRS8rgGs0t9aL9hvyAguNRVgSBjn/kY
 eF8=
WDCIronportException: Internal
Received: from ind002560.ad.shared (HELO jedi-01.hgst.com) ([10.86.48.105])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Mar 2021 12:06:59 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Bin Meng <bin.meng@windriver.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>, Conor.Dooley@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Ivan.Griffin@microchip.com, Lewis.Hanly@microchip.com
Subject: [PATCH v4 4/5] RISC-V: Enable Microchip PolarFire ICICLE SoC
Date:   Wed,  3 Mar 2021 12:02:52 -0800
Message-Id: <20210303200253.1827553-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210303200253.1827553-1-atish.patra@wdc.com>
References: <20210303200253.1827553-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Microchip PolarFire ICICLE soc config in defconfig.
It allows the default upstream kernel to boot on PolarFire ICICLE board.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
---
 arch/riscv/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 6c0625aa96c7..1f2be234b11c 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -16,6 +16,7 @@ CONFIG_EXPERT=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
+CONFIG_SOC_MICROCHIP_POLARFIRE=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
 CONFIG_JUMP_LABEL=y
@@ -82,6 +83,9 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_UAS=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_CADENCE=y
 CONFIG_MMC=y
 CONFIG_MMC_SPI=y
 CONFIG_RTC_CLASS=y
-- 
2.25.1

