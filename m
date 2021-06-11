Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA19F3A3E10
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhFKIf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbhFKIf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:35:56 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3A9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 01:33:58 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r9so5098363wrz.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 01:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d8CKXn9DQPKLP6mUKa+qf9JWrLpTzX9+0oTw0bzOVlg=;
        b=S0l92iDNpaYoe9I1wOIQdkDAbDJ91jAE4GZhLyhBBY1DM8gl6TfFXsSWP5o4aL/8Td
         mOGmKO/sQXC6pd/JHNzojeZlY4N21SKrQha8FkY9jdV3AExJDkwPDPWJqFtWzRCW/3Px
         3R1Tk3K+zq2nGyI1zNvc9IiOw9x2ubEt2sDadUhxpZ+EM9lDaTIBA4ZV/iTAWddXbFgC
         w9xO3mH6B3T/zIomYhVilLOcE4y8ekTdBo0oXhbcZP22b3o0uCV02O4yQUuOBT2/Ubue
         xB7luf/qjM3qNoEktDMsq2076ANj+M+yKbG7gw+9DGV+qmynoCMyAn5RlhHNYxxQ8slX
         74nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d8CKXn9DQPKLP6mUKa+qf9JWrLpTzX9+0oTw0bzOVlg=;
        b=b+s9dSeT2ALwQFUg+ozqv5NojZSToqceTVA92wUe5KTMavwF24Pd2fYoWgz4M050Eg
         PwVy0abFR4kZyYHL2Ojf1UtM8L9Nf/fAaQBdyWf8Ms2oP6aYFFHvrm3K0XLPv9wSODhD
         xQ1ZGVSZ5Yr+VkcFEwr5UT2ZeNGAJD7XuSeF9k5hKs5ymHKX15PH0WqBxOnlh1X2tvN6
         Aw8mno1yYwGKXPn3xW0gBW2V6Q/lNCeyaH2jOOtE9NAs5K9nTSkL6/AzHVOuDMx5iEQ9
         WxlzpAf6VO0vOEDJBBEwepFudEbBtlPf4bY5TQ9osyzq6S9fJtaTUFSnqSRPFgsR0lZ1
         rrzA==
X-Gm-Message-State: AOAM530xC1WkLNIYkCJHiuUnkgvRv1cWNjyjWI8t4TGfySbgt4ch4ZwD
        PLlbq/CyyfXek1qC7Yu+hwxAGA==
X-Google-Smtp-Source: ABdhPJxuw7D4pLza02hZrnMy9PJ0vCu5AdsLwOkcZbURMNyUAtR22PMiB00Grj7mrWQPJOZPh5QN+w==
X-Received: by 2002:adf:a284:: with SMTP id s4mr1116754wra.397.1623400436810;
        Fri, 11 Jun 2021 01:33:56 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n42sm11547428wms.29.2021.06.11.01.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 01:33:56 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/9] nvmem: sprd: Fix an error message
Date:   Fri, 11 Jun 2021 09:33:43 +0100
Message-Id: <20210611083348.20170-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
References: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

'ret' is known to be 0 here.
The expected error status is stored in 'status', so use it instead.

Also change %d in %u, because status is an u32, not a int.

Fixes: 096030e7f449 ("nvmem: sprd: Add Spreadtrum SoCs eFuse support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sprd-efuse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
index 5d394559edf2..e3e721d4c205 100644
--- a/drivers/nvmem/sprd-efuse.c
+++ b/drivers/nvmem/sprd-efuse.c
@@ -234,7 +234,7 @@ static int sprd_efuse_raw_prog(struct sprd_efuse *efuse, u32 blk, bool doub,
 	status = readl(efuse->base + SPRD_EFUSE_ERR_FLAG);
 	if (status) {
 		dev_err(efuse->dev,
-			"write error status %d of block %d\n", ret, blk);
+			"write error status %u of block %d\n", status, blk);
 
 		writel(SPRD_EFUSE_ERR_CLR_MASK,
 		       efuse->base + SPRD_EFUSE_ERR_CLR);
-- 
2.21.0

