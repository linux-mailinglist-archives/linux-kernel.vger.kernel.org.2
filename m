Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E1934BF07
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 22:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhC1Uxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 16:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhC1UxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 16:53:05 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DE2C061762
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 13:53:04 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id f26so13661760ljp.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 13:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nEcuPIlrbFv4i32V7MaOoGQT9baSKHg2WMT0kEgPWGQ=;
        b=erMpS5f3Gx7riI95O/PveVMkI/mPp1002UISNI8NWBio0Nn/IQvElsOjr4jWGjN+Hk
         ytzyEAvgpBn/l0n7kr5NHTZazEmnZ+sfLeV2NJ3oW4CvQecX0rz6Sj8ZXaGMRwILooxR
         FDXjbMQIrODruIVjURdLI0ibObLIvGmNoVFkItXOJ/Zeviyc+8PWv/O07bGOr6FCuWWQ
         o6wXx3M06eqpjv4dyELrUi50nOCDVlLLVdYbxAFSJPgQMYTVi4PgE9nU1ShFXHQ+DDLz
         KwleziLGu+m/KgTHsKVo5Hjq/Iki2q7xZjoOoI03hQ09l7BjU+1CVWjvz1Bq7ZAqCzny
         g2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nEcuPIlrbFv4i32V7MaOoGQT9baSKHg2WMT0kEgPWGQ=;
        b=rKxHcUmOUDUevrFxlPAPm9oulPXprPYxf+ULdkKtd2ALlbXxxsCUlFN6TJD5rAfTMZ
         xUBJ4aL2nE2v0CpExrdkyMyummUfqOGLHwEv5yYQQiNTuMzhsoRRQFFpVrPpfcxRngn5
         m1UTVh05g2bNfQPtM67pP+zyjwrqGFiNdmiHE6EBvMo4T6flH73iXmMlWYmiaJnZ054F
         ph/fNMgbKtflwuI1SVq4wUjRplovQtZNI+tbJT7UOrbmDcZYxkMeM2aV32lAou9sy+Jh
         8jHDScCDwbSKvg7SDfrylfQbGcXf4dOwv417cbhGhoSCQKep9KaAO4+d8Pkc8aS26Xtg
         3XHQ==
X-Gm-Message-State: AOAM532c+6QoYRWxzBQ+m+Qg78JOIROygUTRWbgJVOLICouMtjQXzPbA
        4aV7MafedFZmtaHP97KUHeFC7A==
X-Google-Smtp-Source: ABdhPJxUbVdPh6i09IMVjPWHlxl+LrOSWgkYbDh/T4HYkrPDYL9BRD4/PMkSScwJA8ECHC3fhSzlYQ==
X-Received: by 2002:a2e:9755:: with SMTP id f21mr15577511ljj.319.1616964782563;
        Sun, 28 Mar 2021 13:53:02 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id j19sm1589788lfb.15.2021.03.28.13.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 13:53:02 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Manu Gautam <mgautam@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 0/7] phy: qcom-qmp: provide DP phy support for sm8250
Date:   Sun, 28 Mar 2021 23:52:50 +0300
Message-Id: <20210328205257.3348866-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v4:
 - Fix typo in the qcom,sc7180-qmp-usb3-phy name in the first patch

Changes since v3:
 - Move qcom,sc7180-qmp-usb3-phy and qcom,sdm845-qmp-usb3-phy from
   qcom,qmp-usb3-dp.yaml to qcom,qmp-phy.yaml
 - Do not touch qcom,sm8250-qmp-usb3-phy compatible

Changes since v2:
 - Drop unused qmp_v4_usb3_rx_tbl

Changes since v1:
 - Provide dt bindings
 - Split register renaming from sm8250-dp-phy patch
 - Add respective changes to sm8250 device tree

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/dmitry.baryshkov/kernel.git sm8250-dp-phy

for you to fetch changes up to aef044832f8f34495c35f8324ee55e2500dc3db5:

  arm64: dts: qcom: use dp_phy to provide clocks to dispcc (2021-03-28 23:43:31 +0300)

----------------------------------------------------------------
Dmitry Baryshkov (7):
      dt-bindings: phy: qcom,qmp-usb3-dp-phy: move usb3 compatibles back to qcom,qmp-phy.yaml
      dt-bindings: phy: qcom,qmp-usb3-dp: Add support for SM8250
      phy: qcom-qmp: move DP functions to callbacks
      phy: qcom-qmp: rename common registers
      phy: qcom-qmp: add support for sm8250-usb3-dp phy
      arm64: dts: qcom: sm8250: switch usb1 qmp phy to USB3+DP mode
      arm64: dts: qcom: use dp_phy to provide clocks to dispcc

 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |   2 +
 .../bindings/phy/qcom,qmp-usb3-dp-phy.yaml         |   3 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |  31 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 850 +++++++++++++++------
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  77 +-
 5 files changed, 693 insertions(+), 270 deletions(-)


