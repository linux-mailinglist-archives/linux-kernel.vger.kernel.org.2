Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF793D7F03
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 22:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhG0UUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 16:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhG0UUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 16:20:19 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29008C061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 13:20:19 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id d17so23973840lfv.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 13:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pu/Dc0wbZEEdBX0n+gymF7OvWfXDUCeDoTyuI35f9nc=;
        b=FOFa/sNjWhym9g8D5DSS89BwZuBiqUD+SSrqL7sVUVC38ErQozC1yUlsOxaRti3W6S
         52HkAvK2KdjLeuOIPS0jYFaCYhCGPguKkErKLPC222pg2A+/Shx/g6xk4Qr8Jn/0tY87
         CMCpEQMG4CiFKqHDQRbaEDOumAZCbtUv6cl5ONykldV00D8ia4duiru2eGYQrv0mbMjy
         k8xJ8Gh5kd1jdWB2ap0Bq7FmLLG5qOf2BlKNetEmwS/QGXtTk3h/IZcNxt3jjkil6mqM
         l5RxuPFDwB9dZuwYZe9YmsZj0yRYSzEYTBoahqTkdO5lv3xMXJ7ybvz7ZTNrAhgLXKKW
         KUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pu/Dc0wbZEEdBX0n+gymF7OvWfXDUCeDoTyuI35f9nc=;
        b=Ij8fTYQigi2D5VOzwMNNayP7qXRnfbsVeW1GKo8+YMOFAwr9kjplyoiHt/9WTav+Ke
         UQEq97c78FUu8rk2KbXspSFpPLxmlcsd1TXRWXoah5zYPv5R7D6ih/DUaDZd32BJxvRB
         mJAyVeZqfMG+8isrj6xm4ljNV37F3wTS6DrUJaxA/HD5t7/f1sjjjAV9osWesG24XnN8
         MBnML3OJmshGIWFHJIjBBf375ZgTUxOLOPDtc7GfLKHIOgI0yYQKXb5V40cqjzbdiYgg
         8Uf/9V0xgtLDMLDMFQ79CAMSBarqvTZpa3Qv37Ota6AIbcUjEjZA0LBgHjGoyznK81iO
         CnMQ==
X-Gm-Message-State: AOAM530M50P0ZVm1yi11BZKSARRnM+Vsh0VbQ8G7URYMNQ0Am7Z+Fl5E
        t/9AcZgna+DjfqCmoHF4Z9svag==
X-Google-Smtp-Source: ABdhPJykKCBAnljgl6eXjGqYqbLHliukLxoc381p7oH+9gphJk5y+ErWEJAaVK0G+SYW7j65jmFswg==
X-Received: by 2002:ac2:50c3:: with SMTP id h3mr18255303lfm.126.1627417217436;
        Tue, 27 Jul 2021 13:20:17 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id i11sm376502lfe.215.2021.07.27.13.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 13:20:17 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/6] clk: qcom: use power-domain for sm8250's clock controllers
Date:   Tue, 27 Jul 2021 23:19:56 +0300
Message-Id: <20210727202004.712665-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SM8250 both the display and video clock controllers are powered up by
the MMCX power domain. Handle this by linking clock controllers to the
proper power domain, and using runtime power management to enable and
disable the MMCX power domain.

Dependencies:
- https://lore.kernel.org/linux-arm-msm/20210703005416.2668319-1-bjorn.andersson@linaro.org/
  (pending)

Changes since v5:
 - Dropped devm_pm_runtime_enable callback to remove extra dependency

Changes since v4:
 - Dropped pm_runtime handling from drivers/clk/qcom/common.c Moved the
   code into dispcc-sm8250.c and videocc-sm8250.c

Changes since v3:
 - Wrap gdsc_enable/gdsc_disable into pm_runtime_get/put calls rather
   than calling pm_runtime_get in gdsc_enabled and _put in gdsc_disable
 - Squash gdsc patches together to remove possible dependencies between
   two patches.

Changes since v2:
 - Move pm_runtime calls from generic genpd code to the gdsc code for
   now (as suggested by Ulf & Bjorn)

Changes since v1:
 - Rebase on top of Bjorn's patches, removing the need for setting
   performance state directly.
 - Move runtime PM calls from GDSC code to generic genpd code.
 - Always call pm_runtime_enable in the Qualcomm generic clock
   controller code.
 - Register GDSC power domains as subdomains of the domain powering the
   clock controller if there is one.

----------------------------------------------------------------
Dmitry Baryshkov (8):
      dt-bindings: clock: qcom,dispcc-sm8x50: add mmcx power domain
      dt-bindings: clock: qcom,videocc: add mmcx power domain
      clk: qcom: dispcc-sm8250: use runtime PM for the clock controller
      clk: qcom: videocc-sm8250: use runtime PM for the clock controller
      clk: qcom: gdsc: enable optional power domain support
      arm64: dts: qcom: sm8250: remove mmcx regulator
      clk: qcom: dispcc-sm8250: stop using mmcx regulator
      clk: qcom: videocc-sm8250: stop using mmcx regulator

 .../bindings/clock/qcom,dispcc-sm8x50.yaml         |  7 +++
 .../devicetree/bindings/clock/qcom,videocc.yaml    |  7 +++
 arch/arm64/boot/dts/qcom/sm8250.dtsi               | 11 +---
 drivers/clk/qcom/dispcc-sm8250.c                   | 28 ++++++++--
 drivers/clk/qcom/gdsc.c                            | 59 ++++++++++++++++++++--
 drivers/clk/qcom/gdsc.h                            |  2 +
 drivers/clk/qcom/videocc-sm8250.c                  | 31 +++++++++---
 7 files changed, 124 insertions(+), 21 deletions(-)


