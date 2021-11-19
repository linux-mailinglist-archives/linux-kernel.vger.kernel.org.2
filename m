Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695A3457355
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 17:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbhKSQr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 11:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236582AbhKSQr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 11:47:57 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC323C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:44:55 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 28so9103088pgq.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=ah5lr8SoLo+6+fPsQpE+n96JZomp2g2I5RmGsEvEAmU=;
        b=pOJQtnsqxtFlWChG6PkVngOnfkyHnERrgKRjNTlYPB/YBSnuMwPlFghMuhCkXeoplH
         BMJu4/s7M9Za6VPNKuZceUae7/SnCq4u5ldTdPyVcKvS+AaqptyJKbjlnF2zYyTCKi4Z
         bGvNwq5YQD+ptHK3qkOhbmqVFujgNPiz8fAZif0wD9OAgjOI9txOT/na0QJjjlJAIrE7
         WrDW356fvVFf/jW3LC+EQQ+sLvQo66Iimpa6fglWx51wCdqRklJDRqzdDYzWAh3EttNz
         unyy3aIqQyaj43LKMo24DbylFzOw23ut154TojTySwrPTP6tDgiznq4jKWQRQremCD3C
         pYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=ah5lr8SoLo+6+fPsQpE+n96JZomp2g2I5RmGsEvEAmU=;
        b=m3hl6/OWd9bKXZI1kdSfCEWifxxuYjSocqmuqmHz+Ey+hmyubwZFiGBRKt6zM8YMv3
         5JqeteOOD9FQROp/LMGuDvCK3cmiALLRxh6Ap33MImuV7DKwtlrViQEsnrSTn4OjpgG/
         4OAwDm0GXjQLE9RFvqUlXB3RCvdiEpICpk9LbiqZau5tVyWjWjSGlYdWbItLgqyIAGb3
         FiM3Rz+yFm7dHPgz3sP3K1J2Bq5LEyjKtZLMeZ8A+W+kpEjhg9HqXjX2Zf7ncL+aNNeP
         Bx0YbLTJA7Clns6E/QPlgwYmo84tjWyBsq4Vt2mLHYUr/EElYrcvHjyQsR8XUiTcIBoS
         el/w==
X-Gm-Message-State: AOAM532ZC/cmnwuZc/9RmNHlvjwiTHy2AcJ50eClcp1LPkJuUUWg++zB
        OsToCCP3jw5WM80yLR5NJFxA8Q==
X-Google-Smtp-Source: ABdhPJw6Rk0SaD1ydLEFj1AC3ZiqOl6ymHlDrc8KuQWuuILh5CwIVLyIgXMGI0rf3H5bD5vi3o9dEg==
X-Received: by 2002:a63:f95b:: with SMTP id q27mr18665923pgk.202.1637340289537;
        Fri, 19 Nov 2021 08:44:49 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id f4sm214917pfj.61.2021.11.19.08.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 08:44:48 -0800 (PST)
Subject: [PATCH 03/12] RISC-V: defconfigs: Sort CONFIG_BPF_SYSCALL
Date:   Fri, 19 Nov 2021 08:44:04 -0800
Message-Id: <20211119164413.29052-4-palmer@rivosinc.com>
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

This should have no functional change, it just sorts CONFIG_BPF_SYSCALL
the same way savedefconfig does.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/configs/defconfig      | 2 +-
 arch/riscv/configs/rv32_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 11de2ab9ed6e..a6cb99cf4d3c 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -2,6 +2,7 @@ CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BPF_SYSCALL=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
@@ -13,7 +14,6 @@ CONFIG_USER_NS=y
 CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
-CONFIG_BPF_SYSCALL=y
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
 CONFIG_SOC_MICROCHIP_POLARFIRE=y
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index 05b6f17adbc1..8a57c940d5ef 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -2,6 +2,7 @@ CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BPF_SYSCALL=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
@@ -13,7 +14,6 @@ CONFIG_USER_NS=y
 CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
-CONFIG_BPF_SYSCALL=y
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
 CONFIG_ARCH_RV32I=y
-- 
2.32.0

