Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7337C4393C7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 12:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbhJYKf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 06:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbhJYKf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 06:35:57 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C23FC061243
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 03:33:35 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g10so16528043edj.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 03:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gtXEbVNAEMP2fIX0FN1mTXTkNu2gxV03Z7XtTW5qZGI=;
        b=lud7xTvvv7SSrJ4ZVXj4n3sTCtB3XgEGe/pZjUgBinjzWS0BK3cVapFx5YDEAOqYdy
         OMa5Cswx0p19NFK5dFDY8h/nfxMLZKPq+LncN10pzMOoxAvrgPjr0+Mfkdrznsl+LTGL
         Tj2t99Iarp1TbcuSis/PKVBrMlZFmdBPkXKPdbRzq0rGGB1ZqRQIKhk90sE6k72oQNEw
         CLV8p+aKFkVG0+RQAUuW+XhO6iM8GH2ElYoJsuYq5pmxXbbz1h5YtjqjMabev06tPD+6
         JVPxw/g9j/9yZ4EmPTdFkZiByNfACqahmBxslZPO7SVk88NKbs52svQAMHcxu4eQcPMO
         nFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gtXEbVNAEMP2fIX0FN1mTXTkNu2gxV03Z7XtTW5qZGI=;
        b=SEG9/qIIWZixZKlZAClpCCdsSjCqQfUwWKfQfTxi0bD7kkM4LG0J6BoaEc5+vJrYr5
         FFlFoopNs521K3PgArN68fqEOunjnZ7fFta4utURH3AU/DY9lKipfkgqbXp98lIZSRHr
         q2SMdDr2lN39K4+cpwyNbaBPEgSBQ+1Jm4jc8UuDgrZkra08iMAmKRCmOnuuOuCwo+uK
         5VFLfr6KZ79fmEguIc/UMiDxMFbaJ9xjbR3RzYBNJ2IHagIRzoIR8CmY77GFDbuRzZmt
         3Qb3u7fPaGjoSxNArMQ5B6NwehDV3YI7I3hjtTPLVj6fWCSMnJdYrE1saWYX0CGq6w0j
         Govw==
X-Gm-Message-State: AOAM532OIyb+MfOPTTy1jra9soWeytSaVXDNwHuzv6wTusglgz+gVtrz
        F0FCafKqoPpVCcF5P8245mfw/w==
X-Google-Smtp-Source: ABdhPJxyz8wed5e9lJ191A1Sw4zknkZdq0E6LTsECxkZVJ5Wcllj8LVVRVx/s+8UcU0o7+aWqpzimw==
X-Received: by 2002:a17:907:7b9e:: with SMTP id ne30mr5200109ejc.531.1635158013466;
        Mon, 25 Oct 2021 03:33:33 -0700 (PDT)
Received: from localhost.localdomain (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id k23sm8562822edv.22.2021.10.25.03.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 03:33:33 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     robert.foss@linaro.org, todor.too@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, mchehab@kernel.org, robh+dt@kernel.org,
        angelogioacchino.delregno@somainline.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Subject: [PATCH v1 1/2] media: dt-bindings: media: camss: sdm845: Make clock-lanes property const
Date:   Mon, 25 Oct 2021 12:33:21 +0200
Message-Id: <20211025103322.160913-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mistakenly only one out of four CSI ports had the clock-lane marked as
const.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 .../devicetree/bindings/media/qcom,sdm845-camss.yaml     | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml b/Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml
index 9ca5dfa7f226..d8fb6ce1d7f9 100644
--- a/Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml
@@ -106,7 +106,8 @@ properties:
 
             properties:
               clock-lanes:
-                maxItems: 1
+                items:
+                  - const: 7
 
               data-lanes:
                 minItems: 1
@@ -153,7 +154,8 @@ properties:
 
             properties:
               clock-lanes:
-                maxItems: 1
+                items:
+                  - const: 7
 
               data-lanes:
                 minItems: 1
@@ -176,7 +178,8 @@ properties:
 
             properties:
               clock-lanes:
-                maxItems: 1
+                items:
+                  - const: 7
 
               data-lanes:
                 minItems: 1
-- 
2.30.2

