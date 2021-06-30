Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9504C3B831D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 15:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbhF3Ne1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 09:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbhF3NeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 09:34:22 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF61C061767
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 06:31:53 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id k21so3334147ljh.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 06:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pUIlKUb2VNsBMxEGshGZSTgSUZ/+y9exbQnL3jxdY4Q=;
        b=m8/ZyOw8UIZzA4U6zFtgtKJQrhzLglN5hzj06KtI0x4gEO9vac+4oPc/JIJCmxe1g/
         QGSGUeOaRPeT72vSXYEIAjj5bvORV6EPdLMaJhlz48AXCXKzAa7bXRaZv/nfS6Id1tFM
         y9lzzXwODdpPYlOzvHXecQBkIcBbOjZ5+4pCH7z6viMObyJFfbVNA1Sgh9xDh7TvClMW
         I0dIl0V1K1tBWgYXMtd42a9XsLfpk2I517EQg9mtP7AFQVdB5gVDhCaD9leKliJnfsnR
         zakCs+7l+lwFPVmT6kAycgRR2ZyoRqWfHKZlkxdDV+emmNqUUQ7nrRMwAsWTOSKN2SwY
         EJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pUIlKUb2VNsBMxEGshGZSTgSUZ/+y9exbQnL3jxdY4Q=;
        b=pBz37Pfy8hTzurehiOuwy/8fqtlFBuJfTiDER9QhYNu5NMNzL1C2yQvZxke2DLJJbP
         bDGrCxa9M6uOzvZmJtjbKvo7VXgxODAm8QrXb7oAwcTQ13hUXkmG43JIT0rl7zOhjHi4
         30O7Fn1BctJdStcmmQU2J40XDtDNOfW9lUfnz+yOE3tt86WQDmR6aA50JO8D8nnLdb02
         YDfmuqtohoMexs+0JbM4Mumu8pYAx4dWnwtojxORfV8l6E5lIcXw8Jjhsk3krfrejYjw
         aoPN03ornjDMAAOb3ZrfMlxGsxr1Fy4tOpKlRos4GqCc/cFUQ0oOviCCktel2d5JsNhe
         327w==
X-Gm-Message-State: AOAM53380SymsTXXeEKpSCOH/vpgnJUpqVnkh1ez2s/yi5JPqMAWg6OG
        dHB5OOdIcSgPMeRMPtmMu73wCA==
X-Google-Smtp-Source: ABdhPJzxy9lUaymj8qAVoABsxa20Jd6Ayfz1FEKoQipeBMEocruZ1StfMZia5UMaSaMSQORRW9HWqQ==
X-Received: by 2002:a2e:9e8e:: with SMTP id f14mr7967443ljk.468.1625059911561;
        Wed, 30 Jun 2021 06:31:51 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id x20sm1578098lfd.128.2021.06.30.06.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 06:31:50 -0700 (PDT)
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
Subject: [PATCH 0/6] clk: qcom: use power-domain for sm8250's clock controllers
Date:   Wed, 30 Jun 2021 16:31:43 +0300
Message-Id: <20210630133149.3204290-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SM8250 both the display and video clock controllers are powered up by
the MMCX power domain. Handle this link in GDSC code by using
pm_runtime_get/put to enable and disable the MMCX power domain.

----------------------------------------------------------------
Dmitry Baryshkov (6):
      dt-bindings: clock: qcom,dispcc-sm8x50: add mmcx power domain
      dt-bindings: clock: qcom,videocc: add mmcx power domain
      clk: qcom: gdsc: enable optional power domain support
      arm64: dts: qcom: sm8250: remove mmcx regulator
      clk: qcom: dispcc-sm8250: stop using mmcx regulator
      clk: qcom: videocc-sm8250: stop using mmcx regulator

 .../bindings/clock/qcom,dispcc-sm8x50.yaml         | 19 ++++++++
 .../devicetree/bindings/clock/qcom,videocc.yaml    | 19 ++++++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi               | 13 ++---
 drivers/clk/qcom/common.c                          | 55 +++++++++++++++++++---
 drivers/clk/qcom/dispcc-sm8250.c                   |  1 -
 drivers/clk/qcom/gdsc.c                            |  6 +++
 drivers/clk/qcom/videocc-sm8250.c                  |  4 --
 7 files changed, 97 insertions(+), 20 deletions(-)


