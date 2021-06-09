Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67613A134D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239557AbhFILs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:48:59 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:55841 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239499AbhFILsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:48:35 -0400
Received: by mail-wm1-f52.google.com with SMTP id g204so3804950wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4s1/Jg1HhDEEncoJTBVDB2qVrW8UQryvJsGgvpUV+xI=;
        b=cVHjuAELhDwvpdbPi2qd5bIp3w/aLKgyo3fzT8qkdXVnvQQ9c8osdS2ZptqnfyzQLb
         ja7lj2Z9hcR6RkIWwxJB4M2thYwbYX1nSFvxpi3wEIgDH5qZC63pSMpJQaf3qL4Q9ifX
         ZYGwC4TPV7wddlyzunvp0AtkaXJphg2K+5mmlRIbjQHmD+uJj5/tQanL9j2d4wfWYi39
         WW7j+KgxvjUZQI8tI12/cdk6sCOox3VBChmz45ZoSMi0uqRNGZPjNxTc0I9CyeAZh1hU
         +PU5+RosEoMTJTHCbWMYSejtaMK0aYhJOOGWxwtc7AXVEYo6ulQWQy3L0HvmSS8T3eRA
         WBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=4s1/Jg1HhDEEncoJTBVDB2qVrW8UQryvJsGgvpUV+xI=;
        b=oWlZjBy8RnyuXy2SOcxZmNq5IaN6pN/5zZuhLejVgIUUAfX5DDXGNDhUv7BTjTaU84
         b1WB6ZReJGym/JlJA4ii6UJek0H87wmOLRgNBK60MfU+Yj5TCgO/LmRVhd5i0wyPhFtV
         HsVF7tKXLxpGWkiVeAl2+wsrIQC3XG6bGkqhIvkwHRJBbp1wdr16qw0Uog2c3XP4ijCl
         IZM909j8MODGH3cvyyaa08J3mDjzsQkNR3GHlhDtJlLu09yYfhZjH9zYN6LCzUaoO3Kh
         nuRVyRoun2C1wiTWXEKGnhl4+h4Cpnm9PVmEFSEPfhUv8oV/0QS1MeRHROb+rag2MDQ/
         +gZw==
X-Gm-Message-State: AOAM530fJ76nAVQAsBP3vym8Bl5ccBUbaasHwswlyCIjSysC00XzRP1R
        +kGqrCEzzWUH2HiTTqk/0oqfIoCg1vE0Xti4
X-Google-Smtp-Source: ABdhPJwsLUcaMGCZInb11RHfN50h5UthTEpVaT91Z3buvkGcKGqzZpr/tpg52cOuZbU625ExxQhD1w==
X-Received: by 2002:a05:600c:35c1:: with SMTP id r1mr9213935wmq.181.1623239140298;
        Wed, 09 Jun 2021 04:45:40 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id m23sm21541508wmc.29.2021.06.09.04.45.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jun 2021 04:45:39 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 11/31] arm64: zynqmp: Add missing SMID for pcie to zynqmp.dtsi
Date:   Wed,  9 Jun 2021 13:44:47 +0200
Message-Id: <43f21f5033f7806fba049474bced6131c8cb98ba.1623239033.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623239033.git.michal.simek@xilinx.com>
References: <cover.1623239033.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Stabellini <stefano.stabellini@xilinx.com>

The SMMU is disabled in device tree so this change has no impact.
The benefit is that this way it is in sync with xen.dtsi. Xen enables
the SMMU and makes use of it.

Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index f860e90ea2a6..3fa0517cfd98 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -636,6 +636,8 @@ pcie: pcie@fd0e0000 {
 					<0x0 0x0 0x0 0x2 &pcie_intc 0x2>,
 					<0x0 0x0 0x0 0x3 &pcie_intc 0x3>,
 					<0x0 0x0 0x0 0x4 &pcie_intc 0x4>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x4d0>;
 			power-domains = <&zynqmp_firmware PD_PCIE>;
 			pcie_intc: legacy-interrupt-controller {
 				interrupt-controller;
-- 
2.31.1

