Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC84457356
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 17:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbhKSQsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 11:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236648AbhKSQr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 11:47:58 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C7DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:44:57 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so11409129pjc.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=X7kafgaMfQc5QAZ1oOLiQg/P0i4Kp4ckcP/YfJYFTgA=;
        b=nqSaQrxphluRvJfW72RovSHjHtv8hv1h1+zSS81MpD1MYhlSOYBK+5Q/aIYVqEk4d6
         9DaJwNs/jGtkecf3luGhmnf+/kDtBimhaW5DR4T3WuH9x2N2Qj9ipbOFvRQ6tU5sf4iq
         y0dsnBCZv0zE/kKDMZAsOz+BWLfgbxrkAlL3/v25A393xwzOGYChL6HLnQt4U64crR1l
         RER3VW50FXIv0Rv6F8QZXySxr/nwvfWR+TbkaGbW1LzOtQ3k++ExpjSrAdVRR0mBHdI7
         QWtC0UU3J+i6bqNIFnWDvA9c+aJXJHXH9sbFykfYUhSmRNwp2QuYzM/tD1cRyU3ODHoH
         N4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=X7kafgaMfQc5QAZ1oOLiQg/P0i4Kp4ckcP/YfJYFTgA=;
        b=VE3bVwK/2fKlTxcbSbA88JAiK8C6f9/XeB20kiIQQUPSRUcd1UKjlBD+x2Pszqmjd6
         0O+PI7wqDwrY6vRTaaJDLgimbj5IOi5R2aBsAHpsKA8kuMFcj2iObUf5tmwzueA4Ac7i
         Ecz47lruiUOuBx3GbyNAfBdPgcBfboM/2j3otlIrkIOAJVgjZU5iHwiW96ewFwfZI40u
         BuhIhkiqB9G3Sp6LvNkTNB1ZOOC3+DuLrHxbr5hF7C4xd+slLCVIMYRrLZllsCLPYOoI
         qDV6Zv38b1OJe5TbxvrANkEbUtEYhhNrBoWvQj6KNGBKpw4Uke2XagYYO2fGkUgusv3w
         R9Iw==
X-Gm-Message-State: AOAM533RRQl0O7xhzQqnq916sLqiyWJQp3IbPZcZ1ChEEVRgHBRTg5ov
        En7kK1BorIi57ZRD9PAy0BTEwQ==
X-Google-Smtp-Source: ABdhPJxpsWopDuK5MHxRdfVLXuUpMWPCM6xPemZUxztvFdN1CMDp0pkjul40RUcUgoBTLG7+Ba2VIg==
X-Received: by 2002:a17:902:d505:b0:142:175d:1d4 with SMTP id b5-20020a170902d50500b00142175d01d4mr78063536plg.50.1637340296664;
        Fri, 19 Nov 2021 08:44:56 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id c4sm213874pfl.53.2021.11.19.08.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 08:44:56 -0800 (PST)
Subject: [PATCH 04/12] RISC-V: defconfigs: Sort CONFIG_SYSFS_SYSCALL
Date:   Fri, 19 Nov 2021 08:44:05 -0800
Message-Id: <20211119164413.29052-5-palmer@rivosinc.com>
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

This should have no functional change, it just sorts
CONFIG_SYSFS_SYSCALL the same way savedefconfig does.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/configs/defconfig      | 2 +-
 arch/riscv/configs/rv32_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index a6cb99cf4d3c..96c2a3615bcd 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -14,6 +14,7 @@ CONFIG_USER_NS=y
 CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
+# CONFIG_SYSFS_SYSCALL is not set
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
 CONFIG_SOC_MICROCHIP_POLARFIRE=y
@@ -143,5 +144,4 @@ CONFIG_RCU_EQS_DEBUG=y
 # CONFIG_FTRACE is not set
 # CONFIG_RUNTIME_TESTING_MENU is not set
 CONFIG_MEMTEST=y
-# CONFIG_SYSFS_SYSCALL is not set
 CONFIG_EFI=y
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index 8a57c940d5ef..1f6808aa1261 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -14,6 +14,7 @@ CONFIG_USER_NS=y
 CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
+# CONFIG_SYSFS_SYSCALL is not set
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
 CONFIG_ARCH_RV32I=y
@@ -133,4 +134,3 @@ CONFIG_RCU_EQS_DEBUG=y
 # CONFIG_FTRACE is not set
 # CONFIG_RUNTIME_TESTING_MENU is not set
 CONFIG_MEMTEST=y
-# CONFIG_SYSFS_SYSCALL is not set
-- 
2.32.0

