Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77054403E80
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352489AbhIHRq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350290AbhIHRqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:46:50 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BE8C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 10:45:42 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id v1so1762438plo.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 10:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PvZSczC6umJopWKeatvFKRPXXAs3l7Ppj7hlaQG6eAc=;
        b=cishkXuBrR46GiBj+REajEuR+a1v2dLe7TJaYTi3FZ6HKb/xcpW5AIQpOtxob8SZrU
         wPQFpA1YcPLvipNJ0d5NsPGoldqRBKm8hzAkEz84k/2Ud7Sdcmp7+6v45csfHE0Me5S/
         AsLQeC8V57RYDKux+fHcJdtkq3Lw4EEF5qvgSrNV1jOLMTh80f0yyct6gsVzDM55NfHi
         nA0E9t/UWj2eV7KXpmvP7cKv5I6WbIaAj5u7t/G+kL7cW6+4J8R0HDTPHeVKxXH6jm6E
         Z8hJ8bpKyYiA68YH+y6ywtsccil+UQsTCI3YL2OJsuc/eXuWQXZgTADcRf28X0EmBpDh
         YMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PvZSczC6umJopWKeatvFKRPXXAs3l7Ppj7hlaQG6eAc=;
        b=XqqeUioM0djK0e0QRVrNy0TO5AVpSL/Ez8D/7KY1AWsmsrtFAzTussKxOg/47iEisX
         mGEDPu6MeaPWHAEP7I77QVoKT5fHkpirgovkIbjdmOvYqpxCgDp+lVy6g43IERvBoyRF
         VL300u0m4zFpbp1PUvR8QdGjE3mVXoMNoR6p3bNLgBBwRh9M0YdH10QMExSVfUUXICuU
         utsOZVylbfe/gSBOoibnlBDUdR6PejPt81Jfsk35OGMaOcQTBW+HFAcK78R3pGtKk3D/
         kTIgWo1DVgI2tbcZ7jKNEUMvKOKMd4OB6viGZ4vKAtnta3haRZ8W/JwRqZ9DFW6Dsk2Q
         Wewg==
X-Gm-Message-State: AOAM532YO0q8YKW+95a9O+uMyOMmzLjFLD8RlPcZNhlBcrkO0B3A4JiU
        7+Os09zwJXP33ab7lexHX6WEVw==
X-Google-Smtp-Source: ABdhPJycZ3RbxINQfqWEwJw2vOK5xfrivX+O4UklOCv3iAPQwCHociYaajEMNjUB6HV3Oe6TGjwJUA==
X-Received: by 2002:a17:903:1251:b0:13a:1f5e:20da with SMTP id u17-20020a170903125100b0013a1f5e20damr4034467plh.75.1631123142217;
        Wed, 08 Sep 2021 10:45:42 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b5sm3108466pfr.26.2021.09.08.10.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 10:45:42 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com
Subject: [RFC PATCH v8 04/21] riscv: Add new csr defines related to vector extension
Date:   Thu,  9 Sep 2021 01:45:16 +0800
Message-Id: <efa96ff90447f6f49f8cc4496dd08657786bd9a7.1631121222.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631121222.git.greentime.hu@sifive.com>
References: <cover.1631121222.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the riscv vector spec to add new csr numbers.

[guoren@linux.alibaba.com: first porting for new vector related csr]
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Acked-by: Guo Ren <guoren@kernel.org>
Co-developed-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 arch/riscv/include/asm/csr.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 87ac65696871..069743102fac 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -24,6 +24,12 @@
 #define SR_FS_CLEAN	_AC(0x00004000, UL)
 #define SR_FS_DIRTY	_AC(0x00006000, UL)
 
+#define SR_VS           _AC(0x00000600, UL) /* Vector Status */
+#define SR_VS_OFF       _AC(0x00000000, UL)
+#define SR_VS_INITIAL   _AC(0x00000200, UL)
+#define SR_VS_CLEAN     _AC(0x00000400, UL)
+#define SR_VS_DIRTY     _AC(0x00000600, UL)
+
 #define SR_XS		_AC(0x00018000, UL) /* Extension Status */
 #define SR_XS_OFF	_AC(0x00000000, UL)
 #define SR_XS_INITIAL	_AC(0x00008000, UL)
@@ -31,9 +37,9 @@
 #define SR_XS_DIRTY	_AC(0x00018000, UL)
 
 #ifndef CONFIG_64BIT
-#define SR_SD		_AC(0x80000000, UL) /* FS/XS dirty */
+#define SR_SD		_AC(0x80000000, UL) /* FS/VS/XS dirty */
 #else
-#define SR_SD		_AC(0x8000000000000000, UL) /* FS/XS dirty */
+#define SR_SD		_AC(0x8000000000000000, UL) /* FS/VS/XS dirty */
 #endif
 
 /* SATP flags */
@@ -120,6 +126,12 @@
 #define CSR_MIMPID		0xf13
 #define CSR_MHARTID		0xf14
 
+#define CSR_VSTART		0x8
+#define CSR_VCSR		0xf
+#define CSR_VL			0xc20
+#define CSR_VTYPE		0xc21
+#define CSR_VLENB		0xc22
+
 #ifdef CONFIG_RISCV_M_MODE
 # define CSR_STATUS	CSR_MSTATUS
 # define CSR_IE		CSR_MIE
-- 
2.31.1

