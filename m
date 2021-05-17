Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7149382A47
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbhEQKyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbhEQKyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:54:50 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FD8C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 03:53:34 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id e19so4677529pfv.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 03:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yTBxlhVVQ6O5eAhomhBBjHn+XCVqzUbosulYbl171R0=;
        b=qhcfziigPT7XIWX42Rcy+Q1CvCnFV3sLU7zTexFQtkn5WhttcU6tdaSbKFLWWqGrWu
         mta9om4bcUNLul/CF0hkCILZNz5gIm6f/f9CD7pzc76Qq8luDc/6uk/i6a6dn2UXJqkO
         CFvwqzPxXzdx4Qe1KRYtntDflt2Upab2T/sZNBHEMYuq7N7lFYpxAgVnPt/FAjWkM5+1
         1tOY/t2hPbG1s0Fr3X10gwixFgyei/64nHFJEi3F2riiGhAY8VdjoSt6RF/iQ9HPyUPo
         cBjRRzLjanXOXv2g3Nrq2SsbtHvkhGcApSCh8tL8GPUHngcCROEVX7iHYZoeXV3CS3kD
         OENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yTBxlhVVQ6O5eAhomhBBjHn+XCVqzUbosulYbl171R0=;
        b=lfGiFfBwbrS8MrIGYqkz33FmDDAi2JVcIcjBdBkkkqoqD9ho7EQc6Xqc/rA00cYPjr
         3U7zo0y8dJnSlCU2YUNAai/3xOqklzD0hGeuQWxJYfniRnVxcHfVsEab/uIywycAg8v+
         bU27VGd4WmmMK1HwZbxNLiM/9FEN7pKSoEKgWUx6iLlAA42iSdyToB6txUC2cCP15sDS
         9eL/Q9QhE0p2FOmr/gQpQ9DIDhTIXcAc/IcQJ2LsXiH5TmgjaIjEVooju8d5wy+LIYCA
         hdVMx0ORGe+67iaQKX5+zJaM9OTbbmm3EVBUAx6VBmZT8nvOqauBMDgQt8dVPOuN2nSO
         jNJw==
X-Gm-Message-State: AOAM531v9ReW3sLMM7S33qz83mRA1T5NNqtSbvnp0h32oCbO3YktCRVC
        JTzEnVBcDj/KXdAJfDEXGPLleg==
X-Google-Smtp-Source: ABdhPJxnVyb7acAwoXIIBnmX0AH24LZ6wYVNmFI9u6fao4dTRCSfV/8ZgZrKyrnMiG0OEN80YEF/hA==
X-Received: by 2002:a65:4689:: with SMTP id h9mr23537713pgr.347.1621248814185;
        Mon, 17 May 2021 03:53:34 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id 187sm9511700pff.139.2021.05.17.03.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 03:53:33 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Christoph Fritz <chf.fritz@googlemail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v2 1/2] regulator: fan53880: Fix missing n_voltages setting
Date:   Mon, 17 May 2021 18:53:24 +0800
Message-Id: <20210517105325.1227393-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: e6dea51e2d41 ("regulator: fan53880: Add initial support")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
v2: address Christoph' comment
 drivers/regulator/fan53880.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/fan53880.c b/drivers/regulator/fan53880.c
index e83eb4fb1876..1684faf82ed2 100644
--- a/drivers/regulator/fan53880.c
+++ b/drivers/regulator/fan53880.c
@@ -51,6 +51,7 @@ static const struct regulator_ops fan53880_ops = {
 		      REGULATOR_LINEAR_RANGE(800000, 0xf, 0x73, 25000),	\
 		},							\
 		.n_linear_ranges = 2,					\
+		.n_voltages =	   0x74,				\
 		.vsel_reg =	   FAN53880_LDO ## _num ## VOUT,	\
 		.vsel_mask =	   0x7f,				\
 		.enable_reg =	   FAN53880_ENABLE,			\
@@ -76,6 +77,7 @@ static const struct regulator_desc fan53880_regulators[] = {
 		      REGULATOR_LINEAR_RANGE(600000, 0x1f, 0xf7, 12500),
 		},
 		.n_linear_ranges = 2,
+		.n_voltages =	   0xf8,
 		.vsel_reg =	   FAN53880_BUCKVOUT,
 		.vsel_mask =	   0x7f,
 		.enable_reg =	   FAN53880_ENABLE,
@@ -95,6 +97,7 @@ static const struct regulator_desc fan53880_regulators[] = {
 		      REGULATOR_LINEAR_RANGE(3000000, 0x4, 0x70, 25000),
 		},
 		.n_linear_ranges = 2,
+		.n_voltages =	   0x71,
 		.vsel_reg =	   FAN53880_BOOSTVOUT,
 		.vsel_mask =	   0x7f,
 		.enable_reg =	   FAN53880_ENABLE_BOOST,
-- 
2.25.1

