Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0D73215A9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 13:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhBVMDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 07:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhBVMDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 07:03:52 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2C7C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 04:03:12 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b15so3818716pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 04:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RN+J/cQ3UYA8vDbFfio0gcTzGBY9lrHpdeKD2Fs7CY8=;
        b=dnQirMY5XNWssjV5xFor/9+hdJe4/wfpv97ncukvlQAzGaPfy9ro0xc81E3lQEfqRX
         nb/0G0CQ1GQFisu4YekJ+WITrBoTYF5V6CEXVo7tpB4/fUFxxcpKuHpJQhKoVr/QqoMt
         PCbi01ymtzy4fT7/69m3M8rODxX9INJ+JLQsAkhMMQRBLx3UFXph733iUaJbEaKJaf4a
         DpuUKoEWPcWTB5LMP6q7h2Sr1kOb5dVtP7lBIYy/9Bf+/ykXlmBZdTrh2PoF/7kMHepZ
         1EbdWAuQ9qPelQQcHoQZ9O3m1p9JvhpqboG9ubF2GldaeFjrlOY9x4HcpSuKmn1Pw5Ih
         Xm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RN+J/cQ3UYA8vDbFfio0gcTzGBY9lrHpdeKD2Fs7CY8=;
        b=Ex6bfX9LL0Cq+S9rfVJPHj6mDTkUCHt++oKsFGJaG510wTAakemRpRr3DTEbGt0WNg
         q9CJzpS8ZWWUNd67rHr5r89PXigmAuN9+CbyoAalT+nqO5Zmb5mEVl5lU941s47liMFf
         8ErrXbAP5tM5nXrW2kF9GDIpHH4/WZpv3UO5YZ0+Hqw+22U4aaAT4jcg35fxJou9p0SX
         Kj0c/wLGEqEqjfZK1aDFaO37shrmlgI9EOq3O01vyAx2qdB72QUphmS+ZpI49aBm2uad
         j8jnJierjpDTh1EgbsL0yMvvCr9SiKBJhz4GNmdXIdbgg6Nkgko8X9JyVahpDoho6tf4
         lrNA==
X-Gm-Message-State: AOAM531p6LWZPOiUo+OqwP6AavP+xw1oGevKxfFEyX/Li9XhbYrp1bRy
        BZFuJl8f/FQcTdgGiOtwrDIG
X-Google-Smtp-Source: ABdhPJxyO+GrVKVH43RmyAk94dqCfrZLr6eaBqYt8ot+9/AYZLVN3rjsFb2r8BHf3f9aIJetks2D1Q==
X-Received: by 2002:a17:90a:b28a:: with SMTP id c10mr23173772pjr.39.1613995391573;
        Mon, 22 Feb 2021 04:03:11 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6215:cc7b:cb8f:abf4:d1c9:3864])
        by smtp.gmail.com with ESMTPSA id g17sm17017221pfh.14.2021.02.22.04.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 04:03:10 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        boris.brezillon@collabora.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/3] Add support for secure regions in Qcom NANDc driver
Date:   Mon, 22 Feb 2021 17:32:56 +0530
Message-Id: <20210222120259.94465-1-manivannan.sadhasivam@linaro.org>
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
so that the driver can skip touching them. While at it, the DT binding
is also converted to YAML format.

Thanks,
Mani

Manivannan Sadhasivam (3):
  dt-bindings: mtd: Convert Qcom NANDc binding to YAML
  dt-bindings: mtd: Add a property to declare secure regions in Qcom
    NANDc
  mtd: rawnand: qcom: Add support for secure regions in NAND memory

 .../devicetree/bindings/mtd/qcom,nandc.yaml   | 203 ++++++++++++++++++
 .../devicetree/bindings/mtd/qcom_nandc.txt    | 142 ------------
 drivers/mtd/nand/raw/qcom_nandc.c             |  72 ++++++-
 3 files changed, 266 insertions(+), 151 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/qcom_nandc.txt

-- 
2.25.1

