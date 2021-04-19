Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCB2364850
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 18:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239271AbhDSQeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 12:34:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38543 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239093AbhDSQeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 12:34:15 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYWqG-00028x-NQ
        for linux-kernel@vger.kernel.org; Mon, 19 Apr 2021 16:33:44 +0000
Received: by mail-ed1-f70.google.com with SMTP id v5-20020a0564023485b029037ff13253bcso11492755edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 09:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZS3kDXJbb+yWpJYeuhePkBZuXsYPhImHPxwdAy9xHJY=;
        b=BeZ/v6+XtcERzuIRy56jIROCYH7f7BOwuA21ID7goedrhmh6CAsbhD6NU/fqqOuGFK
         2cFelF1n2ODFCrCEdcHAr5LIOvJkpH6xr21ndfSmOmoK557eZE2XrcRUcjkrSrfcMkTs
         LbxuAi3MoSWySFaaP7Ib6rtCeQRZENJovkojmHzgoVKA3TaN34LrCj92YMqNUABgHDvU
         p8Hxj7CeqcCMA/x2/GfxrsGkvGVuNRYmXL5fflOfMaH1sRMCwT7cnnFTRUfacGDMTry2
         NJ0RFlV0mKfkQg1vWHzzKsG/CpPTRtjQeNR1nPdSuezHwu+Q2RA33eytoZB9lEcwlqCH
         WcVw==
X-Gm-Message-State: AOAM533q5dpSpjUC4oMVRNbBTK52SP7Vd/5MWi2wSNs6DG9B3jNwNYgm
        jzOMgwYgWaod3kNeUvzgruJICFlpt2wc1QsHWi9vltt1Kd1FCpHVQ3YjcTnpBJ9iEGNOzIYLg1V
        7T6kxtYP6ovdTbLY4aVBbxAoOAXs380kAIcOr6IxjhA==
X-Received: by 2002:a05:6402:274d:: with SMTP id z13mr27160881edd.344.1618850024045;
        Mon, 19 Apr 2021 09:33:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0Nlz3x2uIOlIMFvCXOrt3t1Rrh6I6eJcYBGtc1yfXtuXqnznZudlXWhga/rZMGGak1BMwDg==
X-Received: by 2002:a05:6402:274d:: with SMTP id z13mr27160869edd.344.1618850023920;
        Mon, 19 Apr 2021 09:33:43 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id d10sm10884257ejw.125.2021.04.19.09.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 09:33:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] power: supply: act8945a: correct kerneldoc
Date:   Mon, 19 Apr 2021 18:33:35 +0200
Message-Id: <20210419163336.64075-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419163336.64075-1-krzysztof.kozlowski@canonical.com>
References: <20210419163336.64075-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove incorrect kerneldoc marker to fix W=1 warning:

  drivers/power/supply/act8945a_charger.c:22: warning:
    This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/power/supply/act8945a_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/act8945a_charger.c b/drivers/power/supply/act8945a_charger.c
index 5f3eb6941d05..e9b5f4283772 100644
--- a/drivers/power/supply/act8945a_charger.c
+++ b/drivers/power/supply/act8945a_charger.c
@@ -18,7 +18,7 @@
 static const char *act8945a_charger_model = "ACT8945A";
 static const char *act8945a_charger_manufacturer = "Active-semi";
 
-/**
+/*
  * ACT8945A Charger Register Map
  */
 
-- 
2.25.1

