Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8EAB3942D6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbhE1Mo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:44:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42532 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235763AbhE1Mn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:43:56 -0400
Received: from mail-ua1-f71.google.com ([209.85.222.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmboi-00080d-NQ
        for linux-kernel@vger.kernel.org; Fri, 28 May 2021 12:42:20 +0000
Received: by mail-ua1-f71.google.com with SMTP id 78-20020a9f26540000b02902426fc5ddd3so571376uag.16
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iEB2h4Bn3lCrV1o5tVk2hyJU4Tj+yg0ZQdaMOEhsgd0=;
        b=O0K2CirkUQphwqlUMp9qDjpPqRTYxZc4oKMNFIpI2bfcUHNjRvS5hNbQ/KVYz+ugK2
         6M2AimU/tcCBf4sPd3vbhFCaE5fBE2Yu2/yhh1Xgl6UvZd5w3O3wxzME71S1cndk99T4
         fJdQRXbR3mXZiMpI+OBFW9svhunCoG47NxCsIoRSqk5epw4GRsyyXOzxuHcD0gPtfatP
         AWGzoVlZui+uqV+FhIfjpiiLwn2K+qqIecYs64PNdQRRxRmyZLWOswMdvO1vlXIkT9UU
         K4XFLu2YPIuPG8SyfTfIait7G0fz6ODDttky2ljut68xg0Jogcd9GQduw0+us+G5UXlh
         2lHA==
X-Gm-Message-State: AOAM532bo6jIglqMRdLRQbuG/ZaTwI+boI+KmtiB+jsSdKN9wDIhKI0s
        dmp5dIldgVwgPbIH6RSsOK0E1IJt+O7NLqR/PbE5kBTqK7wMJuah8mkKUeLQSSsuuVi51W2wWrl
        zV21J5WIymE3zSvNqwyC9X0ZgEYxsqLMpITrWDRuFvw==
X-Received: by 2002:a67:10c1:: with SMTP id 184mr6783942vsq.37.1622205739808;
        Fri, 28 May 2021 05:42:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWllFrdrg6Jbn+aBJ5/GUhoFVyAz32AVwfOxffn/3s94HonEx3zuiiuqroeuZJehFCIblIDA==
X-Received: by 2002:a67:10c1:: with SMTP id 184mr6783923vsq.37.1622205739642;
        Fri, 28 May 2021 05:42:19 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id b35sm782328uae.20.2021.05.28.05.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:42:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] nfc: s3fwrn5: mark OF device ID tables as maybe unused
Date:   Fri, 28 May 2021 08:41:56 -0400
Message-Id: <20210528124200.79655-8-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528124200.79655-1-krzysztof.kozlowski@canonical.com>
References: <20210528124200.79655-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match either via OF or I2C ID tables.  If OF is disabled,
the table will be unused:

    drivers/nfc/s3fwrn5/i2c.c:265:34: warning:
        ‘of_s3fwrn5_i2c_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/s3fwrn5/i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/s3fwrn5/i2c.c b/drivers/nfc/s3fwrn5/i2c.c
index 38b8d6cab593..4d1cf1bb55b0 100644
--- a/drivers/nfc/s3fwrn5/i2c.c
+++ b/drivers/nfc/s3fwrn5/i2c.c
@@ -262,7 +262,7 @@ static const struct i2c_device_id s3fwrn5_i2c_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, s3fwrn5_i2c_id_table);
 
-static const struct of_device_id of_s3fwrn5_i2c_match[] = {
+static const struct of_device_id of_s3fwrn5_i2c_match[] __maybe_unused = {
 	{ .compatible = "samsung,s3fwrn5-i2c", },
 	{}
 };
-- 
2.27.0

