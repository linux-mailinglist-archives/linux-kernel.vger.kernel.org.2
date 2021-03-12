Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D48339696
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhCLScz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbhCLSch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:32:37 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68387C061762
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 10:32:37 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id z5so12338586plg.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 10:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lLcxMgLQzpOPuMsy/zbtgLb8CJfZoKn9DHLH6v0dwq8=;
        b=JFRJiIKPCLBe+gRs8/quunIzOR3HfENktTlkCaXVWFEdYnTSV2OQ5chktHryBEAtgY
         nCh5JNlcLBMzv/4xTuM+mN1ZkVcTlwni3Iz+p2esee/9QX+d3A957u/fP+NvpZS7DlzD
         rbSDpy9TNDjaxu5VZ8wLLVBDzbB1tY7MpWkCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lLcxMgLQzpOPuMsy/zbtgLb8CJfZoKn9DHLH6v0dwq8=;
        b=LFvjuJ0ymmCO8RtSgtg6q63e59gyhqE2AY16S9ZRQEKfm2ewe8TtpPDDCR5nUDPOKY
         1M3rmvsRGSQfW92MNQ6qUIK867BYSNr+DIXhUVyVwgawoeM6mE0lYyJteHmcW1+hpZ1g
         Ip9WTD+lQhwcaFKb3rsLRN29Wos8nTCmn5tu/kcuRbOaRl9aCqrHG6UBSjd1nPxY02bD
         Z4XBL8H1UTNRabF4VgHa6ZVIG6w9Okp1bjrGpWwObBf0v3/Z/WXTqQhGVSKyg9A2aGA8
         LVnn0WLFLHayFVAve3RSOVG1RIN1D8WYcTbMNxAZNTHIVcpZzdM+MiUZkSunFYk4+zMX
         77Ng==
X-Gm-Message-State: AOAM532rNGLoMscmpiP5OhXLoZSgz6Zd/fedkZwi/B9Sbnl9GkaKJv3j
        Q8AlQ9a9ynIEIUn14Qm2ZgejJA==
X-Google-Smtp-Source: ABdhPJwhW/lrm9bAmgB0dDVBUtRv9pmo/DJiPA0Olw4Z/dkGiQeQZ0jxmX41v7/rF4wmeR5QqJ+FTg==
X-Received: by 2002:a17:902:ea0e:b029:e4:81d4:ddae with SMTP id s14-20020a170902ea0eb02900e481d4ddaemr413248plg.12.1615573956800;
        Fri, 12 Mar 2021 10:32:36 -0800 (PST)
Received: from localhost ([2620:15c:202:1:914f:6483:1dc:1bba])
        by smtp.gmail.com with UTF8SMTPSA id e65sm6382428pfe.9.2021.03.12.10.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 10:32:36 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 0/3] arm64: dts: qcom: sc7180: Disable the charger thermal zone on more trogdor boards
Date:   Fri, 12 Mar 2021 10:32:25 -0800
Message-Id: <20210312183228.550779-1-mka@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already disabled the charger thermal zone for lazor to avoid
bogus temperature readings from an unsupported thermistor. Some
revisions of other trogdor boards that are added by Doug's
'arm64: dts: qcom: Update sc7180-trogdor variants from downstream'
series have the same problem. Disable the charger thermal zone for
them too.

This series is based on v2 of the 'arm64: dts: qcom: Update
sc7180-trogdor variants from downstream' series
(https://patchwork.kernel.org/project/linux-arm-msm/list/?series=440315)

(no changes since v1)

Matthias Kaehlcke (3):
  arm64: dts: qcom: sc7180: lazor: Simplify disabling of charger thermal
    zone
  arm64: dts: qcom: sc7180: Add pompom rev3
  arm64: dts: qcom: sc7180: Add CoachZ rev3

 arch/arm64/boot/dts/qcom/Makefile             |  4 ++
 .../dts/qcom/sc7180-trogdor-coachz-r1.dts     |  9 +++++
 .../dts/qcom/sc7180-trogdor-coachz-r2-lte.dts |  4 +-
 .../dts/qcom/sc7180-trogdor-coachz-r2.dts     | 13 ++++++-
 .../dts/qcom/sc7180-trogdor-coachz-r3-lte.dts | 18 +++++++++
 .../dts/qcom/sc7180-trogdor-coachz-r3.dts     | 15 ++++++++
 .../boot/dts/qcom/sc7180-trogdor-lazor-r0.dts |  9 -----
 .../boot/dts/qcom/sc7180-trogdor-lazor-r1.dts |  9 -----
 .../boot/dts/qcom/sc7180-trogdor-lazor-r3.dts |  9 -----
 .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |  9 +++++
 .../dts/qcom/sc7180-trogdor-pompom-r1.dts     | 12 ++++++
 .../dts/qcom/sc7180-trogdor-pompom-r2-lte.dts |  4 +-
 .../dts/qcom/sc7180-trogdor-pompom-r2.dts     | 38 +++++--------------
 .../dts/qcom/sc7180-trogdor-pompom-r3-lte.dts | 14 +++++++
 .../dts/qcom/sc7180-trogdor-pompom-r3.dts     | 15 ++++++++
 .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  | 31 +++++++++++++++
 16 files changed, 151 insertions(+), 62 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dts

-- 
2.31.0.rc2.261.g7f71774620-goog

