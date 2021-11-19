Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6164445735A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 17:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbhKSQsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 11:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbhKSQsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 11:48:04 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10716C061758
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:45:02 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id x131so9809145pfc.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=UXSD7rOE9GyWI5KIaojYsAN8GSzjqnafFancHnsp3Vw=;
        b=DPKSJFjvcoZfaJOelec3G3kZmSYwaMUGh9fi3dqbvLJiX8uJJnZzTZjbKaUyxqPl33
         vVJu2ihYOPNOjN3cDeAeaAHWA17S2hWnx+tZzDVu+d8PpUrHcweM6pz8WMVXTWUwYXCQ
         V1/198MTgl5Fgj+5+2/7OXSI8Fo/mnoODWNEwyeLCM9Z83YtMPLIqj3410zGGV0jcInd
         wN0B5X8bcjsHdpev8ySD4Ze6iXzH6Fb9emzZZ/GOzuGeucBDvGlFmo0cscTbLvryZzf1
         iuJEjlthj/Q76AFZdH5oXxnqHRr0G/0Kx+f+Ig07idPD3x/2Ijo0DxF6zdEK9+iLg8ND
         xUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=UXSD7rOE9GyWI5KIaojYsAN8GSzjqnafFancHnsp3Vw=;
        b=gJHc/IOw55ga2/KViAT/jotV0MEZZ3Xptt5UBBcfW9PRF2m7OxmAzUtuA9iQYAh7u9
         88y+vVp2SUOrKCRzAH2NNUg5BX5Ffe3R/PC9fEYKmDezUfqMc4Jc5frD/5RS2M7fqL8X
         rl8+ryKanPTvDPik/OZ1L29w63Pnstdpg8mEoe61Gobj4r3b7S6ngzynsh5qO7eEU07B
         5Z9Ehyjtg4lEEPzLXNktr4x0ZI7NBjZqn+TSGqup3t7br2eRCQMRNfRBrXzqK8hp1lWo
         9GO0eg3IYx3jRP61/RZ6+VkzgPhRed0O8ihLBVe9kTy96MT92i5BtoIxU5h6HqcDRHLm
         YypA==
X-Gm-Message-State: AOAM531GDbb/rvRgXCyjaSYQTJU1Jryke4vCKAecWTQepHTJ69NHfp0k
        Qg+HRNLP9gA7eSDfLUyDbTyHiA==
X-Google-Smtp-Source: ABdhPJyYzXvFPPqLpWYpw4Z6xVh+J0emvMtNeK4RTlNqN3AghwAAr0n8BfpU1Il/ZaGsCMGkd5c7qQ==
X-Received: by 2002:aa7:98dd:0:b0:49f:bab8:3b67 with SMTP id e29-20020aa798dd000000b0049fbab83b67mr23219348pfm.86.1637340301522;
        Fri, 19 Nov 2021 08:45:01 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id rm10sm195689pjb.29.2021.11.19.08.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 08:45:01 -0800 (PST)
Subject: [PATCH 08/12] RISC-V: defconfigs: Sort CONFIG_SURFACE_PLATFORMS
Date:   Fri, 19 Nov 2021 08:44:09 -0800
Message-Id: <20211119164413.29052-9-palmer@rivosinc.com>
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
CONFIG_SURFACE_PLATFORMS the same way savedefconfig does.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/configs/nommu_k210_defconfig        | 1 -
 arch/riscv/configs/nommu_k210_sdcard_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index b16a2a12c82a..89ab76349ea8 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -75,7 +75,6 @@ CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_USER=y
 # CONFIG_VIRTIO_MENU is not set
 # CONFIG_VHOST_MENU is not set
-# CONFIG_SURFACE_PLATFORMS is not set
 # CONFIG_FILE_LOCKING is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY_USER is not set
diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/configs/nommu_k210_sdcard_defconfig
index 61f887f65419..690460f79925 100644
--- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
+++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
@@ -72,7 +72,6 @@ CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_USER=y
 # CONFIG_VIRTIO_MENU is not set
 # CONFIG_VHOST_MENU is not set
-# CONFIG_SURFACE_PLATFORMS is not set
 CONFIG_EXT2_FS=y
 # CONFIG_FILE_LOCKING is not set
 # CONFIG_DNOTIFY is not set
-- 
2.32.0

