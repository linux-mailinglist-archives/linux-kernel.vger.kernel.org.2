Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512FA40F02A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 05:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243699AbhIQDG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 23:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243623AbhIQDGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 23:06:22 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15B3C061768
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 20:04:57 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id w6so5227221pll.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 20:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x7aZTfIyIwGJxBeqjp2VS+8QxWVwQJBhJBrFL9IwQ/I=;
        b=TfH/UwihBn07N6B8SaiphNPVx6O91D902u9TQ/EbMLi02aRRf/JGhLsckQFVRKagqX
         nj+URvWiTuuPkzk5H1UH7HoHwe8d5kbH738tn5BQ89Bs2t8GKBygiRZOnMWB+xJZCS+D
         pyRK1oJ0eW7KIIATgqVaTQtK10QDQLDm4pnmkKvQDcaR7hU4JoSLufXXeExBIZBD0o6e
         kvB6yQoLhovrdcwVN07it/wHj5Qa2iGdSKzDZ6KKKLBJh5HZV27n3Pb8KYikgpF1JSoL
         28IUSnRqpyia+pd6cYjRqfG0qLYE7/7dYnc9ORPQdoW8/dmtq8rJ561E4ZXskyPuLCc2
         er1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x7aZTfIyIwGJxBeqjp2VS+8QxWVwQJBhJBrFL9IwQ/I=;
        b=48K4PL2TF8/O22RJ71kONfs19ibYWkqeXhycdM64viA3uluJxtnKN6ORdr9oPCMwoP
         sn23yVBkj6QlcEhu/c0/CLpmIASnOcPnIITAo74xSbgzCVVmqkhSCTjYUet2BmBO5B75
         lMIVfpxVfVdT1LlWc2SPpAjVZUlDZ94PYqDHATxZNsExXbLscDlF9c8dTGUWfuLTSGlL
         iWh4/hI61iDj3KmtlNO6kKnxpAAiZ/4r9/sI9q1mAC9XdT1BM0FxBPD6it5hnd9qib/O
         TbLzkEBpHf5SxDumS+IaqWfXWcet0Nv9/WF3GU4gGKN6RKQw2PE/rEAGyxrUX5CZ9L0s
         VoMw==
X-Gm-Message-State: AOAM532wA8jF1mufBXWWbBiWQII4++/0yI/n2KBgxhUv5BVdhX47Oda/
        GwbwFStZXo6prn8LoBuHrBTQ0Q==
X-Google-Smtp-Source: ABdhPJxW3k+400xVkw3brZ8+3L3VXOsWc6oWBCos9LEzYvlO/dzrhaf2VqwNivupm/FilZzgjd0nEA==
X-Received: by 2002:a17:90b:1a90:: with SMTP id ng16mr18682154pjb.116.1631847897462;
        Thu, 16 Sep 2021 20:04:57 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id q2sm9133930pjo.27.2021.09.16.20.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 20:04:56 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 2/3] dt-bindings: clk: qcom,rpmcc: Document QCM2290 compatible
Date:   Fri, 17 Sep 2021 11:04:33 +0800
Message-Id: <20210917030434.19859-3-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210917030434.19859-1-shawn.guo@linaro.org>
References: <20210917030434.19859-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for the RPM Clock Controller on the QCM2290 SoC.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 Documentation/devicetree/bindings/clock/qcom,rpmcc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt b/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
index a4877881f1d8..da295c3c004b 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
@@ -25,6 +25,7 @@ Required properties :
 			"qcom,rpmcc-msm8994",·"qcom,rpmcc"
 			"qcom,rpmcc-msm8996", "qcom,rpmcc"
 			"qcom,rpmcc-msm8998", "qcom,rpmcc"
+			"qcom,rpmcc-qcm2290", "qcom,rpmcc"
 			"qcom,rpmcc-qcs404", "qcom,rpmcc"
 			"qcom,rpmcc-sdm660", "qcom,rpmcc"
 			"qcom,rpmcc-sm6115", "qcom,rpmcc"
-- 
2.17.1

