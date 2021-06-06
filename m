Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1E639CDB8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 08:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhFFGx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 02:53:56 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:42766 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhFFGx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 02:53:56 -0400
Received: by mail-pf1-f179.google.com with SMTP id s14so9818650pfd.9
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 23:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/VrqiveNbCtM5JuL/Mi2oHd1uC30armETSsygvanFbc=;
        b=s6VhKMjxcJ+TQR9jgSEzprsqoGz+JJCpoC2iN0Hlgu67Ufu82/+PmzMU9uflr1eP/F
         R9cq91lI0Inof+ZDj2HhHceN2JQmFJsp2yCorb2PO9uAeZTATJtfIsPKqjapCN5rTFZI
         +0Rl9t2BZ/LyFJPyKyuYeJ5AkRKUI9Ofp3dYNqjljN99sKg36BfSwTjGEpwxPMUE82Rt
         Cg2LjCbpEsWLJRMTR6vibuyXabUn1HvwF8h/hZ6Z/ByPa7HJcVD6A0DrYEq60jcR6tWh
         l7YUB/wMAN3RyjiqK3ss5EGaygRTdtP8wN/56w+/ZUnU6JB0eeDVlyDf+MZYVnW6GQul
         c2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/VrqiveNbCtM5JuL/Mi2oHd1uC30armETSsygvanFbc=;
        b=FcivUWlmfZ7ofmQA6ZFPPZ645+AhKgf7j90OuoVtruqbP4vWRw0/WDrdnmJMuXh7mw
         sBo7kf5MsZAUtHcuaKqnnV01aAluFONKaAhMLicRnMuvIFfyMPeZppx527xyRizb0G5W
         te7sK+v5xbeTB6efW2GShcmEe5DGrsJ2XWxFyUj+AFfrkSnTO3XuP1T5IM8whCci9dKJ
         kbx/voaUZK5gnGXlmq8Y2VfIDAbv5uxUB1OD4zo/2KPhStDY66EujAQif9YDBtugD5uc
         Wyll2+092ctsCZnEdZRjUVujVF7mH9SbTZokCdNcze81RBjumQPpQqw4tPip7g2NyyEo
         +q7Q==
X-Gm-Message-State: AOAM533Vn7zdaP1wkWN/E7PvLAEUABdv+FPKRhNh+btKmfFchJubbpjR
        N2yD2ub3/iilvzVo8imeQzK0RA==
X-Google-Smtp-Source: ABdhPJw13WtMJBJIaK779Q2shRmxAMF/ySh7N/x33pnT1NR0/RwhxEaxzi5DGu/4h8w9k3sxr4oBKw==
X-Received: by 2002:a63:4c41:: with SMTP id m1mr12454653pgl.394.1622962266842;
        Sat, 05 Jun 2021 23:51:06 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id u21sm5324851pfh.163.2021.06.05.23.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 23:51:05 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Wen Su <wen.su@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/3] regulator: mt6358: Use unsigned int for volt_tables
Date:   Sun,  6 Jun 2021 14:50:50 +0800
Message-Id: <20210606065052.1417111-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regulator_desc expects "const unsigned int *volt_table", thus use
unsigned int instead of u32.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mt6358-regulator.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index 13cb6ac9a892..7c68d27d52bb 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -153,50 +153,50 @@ static const struct linear_range buck_volt_range4[] = {
 	REGULATOR_LINEAR_RANGE(1000000, 0, 0x7f, 12500),
 };
 
-static const u32 vdram2_voltages[] = {
+static const unsigned int vdram2_voltages[] = {
 	600000, 1800000,
 };
 
-static const u32 vsim_voltages[] = {
+static const unsigned int vsim_voltages[] = {
 	1700000, 1800000, 2700000, 3000000, 3100000,
 };
 
-static const u32 vibr_voltages[] = {
+static const unsigned int vibr_voltages[] = {
 	1200000, 1300000, 1500000, 1800000,
 	2000000, 2800000, 3000000, 3300000,
 };
 
-static const u32 vusb_voltages[] = {
+static const unsigned int vusb_voltages[] = {
 	3000000, 3100000,
 };
 
-static const u32 vcamd_voltages[] = {
+static const unsigned int vcamd_voltages[] = {
 	900000, 1000000, 1100000, 1200000,
 	1300000, 1500000, 1800000,
 };
 
-static const u32 vefuse_voltages[] = {
+static const unsigned int vefuse_voltages[] = {
 	1700000, 1800000, 1900000,
 };
 
-static const u32 vmch_vemc_voltages[] = {
+static const unsigned int vmch_vemc_voltages[] = {
 	2900000, 3000000, 3300000,
 };
 
-static const u32 vcama_voltages[] = {
+static const unsigned int vcama_voltages[] = {
 	1800000, 2500000, 2700000,
 	2800000, 2900000, 3000000,
 };
 
-static const u32 vcn33_bt_wifi_voltages[] = {
+static const unsigned int vcn33_bt_wifi_voltages[] = {
 	3300000, 3400000, 3500000,
 };
 
-static const u32 vmc_voltages[] = {
+static const unsigned int vmc_voltages[] = {
 	1800000, 2900000, 3000000, 3300000,
 };
 
-static const u32 vldo28_voltages[] = {
+static const unsigned int vldo28_voltages[] = {
 	2800000, 3000000,
 };
 
-- 
2.25.1

