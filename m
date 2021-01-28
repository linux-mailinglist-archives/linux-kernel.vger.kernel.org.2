Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634E3307D7F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhA1SKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhA1SGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:06:34 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A46AC0611BC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:03:03 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v15so6355720wrx.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Kb16WgSiv4QCUnRh1QxmaZs22WYIlooIF+TJGzI06k=;
        b=uY4tumtm8YxOImI9ocT2XoW8jBaWMaHHZiFSt4FEuXv9bdzGN9Xj+osrJCQGerKD/P
         sSgI2L4hb4qjMt7aVvkNRMKuZ6rj0dJ7y396CeWuYr+K5hDfG0ixH0Mwj/jWYlHVTDDO
         ZUAiIdWz/0iGZCKsHCQSS9R4hek/lPkeCB40HrUQRcjNokwQKG7GwmrVAvVR8eDczZY0
         LO5KJDXrrVmjxg+x/mySwzjkG8UG/5mvat7AgllpymQ6UA2+ssRaQdKkCoCFvnNseHJ0
         3ZT37UgpKQ+OBZllJcKKbHglPTxM3GSUNQYr92qAEjJ4y/Jk3R+/h3imz9I/qP1n3zZr
         qXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Kb16WgSiv4QCUnRh1QxmaZs22WYIlooIF+TJGzI06k=;
        b=uBBv0NPuHuPHX3cmdSxfUFGJ0IoZPSizzVkZJfj8diNMKw6uscklI9pE5K1au0J+qV
         7kyyy5r+fn0c0NZrpth1fs0VjfoICoFzaDM0kLnOVTN6IpUgncv8UwsoQsSAip1oE2d8
         z9nAV9N7Z/cpoJrWKH5fu7hMFHPP/IuZFvqh7QZ/fjQ5mYbjI5DJC1kvJZCNb3iVG6vx
         z7cH/UvjI4ejQzxvatNoK47ZoPyV1iW37fqGX+jrT7IgaMtgmf+NNp21/4R/aQtXBGJl
         21XvHxdU7hyaDexl475cfkz1NbMQwh6C//9pQWLMXKo7ja3SBIw86qy07oJrLw+FTNd1
         WDrg==
X-Gm-Message-State: AOAM530gPrxDYiYDCLQGF3JzpH92ap9IHTxWVtt9pzOlANNbdUalUtUm
        b9aWSKr0uAgoLLq3cEQB0Qb7005O3mOvpcoD
X-Google-Smtp-Source: ABdhPJy0q7zmSeCorDLSuCQkUi+uvpRw9C9SmnsugADQK5tQ2YEsviEZpL2JQSzXWWVaz05j2FO+8w==
X-Received: by 2002:adf:dc88:: with SMTP id r8mr238462wrj.401.1611856982219;
        Thu, 28 Jan 2021 10:03:02 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:03:01 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 16/20] ata: ahci_brcm: Ignore -Woverride-init
Date:   Thu, 28 Jan 2021 18:02:35 +0000
Message-Id: <20210128180239.548512-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128180239.548512-1-lee.jones@linaro.org>
References: <20210128180239.548512-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some ATA drivers use the SCSI host template, a series of interwoven
macros, to aid with initialisation.  Some of these macros conflict,
resulting in the over-writing of previously set values.

This is known behaviour and can be safely ignored.

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/ata/ahci_brcm.c:22:
 drivers/ata/ahci.h:387:16: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/ahci_brcm.c:414:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:387:16: note: (near initialization for ‘ahci_platform_sht.can_queue’)
 drivers/ata/ahci_brcm.c:414:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/ahci_brcm.c:414:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: note: (near initialization for ‘ahci_platform_sht.sdev_attrs’)
 drivers/ata/ahci_brcm.c:414:2: note: in expansion of macro ‘AHCI_SHT’

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index cf851f5a4e7fd..a6755a524efa0 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS_acard-ahci.o		= $(call cc-disable-warning, override-init)
+CFLAGS_ahci_brcm.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_ceva.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_dm816.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_mtk.o		= $(call cc-disable-warning, override-init)
-- 
2.25.1

