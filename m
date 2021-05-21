Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAF838D081
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 00:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhEUWFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 18:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhEUWFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 18:05:33 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11B0C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 15:04:09 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id l70so15305508pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 15:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fZVsdD5w5dtbGbEEJ61BTCXnjeAcPQ5ciZkXFGTTwac=;
        b=BmJq5PJ91Kt9ueWlXfgGzQb1lvyeJkdvPtPnF1aTg6ImNy0Pe5eSeuMnLnT8NW7mCx
         OBMKULvpyEp6PFq/qxpPh8PHEB09lKSWIDfXHL3aOX2G1YFgQmLWjxqBARLtW+ozJnBS
         4XVhdLVFiR5s3e6g7RxHIS2InHQ/uYTsKhjBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fZVsdD5w5dtbGbEEJ61BTCXnjeAcPQ5ciZkXFGTTwac=;
        b=ZtVS5NvJw4NuSgJ1GUqeobwqfXmtirYb/cBIAU9i+r4nRRS68rkkwjvpzpAvN9jnNv
         fv8JhcXs18/76VG6P973Ews+LLN4HjCUabeqevDq5uVV+/nKTSMh5PrAcACk2BXKxHE/
         Zlytou2J0tXAaemDv5FSqdL4qvt6lEtHeWWukE63QQ3Ghaq2zKWK4y+nmEStDRBIy+Uz
         2+oj6ddh57Qef13qYqfPnH3+Z3vz911yF1grKGubX1EwwcQ2c3TdehpKn5sJRrmSNZzl
         Jr0hWNFJmH8+3foVYJiYK7w5Fqh9++1Zf1eNtnYceE/ivSj5t79PAA617a73C8K7MVaB
         EeIA==
X-Gm-Message-State: AOAM533UNRNlFclg/lvHfIkqQcDdAcGayZ3TikdKu9wiaM6Okkm+NJMm
        LqMn5aD8eOn3V3PFDui7AuiS0Q==
X-Google-Smtp-Source: ABdhPJwfj5QFKNrnmLhHknhNHNDuteX9JKlhhDvdG0CFxVyZMRpIv+KuMyWk3myJuifFPv1Lw+3h7Q==
X-Received: by 2002:a63:db01:: with SMTP id e1mr928254pgg.38.1621634649232;
        Fri, 21 May 2021 15:04:09 -0700 (PDT)
Received: from sujitka-glaptop.hsd1.ca.comcast.net ([2601:646:8e00:b2f0:22bd:8c3f:584d:d265])
        by smtp.gmail.com with ESMTPSA id z19sm6478752pjq.11.2021.05.21.15.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:04:08 -0700 (PDT)
From:   Sujit Kautkar <sujitka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Sujit Kautkar <sujitka@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Update sd card pinconf for sc7180 DT
Date:   Fri, 21 May 2021 15:02:45 -0700
Message-Id: <20210521220246.2017976-1-sujitka@chromium.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains change to move sdc pinconf from SoC specific
DT file to board specific DT file. It also contain change to set sdc
GPIO pin to bias-pull up

Tested sd card working on sc7180 based board

Changes in v2:
- added pull-up for IDP

Sujit Kautkar (2):
  arm64: dts: qcom: sc7180: Move sdc pinconf to board specific DT files
  arm64: dts: qcom: sc7180: trogdor: SD-card GPIO pin set bias-pull up

 arch/arm64/boot/dts/qcom/sc7180-idp.dts      | 102 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 102 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi         | 102 -------------------
 3 files changed, 204 insertions(+), 102 deletions(-)

-- 
2.31.1.818.g46aad6cb9e-goog

