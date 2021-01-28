Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C737A307D75
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhA1SJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhA1SEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:04:16 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA9BC061353
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:02:51 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a1so6359562wrq.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oz1ysPXY6dIT/8FVs8doLP4WQeUP6R82FsIHTFVdMfY=;
        b=PCshDChF2psB5lznsc62jLqInBWsbrTH3AsmsS8j2tnSnEfifferJeJSlH4zGWQzsU
         iC4RcRAUfGIvKi/vPDfg9w/x7etN9PzJkIi5f8VvJb7BPg47PRIDFpdylo4VvZ7Efd95
         HfabLRFDScWwg8o7flnyeAymFkEGMwFNrtvna1xFnI3y2Vzwa+RXPJuyjZlbOV6JWJmJ
         S3Au8Yxi1BJYHRunWw8lVec29AtpSKx/7UNsnmRMjW0D4RjcVyEfpKJVcb+2QZESr1rF
         pSKAx2L2ObvxqaSlLGnZNsNXo1Mjp93Wq9aROO75mDXn3HH4Djc7Z9lbIQOiToyuGk/K
         ICww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oz1ysPXY6dIT/8FVs8doLP4WQeUP6R82FsIHTFVdMfY=;
        b=K4SpnXXri4UuBBadT7sLMkhpyiL9sokVu0HlnCznLJ2AU9PGNZYqTZcutFrFqIp5cd
         oAhArjd8OmgCg8SmQHJdR2GHR7E7aiXbjJnJUC97cfKpWbpeOgP7Rl3/7nGUIXhXTQKT
         IakGkFiDDC4PlmQUDflaAF9j/a69S93IW6MZzlwXjCJlYYNCObD8NKhH46Yb1UXPJcdr
         Mi64OMEeBsHlovS21JO2gL7Le713SC6+dJiy8yfTA7nRouRD4YhCVs+7MlGeMwEN/oFD
         aUMnNGsnWwLJY3pWDIEv4REcjmuxxsjftDGPYO50FMqdOvNz7e2l5FsYT9qU/3YX/ueQ
         VP1Q==
X-Gm-Message-State: AOAM530DH7u5PVilf8Tr7PuOB2sZvSfxkekfCiWz4JTSk+HbNdguk5nG
        jz+pjf8JY+1n9CaVAB86/weJmg==
X-Google-Smtp-Source: ABdhPJwjPI5OWXbhQTA/ivFPtXo+b03sqvS4hAl+8fbvpeLCkCYcA4RrTpzKqjyfPmdSuPmatlQZ2g==
X-Received: by 2002:adf:e807:: with SMTP id o7mr331333wrm.308.1611856970720;
        Thu, 28 Jan 2021 10:02:50 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:02:50 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 06/20] ata: ahci_mtk: Ignore -Woverride-init
Date:   Thu, 28 Jan 2021 18:02:25 +0000
Message-Id: <20210128180239.548512-7-lee.jones@linaro.org>
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

 In file included from drivers/ata/ahci_mtk.c:18:
 drivers/ata/ahci.h:387:16: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/ahci_mtk.c:41:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:387:16: note: (near initialization for ‘ahci_platform_sht.can_queue’)
 drivers/ata/ahci_mtk.c:41:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/ahci_mtk.c:41:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: note: (near initialization for ‘ahci_platform_sht.sdev_attrs’)
 drivers/ata/ahci_mtk.c:41:2: note: in expansion of macro ‘AHCI_SHT’

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index c7c26a0ef7632..79c59550c23a0 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS_ahci_dm816.o		= $(call cc-disable-warning, override-init)
+CFLAGS_ahci_mtk.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_platform.o		= $(call cc-disable-warning, override-init)
 
 obj-$(CONFIG_ATA)		+= libata.o
-- 
2.25.1

