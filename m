Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9623642BE10
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 12:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbhJMK6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 06:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhJMK6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:58:14 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF012C061767
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:56:06 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso1958765pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LL9CpSaKrwIGmzf5gUizL7uHqJVR8v2f7iF2al5I2gY=;
        b=mxHA9h0fvl0IV6lqG/ITsAIHHgpNrWhGbL8wzkufFz91H7ItJqO3eFvtZeFcBE25Me
         eXLDK86XM4C6uCH99pHIDHinaiwO8GzO4sT08bzTzTqnsETHwZupKrAaMjl6jbTMzMLa
         gZbL+YAz5ZvaJ5b1ulkwfbogdKK938pwYvQbZ9TcKLC2IHlSo6UYfoI9y9PuhosQz8Fd
         TRrwI1Ir8CWcFlUZvdmt3HlssDOURZXFSx0ZoNWvb3DoKQX+83yVF6s8NoWY4z3VuE6f
         +pD0hd5UY1Xjm7KUtAtLyjW7kTAucKEgBfT/qjX2CA79qg7G7Gk0CP/4cOb90oEt6oyT
         E9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LL9CpSaKrwIGmzf5gUizL7uHqJVR8v2f7iF2al5I2gY=;
        b=M6UZ/YPzb7cI5BxNy9v1i1WWv30ZD2uvsz/jTI/suw/bpUEuedCsXOVxe+MPNJ00sO
         15xQasjiy9tXaaZ/OjzldZNph2uXyXif+qyMcz1MV4pckqFaUZTUKuGYsX2MtsQ4EQuD
         9o77dxtscYpiwcdmmjr6kinK5V+z/fOYKxmgNqVgWtG1MIsiaeWXw9DdpbDzmaoB437q
         813OtdkJT/S/NDsgol7muQ3eeps0c4BmoZ3IM5DruuQy8i4HsolCoBAtcLCOPLQTYw8V
         gMoA4n71Uf1Mv7dJztizhLOrFYtOV3CLGfIbOILzIhbRF8NszavBPtwu79Z1gEMEMMYK
         ztvg==
X-Gm-Message-State: AOAM531q+sE+JbGglOGu7phuLkOk4CqaRZtW8XxFRdxoTVVxfxXDCUF9
        1FAsQ21IZqlMpPiwxLeBeqtKEA==
X-Google-Smtp-Source: ABdhPJxpVn6s06BcFRv7MNatv5Gi4Lr15alhu+KdWwOD+0qh74bxiXioA5VZD8McVcgCoxmkDnyJOg==
X-Received: by 2002:a17:90a:5108:: with SMTP id t8mr12571728pjh.201.1634122566438;
        Wed, 13 Oct 2021 03:56:06 -0700 (PDT)
Received: from localhost.name ([122.161.48.68])
        by smtp.gmail.com with ESMTPSA id b13sm6155351pjl.15.2021.10.13.03.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 03:56:06 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v4 02/20] arm64/dts: qcom: ipq6018: Remove unused 'qcom,config-pipe-trust-reg' property
Date:   Wed, 13 Oct 2021 16:25:23 +0530
Message-Id: <20211013105541.68045-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211013105541.68045-1-bhupesh.sharma@linaro.org>
References: <20211013105541.68045-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'qcom,config-pipe-trust-reg' property doesn't seem to be
used by the qcom, bam_dma driver, so remove the same
from 'ipq6018' dts.

This is a preparatory patch for subsequent patch in
this series which converts the qcom_bam_dma device-tree
binding into YAML format.

Without this change, 'make dtbs_check' leads to the following
error:
 $ arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dt.yaml:
     dma-controller@704000: 'qcom,config-pipe-trust-reg' does not match
     any of the regexes: 'pinctrl-[0-9]+'

Fix the same.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 7b6205c180df..6a05ee82547f 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -201,7 +201,6 @@ cryptobam: dma-controller@704000 {
 			#dma-cells = <1>;
 			qcom,ee = <1>;
 			qcom,controlled-remotely;
-			qcom,config-pipe-trust-reg = <0>;
 		};
 
 		crypto: crypto@73a000 {
-- 
2.31.1

