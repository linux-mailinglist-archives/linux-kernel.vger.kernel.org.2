Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2F7399F1B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 12:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhFCKlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 06:41:09 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:46629 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhFCKlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 06:41:08 -0400
Received: by mail-pj1-f43.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso3574673pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 03:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pRg79UT6E/Gj74wGPI8V0FYVbz3jkCUsXaAsm44vs+g=;
        b=T4sE1cyf15ztjxxnjWVzAtElXiP/nRBYyn2vr5v4vHgqpXUieoec8O3DK0vp/WPvV0
         B5C1QVWhFMavalpOFa5hHC3JGlTBPJrqgnO0ncxBJupE39lEQyByH/w0eK7k0mtNmav4
         mvUDM8FEmKbTUUWcBNHsE5do4D//Y6fYfHVasv9ilHwFEtpWlVsuvyps3s16HON3R1C/
         l4L4iMwGcnpzLg3LccfhfBEDp/nmUOp+m0L7AGwLw01kE9Ce49o9pG7rD43gDIhkC86O
         lMghye1L74Z61P68mI4/ONasCV0+NN/yDz6omGkybOEbD9Vzg4XLLGszhH8uFCpy9gmP
         qOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pRg79UT6E/Gj74wGPI8V0FYVbz3jkCUsXaAsm44vs+g=;
        b=um6d18kQ5yu7FulhmfFDGfd6BdpE3d5ilJabMnYa6H6Th26jSLxD4dYPMrPuBE6Dyx
         ECvfaJ1jmj5pIZsjvHTljOlkDajaYEtrhJ4o1O4pznAi8afFEoX8LAsxnZ5gGJ8ZRdwD
         XEDZvap4B55GMow7LK8rsh9KDxa/y597Ue/4kAF5+afkwWXvH++iBdMv9rQcS25XEPwa
         s0dIMgpSwm2eacS0nkgTQrboWfnylwfoX1wvngdZdBvJK1uw5RD8JihkWuM29EhSqj/O
         3u+nM2crNSMuOQfJK8F+YoNtVj4cHREaY7jvBoRzmkMKHMWei1lb+Ynmax8WjdMhfiaV
         i6ig==
X-Gm-Message-State: AOAM533A9P+0TMVpMOaC/MzvGDxbxYPAqEG0OLYHrjS+C9iXR1BJiyZt
        8QnxO9gmm67RoE7JTRDdMWfZ
X-Google-Smtp-Source: ABdhPJwexUDiehxBzS/6kyi+GFZp5yt7L/1dwn0Ks+AyLd1s9HY3PLCoPBjJZLQj7O2YsrA9u7EHOQ==
X-Received: by 2002:a17:902:7684:b029:f4:b82b:b893 with SMTP id m4-20020a1709027684b02900f4b82bb893mr34494121pll.67.1622716703839;
        Thu, 03 Jun 2021 03:38:23 -0700 (PDT)
Received: from localhost.localdomain ([120.138.12.41])
        by smtp.gmail.com with ESMTPSA id v67sm2053370pfb.193.2021.06.03.03.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 03:38:23 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/3] Add Qualcomm PCIe Endpoint driver support
Date:   Thu,  3 Jun 2021 16:08:11 +0530
Message-Id: <20210603103814.95177-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds support for Qualcomm PCIe Endpoint controller found
in platforms like SDX55. The Endpoint controller is based on the designware
core with additional Qualcomm wrappers around the core.

The driver is added separately unlike other Designware based drivers that
combine RC and EP in a single driver. This is done to avoid complexity and
to maintain this driver autonomously.

The driver has been validated with an out of tree MHI function driver on
SDX55 based Telit FN980 EVB connected to x86 host machine over PCIe.

Thanks,
Mani

Changes in v2:

* Addressed the comments from Rob on bindings patch
* Modified the driver as per binding change
* Fixed the warnings reported by Kbuild bot
* Removed the PERST# "enable_irq" call from probe()

Manivannan Sadhasivam (3):
  dt-bindings: pci: Add devicetree binding for Qualcomm PCIe EP
    controller
  PCI: dwc: Add Qualcomm PCIe Endpoint controller driver
  MAINTAINERS: Add entry for Qualcomm PCIe Endpoint driver and binding

 .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 144 ++++
 MAINTAINERS                                   |  10 +-
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c     | 780 ++++++++++++++++++
 5 files changed, 944 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-qcom-ep.c

-- 
2.25.1

