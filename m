Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68373938BA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 00:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbhE0Wd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 18:33:56 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:42896 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbhE0Wdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 18:33:54 -0400
Received: by mail-oi1-f182.google.com with SMTP id c196so2340724oib.9;
        Thu, 27 May 2021 15:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sza0E/+uMB5EM/AhsG1a1nI/szLc6wK8lbW1ACNSEJo=;
        b=Sl7Br8nWqTrjpGclCN59/AsXepyfGH3jgGf1wp5HH81hcOrIZJmEwp+ghy818cQ0YA
         KlKj4mhpdCvkQwWFPWP4qTvI7uWnsw4U0zWX8P7uA+Lv4PyuJ9hcFdKBCcPJjKG2ToGI
         QrNKZ9gdUohDoO4iL4pd4JBPc8GBczhIeMCir+zSIMAWOlBmRwo3bklXxKAl7yekfkrP
         NsQUz4sdoMdztydCGj0bIyB9r7oQ/UxvIcy0FSKNhlujgNrf7i/Y1+oRBh53zgymVVFX
         LYBgubXIG0RyX9Z5/a6l02vYp5ruRCSWADdYol8H397H6BbnBgJ5982JshaJMdz6bC6/
         kUjQ==
X-Gm-Message-State: AOAM531T9cisJU2KFS3REUfAA2kNVjjokagvJuUs478Ywo3Cj0n72khT
        53m/zlo7jZNpXlZnV04NryRFDa0aoA==
X-Google-Smtp-Source: ABdhPJw9Y8cgQTbb5o9wbbrSLaSAyQsXhRIZd6foOJi06scZcPdfc87su3ecs3OLvzwpiG493Df+Uw==
X-Received: by 2002:aca:4b16:: with SMTP id y22mr3874459oia.125.1622154739243;
        Thu, 27 May 2021 15:32:19 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id q14sm766288ota.31.2021.05.27.15.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 15:32:18 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] of: Drop reserved mem dependency on DMA_DECLARE_COHERENT and DMA_CMA
Date:   Thu, 27 May 2021 17:32:17 -0500
Message-Id: <20210527223217.1572631-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reserved memory regions can be used for more than just DMA regions, so
only enabling on DMA_DECLARE_COHERENT (via HAS_DMA) or DMA_CMA is wrong.
This effectively doesn't matter except for the few cases arches select
NO_DMA.

At least, these users of RESERVEDMEM_OF_DECLARE depend on reserved memory
support:

arch/riscv/mm/init.c:RESERVEDMEM_OF_DECLARE(elfcorehdr, "linux,elfcorehdr", elfcore_hdr_setup);
drivers/memory/tegra/tegra210-emc-table.c:RESERVEDMEM_OF_DECLARE(tegra210_emc_table, "nvidia,tegra210-emc-table",
drivers/soc/fsl/qbman/bman_ccsr.c:RESERVEDMEM_OF_DECLARE(bman_fbpr, "fsl,bman-fbpr", bman_fbpr);
drivers/soc/fsl/qbman/qman_ccsr.c:RESERVEDMEM_OF_DECLARE(qman_fqd, "fsl,qman-fqd", qman_fqd);
drivers/soc/fsl/qbman/qman_ccsr.c:RESERVEDMEM_OF_DECLARE(qman_pfdr, "fsl,qman-pfdr", qman_pfdr);

Let's simplify things and enable OF_RESERVED_MEM when OF_EARLY_FLATTREE is
enabled.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Rob Herring <robh@kernel.org>
---
This is needed to prevent build break on UML with this patch:

https://lore.kernel.org/lkml/20210527193841.1284169-1-robh@kernel.org/

 drivers/of/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 18450437d5d5..3dfeae8912df 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -75,9 +75,7 @@ config OF_NET
 	def_bool y
 
 config OF_RESERVED_MEM
-	bool
-	depends on OF_EARLY_FLATTREE
-	default y if DMA_DECLARE_COHERENT || DMA_CMA
+	def_bool OF_EARLY_FLATTREE
 
 config OF_RESOLVE
 	bool
-- 
2.27.0

