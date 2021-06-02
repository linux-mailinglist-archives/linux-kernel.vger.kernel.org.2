Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB89339935B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 21:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhFBTQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:16:51 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:40688 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhFBTQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:16:47 -0400
Received: by mail-pf1-f181.google.com with SMTP id q25so2962865pfh.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 12:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+X79AjVoey780C+yU2yt7cNXXSYiTJQnnSoyYA222wQ=;
        b=WdVopIJMHVRUrycB41nea4CzP1o95ckHb0JogprvToZuuisikCSxWAKjweF3z/OQNR
         a016vpaVhosW8tLT7DDNS5lSx9aXb/TgLgTcRNUR5AMuuEh0TaIL3YzuV+rZ4Qw5ngUM
         qK51YPU593dVmk5PlZhQSL2/6HUbpSiBZrsCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+X79AjVoey780C+yU2yt7cNXXSYiTJQnnSoyYA222wQ=;
        b=OWKJb3SwXTc3rJCnKWQHTTCLs3v2J3ki4CG/CsRbRcXnJNYGqggL/kOQWC/F/a9QiJ
         gy3CUJ543eBRhFwhZtCJZR42z12eaYHM03Ss6inq75VvEy6KzMkEEk1AIfuKK0pRQutd
         iHIBTiCeVgT80f4YXYnAD5H1LJed81vojTOPbvPOy3x/W9wfeAMjJAehMpFW4DS66QS6
         et4a3DbEz+vgaHyz19gRNTJrOBfn61YMTmxjeRHT8/yMRUau0QBorovfKyOzQQau+OIH
         b5ybGblQ687qJR5PozBsGZZ+Bx+C41hS98XVnOGqdHm0lKVNLVaJo67I46lRjwPDHEpK
         6Gvw==
X-Gm-Message-State: AOAM532OMa8887mxzEEMqttbZ9FCv2TTPRR/x+zXdB0WIaGwAHDOk8BM
        pjEZDWV9icVHpy1eW/HMlcrIjw==
X-Google-Smtp-Source: ABdhPJxeFh53YxJq0tOGNvC2YTttGJccJQeUq1/Rfh+q7p+TynkzWVErHdsozA5XcWpR/GsYkR1EJg==
X-Received: by 2002:a05:6a00:8c4:b029:2b4:8334:ed4d with SMTP id s4-20020a056a0008c4b02902b48334ed4dmr28167092pfu.36.1622661243717;
        Wed, 02 Jun 2021 12:14:03 -0700 (PDT)
Received: from sujitka-glaptop.hsd1.ca.comcast.net ([2601:646:8e00:b2f0:3c25:f769:d7de:98bd])
        by smtp.gmail.com with ESMTPSA id z17sm329242pfq.218.2021.06.02.12.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:14:03 -0700 (PDT)
From:   Sujit Kautkar <sujitka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sujit Kautkar <sujitka@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Update sd card pinconf for sc7180 DT
Date:   Wed,  2 Jun 2021 12:13:37 -0700
Message-Id: <20210602191338.1995827-1-sujitka@chromium.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains change to move sdc pinconf from SoC specific
DT file to board specific DT file. It also contain change to set sdc
GPIO pin to bias-pull up

Tested sd card working on sc7180 based board

Changes in v3:
- update commit message in patch 2

Changes in v2:
- added pull-up for IDP

Sujit Kautkar (2):
  arm64: dts: qcom: sc7180: Move sdc pinconf to board specific DT files
  arm64: dts: qcom: sc7180: SD-card GPIO pin set bias-pull up

 arch/arm64/boot/dts/qcom/sc7180-idp.dts      | 102 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 102 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi         | 102 -------------------
 3 files changed, 204 insertions(+), 102 deletions(-)

-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

