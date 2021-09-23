Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C00416759
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243278AbhIWVYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243192AbhIWVYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:24:06 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD917C061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:22:34 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so3539176otv.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3MYig+t76yXS3PKKNnmxfZV0vUCyZOrKe0JE9dsF3Y=;
        b=q6DQ/uLh+rOOIptl7Av8RCuOCTgOEjdj7GpDdnqxUyESYJRANG61gxUFHaU45agQ2m
         bGjgNCzq1UQ6g1pQGkjXiGaj7A6uEr1mP7jBABFaXd6cLeO+oDKL5CaX9PS72zl9s68Q
         U58lWIA+Qg2kFDZYUYonVYlWF3z5F4vg5ZQU7asFpX4pIuYLMs0YYhRP9Dju7t84GKkl
         9hJ1gfTR22oWcY2KtTvlY2dS8MifcWxQK1Am/1cVJ5RU5Jq3cs/UDVqTOpDVwwVHc/ZE
         UKdsJkfMlGo8RjeEi33NarztHimYe5Z0iRVYzfJ2COnXbwJq/Be47z/eWn65n8uwfZye
         1spQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3MYig+t76yXS3PKKNnmxfZV0vUCyZOrKe0JE9dsF3Y=;
        b=3hVp0oFQvEjaszIEsms9SXrLgI4krD/Bk9eG+4jtZMFmZtQc65fuCVuf2Pq0pDu6jz
         cuix7bps5MctX2dpPQ3ENUZauxuWrVmBfp+M3NcJd+0mz4E6TQet3ntESJo+VBwmMVaE
         ycRqQUoI0d+b4plztNTPV+PJ3db3bo9t98F2ckllDNUR6SmrXyRlUmDZWXmlr6mcpo1v
         4QAIk61a1MbEgi5A2+r0/hJ5TUgTmeq2uihmqbc4qHfo8i7hcxQTz/Qjkauv/zAok8py
         ScOdPU9jkKEJksN90hDEhdMolVrQJOxVFa2l/BPU7PnFnhceE+LkUoxiA4nRW9BEBlkl
         eKZQ==
X-Gm-Message-State: AOAM5329q6Y+mLrca6OgZpK5XIYpRmqb/Iz7baJFgaWmO6m48jKmuYbA
        Vh9ri7Ik/kb13Or/g9f4GMF1fQ==
X-Google-Smtp-Source: ABdhPJw1+QXHT9g87r3Rk2jaH8Dne7oQjgMbwUcaYWZFTuBKwZWtlLl2TUADRgFUKsVb9eCo7tHKag==
X-Received: by 2002:a9d:3e15:: with SMTP id a21mr831400otd.60.1632432154033;
        Thu, 23 Sep 2021 14:22:34 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e16sm1586820oie.17.2021.09.23.14.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 14:22:33 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] arm64: dts: qcom: sdm845: Add thermal zones for PM8998 ADC
Date:   Thu, 23 Sep 2021 14:23:07 -0700
Message-Id: <20210923212311.2877048-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe ADC channels, related thermal monitor channels and add thermal zones for these.

Bjorn Andersson (4):
  dt-bindings: thermal: qcom: add HC variant of adc-thermal monitor
    bindings
  thermal/drivers/qcom/spmi-adc-tm5: Add support for HC variant
  arm64: dts: qcom: pm8998: Add ADC Thermal Monitor node
  arm64: dts: qcom: sdm845: mtp: Add vadc channels and thermal zones

 .../bindings/thermal/qcom-spmi-adc-tm-hc.yaml | 149 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8998.dtsi          |  10 ++
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts       | 128 +++++++++++++++
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c      |  43 ++++-
 4 files changed, 329 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml

-- 
2.29.2

