Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A417844382C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 23:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhKBWFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 18:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhKBWEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 18:04:54 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9698FC061203
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 15:02:19 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 420895EC9;
        Tue,  2 Nov 2021 22:02:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 420895EC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1635890539; bh=z7JqN0V/kJpMc6ONNBYeEyvnAIoTbnkPbVF3QDSXrtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=epq70gJl7bWpc2yx7+npXCMJb/BQ8BNsn0lBu+OHZdoeLuVHNWYdeWVSJ2fsJzs83
         HkT/3Kw4PZDGNwNlH37nnn+Gs+zuwvh9lQeG4KZjSlFxL/6es4s3AaOgikIwSEaBA2
         jwQJPY/JBvKIzPOL7f+wfpcmsb8nbBMeumYLxuHaXOY8u5e5rs2AUpLsV2vafckpYa
         yomywvojZto+X0JUF9BppPMrK6EF6qnz8gzOWKFRxTLnNdmAxM9d72G6BWpFNzM7DD
         mIR/kOAoTl1tor+my9A58JEtzwcnr82mQg7LDXsH+3dP2uVBHlbn8ePoo4241jfigF
         IO9IP8Pq1kIpg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Rubini <rubini@gnudd.com>
Subject: [PATCH 4/9] Remove unused header <linux/sdb.h>
Date:   Tue,  2 Nov 2021 16:01:58 -0600
Message-Id: <20211102220203.940290-5-corbet@lwn.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211102220203.940290-1-corbet@lwn.net>
References: <20211102220203.940290-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6a80b30086b8 ("fmc: Delete the FMC subsystem") removed the last user
of <linux/sdb.h>, but left the header file behind.  Nothing uses this file,
delete it now.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alessandro Rubini <rubini@gnudd.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 include/linux/sdb.h | 160 --------------------------------------------
 1 file changed, 160 deletions(-)
 delete mode 100644 include/linux/sdb.h

