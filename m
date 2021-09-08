Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6EA403E81
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352507AbhIHRrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350246AbhIHRqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:46:52 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD22C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 10:45:44 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id q3so1782590plx.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 10:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oNkS5juwsia6SB7bGOojrAbLTbecFtQQ9fLEL8O0v5w=;
        b=RVQ4JtZYx7jyTfuystkOEpsOXyRRa7Src2FGs8ZOB2SiHNbhYAZSUZVKp3c1risQFm
         c5lsMS+jCUT5xXuKkQMbUQlnJO5RsAveQsSM30U961U96y5J6OuTnHvJytBUH64gYDkg
         J0XK2HzmaA6Ko3b0du9yO6RpT4GimfTlEmGaT6vkTM6RtNZP5iMCAHTX/jGga9VtJ5OL
         6Mp+YcRWRxjl5wF5vAt4ej19dek3rfYuf0+XZD8uItOAhx3qmBLa2Tsdkv3SoWMoWazf
         zItFVRAU9SkZVF0Wi1IQCcMDbHk2ZK9Tjbxb51T7zB+65GLpdwE31eo/m70Pe7zkBvs+
         E/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oNkS5juwsia6SB7bGOojrAbLTbecFtQQ9fLEL8O0v5w=;
        b=mbTy3g/oyNn9okkZF8A3lKpj4oC259LktBxMrO9biBh1KF8nuMXf8h9Q93arpo+jlO
         XIx+Sr3feNrL58FGVKxmQgvLmsCI7JZeEO9yPJ5n2AvaUfCXKD/swlCtGlp14l8INQgF
         9Yw0qRbIC08alBulqEMB1DKnPlm15xyxNfr/xkT10KtRFICmgH+RsO7U/s1BZDvKUEG1
         p1mZK00YoBInNV5MXSJ5Cj4BGsUr14L194p4hkq3/vZGyxz9/Ir1jGIxj7N9i8yWLYVA
         Cnbm6cEu7wc31AJ3/FK0pmAPMasHF3KYHbraA3PCymF29oo0m8F6D0ePMEvTilrNEomy
         cDxQ==
X-Gm-Message-State: AOAM531PV7jK1YAP8v9KMjXtiLXvLT77WcuAsAAuxfx60ajrYbf25p2t
        MGHb4rmi/JiHJoiDDPGAtcGmhZJ/9RgVyg==
X-Google-Smtp-Source: ABdhPJx3EGcGnD0EZkL4f0+SvMnybZfQnGYOtf5O47oFxQGSK8S3WUh/vd/MsehTR25JjboLkdg3AA==
X-Received: by 2002:a17:903:1c2:b0:138:b303:7b95 with SMTP id e2-20020a17090301c200b00138b3037b95mr4024138plh.78.1631123143765;
        Wed, 08 Sep 2021 10:45:43 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b5sm3108466pfr.26.2021.09.08.10.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 10:45:43 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com
Subject: [RFC PATCH v8 05/21] riscv: Add vector feature to compile
Date:   Thu,  9 Sep 2021 01:45:17 +0800
Message-Id: <3bf5002402f4aad88daf11e223ec40ef195fe308.1631121222.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631121222.git.greentime.hu@sifive.com>
References: <cover.1631121222.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This patch adds a new config option which could enable assembler's
vector feature.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reviewed-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/Kconfig  | 9 +++++++++
 arch/riscv/Makefile | 1 +
 2 files changed, 10 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4f7b70ae7c31..619cfc370ee5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -380,6 +380,15 @@ config FPU
 
 	  If you don't know what to do here, say Y.
 
+config VECTOR
+	bool "VECTOR support"
+	default n
+	help
+	  Say N here if you want to disable all vector related procedure
+	  in the kernel.
+
+	  If you don't know what to do here, say Y.
+
 endmenu
 
 menu "Kernel features"
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 428bd3bc202f..1450bdde5288 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -57,6 +57,7 @@ riscv-march-aflags-$(CONFIG_ARCH_RV32I)		:= rv32ima
 riscv-march-aflags-$(CONFIG_ARCH_RV64I)		:= rv64ima
 riscv-march-aflags-$(CONFIG_FPU)		:= $(riscv-march-aflags-y)fd
 riscv-march-aflags-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-aflags-y)c
+riscv-march-aflags-$(CONFIG_VECTOR)		:= $(riscv-march-aflags-y)v
 
 KBUILD_CFLAGS += -march=$(riscv-march-cflags-y)
 KBUILD_AFLAGS += -march=$(riscv-march-aflags-y)
-- 
2.31.1

