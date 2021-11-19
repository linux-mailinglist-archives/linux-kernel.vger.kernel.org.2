Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D35C457359
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 17:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236710AbhKSQsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 11:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236674AbhKSQsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 11:48:02 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C271EC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:45:00 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id m14so9825088pfc.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=FwXbFXmgWnoAKIPPMw3+meN78T1AYlQPW6JO5KlmOFc=;
        b=GwHEWvJxDcaPkR1go7iczosqR2vwQdwLUkLHhDcSqLvzfLnIKDRN5b0/1dZsjz1cgG
         jDelFqQOkpoMOlq036X1xblRXXbEVVuUtiSw6dJ8moZJpzK3xuTmVEnOqH/dMEe2tPcy
         kv/maoq5A5u99d67Mrm4mFwFab2JomdEFQJ7HbxFlnf1qfnFA5ds8BS/t4gDkLRQ3lpm
         ZW/2iH9AIYSFiuGN6oiLlYb0WGNzn9u8H7/74YbwOS1a5MEQX5YXwn+OvoFPCBV3aDzT
         JYrEJHOrTdUvTRcXcOjQD/XAVdjUvhfAfrMbFVAzrWUgT/Zx3++x4zKtEsKzDlwx1Njn
         QXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=FwXbFXmgWnoAKIPPMw3+meN78T1AYlQPW6JO5KlmOFc=;
        b=shLdvYFhTWVmGlVBLnnpSveTXrj2dcwAiJ0OAOl+4f0p3ojZnnbPdJp8GFrKbnF/3z
         j+IEn3wUHplcMDefSXJZa/XolWAsFlwj9DulVziQAMv3XtQrf5GffouhT4opu3EDH6dJ
         PvhHgGS1cy5i5Vdcbe1d1ggcF3x9pN/OPzZbt1OHR07Qk3PoxOVwHEn44py554HeQQyN
         0Lv45nnlNYf+eCNX/oAl/hBiKj0zCarKFOSRoX2qrx/dlkn9LVDwi0uj2olKwZ2+/pZ7
         UJXfRX0pR6HUiOjf0DHlvgQgC2FcJKdCHWHbeG/IxKk/OzYjvfp39ye7Gm82qaAydOG9
         bWhg==
X-Gm-Message-State: AOAM5315yqI2txidnGBrNZI13W/SddHrV4BRy4P5h94IuWZxdm5OBise
        90s7JEwC2ZDdEpU2YNLKJ+eNkA==
X-Google-Smtp-Source: ABdhPJyFACTPphRa6klhxLhx0DCYZ9m6lKenXggXBtQoELuXEFp4/QL7G/1/q93b8AsTV1Re2tHcDw==
X-Received: by 2002:a65:408c:: with SMTP id t12mr18370615pgp.262.1637340300380;
        Fri, 19 Nov 2021 08:45:00 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id t13sm193989pfl.98.2021.11.19.08.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 08:44:59 -0800 (PST)
Subject: [PATCH 07/12] RISC-V: defconfigs: Sort CONFIG_MMC
Date:   Fri, 19 Nov 2021 08:44:08 -0800
Message-Id: <20211119164413.29052-8-palmer@rivosinc.com>
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

This should have no functional change, it just sorts CONFIG_MMC the same
way savedefconfig does.  This only touches the rv64 defconfig because
rv32_defconfig was already sorted correctly.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index fa9017c60b3d..ec9540392df7 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -90,10 +90,10 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_UAS=y
+CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_CADENCE=y
-CONFIG_MMC=y
 CONFIG_MMC_SPI=y
 CONFIG_RTC_CLASS=y
 CONFIG_VIRTIO_PCI=y
-- 
2.32.0

