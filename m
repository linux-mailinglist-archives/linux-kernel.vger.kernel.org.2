Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6674730AA3C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhBAOsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhBAOly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:41:54 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036E6C061355
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 06:39:54 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id c4so14119064wru.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 06:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BlJPa4weJ+jes2vrsBZmFk9aHoMXb6b/UAhdjjLI1xw=;
        b=F0SiN9DmZ1Xdcfbxi61rTAlrPyojJUgAzZ/1RiUTkgtwwca9O5QhFjwlBbbEQtWEHX
         WNAMHH+XxfmPqKtxm/uEYnrLU7lY+o5PYd9ilDZP9bztnMjeVYm/PI9cvtl4iTAlI8N/
         z4JGm0Ea3lMswss6UGbF4P3vWPMQRotQvB59WFypEUG0ta9Zgr3Pjr6ftz90vwk4DIAI
         1iK9KD+iUQ3zjKDzlOdKpp2hK5vOPIzfP7IQIPSCmBgg7YMCnH9kSIelnxRfa21Zo6Rb
         cpra3uvnXL4N66hgn+AshdROd6hPH+soSkrdyyveu/XnE+eCcMG4AtbFc/+RAlnO+7/c
         RP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BlJPa4weJ+jes2vrsBZmFk9aHoMXb6b/UAhdjjLI1xw=;
        b=EPdC4QWT8elq7DC9V5m9Y7BIgv0ZtjD7etTSgaLxCbN8gnGiRLr2SWlQQHKN0lOanH
         5X7aadsXDpRTAl2W7Eo6FBy+1Zv7Ha/2AtyE/DgFYlDSt9NhZn8ktHLtxL7CwvwyJQvZ
         ResBCUDqQJG1Rktc7C087VDjHDisgVcFl4ShmhgUQ69aDlaJUXv51L0agFIEMKvPWTRt
         8Sb1n0ADQIBSnuOqH15nLvwRgMbi5pYSXoITVj4ttgk4amWtLDvuvgEXaWE1U75kiusv
         E/GkqvQC73yKiK7Nv/NA3s0T+XB4HDsqT35V/jt2kB9uLi/quiIynpNuNjGgfLk12nhn
         2zow==
X-Gm-Message-State: AOAM530c3MBOcLu0QPRTnZIHa2N02MGP1dtrrY3ghSGcckgWu2eCBFcD
        rof7LuGehbRQEv0f62/Aa362BQ==
X-Google-Smtp-Source: ABdhPJwmhRhU9Ly9NFrfSfP/oHtPUxEQBV7+5lmrquiTKc1I6Z5/0LBvOlyxwZje10Yq+NQTGg9UNg==
X-Received: by 2002:adf:f749:: with SMTP id z9mr18083441wrp.327.1612190393694;
        Mon, 01 Feb 2021 06:39:53 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:39:53 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Loc Ho <lho@apm.com>, Tuan Phan <tphan@apm.com>,
        Suman Tripathi <stripathi@apm.com>, linux-ide@vger.kernel.org
Subject: [PATCH 09/20] ata: ahci_xgene: Fix incorrect naming of 'xgene_ahci_handle_broken_edge_irq()'s 'host' param
Date:   Mon,  1 Feb 2021 14:39:29 +0000
Message-Id: <20210201143940.2070919-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/ahci_xgene.c:564: warning: Function parameter or member 'host' not described in 'xgene_ahci_handle_broken_edge_irq'
 drivers/ata/ahci_xgene.c:564: warning: Excess function parameter 'ata_host' description in 'xgene_ahci_handle_broken_edge_irq'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Loc Ho <lho@apm.com>
Cc: Tuan Phan <tphan@apm.com>
Cc: Suman Tripathi <stripathi@apm.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/ahci_xgene.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 16246c843365e..dffc432b9d54a 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -537,7 +537,7 @@ static int xgene_ahci_softreset(struct ata_link *link, unsigned int *class,
 
 /**
  * xgene_ahci_handle_broken_edge_irq - Handle the broken irq.
- * @ata_host: Host that recieved the irq
+ * @host: Host that recieved the irq
  * @irq_masked: HOST_IRQ_STAT value
  *
  * For hardware with broken edge trigger latch
-- 
2.25.1

