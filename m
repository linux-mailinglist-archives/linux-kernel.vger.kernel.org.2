Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA728359680
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 09:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbhDIHh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 03:37:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:32802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhDIHhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 03:37:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0793061107;
        Fri,  9 Apr 2021 07:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617953832;
        bh=d6cbefCh5bkB5HgFSHihkPjBZOxuFyP52IfCYR/cdZ8=;
        h=From:To:Cc:Subject:Date:From;
        b=SDH83jlVnBICGVRPXA/Af3UdQbhd9SDEc+E1C3of3f7NiUmiqua82bPo3ZRP+jVwJ
         ABuwxKEg0ks/99bU2DS5rvFYd6ZTlPbA2pTByAH2+5I0P1U+oNCwIo/mfq80+h+zeo
         aFCRVydfPR9plmtvEEgbsPRXbvoRyiTWEvO4WG6RuHz5UwgMM7cdilzkZLJAX42eg8
         lPhQHwsF9cR3IpYR4P3TXknjODEyIxznkA5fBVfLvq1slwbe5S/1bIS7Z9xSjskvte
         o8aHcs5QtpFrzDcrJrjxV0u86CtNSDxRQjxudJ0bbzUlvw2+usuQe3/JfZYK5ZGGDW
         LbBENEdnjmJwQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alexander Shiyan <shc_work@mail.ru>
Cc:     "kernelci . org bot" <bot@kernelci.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: clps711x: fix missing interrupt parent
Date:   Fri,  9 Apr 2021 09:36:53 +0200
Message-Id: <20210409073707.1786613-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The kernelci.org bot reports a build time regression:

arch/arm/boot/dts/ep7209.dtsi:187.17-192.4: Warning (interrupts_property): /keypad: Missing interrupt-parent

There is only one interrupt controller in this SoC, so I assume this
is the parent.

Fixes: 2bd86203acf3 ("ARM: dts: clps711x: Add keypad node")
Reported-by: kernelci.org bot <bot@kernelci.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I applied this fixup on top of the arm/dt branch, so it will be part of
linux-next and the v5.13 pull requests.

 arch/arm/boot/dts/ep7209.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/ep7209.dtsi b/arch/arm/boot/dts/ep7209.dtsi
index 40a277370fd0..57bdad2c1994 100644
--- a/arch/arm/boot/dts/ep7209.dtsi
+++ b/arch/arm/boot/dts/ep7209.dtsi
@@ -186,6 +186,7 @@ syscon3: syscon@80002200 {
 
 	keypad: keypad {
 		compatible = "cirrus,ep7209-keypad";
+		interrupt-parent = <&intc>;
 		interrupts = <16>;
 		syscon = <&syscon1>;
 		status = "disabled";
-- 
2.29.2

