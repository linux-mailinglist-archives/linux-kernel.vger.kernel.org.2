Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A21393F3E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbhE1JHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbhE1JGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:06:51 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA67C061763
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:05:16 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id z137-20020a1c7e8f0000b02901774f2a7dc4so6408439wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QKY7Nwt97Wel376ZxrfOUdfc8QT+39QiKI00VWQO/14=;
        b=cETsOJWQgQVIPEsVJjUzNFQmUWMmPee1hcTqqOuWmu7/ai4R8HMTiT1EfvHP9eHWcK
         11FcyFFb/ryknvG1Www6P18bTeFhkrUONNRDhX125P2ruK4but07UxTh0UZ+mlrduB93
         ezosoNKqtQRvO0rUlmOQi6uOC17M1fwY9Fz2pnuHAF9w7FrKB2ZNNAH+mA9+VNsbUn7K
         ScFI2FhpyYl7JuL8fDBP769JDbbcg6p/w3sZnlIKnRvbBxFV3SHLVMRQtkJ6VqY6eJsg
         xnpZkgQP1Bh/svbdbjSDHq5/YJPTeCjzTrgoQ023Cjb5WoIpv8VY3kNarBFxdd9mbWLI
         DBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QKY7Nwt97Wel376ZxrfOUdfc8QT+39QiKI00VWQO/14=;
        b=kCteHXblK5iBZqWx2wh/Q0KvsDatM9mjxioY9dHde63ZNa6F0G4tuTTgfpclw/A3UF
         zTkOPJZVRqGRbHvxQaukYTtUGNMygNV7UYiIIyH+77bbwfUZCgyE+TIdTocrH9F8YfML
         uu3FFP2a9shaySvh2/cHs3e3Zn2eO2CR69FmxorAj/ummqkFYeXYhqPwmbQGtKlK4/r8
         a0YdVoHhs8yG55PycsEB/ynjjz5ktwAOc1i41YjXk+Eueip+fBe4GDQIOERXFuae++zO
         sVS+3orhkJmIhScziyPvYWBd23LDZg14aTjN47jvONTb5Ucl52KWayQNvwJn2Q3bl+Lj
         4dlQ==
X-Gm-Message-State: AOAM533ALxNz3D70CvEWYz7PEP07MFQ1VPopLhTavgiinxExN7q6Qc6M
        YnWWXdZLXbo41wxyqTYu14apjyuZpSR9Rw==
X-Google-Smtp-Source: ABdhPJxUQmT2mCaxsuzt0DkPUWwZBKAAH94RsxoIBGrhQGVgAqC6MnQeY6WnCJam1ZDPv+wuQfDinw==
X-Received: by 2002:a05:600c:2e43:: with SMTP id q3mr7404576wmf.75.1622192714749;
        Fri, 28 May 2021 02:05:14 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id q11sm7193937wrx.80.2021.05.28.02.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:05:14 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andre Hedrick <andre@linux-ide.org>, linux-ide@vger.kernel.org
Subject: [PATCH 10/11] ata: pata_serverworks: Avoid overwriting initialised field in 'serverworks_osb4_sht
Date:   Fri, 28 May 2021 10:05:01 +0100
Message-Id: <20210528090502.1799866-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528090502.1799866-1-lee.jones@linaro.org>
References: <20210528090502.1799866-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_serverworks.c:257:18: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/pata_serverworks.c:257:18: note: (near initialization for ‘serverworks_osb4_sht.sg_tablesize’)

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_serverworks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index 7511e11eef4d6..b602e303fb54c 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -253,8 +253,9 @@ static void serverworks_set_dmamode(struct ata_port *ap, struct ata_device *adev
 }
 
 static struct scsi_host_template serverworks_osb4_sht = {
-	ATA_BMDMA_SHT(DRV_NAME),
+	ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize	= LIBATA_DUMB_MAX_PRD,
+	.dma_boundary	= ATA_DMA_BOUNDARY,
 };
 
 static struct scsi_host_template serverworks_csb_sht = {
-- 
2.31.1

