Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887443405CB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhCRMoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhCRMny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:43:54 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DE9C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:43:54 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id k4so1246340plk.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4PFxTjdA6OPYv/Z0HQ6IxtumbuUjcIrZvu9tDP9b6fc=;
        b=hSbnLUfx8+yxJLMol5fTrHmYGhroPthMYISrambq8F0GJ8XtZBcTNTznPi4Cp/HFMa
         VKNffNvhiiqtFZCxzMyL4JCg11/Gd/tBrcGadlbyc4hjCj2Ta/98ALTlgXiDdEZmUajH
         /8YGadEFTn33ORLQZCoVMHCaxWEcWqPIOdaEEaxNNBrPWljx9Y7pPEa2wMeJew/DNxIR
         Bmh7JTsMnx3k/rd+LGZ4dY+p+b+DV6j58puabVoz6tszs//joOUysyDo/YRQEe9vbm0Z
         mH4tB0c7O20iPs+0LOs2MOUGin453G4QKm9u/GRXFXmwsaKdv4DZxqmsEz5GsPPI4U1f
         f6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4PFxTjdA6OPYv/Z0HQ6IxtumbuUjcIrZvu9tDP9b6fc=;
        b=uepZJcbpDVEpab7ZjQ2SEauhQOWfI4Gn9lU39q5PL/2TLiXPvaCgHC6XWFYxTCBCRX
         PS3FESK5RDUDS2agKUnwJyK+r28RjGHeJ48bEjqLB/6B2+PPrqRBNlTdXCXjFib12eRx
         Qsz/Si7PoBg/V/Dc2/JouESJzvd7pDkRJjFSU3zbTHstTRoWhadQvgMarkAoEFrnofKp
         WTefF/sK9yNVGHpHTRgg589QYJVTyeeuYT+LcMABMBiL+p5nA910kG8z4OwrYzLjam0A
         zHZjyMi8kP736SyjKPAwllFucIbFBwquBdRSfc26WYp0h7HREH0+/EeT8q4gIDggck4u
         HTxQ==
X-Gm-Message-State: AOAM533R2ySKjXhgWoSqqXtXQv1a1FWAXK3jKsR2jWUyugxtic9pyGca
        bt8T0kkkdRNMrKwLOK2Pguku
X-Google-Smtp-Source: ABdhPJyhf4LPDsQT+4ddw3OhbIRoLPuRSljfW+N6iK88femJmSTzQG1AFdT6kWzbRA2HE8lUSo/NgQ==
X-Received: by 2002:a17:90a:8a0f:: with SMTP id w15mr4099347pjn.200.1616071433983;
        Thu, 18 Mar 2021 05:43:53 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6d00:4737:af26:182c:a57e:1d9e])
        by smtp.gmail.com with ESMTPSA id w84sm2530694pfc.142.2021.03.18.05.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 05:43:53 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        boris.brezillon@collabora.com, Daniele.Palmas@telit.com,
        bjorn.andersson@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 0/3] Add support for secure regions in NAND
Date:   Thu, 18 Mar 2021 18:13:39 +0530
Message-Id: <20210318124342.32745-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a typical end product, a vendor may choose to secure some regions in
the NAND memory which are supposed to stay intact between FW upgrades.
The access to those regions will be blocked by a secure element like
Trustzone. So the normal world software like Linux kernel should not
touch these regions (including reading).

So this series adds a property for declaring such secure regions in DT
so that the driver can skip touching them. While at it, the Qcom NANDc
DT binding is also converted to YAML format.

Thanks,
Mani

Changes in v6:

* Made use of "size" of the regions for comparision
* Used "secure" instead of "sec"
* Fixed the sizeof parameter in of_get_nand_secure_regions()

Changes in v5:

* Switched to "uint64-matrix" as suggested by Rob
* Moved the whole logic from qcom driver to nand core as suggested by Boris

Changes in v4:

* Used "uint32-matrix" instead of "uint32-array" as per Rob's review.
* Collected Rob's review tag for binding conversion patch

Changes in v3:

* Removed the nand prefix from DT property and moved the property parsing
  logic before nand_scan() in driver.

Changes in v2:

* Moved the secure-regions property to generic NAND binding as a NAND
  chip property and renamed it as "nand-secure-regions".

Manivannan Sadhasivam (3):
  dt-bindings: mtd: Convert Qcom NANDc binding to YAML
  dt-bindings: mtd: Add a property to declare secure regions in NAND
    chips
  mtd: rawnand: Add support for secure regions in NAND memory

 .../bindings/mtd/nand-controller.yaml         |   7 +
 .../devicetree/bindings/mtd/qcom,nandc.yaml   | 196 ++++++++++++++++++
 .../devicetree/bindings/mtd/qcom_nandc.txt    | 142 -------------
 drivers/mtd/nand/raw/nand_base.c              | 111 ++++++++++
 include/linux/mtd/rawnand.h                   |   4 +
 5 files changed, 318 insertions(+), 142 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/qcom_nandc.txt

-- 
2.25.1

