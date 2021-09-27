Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A54418F47
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 08:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhI0GuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 02:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbhI0GuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 02:50:24 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23C8C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 23:48:46 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id l6so11071851plh.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 23:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JGgK1pP0+awojk4y6sIFF5gFJNXp8xBI/eToel7KJRI=;
        b=D03xhEMQoE8HCYK3EP8igCx+K+PxXLn2YcVBNqcaYPIJkVlwe6lPvral43lBANxnq7
         429TOCF5KNb1VmC/zwx7295eDjjPG1v2lKJnnTziuRVrvrI9DWBFRsyIE+rswctqbMbu
         A3H8urXOhWwKzPRmkMOID2ojKlQOXhlJo9/35mRM0b3VXwnIj/Gc6yQbLgB44DQAX89f
         uIPH0Hs8dZqDQqiM+UwHM4T8Gi9+IrZPgUOyJQKPcfEmYFslJpptCMF8xX5QNb6i/LfN
         HcPEOOTKFcmicZJ+I8Lw7s4hI5rO1UidUT2O/NkQQtEgr4JE8nbS2I3RC/zK/ZrSde9l
         PXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JGgK1pP0+awojk4y6sIFF5gFJNXp8xBI/eToel7KJRI=;
        b=0l/tjHOg6jDFVbO2i5tXEoFemQpwa/ex8SYBZLuqHtiu2mrDkV887AVQXEwprH8Nnf
         s4u5Nv3joQAoY5Bj401hRIylTU3/c54BaZznl8Qtxq5cKRVYQMEh5yVae/8gm8IaB80V
         CGlnJW55/s4G9RdMFVwDjjZSuS9SBm4RYrDBNROIE8vJqxLEjM3a99e4QsSwqEu0KR1k
         Q5nqVKQICP2KNSgiYZHl4yLVu8znrpnnmSuYPmS5+y5wK4rkesHpfSUYdzAF8eMICCdF
         z/8n39f/XvmEX0YIiR2SryJ4Z/os11hoxGHsVM1H30nhyD4I2sArFywiQe82+U5kqG52
         4V7Q==
X-Gm-Message-State: AOAM532fqzOZizpWG8eZ+PbcVGsPuF8t9Nv/RSIVhOxKbFuAl5oKdFFW
        3twb+suRaFnSKrDy+5G8na6DCw==
X-Google-Smtp-Source: ABdhPJx1HcMXkW5t/LysfiEuICq6FfiPRjiYjTxRvAWl/yGWqirR5BPbcfMGwyg6TftdVkNLfFAA4Q==
X-Received: by 2002:a17:90b:4d08:: with SMTP id mw8mr17640366pjb.97.1632725326394;
        Sun, 26 Sep 2021 23:48:46 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id o16sm17169910pgv.29.2021.09.26.23.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 23:48:45 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/2] Add QCM2290 USB3 PHY support
Date:   Mon, 27 Sep 2021 14:48:27 +0800
Message-Id: <20210927064829.5752-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series adds support for USB3 PHY found on QCM2290 SoC.

Shawn Guo (2):
  dt-bindings: phy: qcom,qmp: Add QCM2290 USB3 PHY
  phy: qcom-qmp: Add QCM2290 USB3 PHY support

 .../devicetree/bindings/phy/qcom,qmp-phy.yaml |  27 ++++
 drivers/phy/qualcomm/phy-qcom-qmp.c           | 143 ++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |   2 +
 3 files changed, 172 insertions(+)

-- 
2.17.1

