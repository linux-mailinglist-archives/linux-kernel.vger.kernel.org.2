Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13594383B54
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 19:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242162AbhEQRek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 13:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbhEQRei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 13:34:38 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE326C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 10:33:21 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g24so4063406pji.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 10:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YyJT27jROY3Us4aMnHuX9K8cycTBbP5Zslf0mdWBiXw=;
        b=CK62iBCy/RQ2BjPv1yClrCpAUpbt+Ysb53ae8FWiM42bso9RpHF+lBg7+pyc1yQeU1
         rcmaOWJJw9UpilQYrizPKIOcJ2PUdwiP992l5W8ureZM+ZFrz20yQkjcdyC/vZCrwUPA
         UMrG8/WzqWupAwiDxke6qgyLEef8Eaf4Sjgn1+tj3kaDWrghW+cfG2db4BQxpTo4h7D2
         Wdq5Ob+D2hPmAlA+LwfFJ4OhXz8Dhr1X3lpTHWIo1GPkpfmFp1GGtMUVPtI9NJZWX3nf
         IO/Oda3HHi1PM4pyM/K4F5Mf5+4ZnN/oEZDZg82xgt2QYtxmLXuZP1kVp0d6WUwOKkez
         gjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YyJT27jROY3Us4aMnHuX9K8cycTBbP5Zslf0mdWBiXw=;
        b=mJw6qts5gHhcF0VY1VcR6XtLXXM0W0Qtw4ETRHySSjhbPWqCRdP2I3W5c/azrBVcTQ
         i78o0j9+OyI+xmOGtIhg4ggXJlt1pODbyiAVmd4ggRPtXLyRnz4Q4muoTXCVxcQTS50W
         zf1iS4Q6/AowAyITPq+t/gEMAsslIRcGNAJ9jM1FJt1HvGzy924QNzzWk7oyXzcvdDeN
         hlCg/D23r4au+jq4+Eg1Vj6D0P1sp4wUWWKE6ycc8dwR0vrgKwqJl24rmpbxLtVbyU6d
         44vkSIF8/PxIXZDNmFk152Za8mYw37T+3MZaQgO7nAjCpm4mN9BoPfk5SbdV4nY+uPb2
         k7Ug==
X-Gm-Message-State: AOAM532VciFU1ec+zT3yuZg3mx/FlQf5yGwTZyzl3Cr4wpvREUp9J14U
        /c/s/0VdW4OjP2an/cVBxsA=
X-Google-Smtp-Source: ABdhPJzKiFisdsryRyyPlxTEC5N4xeu4PT4pPr526crQuP/kU94npr7pMnPRBuXFqs5uz4ipGk1dlg==
X-Received: by 2002:a17:90a:fc8f:: with SMTP id ci15mr537328pjb.147.1621272801488;
        Mon, 17 May 2021 10:33:21 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:47e:c24d:6c72:a52:2c8:7df1])
        by smtp.gmail.com with ESMTPSA id c12sm10358296pfr.154.2021.05.17.10.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 10:33:21 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH v8 0/10] mfd: mt6360: Merge different sub-devices I2C read/write
Date:   Tue, 18 May 2021 01:33:04 +0800
Message-Id: <20210517173314.140912-1-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series merge different sub-device I2C read/write into one Regmap and
fix coding style for well-organized.

Gene Chen (10)
  mfd: mt6360: Rearrange include file
  mfd: mt6360: Remove redundant brackets around raw numbers
  mfd: mt6360: Indicate sub-dev compatible name by using
  mfd: mt6360: Combine mt6360 pmic/ldo resources into mt6360
  mfd: mt6360: Rename mt6360_pmu_data by mt6360_ddata
  mfd: mt6360: Rename mt6360_pmu by mt6360
  mfd: mt6360: Remove handle_post_irq callback function
  mfd: mt6360: Fix flow which is used to check ic exist
  mfd: mt6360: Merge header file into driver and remove unuse register define
  mfd: mt6360: Merge different sub-devices I2C read/write

 drivers/mfd/Kconfig        |   1 +
 drivers/mfd/mt6360-core.c  | 552 ++++++++++++++++++++++++++++++---------------
 include/linux/mfd/mt6360.h | 240 --------------------
 3 files changed, 376 insertions(+), 417 deletions(-)

changelogs between v2 & v3
- Replace mt6360_data to mt6360_ddata
- Split I2C read/write to regmap driver

changelogs between v3 & v4
- Merge back mt6360 regmap driver to MFD driver

changelogs between v4 & v5
- use devm_regmap_init
- define crc calculation magic number

changelogs between v5 & v6
- Remove unrelated change
- Remove regulator device of_compatible

changelogs between v6 & v7
- Replace OF_MFD_CELL by MFD_CELL_RES

changelogs between v7 & v8
- use MFD_CELL_RES for regulator sub-device and sync codebase to latest


