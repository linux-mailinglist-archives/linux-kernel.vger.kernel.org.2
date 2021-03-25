Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7203497A9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhCYRMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:12:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229847AbhCYRL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:11:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2B8D61A16;
        Thu, 25 Mar 2021 17:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616692316;
        bh=jzOzmPhskJoEbVzZw6Hn3YSWVDp0OyjbC2KFfswy5Wo=;
        h=From:To:Cc:Subject:Date:From;
        b=og+8zQUg1o9HUeTgAMJnb2YW76z20gOeMdOpFJnR1tivXrKHAITv12Jp5IM4dESxJ
         oWJQRcalzg0Q6vaBMc2ZnShZo1EWbETmMPcd1nGXhMbo/svG/oLe0goGRl874tOkyQ
         tKnQU+cssUi7KlTji0FVjKckIfSjdJ2JsBXaKX/w145OleWI+IPLUSieQtygzNBEBb
         gJryh2fJJIZPu62BN6CjrU5xn/o9hM7VWY0fj2Un+E/5LBbKb5GYzCBLe3d2nqK6pS
         aRZSeDVarIuOkbKqZUwv2NFK5sqtZ5lJBSlIYNRq4Ww7c/OA2ZnvY+6CzLIFrUrV3v
         +MXBa/PVgfRzg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 1/2] MAINTAINERS: update CZ.NIC's Turris information
Date:   Thu, 25 Mar 2021 18:11:22 +0100
Message-Id: <20210325171123.28093-1-kabel@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all the files maintained by Turris team, not only for MOX, but also
for Omnia. Change website.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 MAINTAINERS | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d23b0ec0c90..2cf388c89196 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1790,19 +1790,26 @@ F:	drivers/net/ethernet/cortina/
 F:	drivers/pinctrl/pinctrl-gemini.c
 F:	drivers/rtc/rtc-ftrtc010.c
 
-ARM/CZ.NIC TURRIS MOX SUPPORT
+ARM/CZ.NIC TURRIS SUPPORT
 M:	Marek Behun <marek.behun@nic.cz>
 S:	Maintained
-W:	http://mox.turris.cz
+W:	https://www.turris.cz/
 F:	Documentation/ABI/testing/debugfs-moxtet
 F:	Documentation/ABI/testing/sysfs-bus-moxtet-devices
 F:	Documentation/ABI/testing/sysfs-firmware-turris-mox-rwtm
 F:	Documentation/devicetree/bindings/bus/moxtet.txt
 F:	Documentation/devicetree/bindings/firmware/cznic,turris-mox-rwtm.txt
 F:	Documentation/devicetree/bindings/gpio/gpio-moxtet.txt
+F:	Documentation/devicetree/bindings/leds/cznic,turris-omnia-leds.yaml
+F:	Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.txt
 F:	drivers/bus/moxtet.c
 F:	drivers/firmware/turris-mox-rwtm.c
+F:	drivers/leds/leds-turris-omnia.c
+F:	drivers/mailbox/armada-37xx-rwtm-mailbox.c
 F:	drivers/gpio/gpio-moxtet.c
+F:	drivers/watchdog/armada_37xx_wdt.c
+F:	include/dt-bindings/bus/moxtet.h
+F:	include/linux/armada-37xx-rwtm-mailbox.h
 F:	include/linux/moxtet.h
 
 ARM/EZX SMARTPHONES (A780, A910, A1200, E680, ROKR E2 and ROKR E6)
-- 
2.26.2

