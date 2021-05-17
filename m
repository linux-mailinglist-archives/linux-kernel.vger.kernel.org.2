Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65EA8382BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 14:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbhEQMCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 08:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236859AbhEQMCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 08:02:01 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61F9C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 05:00:43 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r11so6493733edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 05:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lmFwxPH6uZIhTgCsywft7PH2wef0MTrIdaT6v6CivLo=;
        b=KFsxpfyNvY/btnr3O0yRWEtaqltgCHNzm0TOCI8UkDV2BOYShpYQuOrS7r6+B/WUpa
         ECrmRxw+pyxdrxgLFYpr45Gb8qKFNHjbmwOoT0b54LWr7rnCxnXQ3Hg3LlLX31C9/F4X
         izAcb1krioly0mP8WfudrTnq6XxeERJ2fIW638LQn9eiF+lYbzHWd8cF4/SQjIbbLdGY
         hIAu58KcPaFIXjFLIzgZwYoogzuWMXpa0PSUsq9sQ1xrgsd0ytTqfeB6/pvG5VnDvao1
         2PGAKZVXPVquXt3qT/Ph4NW5eDMMth6Dke5oPZ7Fhb7csAzBLxfmu6ib8hYzooZq6VdO
         bMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lmFwxPH6uZIhTgCsywft7PH2wef0MTrIdaT6v6CivLo=;
        b=KGm3klvZywHcO7BP/F7Q64ySACy/1otb9VEMDi06wXNQYkMYkdZ9SugJIe/D8rjju+
         LY1XvB+g3Btv92F2iA61sspSaL5cOoJJKl18whhYgRlH34LvbBuBdr2UwdsvNu1jIvc0
         pSXNBaYXVv8WmimqcTEx8rXAYTRDvcov/7pkhWsErYDRGJucVuCbjpFU1bLoMWh/99c4
         NF1AVP7SCIkFyw0rHFybQp4lDwMFAGtqW70vgHqsbIvgHz+98LuV8K6SCCGlL4YxHqRX
         CUaJ7sxb7TDbeXRxhTLHXGtzP4Wj6W8Sk78k+cQdp2B5oej+I6SmplNuBUVLXUOknLd/
         /IEA==
X-Gm-Message-State: AOAM530J/dW8ipZPLPV+akj8BViNaKbpjPiSsggNYRkuwyu3QW1CJfTK
        VTNWIlFECxT58B0dI7CcXDgXQw==
X-Google-Smtp-Source: ABdhPJxEkv/fQt9deN9fhiM48UvlD9OdB+DAToniHxhEaIO2jVzex4Rk83UhMKgjs9tZRkfMB8Xadw==
X-Received: by 2002:aa7:db93:: with SMTP id u19mr29799656edt.227.1621252842566;
        Mon, 17 May 2021 05:00:42 -0700 (PDT)
Received: from localhost.localdomain (dh207-99-66.xnet.hr. [88.207.99.66])
        by smtp.googlemail.com with ESMTPSA id yw9sm8537232ejb.91.2021.05.17.05.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 05:00:42 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>
Subject: [PATCH v2] soc: qcom: socinfo: Add remaining IPQ6018 family ID-s
Date:   Mon, 17 May 2021 14:00:34 +0200
Message-Id: <20210517120034.3975027-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ID for IPQ6018 was previously added, but ID-s for rest of the
family are missing.
So, lets add those based on downstream driver.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Reviewed-by: Kathiravan T <kathirav@codeaurora.org>
---
 drivers/soc/qcom/socinfo.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index f6cfb79338f0..6ded90cf3813 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -255,7 +255,11 @@ static const struct soc_id soc_id[] = {
 	{ 351, "SDA450" },
 	{ 356, "SM8250" },
 	{ 402, "IPQ6018" },
+	{ 403, "IPQ6028" },
+	{ 421, "IPQ6000" },
+	{ 422, "IPQ6010" },
 	{ 425, "SC7180" },
+	{ 453, "IPQ6005" },
 	{ 455, "QRB5165" },
 };
 
-- 
2.31.1

