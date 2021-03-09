Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B99332738
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhCINcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhCINbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:31:42 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DFEC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 05:31:42 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id q204so9378084pfq.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 05:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1GtGC4SBuQ2ZFpLAGRU3Pq+Y262ZpPGaqfYEkH6Dyyw=;
        b=nF84KLAK6EzWsXH1yHWAfrQcJnhC4o8yyumHI0TBbY+I1ON60qF45+BdPznldjo8f3
         d8aoGI31x/rInG8GXv3w9dGS5jD6HzfVDPuDbsWBn96lgcqnRCPK0Vv7XAAGoW0EoBAC
         KExrBtd2dUdmxFxYPidcuWBVbzJoeFLovTG5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1GtGC4SBuQ2ZFpLAGRU3Pq+Y262ZpPGaqfYEkH6Dyyw=;
        b=VgY4019RZt8KgGbDm5rjH6Ke+o1X5NawrD4yRMnb0QKswNbslHeNwfDZvWPTkk4Hyf
         Ne1c7Qsl/9m5Xmq48I1sFQ4aiVfTfHBIbJEqHN5AipP9UfHLDNwpXfMwJd/y8kkE5YSo
         wBYZJjstU3SRxYFqUvCnXVuWHm7vYM1oW8qoZ7GEO+EvV+JulZesedc0wuMhfuLZIzie
         jleGmmCtba0SMlFkjKFFBqbYiMI0Hui6MvfjC55YBhp4Yu29ow6rivQSChJZ6ugK1FWG
         7M1ttttCDzh2DRTq+eds4Mt7PhNGtGP9CVNJ7CE4zvXsGO6vxQuTsrIgT/1UOVnJnqLs
         i+Rw==
X-Gm-Message-State: AOAM532xyXFTcMFJhefmjWK+p2LZMDtHhCu2WJmNUvWAxjJfxysxwDMM
        PR958MZSMwttInD/Sw1n0wNu3w==
X-Google-Smtp-Source: ABdhPJwPHn0LnuTNkj++gu3E8wnandxNGTpU86svGpOCxuksTcoujIetoFYAWLu2SylpmgP8eNF68Q==
X-Received: by 2002:a63:5b52:: with SMTP id l18mr25527277pgm.304.1615296702060;
        Tue, 09 Mar 2021 05:31:42 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:f936:57e5:154d:e0d9])
        by smtp.gmail.com with ESMTPSA id 138sm13678649pfv.192.2021.03.09.05.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 05:31:41 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Wolfram Sang <wsa@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-i2c@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v17 2/3] dt-binding: i2c: mt65xx: add vbus-supply property
Date:   Tue,  9 Mar 2021 21:31:30 +0800
Message-Id: <20210309133131.1585838-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210309133131.1585838-1-hsinyi@chromium.org>
References: <20210309133131.1585838-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vbus-supply property for mt65xx. The regulator can be passed into
core and turned off during suspend/sleep to reduce power consumption.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
index 7f0194fdd0cc..2c45647e9f0b 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
@@ -32,6 +32,7 @@ Optional properties:
   - mediatek,have-pmic: platform can control i2c form special pmic side.
     Only mt6589 and mt8135 support this feature.
   - mediatek,use-push-pull: IO config use push-pull mode.
+  - vbus-supply: phandle to the regulator that provides power to SCL/SDA.
 
 Example:
 
-- 
2.30.1.766.gb4fecdf3b7-goog

