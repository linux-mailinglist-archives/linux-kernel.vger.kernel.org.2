Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB42943C7C4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 12:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241486AbhJ0Kgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 06:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241480AbhJ0Kgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 06:36:40 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40A8C061745
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 03:34:14 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so1944727wmz.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 03:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kShnARuTRPPZFlSFMm7BHRQXFKxgp6JyYFpoqdwp25M=;
        b=PO9lUskA+t3618cesdXDDaP60c8lid93P7uNqkqhtagUj0L2esD3J0EhRiBrWoMYeR
         77xWx+tnkvC2ASo5nxNkfh1Q8CHd67YgzfaENGE1Y7Ya8CJnh18KzyBgROmqQV+eC0Rm
         glhUTRAuKPBMjY4yWG/+cLtpnvOKo2yRXE8Fqw15/sfRVkpTnQkIh/YEWVswem24zYas
         eklk5OM5QaDW+YT699vv4/tXDF8Q5QT0U4Q1uYeLNbOFnwo0KEgtJJeyGhyWYT+GzW60
         uxsR79H/7zbXgw5TYItuEjXcBb4Dj7VB08n5tqPe9/2VjpGzkIOM8AHiOGQhIdQ31w4b
         W5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kShnARuTRPPZFlSFMm7BHRQXFKxgp6JyYFpoqdwp25M=;
        b=7kEKJaJLYFhvUAHQYG5/JwwCRXSlFvMNQdSkaQ8gApGhJ7hUXvEmxRoSKVTolWghv3
         0nnXKmkIHTZYSKE2DB55HK4jEGIBrxfeODlZ0i+t5H8MqD+jkSx5l1RJudgAQVE4mdNa
         XBFPFL7jxQOjn2iT5G6bTHnD9+k9g4UkwG98aQCchXiccKjFbbv0CUJxePcrqGVPTO3w
         D/tsedm4xB357g1TSTsvMORS4YjEVIb/nJhulcJyQYYrKlgvuUw6GLXBldChxEkKM2v2
         5I2QJ+Val0HvQRQYIHg01vZKOyvpkHgLJZm95ArojFkaUf2kY6OtbU5GrQnM5IFiWUj+
         8Vxg==
X-Gm-Message-State: AOAM532QfTVLeiDYlOoZ4Czr281vu9I/3UsuVQrDL3idTYxBqFVg0He7
        CqIquH27gUH0grcW7zzNf9Y=
X-Google-Smtp-Source: ABdhPJydBpbQVtRJStGXv54bTK9hMCpVvtAZ+RicKvbIWCFFtJ2igeaj2ZTHmERrN9jbpPREOxPqVw==
X-Received: by 2002:a7b:c40b:: with SMTP id k11mr4746048wmi.116.1635330853509;
        Wed, 27 Oct 2021 03:34:13 -0700 (PDT)
Received: from authentaworks.lxd (ip5f5be9ad.dynamic.kabel-deutschland.de. [95.91.233.173])
        by smtp.gmail.com with ESMTPSA id j10sm7140198wrx.94.2021.10.27.03.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 03:34:13 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     tudor.ambarus@microchip.com, michael@walle.cc, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH 4/4] mtd: spi-nor: micron-st: add mt25qu128abb and mt25ql128abb
Date:   Wed, 27 Oct 2021 10:33:52 +0000
Message-Id: <20211027103352.8879-5-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211027103352.8879-1-sshivamurthy@micron.com>
References: <20211027103352.8879-1-sshivamurthy@micron.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Added new Micron SPI NOR flashes to structure flash_info, which supports
advanced protection and security features.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/spi-nor/micron-st.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index b5d82e85fb92..2bebd76b091a 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -158,10 +158,17 @@ static const struct flash_info st_parts[] = {
 			      SECT_4K | SPI_NOR_QUAD_READ) },
 	{ "n25q064a",    INFO(0x20bb17, 0, 64 * 1024,  128,
 			      SECT_4K | SPI_NOR_QUAD_READ) },
+	{ "mt25qu128abb", INFO6(0x20bb18, 0x12008c, 64 * 1024,  256,
+				SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
+				SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB |
+				SPI_NOR_4BIT_BP | SPI_NOR_BP3_SR_BIT6) },
 	{ "n25q128a11",  INFO(0x20bb18, 0, 64 * 1024,  256,
 			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
 			      SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB |
 			      SPI_NOR_4BIT_BP | SPI_NOR_BP3_SR_BIT6) },
+	{ "mt25ql128abb", INFO6(0x20ba18, 0x12008c, 64 * 1024,  256,
+				SECT_4K | USE_FSR | SPI_NOR_HAS_LOCK |
+				SPI_NOR_QUAD_READ) },
 	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256,
 			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
 	{ "mt25ql256a",  INFO6(0x20ba19, 0x104400, 64 * 1024,  512,
-- 
2.25.1

