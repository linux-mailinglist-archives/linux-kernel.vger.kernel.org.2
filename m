Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35B93240C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbhBXPZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbhBXOqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:46:42 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186CCC06121C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:42:55 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v15so2136491wrx.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Avv6ZnmbXhgqra1UyQEo1jRqhDV3UEf0fLOb0eDNvQ8=;
        b=xZoc3hBIVPJJapaC73bDrdlHYiWZTC8Gd5hvzDsj5M/0Gmhz+TXWHtcm5ek2a1poNV
         ufUQz4YRuGlHWn+djwpPnG9idrsPzvLehgF63M9vJvSXI8aVjU4M97Uy+pXPo2/Us43J
         pEqwK11wGB8W530jG5HXEptjsuh/Y36OJDe1Dmep04wvfMYezvrwLaQ0al88G8e6zgRU
         Vr7hrMVjWud3ibSLkxTEMDiQ1mDXzl2/mZCo16DovjoH1aOD0X5nL90um2wcxiB54xyo
         Pie/uMq/0ZQfO4BXsL8cSZaHcFK29gXfL5l267/39eAo19HMzGdVIRcyqugLzSAV4IhR
         YPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Avv6ZnmbXhgqra1UyQEo1jRqhDV3UEf0fLOb0eDNvQ8=;
        b=q5k0o0T/AaBzGaPFxN/x6WDQHyI4E4pBzps65LAOO7XAvp+tuF/ce51pTeAAxbX53G
         6PUup2Gx2EwB1hEKYWEmJErMtO7wOz+erI3POwrYNmVBFwoiZxYqZzZ/v5syFjLxewEG
         dNYplQtlOxSEA4z37ycMz5EAKLCuc+M7pkPLYnml3mDFgtaGrtq0rNH7axLI1NFPcA2Y
         HswWkO4aQVzRnNIswmt++WisQPkBaibqEb3fXBvhTSn0rCH35cNV86d1e9yw5zhS9b+O
         zAe8jUJ7mXxlCbM/4WiWccawzCcGQLCoaoKGAKIGjD2m0DUVItB0A19FHyZIp11Sqj6f
         WnkQ==
X-Gm-Message-State: AOAM530kmbdx9N3cSKqcTWMGvBC4lsn8X7EP8g0Ix9bmM2FRPT2S4pUH
        LMxeCDircRE+JBgJZD4kd1abJw==
X-Google-Smtp-Source: ABdhPJxWR8fKAlpBPJGDCmIXiINikw6KX+dWZWtvj338MuerAgimT6gWJKuutkrnfT/iEhLRwvQXkg==
X-Received: by 2002:a5d:44d2:: with SMTP id z18mr32219677wrr.26.1614177773751;
        Wed, 24 Feb 2021 06:42:53 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-157-252.adsl.proxad.net. [82.252.157.252])
        by smtp.gmail.com with ESMTPSA id p3sm4170669wro.55.2021.02.24.06.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 06:42:53 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-mtd@lists.infradead.org (open list:NAND FLASH SUBSYSTEM)
Subject: [PATCH v2 8/9] mtd/drivers/nand: Use HZ macros
Date:   Wed, 24 Feb 2021 15:42:18 +0100
Message-Id: <20210224144222.23762-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210224144222.23762-1-daniel.lezcano@linaro.org>
References: <20210224144222.23762-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HZ unit conversion macros are available in units.h, use them and
remove the duplicate definition.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/mtd/nand/raw/intel-nand-controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/intel-nand-controller.c b/drivers/mtd/nand/raw/intel-nand-controller.c
index a304fda5d1fa..8d00191a4815 100644
--- a/drivers/mtd/nand/raw/intel-nand-controller.c
+++ b/drivers/mtd/nand/raw/intel-nand-controller.c
@@ -20,6 +20,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/units.h>
 #include <asm/unaligned.h>
 
 #define EBU_CLC			0x000
@@ -102,7 +103,6 @@
 
 #define MAX_CS	2
 
-#define HZ_PER_MHZ	1000000L
 #define USEC_PER_SEC	1000000L
 
 struct ebu_nand_cs {
-- 
2.17.1

