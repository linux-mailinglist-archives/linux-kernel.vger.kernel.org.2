Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF233CC881
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 12:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhGRKwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 06:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbhGRKwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 06:52:08 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C63C061762
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 03:49:09 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a6so21219910ljq.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 03:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ns8QFitZLPcwmFGJH/IoWVhidyJ3YSGIPh601UhjtkI=;
        b=jb4KPfNuh2HcFsXjoaZ7xMCSJDtz22TZQxRYH5Ld12mOhGZ/2KDcqeaKvo+d1oStIb
         EKR+AMufiaKJrEn53rJwaUSUU5AF2urVMiCwhReGqmT7pl7hdgeHah0z0T2+VHFsX80Q
         eSH3N60Ar5zw9Ow4TPMWsDIsqWLLitIaNMkUDPiXR3f3LZCJOswO8seQ1mwHtkoEcp+v
         GGLwpJZ5arUbwZmKCt2Svq3az6OesdCT0EH652bekQCzkYWN9uYdO30p1aUUPmxPijvD
         xxmbx8+qIKkKhfH40ZdEvFY+YXBChaCRJJXg78RBQoPIfWn31OIXymHu7cicPtNfZoiD
         BVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ns8QFitZLPcwmFGJH/IoWVhidyJ3YSGIPh601UhjtkI=;
        b=mfQHNaKrk5j1+9tU5zAF0NqBLw0ZwklHcyIKtWXbquB4NcYrtFW2uglP2hixpDip5d
         2u/sQrOMBkopBN5zDKyKA2Jq36/wNS7bD9isbKb7Nt8NEMmOG13AUpGsKsT79sAg5VJY
         sNm1LjUrqZMQ72x49WlId/cueVa8fUGX2WyhEfrOv8RSFIDN4b/rehrEZVCxCMPfm56V
         yaYjZvyjxUTHyx8A+4CooEX/T+ed23Ky5tLSr4v+U1CrzYL4xzDY+E+Qq+tB0TwzI/lR
         uczEA8EYQZV9PkZ3GcZ3Mn+dhRINFCX07oCOgo4ortBcSAzARY16V5GqdUcYks6uv67E
         lOoA==
X-Gm-Message-State: AOAM530c+CSyz8DnMwLnDBaeexDRvdHPy7Fxy9nKAIMgK769foT+li25
        wZTEcDs+y7UWAeX4q6t0arfHnA==
X-Google-Smtp-Source: ABdhPJwQUY96yW4DWHCu3a9S3SRo1yCER4Jyu3t5Ey7be7LR7OHHsHKYC8T7ghLROfIuf/weJoX+7A==
X-Received: by 2002:a2e:a315:: with SMTP id l21mr13201098lje.359.1626605347382;
        Sun, 18 Jul 2021 03:49:07 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y22sm1039528lfh.154.2021.07.18.03.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 03:49:06 -0700 (PDT)
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
Subject: [PATCH v5 0/6] clk: qcom: use power-domain for sm8250's clock controllers
Date:   Sun, 18 Jul 2021 13:48:52 +0300
Message-Id: <20210718104901.454843-1-dmitry.baryshkov@linaro.org>
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
Dmitry Baryshkov (9):
      dt-bindings: clock: qcom,dispcc-sm8x50: add mmcx power domain
      dt-bindings: clock: qcom,videocc: add mmcx power domain
      PM: runtime: add devm_pm_runtime_enable helper
      clk: qcom: dispcc-sm8250: use runtime PM for the clock controller
      clk: qcom: videocc-sm8250: use runtime PM for the clock controller
      clk: qcom: gdsc: enable optional power domain support
      arm64: dts: qcom: sm8250: remove mmcx regulator
      clk: qcom: dispcc-sm8250: stop using mmcx regulator
      clk: qcom: videocc-sm8250: stop using mmcx regulator

 .../bindings/clock/qcom,dispcc-sm8x50.yaml         |  7 +++
 .../devicetree/bindings/clock/qcom,videocc.yaml    |  7 +++
 arch/arm64/boot/dts/qcom/sm8250.dtsi               | 11 +---
 drivers/base/power/runtime.c                       | 17 +++++++
 drivers/clk/qcom/dispcc-sm8250.c                   | 21 ++++++--
 drivers/clk/qcom/gdsc.c                            | 59 ++++++++++++++++++++--
 drivers/clk/qcom/gdsc.h                            |  2 +
 drivers/clk/qcom/videocc-sm8250.c                  | 24 ++++++---
 include/linux/pm_runtime.h                         |  4 ++
 9 files changed, 131 insertions(+), 21 deletions(-)


