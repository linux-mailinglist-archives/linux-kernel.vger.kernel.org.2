Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37884403E82
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350226AbhIHRrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350375AbhIHRqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:46:53 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD58FC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 10:45:45 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id k24so3392415pgh.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 10:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7XkWr62oJEVCe0UkWr1Pq747FULmbnq2d1BeCwv5JME=;
        b=KkX3o+mwumw1PmtYzRmn3yb2Lt1FwfifxyLr2h4/tRIhJHOadsUY849d9UOHMOctyk
         DMPd0emSS5ekDAU4TXqnMRmTDMaWRS5a1B/xcD8ljMLeY21BhGaUnVLn4mh4rQSyyoF4
         Z6F7iTMcaA1u3SXKcnk87S/NJDhs20++Y0Z+GNtgEv2H+FdAjJYGqxrdo3FupLCdU5iz
         MDn56QiQMw6xYSnfhHx4xCDyhHSOpLIl9nMpNxeFGHhJ6j+npwkwgBlo2RV9rjE/NPwz
         JGOWEsA749WP/Noc4rZRn7n1aN9FjDYX93G4gu0MpnJDumoffp+N9klKvTQPsSWxpQjD
         oBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7XkWr62oJEVCe0UkWr1Pq747FULmbnq2d1BeCwv5JME=;
        b=TWXjPCbSK2trLyjHFaxZNtdURaimWeX5/K6TWqgWbnNtQvk7h2wc9ha06a7FnTu8ux
         WzUtgtiiLjoiz9Ty5jmkH2hn50MDIRI4qXncEnlQ5f5oxLO8t4dCbxVXtPvkrhIjeJg2
         /KBQ8XMcZIZNT1xKlynz2GtWV9JRDaPfyz1Utz4MYUaHGc1ep3lVeNfl6jdQfjta+KTr
         8wgTFu/aVTdAmwOtZ+FhHPyxr+oS/oMDGg0CDkXAM3HnHZaeCwAj2cFCp+vNJFTWrkr6
         fKhU7kb+5e9i7jjs1UTl/QikYD4tyNJAlFajkMevoy+Mr7n3cyNIJideqHfbMmSEFs8i
         YriQ==
X-Gm-Message-State: AOAM533/C37qWUBoqOnwFRlarBHfj/4MAhea0iU0DgIGtZ4gs63dILYM
        y1H5K2WChbZ/9N3XbvaO3VVD1A==
X-Google-Smtp-Source: ABdhPJw1bfI+VZ6LgcKZ/m09m39T+LvYgh0MYgMaEQbHKN4lFwSePf2BSdrAs8yeIYa5VwS5sM6+YA==
X-Received: by 2002:a63:4f0d:: with SMTP id d13mr4774759pgb.169.1631123145337;
        Wed, 08 Sep 2021 10:45:45 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b5sm3108466pfr.26.2021.09.08.10.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 10:45:45 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com
Subject: [RFC PATCH v8 06/21] riscv: Add has_vector/riscv_vsize to save vector features.
Date:   Thu,  9 Sep 2021 01:45:18 +0800
Message-Id: <05f277fa32f74cefc76a8171abd7430e772753e3.1631121222.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631121222.git.greentime.hu@sifive.com>
References: <cover.1631121222.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is used to detect vector support status of CPU and use
riscv_vsize to save the size of all the vector registers. It assumes
all harts has the same capabilities in SMP system.

[guoren@linux.alibaba.com: add has_vector checking]
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Co-developed-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 arch/riscv/kernel/cpufeature.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 7069e55335d0..7265d947d981 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -21,6 +21,10 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 #ifdef CONFIG_FPU
 __ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
 #endif
+#ifdef CONFIG_VECTOR
+bool has_vector __read_mostly;
+unsigned long riscv_vsize __read_mostly;
+#endif
 
 /**
  * riscv_isa_extension_base() - Get base extension word
@@ -149,4 +153,12 @@ void __init riscv_fill_hwcap(void)
 	if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
 		static_branch_enable(&cpu_hwcap_fpu);
 #endif
+
+#ifdef CONFIG_VECTOR
+	if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
+		has_vector = true;
+		/* There are 32 vector registers with vlenb length. */
+		riscv_vsize = csr_read(CSR_VLENB) * 32;
+	}
+#endif
 }
-- 
2.31.1

