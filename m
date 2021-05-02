Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70512370B60
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 13:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhEBLye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 07:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhEBLyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 07:54:33 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C8DC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 04:53:41 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id n25so3167063edr.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 04:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snejp.pl; s=gmail;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gQhNcy2LNQytLGOWB93x3Yia/FlpQuGD9oTfRwaHwtc=;
        b=YRDDjmMQ4uz6Yg8/UFaM1VFNIMQbNSCUy3AgtxJj0MM7IwRwPtLyffG1VCLA+P8NWj
         G2Sv70kuzDojxXTB54ZXPKVAxJLCHR7W0AYRp4sOzcHag3jm7LNyyCrcel6KCTOjAt4R
         fwr4zGmqS7SZzNbEVl6K7706mBt4tyb8grRYj9s1IFJQAmBAJYY2+7aWFYk1KWr/KwKn
         PqF0cATKc0TStnGyelBsKwGHuIWvc86kl68HmShrxv/xnB0YdN2JHv2M164zU4PUJ7BK
         gn92ZEbHHH/ESJPcn8ZZ/J8XMJVZ8mtyJWf0eG8dqPjiiwfgCU9v0pe81fBc+VXZY6RS
         sMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gQhNcy2LNQytLGOWB93x3Yia/FlpQuGD9oTfRwaHwtc=;
        b=bD6Z3FGMx8vUjNMMvxRDyUJG0p2UcX+oqIDOfm24S11MhdbovOGkUqJGqmwlQYTuJ3
         CZx6QJ2vYurmM0ZP19MaGcStdvpYvUBWUp6Zye/0LbEFaNVi7v4T6QDQY3629sX5ZHkg
         Cb05QhONrunzu4onKkmABD+lwVQWoniq1KscTBPkNlt18Qz3g7b6NM9Vh0bT2zXr1j4v
         UQcaZn24/JQk7g8D+QIwRsQ7VI7eTTSPft0snK0J0bTLGBqUHXFEHP3PXo+7+t5vO3xY
         TTaAIUSvXkwi7TOtqZMLqVJNovcxsdnoKyS75DVt+/EbKJE2+vVVwh2CeIvguvNeg3v6
         H+iw==
X-Gm-Message-State: AOAM530uIQIBlwR+haP61AnltjFMRQCYpfEPCx1NUwTzAHTcXleOEwOL
        XNzG9Tw1AHe1Kmd+xTV9woXAlkGzKJBtLmAv
X-Google-Smtp-Source: ABdhPJwTOA7f5PiQKmT2l38tfhrAv7+vdZZWlfvWVt2eyPOWrVYp9QdFdSUfYT2pM5omKhECTgZztg==
X-Received: by 2002:a50:9e0b:: with SMTP id z11mr15389314ede.228.1619956420544;
        Sun, 02 May 2021 04:53:40 -0700 (PDT)
Received: from PackardBell (192038133011.mbb.telenor.dk. [192.38.133.11])
        by smtp.googlemail.com with ESMTPSA id mp36sm8598075ejc.48.2021.05.02.04.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 04:53:39 -0700 (PDT)
Received: from localhost (PackardBell [local])
        by PackardBell (OpenSMTPD) with ESMTPA id 1777edaa;
        Sun, 2 May 2021 11:53:35 +0000 (UTC)
From:   Bartosz Dudziak <bartosz.dudziak@snejp.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Bartosz Dudziak <bartosz.dudziak@snejp.pl>
Subject: [PATCH 1/2] dt-bindings: regulator: qcom: Document PM8226 smd regulator
Date:   Sun,  2 May 2021 13:53:03 +0200
Message-Id: <20210502115304.8570-1-bartosz.dudziak@snejp.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the PM8226 SMD-RPM regulator entry.

Signed-off-by: Bartosz Dudziak <bartosz.dudziak@snejp.pl>
---
 .../bindings/regulator/qcom,smd-rpm-regulator.yaml           | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
index a35c6cb9bf..83b53579f4 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
@@ -24,6 +24,10 @@ description:
 
   For mp5496, s2
 
+  For pm8226, s1, s2, s3, s4, s5, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10,
+  l11, l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22, l23, l24, l25,
+  l26, l27, l28, lvs1
+
   For pm8841, s1, s2, s3, s4, s5, s6, s7, s8
 
   For pm8916, s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
@@ -68,6 +72,7 @@ properties:
   compatible:
     enum:
       - qcom,rpm-mp5496-regulators
+      - qcom,rpm-pm8226-regulators
       - qcom,rpm-pm8841-regulators
       - qcom,rpm-pm8916-regulators
       - qcom,rpm-pm8941-regulators
-- 
2.25.1

