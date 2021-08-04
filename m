Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7832A3E09C7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 23:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239993AbhHDVC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 17:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240006AbhHDVCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 17:02:39 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8C1C06179E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 14:02:22 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id j18so2927995ile.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 14:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GAu8p3tjcesj9ZyybBwKeN/jK2mgfz8zSdEerPn6tnU=;
        b=z1zArIZFGyTmlE8814DCuSz/67i54nj56oZbf8w0ApKZEXhoFwSJv6Pk1HeNsH8d4o
         vvPlYadKMU/zjR/obYqS69yRuc6HJn9He4NY3m06vVmcVW6C1yzcYwN5a8Pl5+pjSJh0
         PstfNXx/2IXxcd3JlfGk1yHcl3eailMZaybSZgCw8BahzHAZPiXBm19pDCAleYrXrSb6
         WNKQimFgV6vcY7p56MrygixapbJO7/aub86P4ldYU3vcxxATo8HaLWb5oE5KZCiD+QFk
         pX9BH6yiS675HpRSqRmu2nlStBUuv15Q5OFnq6JKf08hu94I99Ftzn+LHyWeNa3iWaXv
         jtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GAu8p3tjcesj9ZyybBwKeN/jK2mgfz8zSdEerPn6tnU=;
        b=iBouCg4OF6Pdk9PQO5hgHmtNiYPPGW1ElESw+6q5EW1gahEP8QuMdwnMunWP4y2t1A
         izYjXRy+FWS3X0LAG9bBaAZoOPw96fo9K4aEbN13Bhft0nlHmksAPpNxe9sC5gOTqqqm
         ZZReDxPYd18AgKMBX8FUj7pMcf51xzd8NPYjTzIS5w93Fr+sxPmhRtb81DqPVBbTinYD
         BSPXFa/Kl0lMQC/X4NvcVOtorzHnSUXt3PFvgn6ApJ5rNipYYbmYq3tzMPgUv618dr6U
         gKR9nGQyHteFYt8Q5cc5iO/Ahnf9olH65SrzN7XWOsoMr0Ray4N3/e+v82e64yAPX24p
         LHFg==
X-Gm-Message-State: AOAM530MMep/ZuBKqosk6kV+Q76FFdu0RsIFx0uAbXBHJP1YZUBuZeE0
        ru1n71c1wTaCaVVddgkg0o4l5A==
X-Google-Smtp-Source: ABdhPJy98vvmzjTpgGFOJCBn3onNvtO3ZY488DPqIqJMIfHhpAjcR/EXFN6lyws1OrGSArZHa32igA==
X-Received: by 2002:a92:6909:: with SMTP id e9mr748365ilc.231.1628110941870;
        Wed, 04 Aug 2021 14:02:21 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id d18sm1687396ile.32.2021.08.04.14.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 14:02:21 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org
Cc:     robh+dt@kernel.org, elder@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: qcom: sm8350: fix IPA interconnects
Date:   Wed,  4 Aug 2021 16:02:14 -0500
Message-Id: <20210804210214.1891755-5-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210804210214.1891755-1-elder@linaro.org>
References: <20210804210214.1891755-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There should only be two interconnects defined for IPA on the
QUalcomm SM8350 SoC.  The names should also match those specified by
the IPA Device Tree binding.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index a631d58166b1c..01f60a3bd1c14 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -666,12 +666,10 @@ ipa: ipa@1e40000 {
 			clocks = <&rpmhcc RPMH_IPA_CLK>;
 			clock-names = "core";
 
-			interconnects = <&aggre2_noc MASTER_IPA &gem_noc SLAVE_LLCC>,
-					<&mc_virt MASTER_LLCC &mc_virt SLAVE_EBI1>,
+			interconnects = <&aggre2_noc MASTER_IPA &mc_virt SLAVE_EBI1>,
 					<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_IPA_CFG>;
-			interconnect-names = "ipa_to_llcc",
-					     "llcc_to_ebi1",
-					     "appss_to_ipa";
+			interconnect-names = "memory",
+					     "config";
 
 			qcom,smem-states = <&ipa_smp2p_out 0>,
 					   <&ipa_smp2p_out 1>;
-- 
2.27.0

