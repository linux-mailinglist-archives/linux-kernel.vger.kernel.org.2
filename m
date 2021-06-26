Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B623C3B4B08
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 01:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhFYXnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 19:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhFYXnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 19:43:51 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B86C061768
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 16:41:28 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id a133so11032346oib.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 16:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ofzH3xCdn8SrueV2vGSvcq48Y8LFduBq0EUJ5hbpNyY=;
        b=vMt9w/cDvgI4OS7EJf7Eamp4L4Kx46UNe9SYE8fL5Ai2fHeIfBnz+RdTLUB3LIEnAS
         A4u352DKsdCA9Jj8ZD+UonFtAppaEexRSRyILNNQMQnWEBieYEXsNUczcfD9KO6+0RiG
         h/rKywh7oRonXojbiF+PZK5Q4t5wJAqrT/YK8YVh9Nd4Gsx6rXWGDyEG1Kbc0yHKiN9x
         gnHUFtV4SKBAaZErHS+dDB4TcuHvVszbP80jR8zjZ/3GYVkmLNFHIuEZuQGChRH1vQZH
         bM2a/f6RSXoZrjs8oeExCFF+to1uyIe3486LepkxFcdd1Yx7X/mE7K0wud0KnsAB0oGj
         jWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ofzH3xCdn8SrueV2vGSvcq48Y8LFduBq0EUJ5hbpNyY=;
        b=fV/4Aqyt3vrqqnD4aHGSDavlY0imccJx3ooI3ZVlw6SkziUwqRcfaFmYCetlODrUNf
         VVrFv+oR+ykDfcB0ssPZ1jDJ/KcWq/vImE4EZFIcSNzieVGJAvgepBDD5OkuIBam2pwY
         Xj01raFTytOEvUR3FHMunPY9u/LFM8CoXo39ihQt19lQuB5KesRzfmoBWVyYCdRotXsM
         eloqhNF0Y/5cWZV3k98lmkQw9dEiiDk2ttIKczdRvQtoFbZUwJ7jI6+/Y1L0lwBSoRqY
         gQhmC8Wavoeq6xUdzGI7BJpIzcC3TOkkKQDHxsimZ9F95/1KPzns6ApwPaJGFzJno9K+
         YBgg==
X-Gm-Message-State: AOAM532FDKkzYy/13bv00aEPlWdLf+8zZ4L+7t9S0K1EWHf8uDLBfbMX
        WKmRKkm/qJHXiGOLtKBuckZb6Q==
X-Google-Smtp-Source: ABdhPJyalttO3x/hpFThz9m6Aqspgsme3u7L8RMd87iVcymsHqnEKd676JnV8omKq2EEQzEGZdS8TQ==
X-Received: by 2002:a54:4612:: with SMTP id p18mr13814919oip.87.1624664488158;
        Fri, 25 Jun 2021 16:41:28 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u10sm1844267otj.75.2021.06.25.16.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 16:41:27 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Sibi S <sibis@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: soc: qcom: aoss: Add SC8180X compatible
Date:   Fri, 25 Jun 2021 16:40:16 -0700
Message-Id: <20210625234018.1324681-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210625234018.1324681-1-bjorn.andersson@linaro.org>
References: <20210625234018.1324681-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for the Qualcomm SC8180x platform to the AOSS QMP
binding.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
index 783dc81b0f26..3747032311a4 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
@@ -18,10 +18,13 @@ power-domains.
 	Definition: must be one of:
 		    "qcom,sc7180-aoss-qmp"
 		    "qcom,sc7280-aoss-qmp"
+		    "qcom,sc8180x-aoss-qmp"
 		    "qcom,sdm845-aoss-qmp"
 		    "qcom,sm8150-aoss-qmp"
 		    "qcom,sm8250-aoss-qmp"
 		    "qcom,sm8350-aoss-qmp"
+		    and:
+		    "qcom,aoss-qmp"
 
 - reg:
 	Usage: required
@@ -70,7 +73,7 @@ The following example represents the AOSS side-channel message RAM and the
 mechanism exposing the power-domains, as found in SDM845.
 
   aoss_qmp: qmp@c300000 {
-	  compatible = "qcom,sdm845-aoss-qmp";
+	  compatible = "qcom,sdm845-aoss-qmp", "qcom,aoss-qmp";
 	  reg = <0x0c300000 0x100000>;
 	  interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
 	  mboxes = <&apss_shared 0>;
-- 
2.29.2

