Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F51645735E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 17:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbhKSQs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 11:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbhKSQsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 11:48:05 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405A0C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:45:03 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id h24so8377619pjq.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=WBBqDu36GT0JmGkU/ix/DWRv5G47jkaRFbPjNqt5g+8=;
        b=is3hPnILMqFCjPu2rtKJai3o/GJ+um6H++RpkLkoy6HEWDtThboP3DhdXOORLxy5T6
         zwqLTAXHjNLUKwJvw65aKtayVRueYPTmdBR3qYYTJqDAouWwIetysr+6CyyKX+lAUeYl
         LTmN/Ibiuc0d5BZYsbKxECSDHcr1RTrDDOEIPyPUuUepKDYDseHUPUpCxuhgLKZ3WPLB
         gDn8SWLsnnOAt/FfKHOJgGYqM+17WrzQ1XM3Ia2MUVcEvO61prxIj03gJ8t6+VYtuAwM
         zf/AVgrX0BPMn5S6h4XbpwdE60ZxxU2AqJPlIVu+8tXg2BrXPdokAWFHOIL7+g7fde6C
         P96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=WBBqDu36GT0JmGkU/ix/DWRv5G47jkaRFbPjNqt5g+8=;
        b=AJvFX0jGX1KWv/SmagxZ6mhbZkbgLI04fyRaHhIcpldhN74UlnHHBcxaEYJs50EWB1
         VdOzdzX8VXPs2wRvoUSANMFK6unMab9qddsauNGPKMEfwfKCZzGuReA63lbHo0MErSlM
         cswJu+VWkNVM2puuGbyl4zrXH7UG2KV/lWfHSEF1BYZbjLw1Yh7f7/zztJeo+Av0s/n4
         Ot/1XmU+zZxbu4JIus1NTyW4YahIVpHMLv/aNG7OF0/bVUrAAYak8zMdnklVIYrg6QtL
         s3esOaeo7cNmfhWv8y7aJEJTcT1smnz24T+VOJ4/KB9i0LjtKWh3EOUicHsdZVsQcOKM
         NcDg==
X-Gm-Message-State: AOAM533G60i1LGB7yj7pzwwhTsVLQOQb7yoS21aS/l15XjmueB7NTMG0
        8iq24zEid4IY2C9S2cvCuPlYPg==
X-Google-Smtp-Source: ABdhPJx/PUbNTC9xq8gA8W1e3jjgfz5qeZ7WKQQBmQ/Je45Uq+DWa9RXtYzBY43oewapB86jzdnZBA==
X-Received: by 2002:a17:902:8f94:b0:143:8e81:3ec1 with SMTP id z20-20020a1709028f9400b001438e813ec1mr77412614plo.52.1637340302699;
        Fri, 19 Nov 2021 08:45:02 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id np1sm11899019pjb.22.2021.11.19.08.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 08:45:02 -0800 (PST)
Subject: [PATCH 09/12] RISC-V: defconfigs: Sort CONFIG_BLK_DEV_BSG
Date:   Fri, 19 Nov 2021 08:44:10 -0800
Message-Id: <20211119164413.29052-10-palmer@rivosinc.com>
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

This should have no functional change, it just sorts CONFIG_BLK_DEV_BSG
the same way savedefconfig does.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/configs/nommu_k210_sdcard_defconfig | 1 -
 arch/riscv/configs/nommu_virt_defconfig        | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/configs/nommu_k210_sdcard_defconfig
index 690460f79925..84b87f8bfc8f 100644
--- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
+++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
@@ -30,7 +30,6 @@ CONFIG_CMDLINE_FORCE=y
 # CONFIG_SECCOMP is not set
 # CONFIG_STACKPROTECTOR is not set
 # CONFIG_GCC_PLUGINS is not set
-# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_MQ_IOSCHED_DEADLINE is not set
 # CONFIG_MQ_IOSCHED_KYBER is not set
 CONFIG_BINFMT_FLAT=y
diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
index e046a0babde4..385cca741b01 100644
--- a/arch/riscv/configs/nommu_virt_defconfig
+++ b/arch/riscv/configs/nommu_virt_defconfig
@@ -32,7 +32,6 @@ CONFIG_SMP=y
 CONFIG_CMDLINE="root=/dev/vda rw earlycon=uart8250,mmio,0x10000000,115200n8 console=ttyS0"
 CONFIG_CMDLINE_FORCE=y
 CONFIG_JUMP_LABEL=y
-# CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_MSDOS_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
-- 
2.32.0

