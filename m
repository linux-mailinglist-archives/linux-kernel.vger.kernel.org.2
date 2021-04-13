Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9794D35D50F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 04:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244390AbhDMCA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 22:00:57 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:62544 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238374AbhDMCAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 22:00:49 -0400
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 12 Apr 2021 19:00:29 -0700
X-QCInternal: smtphost
Received: from gurus-linux.qualcomm.com (HELO gurus-linux.localdomain) ([10.46.162.81])
  by ironmsg01-sd.qualcomm.com with ESMTP; 12 Apr 2021 19:00:29 -0700
Received: by gurus-linux.localdomain (Postfix, from userid 383780)
        id 278D61B19; Mon, 12 Apr 2021 19:00:29 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v3 0/3] Add Qualcomm Technologies, Inc. PM8008 MFD driver
Date:   Mon, 12 Apr 2021 19:00:24 -0700
Message-Id: <cover.1618278453.git.gurus@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v2:
  - Collected Rob Herring's Acked-by for the IRQ listing patch
  - Addressed Rob's comments for the dt-bindings patch

Changes from v1:
  - Removed errant Change-Id from dt-bindings IRQ patch and gathered Bjorn's
    Reviewed-by
  - Fixed up YAML errors using make dt_binding_check

This driver is dependent on changes that have been made to the regmap-irq
framework that have currently been accepted [1][2] in regmap.git upstream by
Mark Brown but haven't made it to Linus' tree yet. For this reason, this driver
has been based on the tip of regmap.git and not mfd.git.

Those changes, and this driver, are the result of a rewrite effort that was
promised a long ago [3]. The framework changes and this driver have been tested
and verified end-to-end on an internal platform.

[1] https://lore.kernel.org/lkml/20210318183607.gFxO2hoTO274vl3jUuxWbi19rq9wQELzN-y3B4jvO10@z/
[2] https://lore.kernel.org/lkml/161726943419.2413.4844313396830856637.b4-ty@kernel.org/
[3] https://lore.kernel.org/lkml/20200519185757.GA13992@codeaurora.org/


Guru Das Srinagesh (3):
  dt-bindings: mfd: pm8008: Add IRQ listing
  dt-bindings: mfd: pm8008: Add bindings
  mfd: pm8008: Add driver for QCOM PM8008 PMIC

 .../devicetree/bindings/mfd/qcom,pm8008.yaml       | 121 +++++++++
 drivers/mfd/Kconfig                                |  15 ++
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/qcom-pm8008.c                          | 284 +++++++++++++++++++++
 include/dt-bindings/mfd/qcom-pm8008.h              |  19 ++
 5 files changed, 440 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
 create mode 100644 drivers/mfd/qcom-pm8008.c
 create mode 100644 include/dt-bindings/mfd/qcom-pm8008.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

