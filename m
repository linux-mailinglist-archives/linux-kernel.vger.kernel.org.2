Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842263B5CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 12:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhF1K4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 06:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbhF1K4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 06:56:19 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3B6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 03:53:52 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id o11so16060804ejd.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 03:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3Svg4KufCMlleknRn+roGXHhdXYCmQgMOGxfVQBcqsk=;
        b=FdL9PinA+EMwomx1qeVTKbZghLZHrs004PW1HUN5/75/45TLyQsgRTM8M3xT8nqRx9
         5VUpD3UPcdNyMzuEWObp0MYmfE6CcCqhSmLc50yBl83OTDK196HO66oBWo6QO6rC7cQi
         vD4E99b4Gb0E5WErLT3gzbk+wVl2FG2PJSofy9+8anJYf60Tf33Yd+GZwI1c2J6ChsCK
         Bm04ntyc4mOVa8uPH0Ak40YgLOuU8gqvwQGKt1twAmuflMMhAq3eFvv883tkfUwLbZfT
         Pw+DF340mfgx5kwuCVAxFp6kVbczCfRL5xCQXfa/TMgmNOs4u6+IBvHdtmp94CguXaTU
         JsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3Svg4KufCMlleknRn+roGXHhdXYCmQgMOGxfVQBcqsk=;
        b=dTEiUVcb7uXQ9CK9ndGqEmTElfBYWOz2kMQR+Rg3hdWfKUC8EAyxJp9dq5Knr6sC38
         slK2SpVM5UBFU+eiif6L1h5QMTYBH/w7KSvVyVjdsnu5+jiFbOR3S2rNWWYB9ijd1drb
         St7sUiTrQ6nmfn75Pvp22XyHI09deN7YA0HEEJYlO2UcAJ6xpd7lUUr7NJOlox1SDTyY
         tCn+P1XU04NqpRYQM09BlDiqtTQYXo+6KKqQbdEnliOK6qG6VkzqDPvDiMqPgbHrah+O
         l5f6ZxiPEhujlv2Rw9H2jrnk1X80EfbuFIVZOuca2RkJO4P71hwpJ1xdMg/um8DAP4no
         6LYg==
X-Gm-Message-State: AOAM532Orq8RfNVzpkPH6QR3eJD605P7bxqxEpYQsxShmnKzl/2NWzGu
        hw+BQeNJ+1y4xFL6/RKdMPk=
X-Google-Smtp-Source: ABdhPJykEhM1KoD/Xx2epu5bd851AuS4I3TCanGsKJu1PbQUdIBjbiRWxevFAFxXbGLT3Dm0Ep/wew==
X-Received: by 2002:a17:906:c108:: with SMTP id do8mr23964506ejc.74.1624877630716;
        Mon, 28 Jun 2021 03:53:50 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2dc2:cc00:2831:3317:971d:3f75])
        by smtp.gmail.com with ESMTPSA id o9sm4668875edc.91.2021.06.28.03.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 03:53:50 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     John Clements <john.clements@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Hawking Zhang <Hawking.Zhang@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] drm/amdgpu: rectify line endings in umc v8_7_0 IP headers
Date:   Mon, 28 Jun 2021 12:53:34 +0200
Message-Id: <20210628105334.27559-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6b36fa6143f6 ("drm/amdgpu: add umc v8_7_0 IP headers") adds the new
file ./drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_7_0_sh_mask.h with
DOS line endings, which is very uncommon for the kernel repository.

Rectify the line endings in this file with dos2unix.

Identified by a checkpatch evaluation on the whole kernel repository and
spot-checking for really unexpected checkpatch rule violations.

Reported-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 .../include/asic_reg/umc/umc_8_7_0_sh_mask.h  | 158 +++++++++---------
 1 file changed, 79 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_7_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_7_0_sh_mask.h
