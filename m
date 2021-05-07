Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F229A376473
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 13:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbhEGL3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 07:29:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42282 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbhEGL3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 07:29:08 -0400
Received: from mail-qk1-f197.google.com ([209.85.222.197])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1leyeN-0006rO-Is
        for linux-kernel@vger.kernel.org; Fri, 07 May 2021 11:28:07 +0000
Received: by mail-qk1-f197.google.com with SMTP id i141-20020a379f930000b02902e94f6d938dso5821285qke.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 04:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nvs/ClTYmViTVvVdTUIxxDVB5ynPNHL5ImJxUphB3LE=;
        b=KZQxWMdmsdeRMt2etGAlXK+RQ/64gLjjUwJIMFS/gk2cdXormqf2M3GHYKCCNLCW12
         K9v5LsaI6Z1+XnH52R2xGgDpFgamhg82g6IgKgUZp6pTS4F463n50VbVIhvWBobtDtnw
         8qNaU2Q4qAuJM499MaargyvkqmDAUXkeG2blp9PFw/xgcnkMlnCI6Yw3ERxvuXx/oxEH
         IbfYjD2Xbs6GASmOHI7N4NJRFRXZD7QP+6PmbyB4jEWGW0YRam5B7yeKXNqi/ux+qEDN
         6QY4UCALwuw6cOYRPLnqHY3Z1pmnK8k6le+aR5GPVZqK2jB55NMZpkN+VmygIMJHtv2r
         kP/Q==
X-Gm-Message-State: AOAM530i6PGT9mQ3rG9wOYma12OxJO62d7zPxfeTeaFEEob58+3qt/WM
        q0vk1xtwfKkfoQ7ZPyjS2DpbxwoFBTlRkFCPI5eE3L8ZBojfk8a0EtF29ivec5oEPqyQcYJVO4a
        R8lHb6gPr94zPINWFio4bTLJSeR2tTbmmC+hVdfev+w==
X-Received: by 2002:ad4:5c68:: with SMTP id i8mr9292119qvh.53.1620386886756;
        Fri, 07 May 2021 04:28:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrkQV2V+1r0D6RUCLE65m0mi6+3ZTeG/IsJ0FUNXfad49nVUfaO+dm1EKUCC1juOtFTefkGg==
X-Received: by 2002:ad4:5c68:: with SMTP id i8mr9292104qvh.53.1620386886587;
        Fri, 07 May 2021 04:28:06 -0700 (PDT)
Received: from localhost.localdomain ([45.237.49.2])
        by smtp.gmail.com with ESMTPSA id a21sm4549293qkk.45.2021.05.07.04.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 04:28:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Thor Thayer <thor.thayer@linux.intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] reset: a10sr: add missing of_match_table reference
Date:   Fri,  7 May 2021 07:28:03 -0400
Message-Id: <20210507112803.20012-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver defined of_device_id table but did not use it with
of_match_table.  This prevents usual matching via devicetree and causes
a W=1 warning:

  drivers/reset/reset-a10sr.c:111:34: warning:
    ‘a10sr_reset_of_match’ defined but not used [-Wunused-const-variable=]

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 627006820268 ("reset: Add Altera Arria10 SR Reset Controller")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/reset/reset-a10sr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/reset-a10sr.c b/drivers/reset/reset-a10sr.c
index 7eacc89382f8..99b3bc8382f3 100644
--- a/drivers/reset/reset-a10sr.c
+++ b/drivers/reset/reset-a10sr.c
@@ -118,6 +118,7 @@ static struct platform_driver a10sr_reset_driver = {
 	.probe	= a10sr_reset_probe,
 	.driver = {
 		.name		= "altr_a10sr_reset",
+		.of_match_table	= a10sr_reset_of_match,
 	},
 };
 module_platform_driver(a10sr_reset_driver);
-- 
2.25.1

