Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D705B358AB9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhDHRFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhDHRFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:05:21 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80B4C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 10:05:09 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d8so1366670plh.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 10:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KvaRWGUBzKg18vrLhcly5xbw1iyhjHp6E8Khnfq8sP0=;
        b=EbqThoFeWox3gBcN8qq4bYfqi0/WfCo/dBfSVkP0YKDt5l6DvOHtwwuPTNjX7P4gk+
         pVJuPaPtH3ewyonD+6NW8v0y540eqldJbmGp5ES3TpYFpjiTeGHb5ie+qc93Woy6U6oa
         c75LlVzVQ51Vmd2pJWAuBCTsJ+oCvbhhH2pK3gE2tYMGFYOALzlgw8uSftHuCuSX5772
         7CyppoTUcsG/Z1KILPxEdX4ZYyoRTFkPQDwreKFpVplIE9U+J5bN9Xhfz65LGK4UA7Om
         FkAYEcgAMXxvI4a3hEei+pjGg5Y1iaSDjPIo7LSbZzXExKTSOencK8J6bHjZC4O0XXQ+
         xSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KvaRWGUBzKg18vrLhcly5xbw1iyhjHp6E8Khnfq8sP0=;
        b=Fqzt0NJJxtmUOLhA43U6DNU1Syd3MtE3ZF9ZOeaLeTVHItzlLYvrkv6JYwGEGZ5BvQ
         mpXmspPT0vVb1h173VnSrKoytn6scGSE0v9O5VUSB9z3qkso/QLpnb29vYOTKUPXfiKq
         tXBfAs2Sn9tjMzWOD0QkWfBCNOtciMKSjo79hfBeFWVQaNMTWpF0FAX0rwg1kiBWxhu7
         zBcAc9hSQg89cBGd0l/LLoQHYlER9TCqL00J/K1S3aS48Tc72nxaGKgNAqpSQ4tItSRc
         0fkJWGaencf+zEa17IZOPzHyuSxiCk1bJ/jSPCT5amy1kXEu4euPxKa3XukniSK3L+WA
         hT7Q==
X-Gm-Message-State: AOAM532RWqbq+/W7Lt4tFVhMsXKlo8MnyzPc8Vlwekg6ASdVgD8xzr2u
        uHmmUd0bu19Zi/fgcihn3bbx
X-Google-Smtp-Source: ABdhPJz8q2PMPk8U2f0CDsxOHAUaSqrUKnXrYXnL3AF64LHpnOZtHGn+nN2OjD7QgJA92ATtu6OR5A==
X-Received: by 2002:a17:90b:784:: with SMTP id l4mr9575865pjz.90.1617901509466;
        Thu, 08 Apr 2021 10:05:09 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id y194sm65183pfb.21.2021.04.08.10.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 10:05:09 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 00/15] SDX55 devicetree updates
Date:   Thu,  8 Apr 2021 22:34:42 +0530
Message-Id: <20210408170457.91409-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

This series updates the SDX55 devicetree by adding below features:

- A7 PLL
- APCS mailbox
- CPUFreq using clk and regulator
- SMP2P
- IMEM, PIL
- SCM
- Interconnect
- Telit FN980 TLB board
- Thundercomm T55 dev board
- Modem remoteproc

Except remoteproc, all of the driver patches already merged. Remoteproc
patch will be submitted separately.

Thanks,
Mani

Manivannan Sadhasivam (15):
  ARM: dts: qcom: sdx55: Add support for A7 PLL clock
  ARM: dts: qcom: sdx55: Add support for APCS block
  ARM: dts: qcom: sdx55: Add CPUFreq support
  ARM: dts: qcom: sdx55: Add modem SMP2P node
  ARM: dts: qcom: sdx55: Add IMEM and PIL info region
  dt-bindings: firmware: scm: Add compatible for SDX55
  ARM: dts: qcom: sdx55: Add SCM node
  ARM: dts: qcom: sdx55: Add interconnect nodes
  ARM: dts: qcom: Fix node name for NAND controller node
  dt-bindings: arm: qcom: Add binding for Telit FN980 TLB board
  ARM: dts: qcom: sdx55: Add basic devicetree support for Telit FN980
    TLB
  dt-bindings: arm: qcom: Add binding for Thundercomm T55 kit
  ARM: dts: qcom: sdx55: Add basic devicetree support for Thundercomm
    T55
  dt-bindings: remoteproc: qcom: pas: Add binding for SDX55
  ARM: dts: qcom: sdx55: Add Modem remoteproc node

 .../devicetree/bindings/arm/qcom.yaml         |   2 +
 .../devicetree/bindings/firmware/qcom,scm.txt |   1 +
 .../bindings/remoteproc/qcom,adsp.txt         |   4 +
 arch/arm/boot/dts/Makefile                    |   4 +-
 arch/arm/boot/dts/qcom-ipq4019.dtsi           |   2 +-
 arch/arm/boot/dts/qcom-sdx55-t55.dts          | 281 +++++++++++++++++
 .../boot/dts/qcom-sdx55-telit-fn980-tlb.dts   | 282 ++++++++++++++++++
 arch/arm/boot/dts/qcom-sdx55.dtsi             | 166 ++++++++++-
 8 files changed, 739 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-sdx55-t55.dts
 create mode 100644 arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts

-- 
2.25.1

