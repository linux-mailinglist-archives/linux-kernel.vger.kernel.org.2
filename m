Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357BD37FCF0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 19:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhEMRzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 13:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhEMRyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 13:54:49 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B704AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 10:53:36 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id z1so14216482qvo.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 10:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLwTH/gQ19iEKMaz/qV61PTvp9y5sz4omGkvP7gez50=;
        b=s7lE0IO6lpihoUDmwGy9e6oqhnUDiidDF/UDwHWx1ULn+cYfAmqkJVWQa9Rett/Knk
         Pwp6T2aWnF117p1dok1CfB83GtHqRrnJt0yJXjTBi60rPrlUqWsv1tWU8BXnPiNg1bbq
         McNwhVGiFSqxfzQDd7Gm0vW57H9+pOMcqZ6z4mQ9Dm8DFNoX0k/RixvPLb8k6dkcCjcY
         pRzjg1VN1vFP+RHGQ96GjZX1aPVtFaEyxMbAWD4Sn3ODzEhi8G2lYxXbO/gus/dRznOM
         4fzDHglojuNcUrpVALsLh5fhcHMUj/P6TG1/SjB2HLz05fAZ63RfLRA7Nh0bPMlryZ15
         9NXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLwTH/gQ19iEKMaz/qV61PTvp9y5sz4omGkvP7gez50=;
        b=FIZQlpidlN1S3J/dT8wgGtxuw4/G/cnzOCot13AjLa9zelHIfxJv6KmxeGLr8Ov+zh
         si2Koe0UwiAq0a8Y3mMq0FpXENzdE0oRElIwnFyHZdVmhEDEuj1+P8xUyuFpTBvG+kRF
         3VYwHgk+VMOUlnK0VrY7hKZ5ePIP7qSbVr6A1gmdfT6Ykm/4PnbIHS5J/zKaJVaFoysq
         ASYY/Yc9mzqTI8pgEhSnwgT5Zb+6yF4zxGM2eHc+78LqieXK0ymErOitEqvEcaBgTOBF
         dcTmrsf3eiT+PzxDfIg6KElroAXpcrJf1GVkY1h+4+GMwVWkcnsz6+6GktoFJWb2tei0
         zcnw==
X-Gm-Message-State: AOAM533tsubGJPz/B8XvFaPAZUjebap8uhB5ONZ1IqsGqhNY7aXBdrru
        qb/adqZRP1qIOiwE3sAvStLy8w==
X-Google-Smtp-Source: ABdhPJy2680bpB24Wz9PUzNflK/5YmhpzCdwvjxM47ns5X1f6pEG6ks4oLS7/Ft4I7szLGpdSszYmQ==
X-Received: by 2002:ad4:4f2c:: with SMTP id fc12mr15523470qvb.49.1620928416053;
        Thu, 13 May 2021 10:53:36 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id m67sm2778736qkd.108.2021.05.13.10.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 10:53:35 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     robert.foss@linaro.org, andrey.konovalov@linaro.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list),
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 0/3] clk: qcom: Add camera clock controller driver for SM8250
Date:   Thu, 13 May 2021 13:52:52 -0400
Message-Id: <20210513175258.5842-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the camera clock controller found on SM8250.

Jonathan Marek (3):
  clk: qcom: clk-alpha-pll: add support for zonda pll
  dt-bindings: clock: add QCOM SM8250 camera clock bindings
  clk: qcom: Add camera clock controller driver for SM8250

 .../bindings/clock/qcom,camcc-sm8250.yaml     |   73 +
 drivers/clk/qcom/Kconfig                      |    7 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/camcc-sm8250.c               | 2456 +++++++++++++++++
 drivers/clk/qcom/clk-alpha-pll.c              |  245 ++
 drivers/clk/qcom/clk-alpha-pll.h              |    6 +
 include/dt-bindings/clock/qcom,camcc-sm8250.h |  138 +
 7 files changed, 2926 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,camcc-sm8250.yaml
 create mode 100644 drivers/clk/qcom/camcc-sm8250.c
 create mode 100644 include/dt-bindings/clock/qcom,camcc-sm8250.h

-- 
2.26.1

