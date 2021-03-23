Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E386E3458E4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhCWHjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhCWHjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:39:40 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE43C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 00:39:40 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id f10so3754099pgl.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 00:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PvF1HrRBEs+yUQZzjOuXkf0eJP1lcdc9T4URK25JLiE=;
        b=IOgARvtDCkd4788B8IVLLNeGvkRiH8zapo76SvNMeVay8WkXWauSzwj6e0dBENjmcK
         svY9lsPOKeQ+1xfPCB+k1EROasuAfuFETH6u+Uqg64de5xEBcmf1qyuIuiooVVgRvpjc
         HBza6moWYqIUGNg/6cb9RV9zBFZrn3IBY2e3ZlLFCmsggYn3EG6gyMrbS1GtS7F6v/4z
         PbU0PFYNWZh5FMfniriUqJrHOC4ZyiAk1HumjI0Z1Yxf0F2rrWWa9sG3O3JqWBwijEPr
         PMGYM1y8Zp/nONQwprb1zliScimQZ4gHxaqqkBc58xIQKVYkPPOh9kIl7L1aFa7+1kWt
         ynyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PvF1HrRBEs+yUQZzjOuXkf0eJP1lcdc9T4URK25JLiE=;
        b=fx0lmzTVrAVz9W3oXMVaZ7aEzV3xwoHd0dxp8OeYil4gl8frC1v4dsNt0UDvebZXF6
         +WnzsCADDFQ8ZdAVnkqJZoTsR+xnKmcvPBUu0LrkM5AsFlK5ykhno1AxSmWZmDcbXvPA
         q8vOuW3edRrhcLu1KGs1uQfWtsTtsqj83HQB+rL7zavRganj47DWsP1n7Bqn5yyStLll
         dG/GVrkxFY5dqr9AXrmMIjldqueHf2F1L9rgBvAVR1nzBR+WXUhHaOZdbjk6jiDZWb5A
         pC4zClSw67jU6ILNN6uII16FzS0W3hrTri0Tt/lruwm7lxwSGHcvuYI2FjJ9IF+7fWsU
         R1MQ==
X-Gm-Message-State: AOAM531K7xJ9+gnYk2h58EGFz12Rg/3RODo7Aj1hq45fSoDnbsBZSR+p
        G8dfpjHHz5XCfTpNkSRnxN/Z
X-Google-Smtp-Source: ABdhPJwKcCmBgi+2BFyvGBP7U0ZM5gtxyveh/rSEI9A3yXA7Pto+p2nuS8rNdoos58t2dRw3w8NfFA==
X-Received: by 2002:a05:6a00:1ad4:b029:216:aa9d:dcea with SMTP id f20-20020a056a001ad4b0290216aa9ddceamr3596742pfv.47.1616485179957;
        Tue, 23 Mar 2021 00:39:39 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.149])
        by smtp.gmail.com with ESMTPSA id fs9sm1587465pjb.40.2021.03.23.00.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 00:39:39 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        boris.brezillon@collabora.com, Daniele.Palmas@telit.com,
        bjorn.andersson@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v8 0/3] Add support for secure regions in NAND
Date:   Tue, 23 Mar 2021 13:09:27 +0530
Message-Id: <20210323073930.89754-1-manivannan.sadhasivam@linaro.org>
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

Changes in v8:

* Reworked the secure region check logic based on input from Boris
* Removed the check where unnecessary in rawnand core.

Changes in v7:

* Made "size" u64 and fixed a warning reported by Kernel test bot

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
 drivers/mtd/nand/raw/nand_base.c              | 105 ++++++++++
 include/linux/mtd/rawnand.h                   |  14 ++
 5 files changed, 322 insertions(+), 142 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/qcom_nandc.txt

-- 
2.25.1

