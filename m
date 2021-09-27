Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC6E419600
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbhI0OMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:12:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234679AbhI0OM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:12:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DEA760F94;
        Mon, 27 Sep 2021 14:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632751850;
        bh=i+bavvwQSsZR/U2SSCUdxSOShS7k+cqLTQgJdlk5IC8=;
        h=From:To:Cc:Subject:Date:From;
        b=o/pHsBWfcf3iVLu+gS9z4G9+dsiEq3G89a8BmNR1uDI5utMJLc3P+zqcY2f8K80Ga
         222m135Pjl2LSUsQE8wBNHS2Mu9Qm7UKwkKhl5g+TmAlF0QsRjwsAOl/9L8bp83fc4
         YPTstuBjtKWe7l7wnAeztelZ9JrCK2sIFeWl6/NygMTukNT4Oan0SnD0fosC0uAWn4
         vms4GHpHJj3lbF1u+rurpBhgFZxTW/5kzcDLCL0jQwEi7+1sBYhR+Swo+TpfhBa0JI
         C7AxpPH96ijl0WVt6Cxz0+nOBp7/vfv4//itZ53thmYOptaMn02kAgdKbBxZ7GpkQO
         WO/tHMDlJCZxg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [RFC] mtd: fixup CFI on ixp4xx
Date:   Mon, 27 Sep 2021 16:10:37 +0200
Message-Id: <20210927141045.1597593-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

drivers/mtd/maps/ixp4xx.c requires MTD_CFI_BE_BYTE_SWAP to be set
in order to compile.

drivers/mtd/maps/ixp4xx.c:57:4: error: #error CONFIG_MTD_CFI_BE_BYTE_SWAP required

This patch avoids the #error output by enforcing the policy in
Kconfig. Not sure if this is the right approach, but it helps doing
randconfig builds.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Any other ideas for how to address it?
---
 drivers/mtd/chips/Kconfig | 2 ++
 drivers/mtd/maps/Kconfig  | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/chips/Kconfig b/drivers/mtd/chips/Kconfig
index aef14990e5f7..19726ebd973d 100644
--- a/drivers/mtd/chips/Kconfig
+++ b/drivers/mtd/chips/Kconfig
@@ -55,12 +55,14 @@ choice
 	  LITTLE_ENDIAN_BYTE, if the bytes are reversed.
 
 config MTD_CFI_NOSWAP
+	depends on !ARCH_IXP4XX || CPU_BIG_ENDIAN
 	bool "NO"
 
 config MTD_CFI_BE_BYTE_SWAP
 	bool "BIG_ENDIAN_BYTE"
 
 config MTD_CFI_LE_BYTE_SWAP
+	depends on !ARCH_IXP4XX
 	bool "LITTLE_ENDIAN_BYTE"
 
 endchoice
diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index aaa164b977fe..4945caa88345 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -302,7 +302,7 @@ config MTD_DC21285
 
 config MTD_IXP4XX
 	tristate "CFI Flash device mapped on Intel IXP4xx based systems"
-	depends on MTD_CFI && MTD_COMPLEX_MAPPINGS && ARCH_IXP4XX
+	depends on MTD_CFI && MTD_COMPLEX_MAPPINGS && ARCH_IXP4XX && MTD_CFI_ADV_OPTIONS
 	help
 	  This enables MTD access to flash devices on platforms based
 	  on Intel's IXP4xx family of network processors such as the
-- 
2.29.2

