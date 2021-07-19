Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A003CEEAF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 00:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242929AbhGSVNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 17:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388294AbhGSUtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 16:49:21 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98837C0613E8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 14:25:02 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id x10so21682548ion.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 14:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+NFov+irJOIAcAXFIXqWWjTSP6xxxi6btrU5/J/bm+U=;
        b=gi4a1X6zqWbU6JFTYdIkrKwXsadmfVQjQZXc4UAu79Xuo9uVaQs5mF1Qh4oVNAFf+J
         uxqTMXWI3d/HGcnI8or4S9FGv7y/VkGY8sHJSRD+V4fJv/rPU3BykqwduAUTyCLWdR+t
         7HIh5+I9OrLLOfnyM2bEFVVWiL0zgmR3sqnOecfKEz/YdsHxd0ATFV59Vnct0shrncnA
         hRT69ZweUPn9c7zCDgy21zgSv9eT605dkhtfk+BdmzX3HFPQrVtftap7h9hxj+QopF2O
         sFgozzJGV27O7gxuOoHLqYwVR0UCe286B4cn5/7acdqmTLthgSXNXktx93ZmDHMNAVea
         Qa5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+NFov+irJOIAcAXFIXqWWjTSP6xxxi6btrU5/J/bm+U=;
        b=ejcHxzqAtkYecLLAC7wUda2bburnfTl+JdO9GFdsVgRYGppRNTrEnO1hBOH5gQ8hqB
         oaJP8WJyk20QSAoe+XWGbe8tUHXwIm1gD3XZP1/gR1gjYQ+VfxbIpb5MYJWIdeFQ+tYt
         jLakzzHr0imVdoF5vM/L55lBBK41SY5l03fBbtSA3DIk92GLgnrgWotn/5bQmFm2JUBZ
         /JZr3W13iiYMGQbOOIeDeDMcJWZ6uqWa6u321XTRhdaIUHYnV+iOm1LYIWTB7344oopn
         VM7TsShSbJsFWmre9yTsvSCWxtA7VgIJ2ik1Lhw/wu0jyfNPwyTwlWgpJ+VWJya4EWnw
         Qewg==
X-Gm-Message-State: AOAM532BQAR8T+piTkXGkAuVRl3dL1AHndpCu88wxbQH336zWtE/p+SZ
        EAI7syIxTvdwuHwP8fz3XQi63Q==
X-Google-Smtp-Source: ABdhPJzNvhuaAmL+Pyh3lSgRYQEiK4aWTYjhrhV1OG2OYHesViN3CWmce6hYG94TSGQmqTftLEZ1kQ==
X-Received: by 2002:a02:90d0:: with SMTP id c16mr23483597jag.106.1626729901944;
        Mon, 19 Jul 2021 14:25:01 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id f16sm10365634ilc.53.2021.07.19.14.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 14:25:01 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org
Cc:     robh+dt@kernel.org, davem@davemloft.net, kuba@kernel.org,
        evgreen@chromium.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, elder@kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/3] arm64: dts: qcom: sc7180: define ipa_fw_mem node
Date:   Mon, 19 Jul 2021 16:24:56 -0500
Message-Id: <20210719212456.3176086-4-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210719212456.3176086-1-elder@linaro.org>
References: <20210719212456.3176086-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the reserved memory space used for IPA firmware for the
Qualcomm SC7180 SoC.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index a5d58eb928960..7af551a1fd904 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -110,6 +110,11 @@ tz_mem: memory@80b00000 {
 			no-map;
 		};
 
+		ipa_fw_mem: memory@8b700000 {
+			reg = <0 0x8b700000 0 0x10000>;
+			no-map;
+		};
+
 		rmtfs_mem: memory@94600000 {
 			compatible = "qcom,rmtfs-mem";
 			reg = <0x0 0x94600000 0x0 0x200000>;
-- 
2.27.0

