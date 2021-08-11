Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E033E8AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 09:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbhHKHPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 03:15:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234855AbhHKHPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 03:15:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 642C7601FE;
        Wed, 11 Aug 2021 07:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628666078;
        bh=iS6H6YaZt439MG1gVB47NVuu85jYESbYxNTfU/8PEnM=;
        h=From:To:Cc:Subject:Date:From;
        b=gbv4Ri4duexJ5RJFW3Kh1RGsYH7tugv5mOIUFgeSw23fBQU7aHy7FXcUzZ2tz0k6n
         gsL6KuATKR5ELh+ews9bEOgYX7UiwDupfxonk/zg+rpa0VujRVSlzeOxUTEo5QCocL
         mE1e0CrNErmqCh+V7FA2EYtXedk7vrQUMTch72D0gOyKhASbKOlZeUjS+nRx92g5TT
         bQn4Lx5p6wf4bHRW5iont99+IQ1SzXaXWIiBF00/ZmjU9xrQ2tJSfYgCMhGgJSuAZb
         mTmtG4em56A386xa2Hw8x9lzFBvAVJit8jOV/OYxTpwzpMVgmJWZKna35+V2FJPU+k
         R+xO5Xk5I5Eqw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mDiRc-00BrrA-MV; Wed, 11 Aug 2021 09:14:32 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: HiSilicon: hi3660: address a PCI warning
Date:   Wed, 11 Aug 2021 09:14:31 +0200
Message-Id: <934f397d227ea589a16c89f1ee9c6f199c662093.1628666047.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver is registered, it produces a warning when
registering the PCI bridge:

	[    5.363450] pci_bus 0000:00: root bus resource [bus 00-01]
	[    5.396998] pci_bus 0000:01: busn_res: can not insert [bus 01-ff] under [bus 00-01] (conflicts with (null) [bus 00-01])
	[    5.284831] pci 0000:00:00.0: PCI bridge to [bus 01-ff]

The reason is that the bus-range is wrong. Address it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index f1ec87c05842..cf2079590ad8 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -1002,7 +1002,7 @@ pcie@f4000000 {
 			      <0x0 0xf3f20000 0x0 0x40000>,
 			      <0x0 0xf5000000 0x0 0x2000>;
 			reg-names = "dbi", "apb", "phy", "config";
-			bus-range = <0x0  0x1>;
+			bus-range = <0x0  0xff>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-- 
2.31.1


