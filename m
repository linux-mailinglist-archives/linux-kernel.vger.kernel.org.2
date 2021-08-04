Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9AD3E09BA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 23:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbhHDVCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 17:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237671AbhHDVCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 17:02:32 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7E9C061798
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 14:02:19 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id c3so2932548ilh.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 14:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dX/WvZ71vHWRGig7P/Gktxx0GWORbXUaLwjhx4396BU=;
        b=hVR0dnLKbZG1a54aqWJZVm6vL47u/5T9drt1m6xd6uvOE0t7xtSGCTK/FiCdBVKSmR
         XoTgUIDut3i5gDpkES6sYtSNU+Lhw7vM6IOQs6nPTc3xo/A/DNM1Q8ReP3691gPELg2K
         Ynii5j1uYAro2tIfa0oIS4Nec1AzLocZbCOEihgg0Y5htogVq0AF9wwjA7BwGuTTreMj
         gcYoAqncvEspqp0ZI4G10XaMrRSafCCPDLNhhzO3WVyHqn7tX0o6ow3SZPmJsDRr/tjq
         /iP2ii3M+ivM0sUFF86xo02FJfEviVIBf2maIoEDfrdhjuV/GpVJ9eHEYlK6/ZWAoDho
         RL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dX/WvZ71vHWRGig7P/Gktxx0GWORbXUaLwjhx4396BU=;
        b=RKCHTicYFLR1bnsRNvyI9FiyO5ay8+YJKrg83V5puvFaEM3cl02qPAf5mxBTESCulC
         iIoH5pTbvE1NGyFbl1q4w2dG2ns2G6cC/ckS6Lk341/JsGsIteEFTP+VefWNtCpi2wf1
         O5owN7QJPrar5yjcAXHGjX5v6kwK/HKgWU63TllrPu/TTLJPQbYpNpcrn2CB1E+7TTdt
         XV0PZHGwHzKrFHLcdKIf6/TCXz1LLCOKJMuQ6cSCLXAlXYOA8L8NRq9oUz2hkvPlzpHB
         C+8YIKL7heX6bkf/UxAgwTU6oZWmv84qOUX5rSmMh96tqpqO57DjNWhoaxnwFnBhAX6z
         4Nzg==
X-Gm-Message-State: AOAM533m16+/h3frk2k4dAdKm+MIOn5gkEtEwG0IJqcqxs0d5ckcCF6R
        K1ON7bupel2FNGw9alnhvyYbiQ==
X-Google-Smtp-Source: ABdhPJzZWpDzmXe2TvYVNgx8qkqOVHqoq0iJQa56rhS/trE3dRhPSA8q9VtdSh5VgAS0evCePq9YHw==
X-Received: by 2002:a92:b112:: with SMTP id t18mr567725ilh.36.1628110938400;
        Wed, 04 Aug 2021 14:02:18 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id d18sm1687396ile.32.2021.08.04.14.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 14:02:17 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org
Cc:     robh+dt@kernel.org, elder@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] arm64: dts: qcom: IPA-related DTS updates
Date:   Wed,  4 Aug 2021 16:02:10 -0500
Message-Id: <20210804210214.1891755-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes four updates to DTS files for Qualcomm SoCs
that include IPA.

Most of this series was posted once before, and accepted into the
net-next/master branch by David Miller:
  https://lore.kernel.org/netdev/20210719212456.3176086-1-elder@linaro.org/

That series got reverted yesterday, meaning these patches can be
taken in through the Qualcomm tree as intended:
  https://lore.kernel.org/netdev/20210802233019.800250-1-elder@linaro.org/

The first patch defines IPA information for the SC7280 SoC.  The
second enables IPA for the SC7280 IDP platform, indicating the
modem should perform early IPA initialization.

The third patch adds the definition of a reserved memory area to
hold IPA firmware for the SC7180 SoC; this is used if the modem does
*not* do early IPA initialization.

And the last patch fixes the definitions used for interconnects for
the SM8350 SoC.  A corresponding update to the configuration data
(IPA code) was posted earlier today:
  https://lore.kernel.org/netdev/20210804135407.1358606-1-elder@linaro.org

  					-Alex

Alex Elder (4):
  arm64: dts: qcom: sc7280: add IPA information
  arm64: dts: qcom: sc7280: enable IPA for sc7280-idp
  arm64: dts: qcom: sc7180: define ipa_fw_mem node
  arm64: dts: qcom: sm8350: fix IPA interconnects

 arch/arm64/boot/dts/qcom/sc7180.dtsi    |  5 +++
 arch/arm64/boot/dts/qcom/sc7280-idp.dts |  5 +++
 arch/arm64/boot/dts/qcom/sc7280.dtsi    | 42 +++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8350.dtsi    |  8 ++---
 4 files changed, 55 insertions(+), 5 deletions(-)

-- 
2.27.0

