Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967A141E0F7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 20:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350905AbhI3SVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 14:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350775AbhI3SVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:21:11 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9ACC06176D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:19:27 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so8457953ota.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ssfSmhsMHjEW6hYVe4PjTHBi61zsb9noqUigbf2gVRo=;
        b=gCZKuBk5M3O2d6AQ6j53Dgx+OE2D665B/f7BF3j+ZV++mhUC2OqzthPTuK+SO78db/
         KtTB8wc45m6vgtkxkxgpJcRqlY+svn2wtwfqEgdA1ykfjqCcFPs/3MqaMXPOFuOsetxG
         cU7T/H8iXPjMWjJE4I+308Nw/WtO0Pex1uN7NlKCT/0Ip6CWTy8eIyj4CQgLgBTk9mb3
         ASm+luD4b6PrECb7zs4GsbHNvpcfn4ECNZwwcOkHYjZVEsi0tQoBzJWRav+R+AXLgPRz
         SI6WUgvPh1T+K+nMAp+KoZkDRol3QIT65/17KNEY2bZmfw7gM87fW7AzIq+1DLOyVXi5
         cKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ssfSmhsMHjEW6hYVe4PjTHBi61zsb9noqUigbf2gVRo=;
        b=AXqCDFxFgYdRJUOaT4j2wiE+V5bFL3xM2WzKjbBbH9yhccth0VmnQ4mHPunJoWbl17
         Ns0KRN00v2M3LXJMxBnJbX2PbMxZqcxdRsJBP3drvBGVLFgsAK+lMYsceXRR8UD0qpuL
         3KT/RjWJz6an6E7h8yZ+XtaqNMJYa41alErV8KJqYPUxWCkQ+Fuz5/DAV7q92OpkT895
         jWMSt9aa8e2pLKtzA3w0lFX4Eqik1/bW3x+hZZu8jEokWUIhBkNKAzDRGCXnHipbjEP9
         3rOCie52SilJs75eK/hzXiiVbufvV7ug8L2ncU6A9AWyq8WYTH8sHimcUEpP6lGo/n/B
         hvhA==
X-Gm-Message-State: AOAM531xhIPtXZV/qMaGIQ4DNPK+JcDDUwsraDnd2HNiOjjrpn6XjpOw
        5DkXAwPTGfu53WqlpBdVUv4WEA==
X-Google-Smtp-Source: ABdhPJysxT/S2qCAUgtNFfo215PxQiLxPc6UaM4C3xoF2S30WXVkVEm2Dx2mDB4zZ6ichO79ZGVVww==
X-Received: by 2002:a9d:7053:: with SMTP id x19mr6729949otj.229.1633025967205;
        Thu, 30 Sep 2021 11:19:27 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id k6sm727416otf.80.2021.09.30.11.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 11:19:26 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Lew <clew@codeaurora.org>,
        Deepak Kumar Singh <deesin@codeaurora.org>
Subject: [PATCH v2 4/4] arm64: dts: qcom: sdm845: Drop standalone smem node
Date:   Thu, 30 Sep 2021 11:21:11 -0700
Message-Id: <20210930182111.57353-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210930182111.57353-1-bjorn.andersson@linaro.org>
References: <20210930182111.57353-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the SMEM binding and driver allows the SMEM node to be
described in the reserved-memory region directly, move the compatible
and hwlock properties to the reserved-memory node and drop the
standadlone node.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Node name is changed to "smem", as "memory" is reserved for memory nodes.

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index beee57087d05..64119d2efdcf 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -99,9 +99,11 @@ aop_cmd_db_mem: memory@85fe0000 {
 			no-map;
 		};
 
-		smem_mem: memory@86000000 {
+		smem@86000000 {
+			compatible = "qcom,smem";
 			reg = <0x0 0x86000000 0 0x200000>;
 			no-map;
+			hwlocks = <&tcsr_mutex 3>;
 		};
 
 		tz_mem: memory@86200000 {
@@ -941,12 +943,6 @@ tcsr_mutex: hwlock {
 		#hwlock-cells = <1>;
 	};
 
-	smem {
-		compatible = "qcom,smem";
-		memory-region = <&smem_mem>;
-		hwlocks = <&tcsr_mutex 3>;
-	};
-
 	smp2p-cdsp {
 		compatible = "qcom,smp2p";
 		qcom,smem = <94>, <432>;
-- 
2.29.2

