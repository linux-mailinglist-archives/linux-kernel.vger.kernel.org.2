Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B937733F04C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 13:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhCQM0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 08:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhCQMZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 08:25:30 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5480FC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 05:25:30 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q5so12022038pgk.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 05:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dytfyZh+t/6hBvEK1wCLf/jrNd0VZgcEm5bChCDpMzg=;
        b=T8mMHzfr8C/YC+9JiBfAbhRi52k5vAbU1VVHjqSTp3ajN4ZKLsUYVNhz0EYauoAGnJ
         Z7UUo63Zr9zkYEyhXZZM8ARh8/UHXXPR+XznYaUit7xmRsRY78J9rUmRtLjynb254c41
         hiH/Hdonpd46H7Fv3uvZ9bXzU64vn0UZ1InzI/8I2zfNnjcYAf7aeJGmJJZmDqAroUfa
         RUJwxQQDAbWtj9v/eHgVrtvzdizvw59Ryky9bpdn7XS3QxLI7jGFKMIycbUV+rqLZYQG
         bJ4KNzUdYCtl/VgFYXbqnGLeyTprjcxQy7inOiff5CFNh17dEGC7A+9cSfSLVRSh8K5+
         tSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dytfyZh+t/6hBvEK1wCLf/jrNd0VZgcEm5bChCDpMzg=;
        b=qarsfKTXbIHyaKSRz5eJCp9bD32f0BGu8lPPyuyOIKwzGE4Op5hmHgWv4Z3w7zuGiP
         F10zxuG0Amyy2TyP7RzGHA8tQRBhJTtexPhciE9NQp4zYQQpAsVgiaCoo9kJxY3vfakB
         grmD9+H5xpM+5ioOL4NpiwtjO9p1hUw1uEhViWLLVLb/Y5ZVqp6tTUS3KKFxMaJlNpxJ
         UIGEfSVrx/UThIThx12e2ArvVJzARqXyAo7iMkMewIg6Yq02ufDl291wn4MzcbVTt1hK
         6AI027Wn83Cj2z5WPtpVHSL7BF9vJe/IvgBO0NPlukfcyWx6k3bDfGTqZsVtMQifFwrX
         NjBA==
X-Gm-Message-State: AOAM532to6YCiZ9M0UNIkererFtXVi6I7OMZWyecnGy5ZL5zHULZPH+P
        nMIP+6BRSTmod8Tke84UGA8t
X-Google-Smtp-Source: ABdhPJxQBvjNynU90CGeAQhvI+CodJMu3cpJ1BPfySYq2j+bTcpYj1MoGwp4aHHogsCKuoK9qkeGuQ==
X-Received: by 2002:a63:1d0b:: with SMTP id d11mr2426883pgd.190.1615983929440;
        Wed, 17 Mar 2021 05:25:29 -0700 (PDT)
Received: from localhost.localdomain ([103.66.79.72])
        by smtp.gmail.com with ESMTPSA id y23sm19285730pfo.50.2021.03.17.05.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 05:25:29 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        boris.brezillon@collabora.com, Daniele.Palmas@telit.com,
        bjorn.andersson@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 0/3] Add support for secure regions in NAND
Date:   Wed, 17 Mar 2021 17:55:10 +0530
Message-Id: <20210317122513.42369-1-manivannan.sadhasivam@linaro.org>
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
 include/linux/mtd/rawnand.h                   |   4 +
 5 files changed, 312 insertions(+), 142 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/qcom_nandc.txt

-- 
2.25.1

