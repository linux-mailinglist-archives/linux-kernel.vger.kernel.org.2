Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAF0327C57
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 11:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbhCAKiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 05:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbhCAKd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 05:33:57 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272B7C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 02:33:17 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id f12so11733121wrx.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 02:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kbnph1EgCCLH/ZUBf6ushQsd4tna/Kgc6Gzslj73xqg=;
        b=cWDsnU98vH2ApOyNibkem6GKZR0VtBIlcN4tmz85vBXntQid5CblUXICB76TEgzcES
         d+fyDncdu8sc6MymQZlxr8vcIH6eI5ZX5Uib+Zzr6mDzOAe9nd8PqZw18RTAor/XZ9Zu
         gqsAtMsoXn30hMQ6OuFcxRpXiaKsHsGzMee/joslOXBjiSyj+aB7uiagcZvJsExcShDj
         qgZw/5KbH55INzEp27bOFfcAAOaNksH7YkZvVj+s21dyuDZPgy2xUCUIqRNMyo25DaZO
         FopsJ9vujmuvKlf22rR9aJ/2UCqjNkbfiupCaskxdexUsVkn3NbBXK6uPaD7JUW7+AfC
         sUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kbnph1EgCCLH/ZUBf6ushQsd4tna/Kgc6Gzslj73xqg=;
        b=h9ZMvnts0bP3ow5AN5KdZChVwzu9PajYGgwcqnkgA+Axo5GsB97n7oo60a+2pK1K7D
         9MCnbpjRGookvItmVzW55pKOUh7HGywCxvzHzj7uJZA+xgj1ZNAU5ojv2tH13mhEv/oF
         YxdeQUUdZcnxRQWDTRTXcb7mcGBjnguxIgSwbSnEI3/ubTWprO0kPOUmbeF8iig9q7SZ
         9GeMzUOkgHTNkhewIcb6i6BqidYw5GczH8eS9sy4oFTcl22EuMIcSW6iprdwkeSGXZyI
         PAVWQcbe6VyU/+0ZEmR+nWz/tBcNbDveT2cJZgyOcMKOBcwbnE5/lU9ZKkGoKxXqkOHr
         H1nw==
X-Gm-Message-State: AOAM533WcbQ2J86/8QjFAW2CafRNcu5KL/RIVy/iknx9bax7lNNvGSrn
        5Z0maasfnCRd6TZisZdGFWSAfQ==
X-Google-Smtp-Source: ABdhPJx7TX1Vb/WAmbpLxMUAg8GrEv61MnwbIOHCHBzra1kdALsnpwqHAJlbUCRrFUsXPjgxOwpWBg==
X-Received: by 2002:adf:f90d:: with SMTP id b13mr16901223wrr.198.1614594795951;
        Mon, 01 Mar 2021 02:33:15 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id m3sm8033651wmc.48.2021.03.01.02.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 02:33:15 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        andreas@kemnade.info, devicetree@vger.kernel.org
Subject: [PATCH 1/1] dt-bindings: mfd: ricoh,rn5t618: Trivial: Fix spelling mistake of 'additionally'
Date:   Mon,  1 Mar 2021 10:33:09 +0000
Message-Id: <20210301103309.2404426-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml b/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
index d70e85a09c84e..032a7fb0b4a71 100644
--- a/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
+++ b/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
@@ -15,7 +15,7 @@ description: |
   GPIOs, and a watchdog timer. It can be controlled through an I2C interface.
   The RN5T618/RC5T619 provides additionally a Li-ion battery charger,
   fuel gauge, and an ADC.
-  The RC5T619 additionnally includes USB charger detection and an RTC.
+  The RC5T619 additionally includes USB charger detection and an RTC.
 
 allOf:
   - if:
-- 
2.27.0

