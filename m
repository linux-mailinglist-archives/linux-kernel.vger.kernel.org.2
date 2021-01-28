Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01469307D9B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhA1SPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbhA1SHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:07:21 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC292C061A29
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:03:07 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id g10so6350390wrx.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uLTjdVY72aKyqSF59N/uJRYV12gUSHg1TskoZb+zwxc=;
        b=XxpSF2uP2v0W9RW2VCJqhChGAX6WSCAXs6w4ijZe6v+12yrVxLzHWT1Ec/Q+f/FtXI
         9HqklksJde6eMBy/0MI4UQM5rIzajbYvZgaXfZv1WnfdVhfWIadYljnqt0OGCCgOgex4
         kYi6InAkGU0oFT0kDeOzCT+T/eYaBP8f/ATqDzUoD2dJ8ZBTmZsjNw28UDwA2i30psU7
         QjTanU5sTVW7sPPBj6jpc+3Ct+XEYM6sH+DrHzWoXx2ysWqds68bJPs1xsvqbBsqszxJ
         ctswyt4WdjEGjUELBK2BBMQNfdqOv/aNhV7mWh0K0JpxUZbLVLQBV/OJPzqMr4dnsFdl
         kXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uLTjdVY72aKyqSF59N/uJRYV12gUSHg1TskoZb+zwxc=;
        b=MhtUQn+quw2jWyPUrBTL3cSgvaAhXEyvFry7MAnTyQuHY2RuGFIsk/gOoQr6gGStfU
         7zYNAOG1gzoc0+Gi3S4jK2vov+Z4mMJn9hg3U+ysDWn2PxtpseDJnsEDW9MgnsFEoeWh
         VUagKPMx5anfi0EnLvjC+XRdvijm3MjTTebUk45VN1Sxmk9ici9W0gvfd8qgq5qIBNL/
         Dd7HZ5dDSPihBj363Qgwj9S0m0Sm0rWH1KN1IedEH12KIm0vV7QT/PQF/814vCsQPCyb
         rGC9NzeTlr76hFwbe0MCdzO9xiLGnFfWzCAdMrO+0CN/zw3M9Gy+AoWoLx3JOtviDe3c
         L3aA==
X-Gm-Message-State: AOAM530h+gGOdN8aJiY+spuKPtgj17MBrJX4/bzn76sdftF4AznTaXIL
        HQYq49SzrR5DMExsLwsr6xGXIw==
X-Google-Smtp-Source: ABdhPJyWSuYrKMWdaIv71fSya9X1MGXlIYeadHHN2MFhUwF+tSJksHr5Ryna9O09obzzpWv9VnBglg==
X-Received: by 2002:a5d:6044:: with SMTP id j4mr247434wrt.287.1611856986700;
        Thu, 28 Jan 2021 10:03:06 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:03:06 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 20/20] ata: ahci: Ignore -Woverride-init
Date:   Thu, 28 Jan 2021 18:02:39 +0000
Message-Id: <20210128180239.548512-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128180239.548512-1-lee.jones@linaro.org>
References: <20210128180239.548512-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some ATA drivers use the SCSI host template, a series of interwoven
macros, to aid with initialisation.  Some of these macros conflict,
resulting in the over-writing of previously set values.

This is known behaviour and can be safely ignored.

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/ata/ahci.c:35:
 drivers/ata/ahci.h:387:16: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/ahci.c:104:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:387:16: note: (near initialization for ‘ahci_sht.can_queue’)
 drivers/ata/ahci.c:104:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/ahci.c:104:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: note: (near initialization for ‘ahci_sht.sdev_attrs’)
 drivers/ata/ahci.c:104:2: note: in expansion of macro ‘AHCI_SHT’

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index a6755a524efa0..4580a0306bf3d 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS_acard-ahci.o		= $(call cc-disable-warning, override-init)
+CFLAGS_ahci.o			= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_brcm.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_ceva.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_dm816.o		= $(call cc-disable-warning, override-init)
-- 
2.25.1

