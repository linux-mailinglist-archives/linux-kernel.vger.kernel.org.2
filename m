Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81D340AAD8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhINJbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhINJbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:31:13 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D3FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 02:29:55 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:d46f:7eb5:4a37:9d14])
        by xavier.telenet-ops.be with bizsmtp
        id tlVr2500F2aSKa101lVr2l; Tue, 14 Sep 2021 11:29:54 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mQ4lC-004R8x-M8; Tue, 14 Sep 2021 11:29:50 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mQ4lC-000i9G-7c; Tue, 14 Sep 2021 11:29:50 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] nvmem: NVMEM_NINTENDO_OTP should depend on WII
Date:   Tue, 14 Sep 2021 11:29:49 +0200
Message-Id: <01318920709dddc4d85fe895e2083ca0eee234d8.1631611652.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Nintendo Wii and Wii U OTP is only present on Nintendo Wii and Wii U
consoles.  Hence add a dependency on WII, to prevent asking the user
about this driver when configuring a kernel without Nintendo Wii and Wii
U console support.

Fixes: 3683b761fe3a10ad ("nvmem: nintendo-otp: Add new driver for the Wii and Wii U OTP")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/nvmem/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 39854d43758be3fb..da414617a54d4b99 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -109,6 +109,7 @@ config MTK_EFUSE
 
 config NVMEM_NINTENDO_OTP
 	tristate "Nintendo Wii and Wii U OTP Support"
+	depends on WII || COMPILE_TEST
 	help
 	  This is a driver exposing the OTP of a Nintendo Wii or Wii U console.
 
-- 
2.25.1

