Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CD734AAB4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhCZO7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhCZO6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:58:52 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04EFC0613B3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:58:51 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 15so7791682ljj.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snejp.pl; s=gmail;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ro62SIlTr46CZwtgL4vPrPHqs2jlXt7ltUw/pHWUPVg=;
        b=pwlyfkIfdIXjNs16JX17azCcI5JHCrbEJYegYaLU8/FjRmV+JtpW1B+wDBrYztItDx
         BsHPmXvhHMS+YUsGLvUOidjz7GopbH2Up9Me9eTFCwDzKsWnfIOZ3nKZ4zKwe7cg3mIO
         1ksmwZ9NLXyiZYg+ZQvb9BBudODNP+WaBv7tDJZFHrBX5wF7cautqNz2GLoKicf75Xup
         N7xqBb79UYyOlYkagmSAglf1XZVbfgxYjPOxdERqtyyDZOIr1s35IjqbtL+XAzcSEke5
         +UkPiTP1tk+KUDd+S3Ic3CKuEsbVM9sA/OzRc6xGVEQX4TpW0gn6ff8u6Z2ldjcjfwLK
         tjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ro62SIlTr46CZwtgL4vPrPHqs2jlXt7ltUw/pHWUPVg=;
        b=V9/J9cPls3pvQyrCg7wSY5d4eNb4lmYv0+y0lrxOW1AiolrPSz9rTpNEzH/aAPLvCI
         x6j39QGD67aQVPjmX45DnfwjX8Q+2OWKWnciBWlSgCnJ1FR3XmzPyEYUeGdprQ8kqijE
         /DsK/wF/x/t3GiUS1/if/fezhIi+7t0hYMSFI70Li62nqvE009nfiGFxj32V+dR+7LpF
         8NDsWseVaLfGMqqFDllfDUHwbx31vCYYYQ60CMFnwb8N7Cf2rbbWCcUN5jVkL60uKnWp
         9N0pFFFa8TgIOBeh8FcCkErywIBMvSGJ0xagqE1Y77OcQCdmfT2csfZOcNDpxA1EH+gh
         82uQ==
X-Gm-Message-State: AOAM533TgGsKdha9pKFw7DQ/CJISs2eGBfYCoOKl6sBBHYRvTfCdhDfy
        m38P4/9PuO5CsVIVEQca86Pa5g==
X-Google-Smtp-Source: ABdhPJz18+GKnZeCIm3xWeh70XGDQm/Ehx3OsY6KvuOLEV9PeV9ApKF9yFytSFUdCcHXHvZataq2mg==
X-Received: by 2002:a2e:a487:: with SMTP id h7mr9071922lji.447.1616770729903;
        Fri, 26 Mar 2021 07:58:49 -0700 (PDT)
Received: from PackardBell ([82.160.139.10])
        by smtp.googlemail.com with ESMTPSA id k2sm893382lfm.174.2021.03.26.07.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 07:58:49 -0700 (PDT)
Received: from localhost (PackardBell [local])
        by PackardBell (OpenSMTPD) with ESMTPA id ec223c69;
        Fri, 26 Mar 2021 14:58:48 +0000 (UTC)
From:   Bartosz Dudziak <bartosz.dudziak@snejp.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Bartosz Dudziak <bartosz.dudziak@snejp.pl>
Subject: [PATCH 0/5] Samsung Galaxy S III Neo Initial DTS
Date:   Fri, 26 Mar 2021 15:58:11 +0100
Message-Id: <20210326145816.9758-1-bartosz.dudziak@snejp.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches enables to boot MSM8226 SoC in Samsung Galaxy S III Neo
mobile phone. Implemented clocks are on top of MSM8974 GCC driver because there
is really little difference between them. UART serial communication is working.
I have working patches for the regulators, EMMC, multithreading and Wifi for
this device but they are not clean and ready to submit.

Bartosz Dudziak (5):
  dt-bindings: clock: qcom: Add MSM8226 GCC clock bindings
  clk: qcom: gcc: Add support for Global Clock controller found on
    MSM8226
  arm: dts: qcom: Add support for MSM8226 SoC
  dt-bindings: arm: qcom: Document MSM8226 SoC binding
  arm: dts: qcom: Add initial DTS file for Samsung Galaxy S III Neo
    phone

 .../devicetree/bindings/arm/qcom.yaml         |   6 +
 .../devicetree/bindings/clock/qcom,gcc.yaml   |  13 +-
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/qcom-msm8226-samsung-s3ve3g.dts  |  25 +++
 arch/arm/boot/dts/qcom-msm8226.dtsi           | 152 ++++++++++++++
 drivers/clk/qcom/gcc-msm8974.c                | 185 ++++++++++++++++--
 6 files changed, 364 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dts
 create mode 100644 arch/arm/boot/dts/qcom-msm8226.dtsi

-- 
2.25.1

