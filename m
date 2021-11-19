Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D660F45735F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 17:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbhKSQs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 11:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236674AbhKSQsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 11:48:08 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11D4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:45:06 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id y7so8613580plp.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=QtaSSFMsqBIq8kJ2oNDlofo69jd6X8iaroIn8+5/lTM=;
        b=IpNlfu3x0dU6brOg5DNWCgBZ6IQQvWYdhM0507AuWCbi2OXvgJ3/FNqMM/cgIPwYqC
         MC5RSEA3OoF0pz0467PG4AvRFBcCz+AfZuKl3gC3+52fehypa/gySy93x3sSwKL3P1SM
         m6OB9PKLClcwxhyx/B8EhF66k6eMBvuT2/CDn+292P+PIb39RItlSffZFrwKopBmN8ac
         xVnkdNZHzLpUkTxVwXtcF1y/GUhptW5XXy1Qo0ZhMedSilzdRH5ItRsNg2rZZcKbuIEo
         ZsIk147WLEe2Jx93JwVbMu5ovSKypy38Oq4ywlZY7PbdlYWAj1Xv8FbAV62hCHYKpz6n
         pVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=QtaSSFMsqBIq8kJ2oNDlofo69jd6X8iaroIn8+5/lTM=;
        b=cIDShQh/l1APItTqINLB3xjXK9/jfU8NbotW81L+LGYestkwAZ78VXtUZnKFf3wGNC
         x8fxRwuOC80Q+nu8wcpMfG21PpWEAz2slqCu93X/gS9/XRfdsdUkzlCPxi9AoD3ZGLRq
         NgXY7G418D7m564LLwGmMwG1kGsHj52nY3MXWyH2BSyITOfWbdINb4NXvAMi/MrW8FEt
         k3iMVdp1F2rUdes/agQMqObLIHW7vlz3FkQVFTu9o4wbZC7E9rjEYLJOsCh0oKmAVbLO
         n4AcVxklw6nRbWy8czkI55GHH8cc9zykkLQKcx1BYHtIJkwPqtmejgWzE5kzEzPW4vLf
         +OgQ==
X-Gm-Message-State: AOAM530V0BPMGzMOWTNATalVbqpTG9Lo5nOzhK3Wbogboah+MKQLbbLL
        sp1p5olMC5GPRS2Kth1F26wtog==
X-Google-Smtp-Source: ABdhPJzam1HD0HGxNuDaeb2MJR9obhPXVMPUr0q5Y+mqSw/25JXA74d7shGTzIeWWNsFCvvqqEwzBQ==
X-Received: by 2002:a17:902:d2c1:b0:141:f710:922 with SMTP id n1-20020a170902d2c100b00141f7100922mr42315105plc.7.1637340306392;
        Fri, 19 Nov 2021 08:45:06 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id c2sm193607pfv.112.2021.11.19.08.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 08:45:05 -0800 (PST)
Subject: [PATCH 12/12] RISC-V: defconfigs: Remove redundant K210 DT source
Date:   Fri, 19 Nov 2021 08:44:13 -0800
Message-Id: <20211119164413.29052-13-palmer@rivosinc.com>
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

The "k210_generic" DT has been the default in Kconfig since 7d96729a9e7
("riscv: Update Canaan Kendryte K210 device tree"), so drop it from the
defconfigs to avoid diff with savedefconfig.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/configs/nommu_k210_defconfig        | 1 -
 arch/riscv/configs/nommu_k210_sdcard_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index 89ab76349ea8..e8ceab678e8b 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -29,7 +29,6 @@ CONFIG_EMBEDDED=y
 CONFIG_SLOB=y
 # CONFIG_MMU is not set
 CONFIG_SOC_CANAAN=y
-CONFIG_SOC_CANAAN_K210_DTB_SOURCE="k210_generic"
 CONFIG_MAXPHYSMEM_2GB=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/configs/nommu_k210_sdcard_defconfig
index 84b87f8bfc8f..46aa3879f19c 100644
--- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
+++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
@@ -21,7 +21,6 @@ CONFIG_EMBEDDED=y
 CONFIG_SLOB=y
 # CONFIG_MMU is not set
 CONFIG_SOC_CANAAN=y
-CONFIG_SOC_CANAAN_K210_DTB_SOURCE="k210_generic"
 CONFIG_MAXPHYSMEM_2GB=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
-- 
2.32.0

