Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AF6403E7D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350185AbhIHRqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350246AbhIHRqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:46:46 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06638C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 10:45:37 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id s29so2703006pfw.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 10:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VcOMi6ITdU4I4edFLesYSJaP0RX1fCppqwJ8xVLL0ik=;
        b=MxeROP0RPbN/H9A8pHZYHn8Y6z8SYCJqR4t0/qQ/tUd+3HYR5qqG8o39+8aFn4QiP7
         PcpD/yw2yIlscxGQaKAvFSwfoheXT1PVlH0Rs2BHPhtNHJICdXotFD3UqP50bT3iMC8F
         9EN0yq5kWxlHjfz4ouqHc/kUTe/errThuL4MYE9e2E7Qtwz1Myu91xcaP3RC1YTL94/D
         8gziPSbSDEIwVvl0TmIlZZRtyPGKm1qad3K7n/7wn39keRznTndDsBpMb4vNdb9UtB2y
         7u7ftncL9F5XvP0IGr2v870W88d6IxVF4CQRWlatHMyJmgR8bIrzSEaINAGGDFotnFYf
         tKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VcOMi6ITdU4I4edFLesYSJaP0RX1fCppqwJ8xVLL0ik=;
        b=zZAmL7uINMuL1rW8Nn/Yg9KSztqOhOh3FGCZgVdTgtODVZXW4dgw1R3tJbZkrHl3Sl
         ogkMLrs6N+HL5rxtThcAt3r3yB05KPNZYg6csHrJJLAklzzMs0peB1a+AMmkvnYJGxwN
         R6u4fKAiVmkoDYbRJqKHnbwRLy8pdh3qrqHj40zxJchW0/uOVL/xqf7Lfh5xJGIVpPQp
         zGn/VICZY+mMRHwQQWxPHZk67VkDw5JgFfBx7GEubDo2wBigPyKkYSf/1DC0oRrzMhmq
         zkm9vQ7ldhaxpRbprXIBynalYJCLfukPbm/CpcFKg0BRzs4qa7zPHsPHfXKCp/Hh7jZG
         XgUA==
X-Gm-Message-State: AOAM53362Nn4IzvjEDFSzSSBaOJw0AFGhXpF85H+eOYVEIMAOkf+lvrI
        2izAwMQJfBRo+wnXRD/lEMortg==
X-Google-Smtp-Source: ABdhPJznawYnmbB6fLsU/hbPSpUWDxsncE8PBN3+UiHSAfC1IrhE69U0ra3xpTcCvUFgM4Yge+NfjA==
X-Received: by 2002:a05:6a00:98f:b0:40c:96c5:b4fd with SMTP id u15-20020a056a00098f00b0040c96c5b4fdmr4879796pfg.0.1631123137330;
        Wed, 08 Sep 2021 10:45:37 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b5sm3108466pfr.26.2021.09.08.10.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 10:45:37 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com
Subject: [RFC PATCH v8 01/21] riscv: Separate patch for cflags and aflags
Date:   Thu,  9 Sep 2021 01:45:13 +0800
Message-Id: <3814a5e48384a893ee61613ad9718dabc95ab334.1631121222.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631121222.git.greentime.hu@sifive.com>
References: <cover.1631121222.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Use "subst fd" in Makefile is a hack way and it's not convenient
to add new ISA feature. Just separate them into riscv-march-cflags
and riscv-march-aflags.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/Makefile | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index bc74afdbf31e..428bd3bc202f 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -48,12 +48,18 @@ endif
 endif
 
 # ISA string setting
-riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32ima
-riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64ima
-riscv-march-$(CONFIG_FPU)		:= $(riscv-march-y)fd
-riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
-KBUILD_CFLAGS += -march=$(subst fd,,$(riscv-march-y))
-KBUILD_AFLAGS += -march=$(riscv-march-y)
+riscv-march-cflags-$(CONFIG_ARCH_RV32I)		:= rv32ima
+riscv-march-cflags-$(CONFIG_ARCH_RV64I)		:= rv64ima
+riscv-march-$(CONFIG_FPU)			:= $(riscv-march-y)fd
+riscv-march-cflags-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-cflags-y)c
+
+riscv-march-aflags-$(CONFIG_ARCH_RV32I)		:= rv32ima
+riscv-march-aflags-$(CONFIG_ARCH_RV64I)		:= rv64ima
+riscv-march-aflags-$(CONFIG_FPU)		:= $(riscv-march-aflags-y)fd
+riscv-march-aflags-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-aflags-y)c
+
+KBUILD_CFLAGS += -march=$(riscv-march-cflags-y)
+KBUILD_AFLAGS += -march=$(riscv-march-aflags-y)
 
 KBUILD_CFLAGS += -mno-save-restore
 KBUILD_CFLAGS += -DCONFIG_PAGE_OFFSET=$(CONFIG_PAGE_OFFSET)
-- 
2.31.1

