Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B3A340EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 21:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhCRT7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbhCRT7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:59:37 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89926C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 12:59:36 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id n138so6486145lfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 12:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P1rcveWXMVbmUI08P7yo7o1jOZYDTdFMfxcMXg2Pco4=;
        b=kUTQqs9YUwKdZmMyssA/Agyv6JmeKyuAgfawFJCENWtZK5O7Be7DDIgF49UvOBiUc5
         7T42EzfYh91WoSW7LerGOBEkSoHWzmSTzP1RPZjidmEToZbskkBuuL12tz06ioVZy1iW
         jpVtXWfqj9NHIX8xOI8hxKhRyRvCsXcc5+EWsPLcaJnF434roiwOBoGp37tReOA9gtKt
         E0vrEHYGaxwZrtwHQukzZZmPIcLYNdqM0LdPcPOMVIS8HKXJgmBQ85TYSctKLdb8bnQk
         ay0oRCdDxz57E1loyHCWYQ79efWmdZ6e/h92VDb2YOUrrbaRi8c40DBQzJIaFeYLtwz8
         ZkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P1rcveWXMVbmUI08P7yo7o1jOZYDTdFMfxcMXg2Pco4=;
        b=OlD0r2Ezlrv4TBs9sPmjssrjd5IB3RR/T/CyEM88JUDU8W6IuFaSJhnw7OR3dLkELu
         N9oxyJDy0bRIMnBaA1D3QhHn1jV5o8MNaThg+53nU2Mm+w35PqXKfYIgVcH0tBY999D5
         dQZcoap6UMquBA2OwnCmJt/lHsuHeow0ye2RZtUxQlZI5c2tTd//A1R8eKyf64E+g4Wu
         jGF74YT/UUZvt5BhyAkRt2Y/6iyG1N3yAuUclpj2bnLsnleCofjhhv896UcWu04upJh2
         vBR6pdzEWuBYOoADpYdI8tkFHd6VV5nVET965rwWUTNbnVK04sOv7XrJ2ziuy3AFhgpp
         5/xA==
X-Gm-Message-State: AOAM532cKwDt0EeqQMqtw52EJcLytXuHrhrs4unjh9Y8gtRXeselp5VY
        WzKCgm7Kh5XK7J7hRbLor9BtHQ==
X-Google-Smtp-Source: ABdhPJx/L6412T2QwZNfbmMG8R469G27LuwHg+Rf+E0cXxQ6YdoOIFV00Wq6ZR0oUtpUsWRmz8t5tA==
X-Received: by 2002:a19:23c7:: with SMTP id j190mr6230266lfj.148.1616097575129;
        Thu, 18 Mar 2021 12:59:35 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id g6sm344159lfh.232.2021.03.18.12.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 12:59:34 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Manu Gautam <mgautam@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 0/6] phy: qcom-qmp: provide DP phy support for sm8250
Date:   Thu, 18 Mar 2021 22:59:24 +0300
Message-Id: <20210318195930.2229546-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
 - Drop unused qmp_v4_usb3_rx_tbl

Changes since v1:
 - Provide dt bindings
 - Split register renaming from sm8250-dp-phy patch
 - Add respective changes to sm8250 device tree

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/dmitry.baryshkov/kernel.git sm8250-dp-phy

for you to fetch changes up to 31f660041a72c2321ebc5328a9cfdaa6e0c63ff1:

  arm64: dts: qcom: use dp_phy to provide clocks to dispcc (2021-03-18 22:57:57 +0300)

----------------------------------------------------------------
Dmitry Baryshkov (6):
      dt-bindings: phy: qcom,qmp-usb3-dp: Add support for SM8250
      phy: qcom-qmp: move DP functions to callbacks
      phy: qcom-qmp: rename common registers
      phy: qcom-qmp: add support for sm8250-usb3-dp phy
      arm64: dts: qcom: sm8250: switch usb1 qmp phy to USB3+DP mode
      arm64: dts: qcom: use dp_phy to provide clocks to dispcc

 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |   1 -
 .../bindings/phy/qcom,qmp-usb3-dp-phy.yaml         |   2 +
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |  31 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 850 +++++++++++++++------
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  77 +-
 5 files changed, 692 insertions(+), 269 deletions(-)


