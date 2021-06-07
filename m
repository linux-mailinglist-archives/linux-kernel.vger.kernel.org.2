Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4778F39DB91
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 13:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhFGLmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 07:42:05 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:55278 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhFGLmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 07:42:04 -0400
Received: by mail-pj1-f54.google.com with SMTP id g24so9633844pji.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 04:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jfeGYJOtKlcuIHOfL8nGiu8SwZWAHSC11095aJQL1jY=;
        b=JHIeh6i4kE/pt7r7xB6cVQFnOBlfdoMPUc9uaALbGoaDkRTvaO9dV8g3kLCTqJaMew
         PgQQTQN5faxzpFWEyvCApGxKzC3V0ye1fFTZ5nW8tRcfRUzQLqreV4vmcKYT9A58co9t
         O/PYB+6dFkL8h7oVN3/07N3mSFbXY/3Pa1ub5P2MaQTrgZtbqETDZkrRHQT0bDRU9pNx
         2uTldSGLqUVCLLGKxcxPEFUdXatG2thtO0BEn7iU2KhT4vkPq4RK0/BJr63W0ksyIbvp
         qRTFeZzAwdRfRiDpmskkukNJtFpyHJ6ltvMgSgqFyPtka4AaPoQ0NEHhE6nr8rHI6fza
         Ou2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jfeGYJOtKlcuIHOfL8nGiu8SwZWAHSC11095aJQL1jY=;
        b=KMSOoTmJpRZmEIx1YNxJ58KRYIGJ+lHucaXC5rwr4wI5JFAo0tKU04spg39/yUqsp/
         4jtRbNVvmoujgq9EE0cPWBHczYwbOXGZ87sg60bWWxjjNqmlQ3nG+pJv2qEL4y7YJFV+
         PSxYy6omf02wln+RuORIjg5lqZkul3Lkx4C9rjzP+pS/WC1g/HQJ1X6x/dQvs+qpm0R3
         MXG/Ym0u6+V4ajF2Z8I8w0fUZI2ZygMo0RjR1+JkLuZiX+iQjK349nVayUlkZ9Pu7Faf
         XvpWV4WpBA6t5rDgVO6kSl6qCR4FtoZfOlgyKyhk5Z4/uiIljeqNWuQ9/xrlnwQgRkgL
         1ZCQ==
X-Gm-Message-State: AOAM532O5PYGDdokk2oo5QQZuWafBGb0Se7eYK9aNKoEEp1Z6h1xyzf1
        ZNfoLt7H3d/pIWwqSFR8UpRK6Q==
X-Google-Smtp-Source: ABdhPJxYaHxB0tXydPhuS9V12XDKPhoHPORk1mH4GYgbPCASYdKQq6J4FwMijmqQprfcbnYEGhgeww==
X-Received: by 2002:a17:90a:bd04:: with SMTP id y4mr16602615pjr.127.1623065953309;
        Mon, 07 Jun 2021 04:39:13 -0700 (PDT)
Received: from localhost.localdomain.name ([122.177.177.211])
        by smtp.gmail.com with ESMTPSA id j7sm7223939pjf.0.2021.06.07.04.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:39:13 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        bhupesh.linux@gmail.com
Subject: [PATCH 1/8] dt-bindings: qcom: rpmh-regulator: Add compatible for SA8155p-adp board pmics
Date:   Mon,  7 Jun 2021 17:08:33 +0530
Message-Id: <20210607113840.15435-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210607113840.15435-1-bhupesh.sharma@linaro.org>
References: <20210607113840.15435-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible strings for pmm8155au_1 and pmm8155au_2 pmics
found on SA8155p-adp board.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Andy Gross <agross@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: bhupesh.linux@gmail.com
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index e561a5b941e4..ea5cd71aa0c7 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -55,6 +55,8 @@ properties:
       - qcom,pm8009-1-rpmh-regulators
       - qcom,pm8150-rpmh-regulators
       - qcom,pm8150l-rpmh-regulators
+      - qcom,pmm8155au-1-rpmh-regulators
+      - qcom,pmm8155au-2-rpmh-regulators
       - qcom,pm8350-rpmh-regulators
       - qcom,pm8350c-rpmh-regulators
       - qcom,pm8998-rpmh-regulators
-- 
2.31.1

