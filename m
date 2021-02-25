Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064D73249AE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 05:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhBYEMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 23:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbhBYEMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 23:12:20 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F589C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 20:11:40 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id c19so2710788pjq.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 20:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kWvndBzAFJbUCgudW2fOtKqRm0n+8przz6MQZbJUpfg=;
        b=z4pBsimnaBnUQtZQfOxFmngvwePpdxMwoFXUQNzRUF6W57v0QRDbUckzNug5MJjice
         Ylc/0iP8yBDCx3i4li2GTnuEVaMOmwZBn7cxpoL6epUvjJlWDYCBAatTBs3BPyAguiJJ
         O6IggNMCEvlkIyPl0oaqW5mVKwsqr/ChMHMiL2HT+0+Luea5yXgjgADE8BxuTStQFk4i
         nBgUiYciwvHWE66gHpQcCFHhF1QJlcdjWLxEZUxwBIC/vUNwS7wBHDF1Ui62lPgDDbQ6
         fpMMPa9xBndwbaCSTG53HrFm5gb3XF/lAbz2TT/0Wp3PK8mNHGOrIIjZANC4Kj8dFJzz
         8D0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kWvndBzAFJbUCgudW2fOtKqRm0n+8przz6MQZbJUpfg=;
        b=rzHjk5lkWarjrWJS6l+tk8EKVvQ2DrNo073KYWfV0zoY7FFnHdgx+xy4D9oJoIjX0Q
         PE7+L1aQIQEG6mIZ6LJjXlPLhdv74QySdfJNvzz5VqoJTW8j0SALJNCopvnAT77EDG3R
         PD5rksUxgGSM50xF0TbY9gKNA8LrS7rw3fA2Aopftf0a1K7dqbI/cbKivin7Zm/a9pnn
         GDtosnm7mVE6PijG5R3pHwrBsPv2Y1slrdE01uBJZyCmtfCoyP4IKek/itSJ6rtL/IhC
         0dqkjfcyYtY1UmTUci0iE3mhcoUj5cOKm9mTIpSvodVh9Fgk9kVx8VderPXyXca1AUiI
         hoWw==
X-Gm-Message-State: AOAM533gt1dpI0DosBGRTHQK2hexFgdDqdijG+/VReahH9VsCg3FyWEW
        QTY90liY8/CN/vYSuveVzF+/bBsIMleS
X-Google-Smtp-Source: ABdhPJxjzQUHOO9pmE1ewQkHZu3Xe9wtIoxLEISh0thnwTBmC8+3r4lMS1sM7XmWKFQW+4N+4+6qoQ==
X-Received: by 2002:a17:90a:cc02:: with SMTP id b2mr1240825pju.115.1614226299834;
        Wed, 24 Feb 2021 20:11:39 -0800 (PST)
Received: from localhost.localdomain ([103.66.79.45])
        by smtp.gmail.com with ESMTPSA id c12sm4155494pjq.48.2021.02.24.20.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 20:11:39 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        boris.brezillon@collabora.com, Daniele.Palmas@telit.com,
        bjorn.andersson@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/3] Add support for secure regions in Qcom NANDc driver
Date:   Thu, 25 Feb 2021 09:41:26 +0530
Message-Id: <20210225041129.58576-1-manivannan.sadhasivam@linaro.org>
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

Changes in v2:

* Moved the secure-regions property to generic NAND binding as a NAND
  chip property and renamed it as "nand-secure-regions".

Manivannan Sadhasivam (3):
  dt-bindings: mtd: Convert Qcom NANDc binding to YAML
  dt-bindings: mtd: Add a property to declare secure regions in NAND
    chips
  mtd: rawnand: qcom: Add support for secure regions in NAND memory

 .../bindings/mtd/nand-controller.yaml         |   7 +
 .../devicetree/bindings/mtd/qcom,nandc.yaml   | 196 ++++++++++++++++++
 .../devicetree/bindings/mtd/qcom_nandc.txt    | 142 -------------
 drivers/mtd/nand/raw/qcom_nandc.c             |  72 ++++++-
 4 files changed, 266 insertions(+), 151 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/qcom_nandc.txt

-- 
2.25.1

