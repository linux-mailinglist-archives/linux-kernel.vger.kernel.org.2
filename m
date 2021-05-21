Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF5838CE93
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 22:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhEUUH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 16:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbhEUUHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 16:07:21 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0E2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 13:05:57 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id lx17-20020a17090b4b11b029015f3b32b8dbso6151471pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 13:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ybXypeyea8Cf9kwFCSJgN0ItJkY4+UPXl7JyFWq2ns4=;
        b=gvizpSBJ+apVKVlvGSXBZj2gEs1knSeRCxVXdN3vtGCGuh0shDb201I84svqrga0q5
         uX0JPqks5j4LZz+18rZ/lbNlLgVxjOPNcvhpUIOGJFxgSOGBLVHP9VgULuSrvy1abr3+
         NBYnw9w9w/vub/ZSfFkg831gtYAHt7j9EAO1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ybXypeyea8Cf9kwFCSJgN0ItJkY4+UPXl7JyFWq2ns4=;
        b=mFaWsdOrRZJF+mBCoU5Bop6wjpu5E/3uDqBEvCQQD3CipAjhqVDMUZcppBseBa4Orz
         7sQMcvMG/KihmDC3v2yi4yfyYRYPxXQwIE80QFefUDP/Z0KSEXwBfXtXV49lOwkQxVBz
         60+Y8WNGE4vxoeLijpCajwGGxe1GBTSpyPEZDNzL/KPFwopCNvTtHI2y7FkfjbWk6f0R
         9OCwLSV7OzfwqZknFkEH2e5B5tx8V7Oi+Fb4Jc0m2ILPGovqyua58u3dvHgPBcVdmAbx
         y6fLQmrDNn5SuH3AeZ0kesPtJrUU5F6RRbSTPjGDMjbjdnuoAMTJp2hwqhUa/CgUl9w2
         iI9Q==
X-Gm-Message-State: AOAM531+y/rnCiBNiYE/NrG+H9Mv7fLlh2F8oZEDj0fbvZTNjt1jx5Dz
        IxroW8pBptK54xLOEA0p2Ic4Jw==
X-Google-Smtp-Source: ABdhPJzhy4xTRi3QdYIYW790JHpwnfEydljuE/FpMrNWeq4/SEl0a4KL/tU7v+aalWjydp3F/uLpOQ==
X-Received: by 2002:a17:90b:11cf:: with SMTP id gv15mr12620696pjb.26.1621627557050;
        Fri, 21 May 2021 13:05:57 -0700 (PDT)
Received: from sujitka-glaptop.hsd1.ca.comcast.net ([2601:646:8e00:b2f0:22bd:8c3f:584d:d265])
        by smtp.gmail.com with ESMTPSA id z19sm4550614pjn.0.2021.05.21.13.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 13:05:56 -0700 (PDT)
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
Subject: [PATCH v1 0/2] Update sd card pinconf for sc7180 DT
Date:   Fri, 21 May 2021 13:05:27 -0700
Message-Id: <20210521200529.1991729-1-sujitka@chromium.org>
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

Sujit Kautkar (2):
  arm64: dts: qcom: sc7180: Move sdc pinconf to board specific DT files
  arm64: dts: qcom: sc7180: trogdor: SD-card GPIO pin set bias-pull up

 arch/arm64/boot/dts/qcom/sc7180-idp.dts      | 102 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 102 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi         | 102 -------------------
 3 files changed, 204 insertions(+), 102 deletions(-)

-- 
2.31.1.818.g46aad6cb9e-goog

