Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCB23B531E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 13:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhF0LtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 07:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhF0Ls7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 07:48:59 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A69CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 04:46:35 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id u190so12809871pgd.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 04:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1APTTMV9Lifc+OwM91+HWP/syKCs1M6tgCrtH/oY5DM=;
        b=OxFsle3TPnqpQrkKRfr6FIlIdft5npSSQVoSGZ9th5qDVwluDAs2xE3711qFgX5Vwb
         3pDpi7HnXstmu0b07bzYN+juGc5BGdV5R3jpiI3Vgrk/tVa1h6A2zLPb+I5BN0evQIoH
         DTaHh44mnVcM/TWMBTPTyO6SaMDWN258s2Yny7ylo64U+h7nY8Y9i9K8pIf3/gn/9NkI
         MWdo8/Y5byyNO2yg3j03V91SXQoLQP0NKK7tg5eyfmAJBzgr57gud4OQ2d+OzyZ4uZXQ
         xrTgy7+p4Qrv8LCZBhjFTBjFsfqHpaM8l9NJCKqmO6k1W7Nd38/R1lgU/MVhA27JKzQg
         o+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1APTTMV9Lifc+OwM91+HWP/syKCs1M6tgCrtH/oY5DM=;
        b=hPm+Ytjqj3c6jVIFi7zrfDAWCHbp6nePo94Y4h5o3s81B1BvGowsFaBT89SRZqaZK1
         lcf+f4pFFMR6g2VylBP9r+wJ02iBr98cYDGU/iPPHe7ZDa2quWeAM87ax9hHCOhTe8kD
         zPBmwGdYrI6dOwFyVkn7krZu8+xEJ3dDHV/5ccovQK91SB5IeQKbnI841idoqbk9a7lv
         DGZkTyULRM0HS9MAT7sucIXFY6TFLXs80pHVEIY+hp4UQc8NAn6IkH69aqL3yIgObFos
         E61/i1keUwtTYBsRlj3MOv9jTHeGscNtfIfb1aaWzR++qHbLoUe96K0bksXD/x4vhcNW
         c4sQ==
X-Gm-Message-State: AOAM532bElRYY4OnmJeExP5dseMQiZWO1+HPrDkJxSz3DnGz5zCVj+u7
        +oomx2s9zkANGoK3uoKvwIxADg==
X-Google-Smtp-Source: ABdhPJwyGByc7wC4Sa8JpqOsVsN2rWIfXzFKknOfGa/yhwP91iSZ/b+QSaTvmv8LVAlexXW/s/Bu6Q==
X-Received: by 2002:aa7:920d:0:b029:2d9:2ead:70dd with SMTP id 13-20020aa7920d0000b02902d92ead70ddmr19547335pfo.67.1624794394969;
        Sun, 27 Jun 2021 04:46:34 -0700 (PDT)
Received: from localhost.localdomain.name ([182.69.217.12])
        by smtp.gmail.com with ESMTPSA id x21sm10768762pfu.211.2021.06.27.04.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 04:46:34 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        balbi@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, agross@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v2 0/3] arm64: dts: qcom: Fix usb entries for SA8155p-adp board
Date:   Sun, 27 Jun 2021 17:16:13 +0530
Message-Id: <20210627114616.717101-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
----------------
- v1 can be seen here: https://lore.kernel.org/linux-arm-msm/20210625220311.527549-1-bhupesh.sharma@linaro.org/T/#mc49710316c9b527c2ee6562f4b91a05a2d15ca8b
- Addressed review comments from Bjorn.

This series enables the support for two USB ports (named portB and
portC) found on the SA8155p-adp board which are connected to USB Type A
connectors.

It also contains two minor cleanups:
- naming related fix for dwc3 usb nodes found in qcom arm64 dts files.
- arrange usb nodes together in sm8150 dts.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>

Bhupesh Sharma (3):
  arm64: dts: qcom: Use correct naming for dwc3 usb nodes in dts files
  arm64: dts: qcom: Cosmetic changes - arrange USB nodes together in
    sm8150 dts
  arm64: dts: qcom: Fix usb entries for SA8155p adp board

 arch/arm64/boot/dts/qcom/msm8994.dtsi    |  2 +-
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 60 ++++++++++++++++++++----
 arch/arm64/boot/dts/qcom/sm8150.dtsi     | 30 ++++++------
 arch/arm64/boot/dts/qcom/sm8250.dtsi     |  4 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi     |  4 +-
 5 files changed, 71 insertions(+), 29 deletions(-)

-- 
2.31.1

