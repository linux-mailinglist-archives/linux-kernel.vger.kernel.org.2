Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B91307DAE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhA1SR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhA1SGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:06:11 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B6AC0611C0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:03:02 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id 7so6362297wrz.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RnaBivPDyIR6gMAHAoH39HuDWPvuUIfAphuD3A1F0ZE=;
        b=GmTt6uepAz3Dn8NZmdm/BpZmoDDL7JOogKQSj/2DdscZhtv74SQ3r/PuDlDeSForKM
         o5+rbKyl5ATV6x06CbajjAu6abcqUq8sObBpfUXgwKD0GdKkoDwniAUcuFY2a0FwAAYu
         +Qa/Na6KUrTg9/jQlzFcZZHJdIRb1NImmmQTvvy4YdSjlu+lqINGVXOodnVNaPh74vkA
         AP7antxMT6B0JYzbuXNgSrb07xCThkY03NIQZ3aS9mvKs8mQacXQCIm9chMlc0BHDWot
         Yl4K3CbN5hKt54wYnGPI3eKRLPdl70gICFBfr34rg4I2NgmbT8mdl1H8PZl/DV6+75aI
         HMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RnaBivPDyIR6gMAHAoH39HuDWPvuUIfAphuD3A1F0ZE=;
        b=XSTOMiMkQ2uaAQsJIlZyjo3I3XpC/rjj+cJ3V8IfMzJYUyWTOG3EvQ40i3CCanCH+q
         EHn2rb2F2PaX2V0ZUFr+Qdlwgeae/v93r1gBnCRS63o9cKkDjM/aj6WzJnvJ6Vuv7GwV
         gyo62KBdeZgpihhVireB2J9titklOE59ZGMNp0lYB0D1eWW9hrseH9oXiNBpqx+DJF1E
         ZEAnOQuBI0nF5U9BDiYVo59YtZjYTDhV+FTWQNaG0aQbL9MhJxJwRN2F2pYhh1prNCKm
         kNCBFZKHIfS0XR/AUJJte7UeMkyOvjOvw0ZzmIUh9dsSdPtQ6xwjbrHUoRM3sxlvaUfi
         bW8Q==
X-Gm-Message-State: AOAM5319bQev2vK1o/N0MSIEf1CenyAnqDB5hGvV9SSQIx67NacH1GtJ
        3qTXWBcMzji0at8pmp3atgr1wA==
X-Google-Smtp-Source: ABdhPJyQoFfgxJ9wREOuyYhhU7/FmotdW8dZeHkvFg/1RJHmXWvNuU2KrLPJd6Ia32VJzLOcpRkxQg==
X-Received: by 2002:a05:6000:108b:: with SMTP id y11mr233167wrw.379.1611856980901;
        Thu, 28 Jan 2021 10:03:00 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:03:00 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 15/20] ata: sata_highbank: Ignore -Woverride-init
Date:   Thu, 28 Jan 2021 18:02:34 +0000
Message-Id: <20210128180239.548512-16-lee.jones@linaro.org>
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

 In file included from drivers/ata/sata_highbank.c:25:
 drivers/ata/ahci.h:387:16: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/sata_highbank.c:442:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:387:16: note: (near initialization for ‘ahci_highbank_platform_sht.can_queue’)
 drivers/ata/sata_highbank.c:442:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/sata_highbank.c:442:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: note: (near initialization for ‘ahci_highbank_platform_sht.sdev_attrs’)
 drivers/ata/sata_highbank.c:442:2: note: in expansion of macro ‘AHCI_SHT’

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index d46703777cdd4..cf851f5a4e7fd 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -5,6 +5,7 @@ CFLAGS_ahci_ceva.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_dm816.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_mtk.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_platform.o		= $(call cc-disable-warning, override-init)
+CFLAGS_sata_highbank.o		= $(call cc-disable-warning, override-init)
 CFLAGS_sata_sil24.o		= $(call cc-disable-warning, override-init)
 
 obj-$(CONFIG_ATA)		+= libata.o
-- 
2.25.1

