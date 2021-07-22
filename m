Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2059C3D1BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 04:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhGVBgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 21:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhGVBgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 21:36:46 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0036CC061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 19:17:21 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id bt15so4083300pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 19:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=07mq1tbTyL2EUpcAXYfDuJ/atzwMHIawr2ISlNOgil0=;
        b=fll3GwPr5G609VlObfTF3PBHdPewGkU5Y7oNH+VWKn/lzjN7EbWyM3Uf3+iyN2r4gj
         hgHYCiBbMCoZZOoPs2FhLDGRR1sJH7epGaZDjalcFdw8uqCd3g+/fe7sgf1+HB/1UYVB
         eHF6m8xxUGRHfhZW5GmOClGyh2JMJCnEbWSVP5qTnYQtQovVSTCUltkfNWHmkc7KHz6N
         rH+/xfr/inpgCniZt5DeTeNCKFrkWB9gJ1+G9A49LL/e4/OqqI38/ZMIXosYJGY2G4TL
         xiRDr87bZqYXe9b33xjiZcxRBgTspxxcsFZI2CJsPIs30D0FLfNW8I9mJ1u2pPjsZF+c
         L/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=07mq1tbTyL2EUpcAXYfDuJ/atzwMHIawr2ISlNOgil0=;
        b=AlmVhIrCpFs/dj+JVYzSpI+bzkevd2qJc6lcM8J53USRv6M47ym/i/qhVWgI3cWSYO
         eJQznPLQ1DqWpls2kTMSArImXz9mlEt/fqRiSKVntOYSrrVluP1vvpqjAx3RbTqmXF8n
         icRFxcW4uIklau8xT8JpE9i5g7keN09+/nXPTiSN6FBusH6BmdfABcKDVOiLrzfXKw+p
         imuQ+LqM6hWPyqMzdcccwwNHr6ih9vOkdXzdSNDbNjX4u5Kmb1mjLl3B/GWdkMHT6k7n
         iGq1rR2iO8R8LQmYHrNVt5hdAQl1Q1bAAhuX6srpuyniGhWA/VO0a1ItPclLucLrmr7w
         ZE0g==
X-Gm-Message-State: AOAM531Cdh4sdXxcfQ4igfpWyNmV3Prtk4eeQtQRZsvKl+o543QnGr95
        //vo8T+5wnGr9g0ODLwHzPQ=
X-Google-Smtp-Source: ABdhPJya/laHEhbhnkuWT6LkpVzEG5xHxaJhq+pxOP5h+XehJ/ZBHvG0mQRxtrDKApw5VAPIbLrQVg==
X-Received: by 2002:a62:be18:0:b029:318:df2e:c17c with SMTP id l24-20020a62be180000b0290318df2ec17cmr40104107pff.30.1626920241309;
        Wed, 21 Jul 2021 19:17:21 -0700 (PDT)
Received: from vultr.guest ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id b3sm1245448pju.47.2021.07.21.19.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 19:17:20 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] riscv: kexec: do not add '-mno-relax' flag if compiler doesn't support it
Date:   Thu, 22 Jul 2021 10:17:15 +0800
Message-Id: <20210722021715.127066-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V special option '-mno-relax' which to disable linker relaxations
is supported by GCC8+. For GCC7 and lower versions do not support this
option.

Fixes: fba8a8674f ("RISC-V: Add kexec support")
Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 arch/riscv/kernel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index d3081e4d9600..3397ddac1a30 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -11,7 +11,7 @@ endif
 CFLAGS_syscall_table.o	+= $(call cc-option,-Wno-override-init,)
 
 ifdef CONFIG_KEXEC
-AFLAGS_kexec_relocate.o := -mcmodel=medany -mno-relax
+AFLAGS_kexec_relocate.o := -mcmodel=medany $(call cc-option,-mno-relax)
 endif
 
 extra-y += head.o
-- 
2.26.2


