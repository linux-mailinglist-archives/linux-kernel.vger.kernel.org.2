Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835F13A202D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 00:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhFIWhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 18:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhFIWhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 18:37:16 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A48C0617AE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 15:35:11 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id d1so25078644ils.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 15:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7yhJsF4sf6g0J5+Wkc48fcn32kH/upZlX3LD7ehd/r4=;
        b=iFlIBZ5Mfm422uNt/F8WgwSdZtKGzWTZh3G+ld6B0meYU3+rtqEvJwkYq5NhfktNke
         tkk/L11PPenB5WKqj3hbau+He4BwCZLpvF+B260RFmumja1p5XwcAjuaHLJVIyk+0hrv
         OOvc3tgadnFuw53wVD8up3iVlfVpZKHRESVMUU+d0ta4zDkuD0tm/pnsTJT0X2E14atw
         NPWGHoNq3NBGPaCeijG0gd4hJZX2TN302h+RNeQ5bJf75ss5NEMvaAHNoDsu3/M9GE9Y
         ysRYR/+1yGXPZ3kQMb5TYlzXh1JrlafbyhCFIrpdiP5jr7O7L+meOkhxmBiEamgOtTZL
         fKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7yhJsF4sf6g0J5+Wkc48fcn32kH/upZlX3LD7ehd/r4=;
        b=b3y3ALT//YWERbvGEblZR5YNS2bjKOlJVsQvzWORLNundt4N6RNcBweRYeM34zjQRU
         Hsz6JPS2Ovbm+8LG8oF0Di2rO0ji9CJSi3ZXBhQHmgj7cNvqJzefTdM+Z9FxCHeWy/li
         kX7C+yXOUg0ou5uHYvhGOV2QZauTwisrl6X4mF78FfQ02uLZd1Tqb+HY6YqecD/otjLT
         zbM35p3YhMF/cUh/2nCaAzQzqV1MDxQ90dpGnr+k1MhN0WRw9iXExh/N/tjL6S91pkP6
         H43KcXYb+oP5DBywARFaWsyJxZqdfE8s5YYfgmWjFUZYueIP2sDITvaXIhS1mLcXYJBg
         eQsw==
X-Gm-Message-State: AOAM531L3wTj7noLl7E4oH7aCvD1LeqMV9UG+QftIyLgDRz0JeZp0jEp
        jEcmYpiWHLjlCuHbwQiyLWm5oA==
X-Google-Smtp-Source: ABdhPJxtRPenfKwI8qEBXz0IOHU2YL7XSkC5FvxqzEPNu1fTEZtBkj0ucI738VZx69YrFJOS3Vkz2A==
X-Received: by 2002:a05:6e02:108f:: with SMTP id r15mr1390270ilj.86.1623278111240;
        Wed, 09 Jun 2021 15:35:11 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id c19sm750165ili.62.2021.06.09.15.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 15:35:10 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 05/11] net: ipa: separate region range check from other validation
Date:   Wed,  9 Jun 2021 17:34:57 -0500
Message-Id: <20210609223503.2649114-6-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210609223503.2649114-1-elder@linaro.org>
References: <20210609223503.2649114-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only thing done by ipa_mem_valid_one() that requires hardware
access is the check for whether all regions fit within the size of
IPA local memory specified by an IPA register.

Introduce ipa_mem_size_valid() to implement this verification and
stop doing so in ipa_mem_valid_one().  Call the new function from
ipa_mem_config() (which is also the caller of ipa_mem_valid()).

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_mem.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipa/ipa_mem.c b/drivers/net/ipa/ipa_mem.c
index 62e1b8280d982..f245e1a60a44b 100644
--- a/drivers/net/ipa/ipa_mem.c
+++ b/drivers/net/ipa/ipa_mem.c
@@ -115,9 +115,6 @@ static bool ipa_mem_valid_one(struct ipa *ipa, const struct ipa_mem *mem)
 	else if (mem->offset < mem->canary_count * sizeof(__le32))
 		dev_err(dev, "region %u offset too small for %hu canaries\n",
 			mem_id, mem->canary_count);
-	else if (mem->offset + mem->size > ipa->mem_size)
-		dev_err(dev, "region %u ends beyond memory limit (0x%08x)\n",
-			mem_id, ipa->mem_size);
 	else if (mem_id == IPA_MEM_END_MARKER && mem->size)
 		dev_err(dev, "non-zero end marker region size\n");
 	else
@@ -151,6 +148,28 @@ static bool ipa_mem_valid(struct ipa *ipa)
 	return true;
 }
 
+/* Do all memory regions fit within the IPA local memory? */
+static bool ipa_mem_size_valid(struct ipa *ipa)
+{
+	struct device *dev = &ipa->pdev->dev;
+	u32 limit = ipa->mem_size;
+	enum ipa_mem_id mem_id;
+
+	for (mem_id = 0; mem_id < ipa->mem_count; mem_id++) {
+		const struct ipa_mem *mem = &ipa->mem[mem_id];
+
+		if (mem->offset + mem->size <= limit)
+			continue;
+
+		dev_err(dev, "region %u ends beyond memory limit (0x%08x)\n",
+			mem_id, limit);
+
+		return false;
+	}
+
+	return true;
+}
+
 /**
  * ipa_mem_config() - Configure IPA shared memory
  * @ipa:	IPA pointer
@@ -184,6 +203,10 @@ int ipa_mem_config(struct ipa *ipa)
 			mem_size);
 	}
 
+	/* We know our memory size; make sure regions are all in range */
+	if (!ipa_mem_size_valid(ipa))
+		return -EINVAL;
+
 	/* Prealloc DMA memory for zeroing regions */
 	virt = dma_alloc_coherent(dev, IPA_MEM_MAX, &addr, GFP_KERNEL);
 	if (!virt)
-- 
2.27.0

