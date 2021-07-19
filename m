Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9701A3CDEB5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 17:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346340AbhGSPFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 11:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344231AbhGSOsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 10:48:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14B766140A;
        Mon, 19 Jul 2021 15:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626708437;
        bh=1fOpBQFPGJh3jYfnNThexnAEFH4o1IaAuITIQp2BZdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2rOkZsXhX0ohi0DK8Q0k1LdNov+KIAevl21/hGc+b5mezon09mvPXgCNC8VZGPkJ4
         Hq3MGtwn9SiK/IzYs4KOnNmq9xw73XaccNuYlwUTCj42tAcvLIOWHzmShLA4jRi05p
         l7LRuw9mJTZ6SgmlD4oQttboc9z3W+UvQvlHo/kY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aswath Govindraju <a-govindraju@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 310/315] ARM: dts: am335x: align ti,pindir-d0-out-d1-in property with dt-shema
Date:   Mon, 19 Jul 2021 16:53:19 +0200
Message-Id: <20210719144953.670503267@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210719144942.861561397@linuxfoundation.org>
References: <20210719144942.861561397@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aswath Govindraju <a-govindraju@ti.com>

[ Upstream commit 414bfe1d26b60ef20b58e36efd5363188a694bab ]

ti,pindir-d0-out-d1-in property is expected to be of type boolean.
Therefore, fix the property accordingly.

Fixes: 444d66fafab8 ("ARM: dts: add spi wifi support to cm-t335")
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am335x-cm-t335.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index 947c81b7aaaf..56a04d3086c3 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -552,7 +552,7 @@ status = "okay";
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi0_pins>;
-	ti,pindir-d0-out-d1-in = <1>;
+	ti,pindir-d0-out-d1-in;
 	/* WLS1271 WiFi */
 	wlcore: wlcore@1 {
 		compatible = "ti,wl1271";
-- 
2.30.2



