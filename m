Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223393B2B47
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhFXJYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhFXJYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:24:20 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8449BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 02:22:00 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d11so5881929wrm.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 02:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eil13llqRA8gYhUtxKkI3REM+ezUGVLrIHE4Cv2dVF8=;
        b=uhjdive/O7I2WAuxOtK/E1s2j/zgeRvQzfihlEW8X/mI6MelZSIx1sNhvw83vrwVS3
         8Nd+BLc0014wUTXeUJ4A7kgZHjUUuqF6+lO7crQJs+StROQx///ECIVDXxq75RLqkqQv
         /0NUlGqw5GahfYINcQAmor72L2Jwodfhcg0Fx5szchgiP8SjcpMehH/ME8mGH9kOTb78
         OiM5Nt6fe90IR9LKc4lOSnE6kYMAjlIBqLh4eGFqb+Rt2ZPGJ5CS1T/7Njt7KYKOCf8t
         ne5KgG8W6X8pjnoIysVJUC9abq8vmjkvWwA8SBS28kT5giu0J55ePt3PQlrmDFAuj+fe
         12DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eil13llqRA8gYhUtxKkI3REM+ezUGVLrIHE4Cv2dVF8=;
        b=pEx0YQykj0U4P7HiC+pJ1qNlTuoYW6ZGay7QDY6Qe5e7TcNeyylJsr/NJed5xyGc63
         cxscgsYJVkVWCTQ40wlHOwkLLjiK6mbSGF5jAE8m//o13Q9VESnPhzRnHZR+Crs3mwbd
         5bDhZ4nIjSWwTcbxp8i0vJtwIfyoNj28wRcYqpeQwh+y2Otn/jgeadfAgV1eeoJwfovH
         1JZqzFE4X3XxG9hb0bBE+7rD8B2CvGEkHZLfNpf7DCtuccvmVZZdfb5GLY23MScrMtWz
         ttRo8TOdSmhEh52FTj5mFS8QLYAjGSrT7c3xMfsN2sPBHE9RA8BdOelo89dvr3EnDOmE
         OxNQ==
X-Gm-Message-State: AOAM531VYgnnZK0lonYsOuvAdznc5UBwfCjn58v8GU843yliV/ZJOFd0
        Y1tpUTgNWGV/9U/NG8Pjsdwr4A==
X-Google-Smtp-Source: ABdhPJztlTt5zmiHbLHkei3r2qRcSGTuDwQiJ31CFKymrlQ3Ku1mjf4fKdAVOaYllWr2BwpDAXBP0A==
X-Received: by 2002:a5d:4dd2:: with SMTP id f18mr3260555wru.86.1624526518958;
        Thu, 24 Jun 2021 02:21:58 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id u18sm2235066wmj.15.2021.06.24.02.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 02:21:58 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Subject: [PATCH] ASoC: qcom: lpass-cpu: mark IRQ_CLEAR register as volatile and readable
Date:   Thu, 24 Jun 2021 10:21:53 +0100
Message-Id: <20210624092153.5771-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently IRQ_CLEAR register is marked as write-only, however using
regmap_update_bits on this register will have some side effects.
so mark IRQ_CLEAR register appropriately as readable and volatile.

Fixes: da0363f7bfd3 ("ASoC: qcom: Fix for DMA interrupt clear reg overwriting")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-cpu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 0b9cbf2ce505..8998697cd1e1 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -525,6 +525,8 @@ static bool lpass_cpu_regmap_readable(struct device *dev, unsigned int reg)
 			return true;
 
 	for (i = 0; i < v->irq_ports; ++i) {
+		if (reg == LPAIF_IRQCLEAR_REG(v, i))
+			return true;
 		if (reg == LPAIF_IRQEN_REG(v, i))
 			return true;
 		if (reg == LPAIF_IRQSTAT_REG(v, i))
@@ -566,9 +568,12 @@ static bool lpass_cpu_regmap_volatile(struct device *dev, unsigned int reg)
 	struct lpass_variant *v = drvdata->variant;
 	int i;
 
-	for (i = 0; i < v->irq_ports; ++i)
+	for (i = 0; i < v->irq_ports; ++i) {
+		if (reg == LPAIF_IRQCLEAR_REG(v, i))
+			return true;
 		if (reg == LPAIF_IRQSTAT_REG(v, i))
 			return true;
+	}
 
 	for (i = 0; i < v->rdma_channels; ++i)
 		if (reg == LPAIF_RDMACURR_REG(v, i))
-- 
2.21.0

