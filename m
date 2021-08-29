Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4F53FACC4
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 17:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbhH2Psy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 11:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbhH2Psx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 11:48:53 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3142BC061756
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 08:48:01 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id p15so21257559ljn.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 08:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ON8B7MXOOZz/UZUTIAo25KHPPQ8XcjU+Eygo8cllfIE=;
        b=jo+zZDZW8upeygR2His05OCK/EGbR2Bdg8xeLiM7fTPXHTKZn5p+6y0u7y543tB2n+
         TrDxDZOQAp3KXfeynllRKUA0jwkhO7E4vq85jgktjdSAX4cb10TatMvF0RxJ9jaEQuyr
         ESIP7jzu8Om9bqwiVce2L/uu5CLwzASZsMLjCYDVFs6xL8OI9ll+GEET94/0R8gYtju9
         tyeOJP584PNvyYCRHxfysoEmb70axLqgjVyzzE2D/WGuHiRaLlHXv4XpACVw9depaOEa
         moHyE5uCzYlDOvFlAI8cI8c0IYmhj/qj6CYcP8KxNPyR7hFHKFjTb62b3+8F0Vp/oWKz
         Jxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ON8B7MXOOZz/UZUTIAo25KHPPQ8XcjU+Eygo8cllfIE=;
        b=QPxKpFjbIKcYpgOyz1iTXNg6DDKKHrJ+BuxOALSDdjefmOhMKOymahIkwEcTEStjAt
         LvTAkIBmQ4D9kfw195Lme5jZVIw2k679NlBT+KS1nRBVR4w1CNHD1nKJJ053ooWpMrpe
         FVQ52F322cpFo7IW38NuYKFqsk5Q9hLUnEr7s+OK5lciN/HaN87QmBxmr12rcTJw5nsf
         OUn4qAaS4APD+4YqKGfndG4K18aj2k9xtbqy8FseydRu9biUv+qNiKlcTkDrAze3ThUC
         JFbkE2bnaxgGvQDTEmT/WRcPZ5YwLm60EwYzlXZKhJBKAsarT1utDARVj1UG9YcBHhpA
         o34g==
X-Gm-Message-State: AOAM530ObJrH3j4QWbY0rZB3CkmV+fXZwgMnaVITNv+g5lfHpDfWd+dh
        4UWFJQNPQooOWhsyXVuAgO+71Q==
X-Google-Smtp-Source: ABdhPJzWaIS4QyNwTV2uVyKBxTkYNEoPA2E8WWR0u4z/eVli9n5t0eplZJBJu2lsX+TZTVBSFGltKA==
X-Received: by 2002:a05:651c:1126:: with SMTP id e6mr16797376ljo.28.1630252079428;
        Sun, 29 Aug 2021 08:47:59 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y5sm1481243ljd.38.2021.08.29.08.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 08:47:58 -0700 (PDT)
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
Subject: [PATCH v7 0/6] clk: qcom: use power-domain for sm8250's clock controllers
Date:   Sun, 29 Aug 2021 18:47:49 +0300
Message-Id: <20210829154757.784699-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
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
https://lore.kernel.org/linux-pm/1628767642-4008-1-git-send-email-rnayak@codeaurora.org/
(pending inclusion into 5.15)

Changes since v6:
 - Dropped dependency on Bjorn's patches
 - Restored required-opps properties
 - Held pm device state while gdsc is powered on, removing dependency on
   genpd's power_on() powering the domain into required state.

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

 .../bindings/clock/qcom,dispcc-sm8x50.yaml         | 13 ++++++
 .../devicetree/bindings/clock/qcom,videocc.yaml    | 13 ++++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi               | 13 ++----
 drivers/clk/qcom/dispcc-sm8250.c                   | 28 ++++++++++--
 drivers/clk/qcom/gdsc.c                            | 51 ++++++++++++++++++++--
 drivers/clk/qcom/gdsc.h                            |  2 +
 drivers/clk/qcom/videocc-sm8250.c                  | 31 ++++++++++---
 7 files changed, 130 insertions(+), 21 deletions(-)



