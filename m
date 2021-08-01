Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77203DCE2A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 01:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhHAXpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 19:45:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50972 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbhHAXpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 19:45:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 700991F41069
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 2/3] mtdblock: Add comment about UBI block devices
Date:   Sun,  1 Aug 2021 20:45:08 -0300
Message-Id: <20210801234509.18774-7-ezequiel@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210801234509.18774-1-ezequiel@collabora.com>
References: <20210801234509.18774-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a surprisingly large number of tutorials
that suggest using mtdblock to mount SquashFS filesystems
on flash devices, including NAND devices.

Given this approach is suboptimal than using UBI, and given
the UBI block device layer was introduced many years ago
specifically with this use case in mind, add a small
comment inviting users and developers to consider UBI block.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/mtd/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 32bed6c63863..91cdbbd44317 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -151,6 +151,9 @@ config MTD_BLOCK_RO
 	  You do not need this option for use with the DiskOnChip devices. For
 	  those, enable NFTL support (CONFIG_NFTL) instead.
 
+comment "Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK."
+	depends on MTD_BLOCK || MTD_BLOCK_RO
+
 config FTL
 	tristate "FTL (Flash Translation Layer) support"
 	depends on BLOCK
-- 
2.32.0