diff --git a/include/linux/sdb.h b/include/linux/sdb.h
deleted file mode 100644
index a2404a2bbd10..000000000000
--- a/include/linux/sdb.h
+++ /dev/null
@@ -1,160 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This is the official version 1.1 of sdb.h
- */
-#ifndef __SDB_H__
-#define __SDB_H__
-#ifdef __KERNEL__
-#include <linux/types.h>
-#else
-#include <stdint.h>
-#endif
-
-/*
- * All structures are 64 bytes long and are expected
- * to live in an array, one for each interconnect.
- * Most fields of the structures are shared among the
- * various types, and most-specific fields are at the
- * beginning (for alignment reasons, and to keep the
- * magic number at the head of the interconnect record
- */
-
-/* Product, 40 bytes at offset 24, 8-byte aligned
- *
- * device_id is vendor-assigned; version is device-specific,
- * date is hex (e.g 0x20120501), name is UTF-8, blank-filled
- * and not terminated with a 0 byte.
- */
-struct sdb_product {
-	uint64_t		vendor_id;	/* 0x18..0x1f */
-	uint32_t		device_id;	/* 0x20..0x23 */
-	uint32_t		version;	/* 0x24..0x27 */
-	uint32_t		date;		/* 0x28..0x2b */
-	uint8_t			name[19];	/* 0x2c..0x3e */
-	uint8_t			record_type;	/* 0x3f */
-};
-
-/*
- * Component, 56 bytes at offset 8, 8-byte aligned
- *
- * The address range is first to last, inclusive
- * (for example 0x100000 - 0x10ffff)
- */
-struct sdb_component {
-	uint64_t		addr_first;	/* 0x08..0x0f */
-	uint64_t		addr_last;	/* 0x10..0x17 */
-	struct sdb_product	product;	/* 0x18..0x3f */
-};
-
-/* Type of the SDB record */
-enum sdb_record_type {
-	sdb_type_interconnect	= 0x00,
-	sdb_type_device		= 0x01,
-	sdb_type_bridge		= 0x02,
-	sdb_type_integration	= 0x80,
-	sdb_type_repo_url	= 0x81,
-	sdb_type_synthesis	= 0x82,
-	sdb_type_empty		= 0xFF,
-};
-
-/* Type 0: interconnect (first of the array)
- *
- * sdb_records is the length of the table including this first
- * record, version is 1. The bus type is enumerated later.
- */
-#define				SDB_MAGIC	0x5344422d /* "SDB-" */
-struct sdb_interconnect {
-	uint32_t		sdb_magic;	/* 0x00-0x03 */
-	uint16_t		sdb_records;	/* 0x04-0x05 */
-	uint8_t			sdb_version;	/* 0x06 */
-	uint8_t			sdb_bus_type;	/* 0x07 */
-	struct sdb_component	sdb_component;	/* 0x08-0x3f */
-};
-
-/* Type 1: device
- *
- * class is 0 for "custom device", other values are
- * to be standardized; ABI version is for the driver,
- * bus-specific bits are defined by each bus (see below)
- */
-struct sdb_device {
-	uint16_t		abi_class;	/* 0x00-0x01 */
-	uint8_t			abi_ver_major;	/* 0x02 */
-	uint8_t			abi_ver_minor;	/* 0x03 */
-	uint32_t		bus_specific;	/* 0x04-0x07 */
-	struct sdb_component	sdb_component;	/* 0x08-0x3f */
-};
-
-/* Type 2: bridge
- *
- * child is the address of the nested SDB table
- */
-struct sdb_bridge {
-	uint64_t		sdb_child;	/* 0x00-0x07 */
-	struct sdb_component	sdb_component;	/* 0x08-0x3f */
-};
-
-/* Type 0x80: integration
- *
- * all types with bit 7 set are meta-information, so
- * software can ignore the types it doesn't know. Here we
- * just provide product information for an aggregate device
- */
-struct sdb_integration {
-	uint8_t			reserved[24];	/* 0x00-0x17 */
-	struct sdb_product	product;	/* 0x08-0x3f */
-};
-
-/* Type 0x81: Top module repository url
- *
- * again, an informative field that software can ignore
- */
-struct sdb_repo_url {
-	uint8_t			repo_url[63];	/* 0x00-0x3e */
-	uint8_t			record_type;	/* 0x3f */
-};
-
-/* Type 0x82: Synthesis tool information
- *
- * this informative record
- */
-struct sdb_synthesis {
-	uint8_t			syn_name[16];	/* 0x00-0x0f */
-	uint8_t			commit_id[16];	/* 0x10-0x1f */
-	uint8_t			tool_name[8];	/* 0x20-0x27 */
-	uint32_t		tool_version;	/* 0x28-0x2b */
-	uint32_t		date;		/* 0x2c-0x2f */
-	uint8_t			user_name[15];	/* 0x30-0x3e */
-	uint8_t			record_type;	/* 0x3f */
-};
-
-/* Type 0xff: empty
- *
- * this allows keeping empty slots during development,
- * so they can be filled later with minimal efforts and
- * no misleading description is ever shipped -- hopefully.
- * It can also be used to pad a table to a desired length.
- */
-struct sdb_empty {
-	uint8_t			reserved[63];	/* 0x00-0x3e */
-	uint8_t			record_type;	/* 0x3f */
-};
-
-/* The type of bus, for bus-specific flags */
-enum sdb_bus_type {
-	sdb_wishbone = 0x00,
-	sdb_data     = 0x01,
-};
-
-#define SDB_WB_WIDTH_MASK	0x0f
-#define SDB_WB_ACCESS8			0x01
-#define SDB_WB_ACCESS16			0x02
-#define SDB_WB_ACCESS32			0x04
-#define SDB_WB_ACCESS64			0x08
-#define SDB_WB_LITTLE_ENDIAN	0x80
-
-#define SDB_DATA_READ		0x04
-#define SDB_DATA_WRITE		0x02
-#define SDB_DATA_EXEC		0x01
-
-#endif /* __SDB_H__ */
-- 
2.31.1

