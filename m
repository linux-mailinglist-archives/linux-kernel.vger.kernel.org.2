Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD84145735D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 17:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbhKSQsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 11:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbhKSQsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 11:48:06 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD81C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:45:04 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id g28so9133552pgg.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=ivqtHuQQy+Ti1nGZM78VH3NnxqlTHSj7efazweFJjBg=;
        b=xCJz84KUacA0+N0Ca6TRoBqmuuLTgLoHxBPbMdmvVVYr2Z4lQ6x7ziqa7G8DjcIsXB
         35wAgPJ+2MeGBdtBQtGakgnIhw+JBChvxlxedWkQmm5vhkm/oVEJm3gH6VvZEWF1V5hi
         7HOYHSf2NMWSnt5Y0MdH4A3TOPJZXzcx8fjmth/fkMEoz+jfsCvusR8n3HgeTurfWkf/
         AI9y4j9vwb7624GPrW/ggtfsZqjDohsws3KxSHl9ZX0n7vdy6YLvAfwjX/Ao9if16p29
         QiYcsLjQX0GaC8/7rBPfudJ64y2lrnenoJZyvxBek8mTcC9DRWsMj2HKcFGnA8l6j3A6
         xHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=ivqtHuQQy+Ti1nGZM78VH3NnxqlTHSj7efazweFJjBg=;
        b=Te2YK8nByez3yzF5Hdxiu2umQpjvDDJGkfoB2XWBZvg1V1T8EUQRegG982lyplMdLB
         RusJIy8upPaSyPDHAIDf5AEjEbjtyHmO6Efwx00hzlDm+pARWcV8veBAdGe+np34LTle
         cBpsoAhER6vLwhymSopJq+zj7hYknqznkVxv5I+kxgKOwv1tO0Am4HH/L5Q0mmTATfL5
         PmmBZwc7lkRCq48HMJxSohtVRo6KNt2Yp+iBU3/uD0kgVmIWqFKSnpv7fwH/2G6Mi7X3
         aZ+uGHZ3WszNW2IFuQcvARl43YM1QFpVHsYz6tho1L3zeDPnEkLIMDcHZgMklE6cquMa
         tZDw==
X-Gm-Message-State: AOAM530c2ZhlZ8oEuQbhxKGffKfm5AAF4YsZsvZy7ULMCx+O40u9dbqw
        k7rwbQxbGVav8f9vcWlTZbxarg==
X-Google-Smtp-Source: ABdhPJyHrtCKVEz3g1W4YC/nDDEb0i8GXYsPXYbT0SIo742e2HT/EXNSMRC4MWwkFtknpt95l9iQMQ==
X-Received: by 2002:a05:6a00:1399:b0:49f:ae7d:cda6 with SMTP id t25-20020a056a00139900b0049fae7dcda6mr24039382pfg.10.1637340303855;
        Fri, 19 Nov 2021 08:45:03 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id h25sm207718pgm.33.2021.11.19.08.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 08:45:03 -0800 (PST)
Subject: [PATCH 10/12] RISC-V: defconfigs: Remove redundant CONFIG_POWER_RESET
Date:   Fri, 19 Nov 2021 08:44:11 -0800
Message-Id: <20211119164413.29052-11-palmer@rivosinc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211119164413.29052-1-palmer@rivosinc.com>
References: <20211119164413.29052-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        anup.patel@wdc.com, heinrich.schuchardt@canonical.com,
        atish.patra@wdc.com, bin.meng@windriver.com,
        sagar.kadam@sifive.com, damien.lemoal@wdc.com, axboe@kernel.dk,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

As of ab7fbad0c7d7 ("riscv: Fix unmet direct dependencies built based on
SOC_VIRT") we select CONFIG_POWER_RESET=y along with CONFIG_SOC_VIRT,
which is already in defconfig.  This make setting CONFIG_POWER_RESET in
the defconfigs redundant, so remove it to remain consistent with
savedefconfig.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/configs/defconfig      | 1 -
 arch/riscv/configs/rv32_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index ec9540392df7..a72dbd74b93d 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -74,7 +74,6 @@ CONFIG_SPI_SIFIVE=y
 # CONFIG_PTP_1588_CLOCK is not set
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SIFIVE=y
-CONFIG_POWER_RESET=y
 CONFIG_DRM=m
 CONFIG_DRM_RADEON=m
 CONFIG_DRM_NOUVEAU=m
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index 1f6808aa1261..8b56a7f1eb06 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -70,7 +70,6 @@ CONFIG_HW_RANDOM_VIRTIO=y
 CONFIG_SPI=y
 CONFIG_SPI_SIFIVE=y
 # CONFIG_PTP_1588_CLOCK is not set
-CONFIG_POWER_RESET=y
 CONFIG_DRM=y
 CONFIG_DRM_RADEON=y
 CONFIG_DRM_VIRTIO_GPU=y
-- 
2.32.0