index 4c5097fa0c09..d5ef91d3c391 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_7_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_7_0_sh_mask.h
@@ -1,79 +1,79 @@
-#ifndef _umc_8_7_0_SH_MASK_HEADER
-#define _umc_8_7_0_SH_MASK_HEADER
-
-//UMCCH0_0_GeccErrCntSel
-#define UMCCH0_0_GeccErrCntSel__GeccErrCntCsSel__SHIFT                                                        0x0
-#define UMCCH0_0_GeccErrCntSel__GeccErrInt__SHIFT                                                             0xc
-#define UMCCH0_0_GeccErrCntSel__GeccErrCntEn__SHIFT                                                           0xf
-#define UMCCH0_0_GeccErrCntSel__PoisonCntEn__SHIFT                                                            0x10
-#define UMCCH0_0_GeccErrCntSel__GeccErrCntCsSel_MASK                                                          0x0000000FL
-#define UMCCH0_0_GeccErrCntSel__GeccErrInt_MASK                                                               0x00003000L
-#define UMCCH0_0_GeccErrCntSel__GeccErrCntEn_MASK                                                             0x00008000L
-#define UMCCH0_0_GeccErrCntSel__PoisonCntEn_MASK                                                              0x00030000L
-//UMCCH0_0_GeccErrCnt
-#define UMCCH0_0_GeccErrCnt__GeccErrCnt__SHIFT                                                                0x0
-#define UMCCH0_0_GeccErrCnt__GeccUnCorrErrCnt__SHIFT                                                          0x10
-#define UMCCH0_0_GeccErrCnt__GeccErrCnt_MASK                                                                  0x0000FFFFL
-#define UMCCH0_0_GeccErrCnt__GeccUnCorrErrCnt_MASK                                                            0xFFFF0000L
-//MCA_UMC_UMC0_MCUMC_STATUST0
-#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCode__SHIFT                                                         0x0
-#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCodeExt__SHIFT                                                      0x10
-#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV22__SHIFT                                                          0x16
-#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrLsb__SHIFT                                                           0x18
-#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV30__SHIFT                                                          0x1e
-#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreId__SHIFT                                                         0x20
-#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV38__SHIFT                                                          0x26
-#define MCA_UMC_UMC0_MCUMC_STATUST0__Scrub__SHIFT                                                             0x28
-#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV41__SHIFT                                                          0x29
-#define MCA_UMC_UMC0_MCUMC_STATUST0__Poison__SHIFT                                                            0x2b
-#define MCA_UMC_UMC0_MCUMC_STATUST0__Deferred__SHIFT                                                          0x2c
-#define MCA_UMC_UMC0_MCUMC_STATUST0__UECC__SHIFT                                                              0x2d
-#define MCA_UMC_UMC0_MCUMC_STATUST0__CECC__SHIFT                                                              0x2e
-#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV47__SHIFT                                                          0x2f
-#define MCA_UMC_UMC0_MCUMC_STATUST0__Transparent__SHIFT                                                       0x34
-#define MCA_UMC_UMC0_MCUMC_STATUST0__SyndV__SHIFT                                                             0x35
-#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV54__SHIFT                                                          0x36
-#define MCA_UMC_UMC0_MCUMC_STATUST0__TCC__SHIFT                                                               0x37
-#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreIdVal__SHIFT                                                      0x38
-#define MCA_UMC_UMC0_MCUMC_STATUST0__PCC__SHIFT                                                               0x39
-#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrV__SHIFT                                                             0x3a
-#define MCA_UMC_UMC0_MCUMC_STATUST0__MiscV__SHIFT                                                             0x3b
-#define MCA_UMC_UMC0_MCUMC_STATUST0__En__SHIFT                                                                0x3c
-#define MCA_UMC_UMC0_MCUMC_STATUST0__UC__SHIFT                                                                0x3d
-#define MCA_UMC_UMC0_MCUMC_STATUST0__Overflow__SHIFT                                                          0x3e
-#define MCA_UMC_UMC0_MCUMC_STATUST0__Val__SHIFT                                                               0x3f
-#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCode_MASK                                                           0x000000000000FFFFL
-#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCodeExt_MASK                                                        0x00000000003F0000L
-#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV22_MASK                                                            0x0000000000C00000L
-#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrLsb_MASK                                                             0x000000003F000000L
-#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV30_MASK                                                            0x00000000C0000000L
-#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreId_MASK                                                           0x0000003F00000000L
-#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV38_MASK                                                            0x000000C000000000L
-#define MCA_UMC_UMC0_MCUMC_STATUST0__Scrub_MASK                                                               0x0000010000000000L
-#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV41_MASK                                                            0x0000060000000000L
-#define MCA_UMC_UMC0_MCUMC_STATUST0__Poison_MASK                                                              0x0000080000000000L
-#define MCA_UMC_UMC0_MCUMC_STATUST0__Deferred_MASK                                                            0x0000100000000000L
-#define MCA_UMC_UMC0_MCUMC_STATUST0__UECC_MASK                                                                0x0000200000000000L
-#define MCA_UMC_UMC0_MCUMC_STATUST0__CECC_MASK                                                                0x0000400000000000L
-#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV47_MASK                                                            0x000F800000000000L
-#define MCA_UMC_UMC0_MCUMC_STATUST0__Transparent_MASK                                                         0x0010000000000000L
-#define MCA_UMC_UMC0_MCUMC_STATUST0__SyndV_MASK                                                               0x0020000000000000L
-#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV54_MASK                                                            0x0040000000000000L
-#define MCA_UMC_UMC0_MCUMC_STATUST0__TCC_MASK                                                                 0x0080000000000000L
-#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreIdVal_MASK                                                        0x0100000000000000L
-#define MCA_UMC_UMC0_MCUMC_STATUST0__PCC_MASK                                                                 0x0200000000000000L
-#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrV_MASK                                                               0x0400000000000000L
-#define MCA_UMC_UMC0_MCUMC_STATUST0__MiscV_MASK                                                               0x0800000000000000L
-#define MCA_UMC_UMC0_MCUMC_STATUST0__En_MASK                                                                  0x1000000000000000L
-#define MCA_UMC_UMC0_MCUMC_STATUST0__UC_MASK                                                                  0x2000000000000000L
-#define MCA_UMC_UMC0_MCUMC_STATUST0__Overflow_MASK                                                            0x4000000000000000L
-#define MCA_UMC_UMC0_MCUMC_STATUST0__Val_MASK                                                                 0x8000000000000000L
-//MCA_UMC_UMC0_MCUMC_ADDRT0
-#define MCA_UMC_UMC0_MCUMC_ADDRT0__ErrorAddr__SHIFT                                                           0x0
-#define MCA_UMC_UMC0_MCUMC_ADDRT0__LSB__SHIFT                                                                 0x38
-#define MCA_UMC_UMC0_MCUMC_ADDRT0__Reserved__SHIFT                                                            0x3e
-#define MCA_UMC_UMC0_MCUMC_ADDRT0__ErrorAddr_MASK                                                             0x00FFFFFFFFFFFFFFL
-#define MCA_UMC_UMC0_MCUMC_ADDRT0__LSB_MASK                                                                   0x3F00000000000000L
-#define MCA_UMC_UMC0_MCUMC_ADDRT0__Reserved_MASK                                                              0xC000000000000000L
-
-#endif
+#ifndef _umc_8_7_0_SH_MASK_HEADER
+#define _umc_8_7_0_SH_MASK_HEADER
+
+//UMCCH0_0_GeccErrCntSel
+#define UMCCH0_0_GeccErrCntSel__GeccErrCntCsSel__SHIFT                                                        0x0
+#define UMCCH0_0_GeccErrCntSel__GeccErrInt__SHIFT                                                             0xc
+#define UMCCH0_0_GeccErrCntSel__GeccErrCntEn__SHIFT                                                           0xf
+#define UMCCH0_0_GeccErrCntSel__PoisonCntEn__SHIFT                                                            0x10
+#define UMCCH0_0_GeccErrCntSel__GeccErrCntCsSel_MASK                                                          0x0000000FL
+#define UMCCH0_0_GeccErrCntSel__GeccErrInt_MASK                                                               0x00003000L
+#define UMCCH0_0_GeccErrCntSel__GeccErrCntEn_MASK                                                             0x00008000L
+#define UMCCH0_0_GeccErrCntSel__PoisonCntEn_MASK                                                              0x00030000L
+//UMCCH0_0_GeccErrCnt
+#define UMCCH0_0_GeccErrCnt__GeccErrCnt__SHIFT                                                                0x0
+#define UMCCH0_0_GeccErrCnt__GeccUnCorrErrCnt__SHIFT                                                          0x10
+#define UMCCH0_0_GeccErrCnt__GeccErrCnt_MASK                                                                  0x0000FFFFL
+#define UMCCH0_0_GeccErrCnt__GeccUnCorrErrCnt_MASK                                                            0xFFFF0000L
+//MCA_UMC_UMC0_MCUMC_STATUST0
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCode__SHIFT                                                         0x0
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCodeExt__SHIFT                                                      0x10
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV22__SHIFT                                                          0x16
+#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrLsb__SHIFT                                                           0x18
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV30__SHIFT                                                          0x1e
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreId__SHIFT                                                         0x20
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV38__SHIFT                                                          0x26
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Scrub__SHIFT                                                             0x28
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV41__SHIFT                                                          0x29
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Poison__SHIFT                                                            0x2b
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Deferred__SHIFT                                                          0x2c
+#define MCA_UMC_UMC0_MCUMC_STATUST0__UECC__SHIFT                                                              0x2d
+#define MCA_UMC_UMC0_MCUMC_STATUST0__CECC__SHIFT                                                              0x2e
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV47__SHIFT                                                          0x2f
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Transparent__SHIFT                                                       0x34
+#define MCA_UMC_UMC0_MCUMC_STATUST0__SyndV__SHIFT                                                             0x35
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV54__SHIFT                                                          0x36
+#define MCA_UMC_UMC0_MCUMC_STATUST0__TCC__SHIFT                                                               0x37
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreIdVal__SHIFT                                                      0x38
+#define MCA_UMC_UMC0_MCUMC_STATUST0__PCC__SHIFT                                                               0x39
+#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrV__SHIFT                                                             0x3a
+#define MCA_UMC_UMC0_MCUMC_STATUST0__MiscV__SHIFT                                                             0x3b
+#define MCA_UMC_UMC0_MCUMC_STATUST0__En__SHIFT                                                                0x3c
+#define MCA_UMC_UMC0_MCUMC_STATUST0__UC__SHIFT                                                                0x3d
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Overflow__SHIFT                                                          0x3e
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Val__SHIFT                                                               0x3f
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCode_MASK                                                           0x000000000000FFFFL
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCodeExt_MASK                                                        0x00000000003F0000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV22_MASK                                                            0x0000000000C00000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrLsb_MASK                                                             0x000000003F000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV30_MASK                                                            0x00000000C0000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreId_MASK                                                           0x0000003F00000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV38_MASK                                                            0x000000C000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Scrub_MASK                                                               0x0000010000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV41_MASK                                                            0x0000060000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Poison_MASK                                                              0x0000080000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Deferred_MASK                                                            0x0000100000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__UECC_MASK                                                                0x0000200000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__CECC_MASK                                                                0x0000400000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV47_MASK                                                            0x000F800000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Transparent_MASK                                                         0x0010000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__SyndV_MASK                                                               0x0020000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV54_MASK                                                            0x0040000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__TCC_MASK                                                                 0x0080000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreIdVal_MASK                                                        0x0100000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__PCC_MASK                                                                 0x0200000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrV_MASK                                                               0x0400000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__MiscV_MASK                                                               0x0800000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__En_MASK                                                                  0x1000000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__UC_MASK                                                                  0x2000000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Overflow_MASK                                                            0x4000000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Val_MASK                                                                 0x8000000000000000L
+//MCA_UMC_UMC0_MCUMC_ADDRT0
+#define MCA_UMC_UMC0_MCUMC_ADDRT0__ErrorAddr__SHIFT                                                           0x0
+#define MCA_UMC_UMC0_MCUMC_ADDRT0__LSB__SHIFT                                                                 0x38
+#define MCA_UMC_UMC0_MCUMC_ADDRT0__Reserved__SHIFT                                                            0x3e
+#define MCA_UMC_UMC0_MCUMC_ADDRT0__ErrorAddr_MASK                                                             0x00FFFFFFFFFFFFFFL
+#define MCA_UMC_UMC0_MCUMC_ADDRT0__LSB_MASK                                                                   0x3F00000000000000L
+#define MCA_UMC_UMC0_MCUMC_ADDRT0__Reserved_MASK                                                              0xC000000000000000L
+
+#endif
-- 
2.17.1

