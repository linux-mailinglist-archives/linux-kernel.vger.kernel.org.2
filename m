Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF753AAB14
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 07:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhFQFg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 01:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhFQFg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 01:36:57 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E58FC061760
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 22:34:50 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso3156525pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 22:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UcB/vjjB0e9gJipKA//v703MbAzCMRsupGuwwOTjDio=;
        b=fgXIaaj0HsETVKRyV7KBf7e8L7whuTkRdRypBzdMxreL8fpjS/pj+jJmzd/e6Tqsoc
         fwz8wO2Ex40oAjBGyov+1j71RuXcfPZzstyUVkSOtB+fkkJGA2MaBq268rPFZH3K05AX
         lkozkVGK9PW7AEUmagUY7QhmXxxIF6/YEGfaRuLAuPewiWAEDgbHtPCq/3ejFk9cKeBw
         A1ckh0w3ipZWbLUGS/Nk/hvpqsgJpJnt3RsCUQxoSclVLbyH4wY6ljG7uS/MBqhIopDI
         I9DAkT7PcDUtFbZYSelMnwPvDSuFbHQE6sPPJKxLsJc+jf0aEHwgMVCkGtoyTG0qYJf0
         mBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UcB/vjjB0e9gJipKA//v703MbAzCMRsupGuwwOTjDio=;
        b=M6L0qfLc4vaqc+hZiK6aCPzN+T8Vqn/mI7h0KQM9AosKpiUUoeiyKaHaudVvE1P8v0
         biovXtWYw83ArN8hB28I1PQ3Gcrdw6VBM0fk8vuaM6qP49RQ0Zipzt6vhj02BFPxl+5u
         L3t+dQJKBkrfo/gIeHZMc1c2g9TyoJoAgyl2QtxxguWwRnEqMXpFXod4gqKAORQV+6Qw
         DQ/bJmUmrDvWbpQHe7mBVUfscqGw8HCNLPORV2O9gjcXuWKIJF1b3Yg1Y0XKwPpWn+6E
         gcPeYNj0/EuErY2tXwx0nuVaKu9brtjrg8rYrHTXcUf83tbplWjrjBAtx7ZOUuQpztHj
         KRwQ==
X-Gm-Message-State: AOAM531YY+ceVwqEsQgU2LC4nwRiBwJJ3YfG6GiUoV9nnry5NmPaff0d
        uXTVouNiI8W0iPWA+9k9pViyww==
X-Google-Smtp-Source: ABdhPJyPwl7B31LdfVyW4xxhljTdgfTaKBwcQ7ULtqWZptk2a47gLvT69SNWtCi1HT4v67HIoi2N2w==
X-Received: by 2002:a17:90a:1da3:: with SMTP id v32mr2774502pjv.192.1623908089665;
        Wed, 16 Jun 2021 22:34:49 -0700 (PDT)
Received: from localhost.name ([122.177.46.2])
        by smtp.gmail.com with ESMTPSA id m126sm4056405pfb.15.2021.06.16.22.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 22:34:49 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v3 2/4] dt-bindings: pinctrl: qcom,pmic-gpio: Add compatible for SA8155p-adp
Date:   Thu, 17 Jun 2021 11:04:30 +0530
Message-Id: <20210617053432.350486-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210617053432.350486-1-bhupesh.sharma@linaro.org>
References: <20210617053432.350486-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pmic-gpio compatible string for pmm8155au pmic
found on the SA8155p-adp board.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
index 10f049e21264..95d158848546 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
@@ -33,6 +33,7 @@ PMIC's from Qualcomm.
 		    "qcom,pmi8994-gpio"
 		    "qcom,pmi8998-gpio"
 		    "qcom,pmk8350-gpio"
+		    "qcom,pmm8155au-gpio"
 		    "qcom,pmr735a-gpio"
 		    "qcom,pmr735b-gpio"
 		    "qcom,pms405-gpio"
@@ -122,6 +123,7 @@ to specify in a pin configuration subnode:
 		    gpio1-gpio2  for pmi8950
 		    gpio1-gpio10 for pmi8994
 		    gpio1-gpio4  for pmk8350
+		    gpio1-gpio10 for pmm8155au
 		    gpio1-gpio4  for pmr735a
 		    gpio1-gpio4  for pmr735b
 		    gpio1-gpio12 for pms405 (holes on gpio1, gpio9 and gpio10)
-- 
2.31.1

