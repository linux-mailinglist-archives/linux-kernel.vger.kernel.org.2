Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AEC352C0C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbhDBPBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 11:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbhDBPBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 11:01:46 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFA3C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 08:01:43 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id h8so2629598plt.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 08:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ldZzMYp9rBIEkuelFhL1o+s+U9zYs7UBzeIApWLg0og=;
        b=n6RIi2rOaJ2VF59xOiWxOs+AUToxL9jEvdKG47HKc6iG15nkn0+iwj7DezBguhzxZ+
         JKO+naDulBdXIQyejCZ1GOKRxR7GzHxhUvEM/VOx0tpqj95rE3tt7Dv1MM6WPbIiKYhh
         7th+iejlGRsQTYTzRQFUPiRPFHBGWhsj+FtKmqVlNBShm1m5D2Ssnn+ieyK3pY0Hdnph
         sf2iQ18tsjcAYdnxeL8iTkLTlW7D4OkARNbWSH76eoaTck5nyF5yckrdIKtDyKu59R6f
         wbZNPtsN/S9qRMJoKRVUxfymcM5FYvOY6Qqql7zlRFwgy4Os6GV7KXNL5W5B4iMIasAs
         5xJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ldZzMYp9rBIEkuelFhL1o+s+U9zYs7UBzeIApWLg0og=;
        b=gKu74m1zbvRMkU9A9NcZINJHKNWmk1JA7ZYYX9WfsgLhsLkGwDottES6N9FzvaeRBu
         Nat1A4fc0TfSo62T+ic4Y78cxe7vyGVpytp3VqW/8VElvRisImHoCSPbsBKo1yJu2KjI
         Ebn/iTKHbn4Ws0bn0mN/Ajw9CMechnp/Dqe3yWRKsP4XYHsgykYxkhRjop2xKRp5YsVA
         5Pi3uyJi8sCJdBWl/3p0gT5eEOmUhHs71NJKArvNgjox2+jAuXDVNUyGRyzX7HfeIXUU
         5L8onK2IzNWTgXEJc9KtARU12nh75Z6HhUFsV8VQUoESKfUnEIugwqP+gyrc+ECrwpb5
         Nubw==
X-Gm-Message-State: AOAM530PdKqQf8R7Vv1QQUuZX/2NN6JNiN616DVubcIFlubarLnmz+8H
        wn+HLj2ndLIUncTZoUYv9bEH
X-Google-Smtp-Source: ABdhPJzysKHkD5hPLLoXR+L/SXqkFq153ovg5+Vmyw8i0BA/UvbNYS6f/EmK3dcKK6n+aVLWn8gBQw==
X-Received: by 2002:a17:902:bb8e:b029:e6:3b2:5834 with SMTP id m14-20020a170902bb8eb02900e603b25834mr13267915pls.38.1617375702769;
        Fri, 02 Apr 2021 08:01:42 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.174])
        by smtp.gmail.com with ESMTPSA id x7sm8773647pff.12.2021.04.02.08.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 08:01:42 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        boris.brezillon@collabora.com, Daniele.Palmas@telit.com,
        bjorn.andersson@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v11 0/4] Add support for secure regions in NAND
Date:   Fri,  2 Apr 2021 20:31:24 +0530
Message-Id: <20210402150128.29128-1-manivannan.sadhasivam@linaro.org>
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

Changes in v11:

* Removed unneeded check in nand_block_isreserved()
* Used mtd->erasesize as the size in nand_isbad_bbm()

Changes in v10:

* Added Rob's review tag for binding

Changes in v9:

Based on review comments from Miquel:

* Fixed the secure-regions check
* Renamed the function to nand_region_is_secured() and used bool return
* Moved the parsing function to nand_scan()

* Added a patch to fix nand_cleanup in qcom driver

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

Manivannan Sadhasivam (4):
  dt-bindings: mtd: Convert Qcom NANDc binding to YAML
  dt-bindings: mtd: Add a property to declare secure regions in NAND
    chips
  mtd: rawnand: Add support for secure regions in NAND memory
  mtd: rawnand: qcom: Add missing nand_cleanup() in error path

 .../bindings/mtd/nand-controller.yaml         |   7 +
 .../devicetree/bindings/mtd/qcom,nandc.yaml   | 196 ++++++++++++++++++
 .../devicetree/bindings/mtd/qcom_nandc.txt    | 142 -------------
 drivers/mtd/nand/raw/nand_base.c              | 100 ++++++++-
 drivers/mtd/nand/raw/qcom_nandc.c             |   1 +
 include/linux/mtd/rawnand.h                   |  14 ++
 6 files changed, 317 insertions(+), 143 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/qcom_nandc.txt

-- 
2.25.1

