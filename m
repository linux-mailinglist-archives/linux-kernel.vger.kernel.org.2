Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB6541BD9E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 05:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244046AbhI2Dor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 23:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239755AbhI2Doo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 23:44:44 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CD2C061745
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 20:43:04 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h12so635138pjj.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 20:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8EIDIG7He/WdJECyN2rIQHoUkf1zGI2sOfErvrjMF1g=;
        b=kuWPmsoRK9qCOXQhyxXQGOqOvNquxsxoUC42Bng3blovL6sX9bC2bYDmImOj+8fTp/
         MySsDJEShHHYqrJpRIpxiCoMuJFm4YwLZ3RXSyz98cml5KghqpxVtVU9x767bZtODKlq
         lTF5sitYWDL+IZHFJFEVfVv4VdSNTKqwvZl3C4j3sSSAnD1M18Y0UF9B9g+IPmj/88+m
         lniW+N1kDEJ9Ou2tSr4VYb4yJfEk8da52G9xjrF/lqM0ThI2ej4t7Pvz0lC6P6RrpaAB
         d8zGgs1PGeTsTBGuzhgQyV9a4SFDxH0TUdfrDpk2UuKvP9c7Tpb68V90EaCqLwxA/QaL
         fP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8EIDIG7He/WdJECyN2rIQHoUkf1zGI2sOfErvrjMF1g=;
        b=5D3OcAdFYla1T368sbsLXyxVEgiCRUkH1a9VVJPHI2/mQPQjKjnIUWsY3heJxX4amH
         lskB/2TdjPZtOFk6nBUlgmiE0IfRBfjXFi/69BEAqKe6tIJVSS3GF1HRTpqAHHjy12eA
         eRyp1OaZU7fA2ZAPEhmPIZUnZSQ1vOm7Bsqa376G+L6HrBnMvXIoBqfC4lNjptQ+BcPq
         ZK7ZwpM6yKMFPjEZN0CXGkiKpC/NSrOvpqFpul1ssZ9HdqxWFappLDA+sqnfD8uZ4tH+
         pQtV0iYrWJFtfuXsxsWQyblJIj7ZFFw8vaG15EM2hOU1sA+S+Ks/5DaqeCiEglYL35dF
         D/sQ==
X-Gm-Message-State: AOAM532Ufti8pfrpxfLIB3eHUq2C/eIJuB718UwcatoLfZAacZHUjbEB
        DVogHZgYR0TLh58dIiA/yZFqtg==
X-Google-Smtp-Source: ABdhPJzUqMPiehVu2EGfrsf8/6nW/NInCCQQuRSrplizc06q+EfiDn320mU2cjaSW62oPRAff5W5Rg==
X-Received: by 2002:a17:90b:2358:: with SMTP id ms24mr2404501pjb.1.1632886984179;
        Tue, 28 Sep 2021 20:43:04 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id b7sm533032pfb.20.2021.09.28.20.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 20:43:03 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 00/10] Make Qualcomm QMP PHY dtbs_check warning free
Date:   Wed, 29 Sep 2021 11:42:43 +0800
Message-Id: <20210929034253.24570-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As I recently add QMP USB3 PHY support for QCM2290 and touch the binding
doc.  Rob's bot report a huge number of dtbs_check warnings on Qualcomm
DTS files.  Although none of them is new warning introduced by my
change, I decided to clean them up.

The first two patches are fixes on QMP PHY binding, and the reset are
all fixes on Qualcomm DTS.  In the end, with this series, we are QMP PHY
dtbs_check warning free!


Shawn Guo (10):
  dt-bindings: phy: qcom,qmp: '#clock-cells' is not required for parent
    node
  dt-bindings: phy: qcom,qmp: IPQ6018 and IPQ8074 PCIe PHY require no
    supply
  arm64: dts: qcom: msm8996: Move '#clock-cells' to QMP PHY child node
  arm64: dts: qcom: Correct QMP PHY child node name
  arm64: dts: qcom: Drop max-microamp and vddp-ref-clk properties from
    QMP PHY
  arm64: dts: qcom: Drop reg-names from QMP PHY nodes
  arm64: dts: qcom: msm8998-clamshell: Add missing vdda supplies
  arm64: dts: qcom: Fix IPQ8074 PCIe PHY nodes
  arm64: dts: qcom: ipq8074-hk01: Add dummy supply for QMP USB3 PHY
  ARM: dts: qcom: sdx55: Drop '#clock-cells' from QMP PHY node

 .../devicetree/bindings/phy/qcom,qmp-phy.yaml | 57 +++++++++----------
 arch/arm/boot/dts/qcom-sdx55.dtsi             |  1 -
 arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts  |  3 -
 arch/arm64/boot/dts/qcom/ipq6018.dtsi         |  2 +-
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts     |  6 ++
 arch/arm64/boot/dts/qcom/ipq8074.dtsi         | 54 +++++++++++++-----
 arch/arm64/boot/dts/qcom/msm8996.dtsi         | 14 ++---
 .../boot/dts/qcom/msm8998-clamshell.dtsi      |  2 +
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi     |  4 --
 .../boot/dts/qcom/msm8998-oneplus-common.dtsi |  4 --
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |  8 +--
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |  2 -
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts      |  2 -
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 11 ++--
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts       |  2 -
 .../dts/qcom/sm8150-microsoft-surface-duo.dts |  2 -
 arch/arm64/boot/dts/qcom/sm8150-mtp.dts       |  2 -
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |  7 +--
 arch/arm64/boot/dts/qcom/sm8250-hdk.dts       |  2 -
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts       |  2 -
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 10 ++--
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts       |  2 -
 arch/arm64/boot/dts/qcom/sm8350-mtp.dts       |  2 -
 arch/arm64/boot/dts/qcom/sm8350.dtsi          |  6 +-
 24 files changed, 102 insertions(+), 105 deletions(-)

-- 
2.17.1

