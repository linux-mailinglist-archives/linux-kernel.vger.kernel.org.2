Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EF94155B2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 05:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238977AbhIWDCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 23:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238934AbhIWDCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 23:02:50 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E069C061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 20:01:19 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id j15so1652550plh.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 20:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Rsco8rJJnmLAZwuOl5TFQP4xk+kS1llqY9y42TeLc7k=;
        b=ZDVmwjwpxM1L0d9KchLJG+3f3jTvhiSmAQOgPf2/GA2T3yLlD3ZeqZqyaz4LBgKfXJ
         fibnn7uSUtltU7Xni6VWAQQs4a5ZPaVU8QQAOcVHM5cQ8MCMynuamPDCBwFK35Tbz9eC
         gpVwWqU8N7kwsLbZKowKhY7Rl72MsHClzjEmbAXF4NI+TKEfjLwo5dDjQaElwIjycsgb
         /8n1z9zGYXwuWYML9esdwfJCEzMI8OteF8y5pPMV7pa0UQDbq+2zzKjBpGwD16mxVPfd
         deH1ODs+gubjOXufAAQOHlhTpfjWDKVKA/TRX1pEwhxBc7Ec2hk1OzWeFZ2oZiZlesoV
         xI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rsco8rJJnmLAZwuOl5TFQP4xk+kS1llqY9y42TeLc7k=;
        b=tkEfx4/AFtWkR6ARcuaBv1fYKu2ojRXZTIHBMXiqmk5/ECfGVT/UuPWEWeOlkENn/E
         +p97vXt7M25MAxLvFb1YGy0iP7w681ZDYFURsPvlaO+M5fFEWEWCw6L15AcR3MtIFYcS
         f28r0ok/H4HXp2wlTwDOzd3pWU2OYWCA+7HNgP82zZTAkWEEQXduZ7Zgn75BUVhg3f3f
         1oibgzl9Zi3uCzBO92LYuaPjG4Fux46AC6XanvvnXzUSi9aTqtL6wCRg9bsBwzcp+1Q8
         6uVMO4S0PntJPnUioTJLBruLDgU1v0gvpRWlmS9AwsOqSLAxzerV940x1xdv2kSKfAa2
         SQJg==
X-Gm-Message-State: AOAM533tNcpdxA7g81wWwNPNghLDA0z1IWxInwCgMVrkDygOrAFhrmJe
        GW1r9yh3nax09CdTJk2jqTxWeA==
X-Google-Smtp-Source: ABdhPJybJbLzIo5B2ipqXGGUZDnneckSq02xnZlDHPOc08LSdrQ2583QYBqxR429xY65u76mkmJKxA==
X-Received: by 2002:a17:90a:19d2:: with SMTP id 18mr15085854pjj.122.1632366078854;
        Wed, 22 Sep 2021 20:01:18 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id i7sm4226869pgp.39.2021.09.22.20.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 20:01:18 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 0/2] Add pinctrl driver for QCM2290
Date:   Thu, 23 Sep 2021 11:01:00 +0800
Message-Id: <20210923030102.29148-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series adds QCM2290 pinctrl driver and bindings.

Changes for v2:
- Update pattern in bindings to cover entire GPIO space.
- Sort qcm2290 functions.
- Group phase_flagN into a single function, and same to qdss_gpio, atest
  and dac_calib.
- Correct .compatible to be qcom,qcm2290-tlmm.


Shawn Guo (2):
  dt-bindings: pinctrl: qcom: Add QCM2290 pinctrl bindings
  pinctrl: qcom: Add QCM2290 pinctrl driver

 .../pinctrl/qcom,qcm2290-pinctrl.yaml         |  186 +++
 drivers/pinctrl/qcom/Kconfig                  |    8 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-qcm2290.c        | 1129 +++++++++++++++++
 4 files changed, 1324 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-qcm2290.c

-- 
2.17.1

