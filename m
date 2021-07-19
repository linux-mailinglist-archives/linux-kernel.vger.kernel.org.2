Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A131C3CEEE8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 00:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243307AbhGSVT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 17:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388261AbhGSUru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 16:47:50 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AEAC0613DB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 14:24:59 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id k16so21668106ios.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 14:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eiS9vjeAV2w43I7uPoTEYtj1lxKQUremRNEzEWxblLQ=;
        b=DmY3NAa1Wc7QkMPU62eiTsB1Y9XMGMG14olpOm1y0iQeG893XV5S2Uq/fuVCzYj5aK
         bQOhjz5/VB3zL9FxM6Kdgwxfoyq8oS1aFLxYEayLiggZVGYF4d0igSOCQelpOrNzM2PK
         +51FLp0tofK1DaInT9Gv0UWyrF721EKaQc3aOGuvfkeq9uWC/VXkL3z4YjLOa9PoyNd6
         67sL4xd5oLyWZ5WkUoysxjjz8dM1WZAGP7Nge6Zkbzo9qvEViAd9xIfamr1ByjScq5zc
         /JS+Mb4Z88GieoUtAehR2++vIUG1UYzmjVyLiPY5S9N5bmydhZRD85HzOMoAEtiATBFM
         nK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eiS9vjeAV2w43I7uPoTEYtj1lxKQUremRNEzEWxblLQ=;
        b=IsUNUAFpvIeoABjL73ErvE727ymct+oi1Jp4Qbr9XWxrfrMuPbdheIGKtuMkMO8L4r
         pJm6k4aeJvrLKdiyTCA2FOkgjidrFtZYizcf20nd4PhQFxEhz95G4sOu9OvPdOvLT7y4
         1wHGgJv/TayWmmt3A43Z+5jW6VTK5TocpRFJOLqstbR2At7wnorfjZpwCgCbajyS035B
         pNd8ErGL05sKJ2lDgqgmhL66f+3ufVp5gTxvb17DcCG62boiUZeYGzuWKm+k2WI+5IFo
         Y96xVnuRcEROMVDvEs/iz8tUNhmwR6KQw87bh6rZHRqDDZLO/78gR1V8CU0cAV1Q3nck
         AGJQ==
X-Gm-Message-State: AOAM53195CRbNm6kSbRp6g+Tbsi57RWSgMMAC1ZX5HdjUv/+BsEEva2j
        q/3Jf9bFAo69nIcv5uz7l8zUvA==
X-Google-Smtp-Source: ABdhPJzBE7wuSpBBojhR5L71d5Kg8g/9Kq2GBgkRksKv2M7CNBU0DAHcj9JSFTJLp5LE7JUsWEHvpA==
X-Received: by 2002:a05:6638:6a6:: with SMTP id d6mr23269298jad.118.1626729899304;
        Mon, 19 Jul 2021 14:24:59 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id f16sm10365634ilc.53.2021.07.19.14.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 14:24:58 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org, robh+dt@kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] arm64: dts: qcom: DTS updates
Date:   Mon, 19 Jul 2021 16:24:53 -0500
Message-Id: <20210719212456.3176086-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series updates some IPA-related DT nodes.

Newer versions of IPA do not require an interconnect between IPA
and SoC internal memory.  The first patch updates the DT binding
to reflect this.

The second patch adds IPA information to "sc7280.dtsi", using only
two interconnects.  It includes the definition of the reserved
memory area used to hold IPA firmware.

The last patch defines the reserved IPA firmware memory area in
"sc7180.dtsi".

					-Alex

Alex Elder (3):
  dt-bindings: net: qcom,ipa: make imem interconnect optional
  arm64: dts: qcom: sc7280: add IPA information
  arm64: dts: qcom: sc7180: define ipa_fw_mem node

 .../devicetree/bindings/net/qcom,ipa.yaml     | 18 ++++----
 arch/arm64/boot/dts/qcom/sc7180.dtsi          |  5 +++
 arch/arm64/boot/dts/qcom/sc7280.dtsi          | 43 +++++++++++++++++++
 3 files changed, 58 insertions(+), 8 deletions(-)

-- 
2.27.0

