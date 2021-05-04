Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255293729E7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 14:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhEDMPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 08:15:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41496 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhEDMPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 08:15:38 -0400
Received: from mail-qt1-f200.google.com ([209.85.160.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1ldtwo-000148-PT
        for linux-kernel@vger.kernel.org; Tue, 04 May 2021 12:14:42 +0000
Received: by mail-qt1-f200.google.com with SMTP id r20-20020ac85c940000b02901bac34fa2eeso3372903qta.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 05:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2jrHuSrwRsSBaANh1fW2x8t+NrzkJf+pmPZRwAI6hhI=;
        b=nhitBBlNJuu7xChzLc1I8mZ85wYuFPrEG5BcvqXr2QTqCJ/sbPv30U8VIjsc2tcqeW
         yK61k3XUDZcUpKiWH5S568sUO3ZduGG8dXpC49YwmaSzr+v98FdELsuWPhe9+JhRnne8
         clbF5iztkn9Q0NS1zRdp0Qnc471XiP2N6rsip6MVsVSnIrTXkgfmFUyTG60xQ08RKgyL
         LxE7WJ/kRTcAcZbry5brTy1mxPZYQ78dP8YpH8qgxS/KVNxCDmQaM7xpOxuxzj5nm9Ri
         bbRSJGwZlKrj8xb3HyBWoBU5ZhDcfxUO3SY1dySl8xNliq3/roCmuw/LMOZQbSmwLjhT
         VtYA==
X-Gm-Message-State: AOAM532nVg0az2mF6dol3qo7LTRkFXKFt6DPZ1qSQWUDjy1JNnPgLwk9
        q78DeUKpSOOiSu8RUpeEHLtbxwIteWx7SRZRO3WRaxInJXh/E4D2sAq0zZmrigoZb/MsgPIT2wW
        WpmcW9i7zyp19MEIGz0T/2D2GCVlq+menJ16IGPMfUA==
X-Received: by 2002:a05:6214:a62:: with SMTP id ef2mr19916177qvb.31.1620130482025;
        Tue, 04 May 2021 05:14:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfTe7sTJl6AKixtSfV1yALubwrsCN0jqdi8R0pr10kYahin2lK2I1QmOQq1q4omwSb3OIA7g==
X-Received: by 2002:a05:6214:a62:: with SMTP id ef2mr19916162qvb.31.1620130481914;
        Tue, 04 May 2021 05:14:41 -0700 (PDT)
Received: from localhost.localdomain ([45.237.49.5])
        by smtp.gmail.com with ESMTPSA id v66sm10743990qkd.113.2021.05.04.05.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 05:14:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] MAINTAINERS: power: supply: use Krzysztof Kozlowski's Canonical address
Date:   Tue,  4 May 2021 08:14:37 -0400
Message-Id: <20210504121437.13424-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to Canonical address in S3C power supply driver, just like in
other entries.

Cc: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1783372a608a..ccb9823fb77f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16021,7 +16021,7 @@ W:	http://www.ibm.com/developerworks/linux/linux390/
 F:	drivers/s390/scsi/zfcp_*
 
 S3C ADC BATTERY DRIVER
-M:	Krzysztof Kozlowski <krzk@kernel.org>
+M:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
 L:	linux-samsung-soc@vger.kernel.org
 S:	Odd Fixes
 F:	drivers/power/supply/s3c_adc_battery.c
-- 
2.25.1

