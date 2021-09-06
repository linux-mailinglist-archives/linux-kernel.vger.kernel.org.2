Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA9F401960
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 12:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241482AbhIFKBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 06:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhIFKBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 06:01:48 -0400
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BF4C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 03:00:43 -0700 (PDT)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mNBQf-00C7qA-AC
        for linux-kernel@vger.kernel.org; Mon, 06 Sep 2021 12:00:41 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mNBQ3-00C7oT-15; Mon, 06 Sep 2021 12:00:03 +0200
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mNBQ2-00HYaC-AH; Mon, 06 Sep 2021 12:00:02 +0200
From:   Bert Vermeulen <bert@biot.com>
To:     Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Bert Vermeulen <bert@biot.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     John Crispin <john@phrozen.org>
Subject: [PATCH] ARM: decompress: Use /memreserve/ DTS nodes when validating memory
Date:   Mon,  6 Sep 2021 11:59:28 +0200
Message-Id: <20210906095930.4184449-1-bert@biot.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the bootloader needs the start of memory to be preserved, for example
because it dropped the Trusted Firmware blob there, this chunk of memory
shouldn't be used by the kernel.

To avoid adding yet another SoC-specific text offset to arch/arm/Makefile,
this patch allows for a /memreserve/ entry in the DTS to mark off the
memory chunk instead.

Signed-off-by: Bert Vermeulen <bert@biot.com>
---
 arch/arm/boot/compressed/fdt_check_mem_start.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/fdt_check_mem_start.c b/arch/arm/boot/compressed/fdt_check_mem_start.c
index 62450d824c3c..15a20c60155e 100644
--- a/arch/arm/boot/compressed/fdt_check_mem_start.c
+++ b/arch/arm/boot/compressed/fdt_check_mem_start.c
@@ -64,7 +64,7 @@ uint32_t fdt_check_mem_start(uint32_t mem_start, const void *fdt)
 	uint32_t addr_cells, size_cells, base;
 	uint32_t fdt_mem_start = 0xffffffff;
 	const fdt32_t *reg, *endp;
-	uint64_t size, end;
+	uint64_t rsvaddr, size, end;
 	const char *type;
 	int offset, len;
 
@@ -74,6 +74,19 @@ uint32_t fdt_check_mem_start(uint32_t mem_start, const void *fdt)
 	if (fdt_magic(fdt) != FDT_MAGIC)
 		return mem_start;
 
+	for (offset = fdt_off_mem_rsvmap(fdt); ; offset += 16) {
+		rsvaddr = get_val(fdt + offset, 8);
+		size = get_val(fdt + offset + 8, 8);
+
+		if (!rsvaddr && !size)
+			break;
+
+		end = rsvaddr + size;
+		if (mem_start >= rsvaddr && mem_start <= end)
+			/* Relocate past reserved block */
+			mem_start = round_up(end, SZ_2M);
+	}
+
 	/* There may be multiple cells on LPAE platforms */
 	addr_cells = get_cells(fdt, "#address-cells");
 	size_cells = get_cells(fdt, "#size-cells");
-- 
2.25.1

