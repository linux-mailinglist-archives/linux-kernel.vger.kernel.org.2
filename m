Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDDB3D94E4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 20:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhG1SBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 14:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhG1SBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 14:01:06 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155A5C061798;
        Wed, 28 Jul 2021 11:01:03 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id t68so3085796qkf.8;
        Wed, 28 Jul 2021 11:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r4bT7HeLBcKZhFeUiGhpGlFbEiM6IKHw69zvHFi+0OI=;
        b=k87taw6f0eEdVXbKKkk6UFP9RjT3t9HXI0prijEFlGB8eOl8fnZour12xrVFdzTfYj
         ZWysXL8dSqWJ/R1Jt3kTMcRoi8+s8Xnm+FOd1YjGWVYLaOcgdPUykIptnsTv45HqyZw8
         AUosu/VBPpV+3OagQnkAKmmXYttvAlHA6eVq1y16V3PyJbKMqSWCUa1CufXrh6uZqanC
         ccGS5YoBx8r/9NF0AIpW6gLbPn5tNS5hzvS+jG2V1XpwOo6eMj3KOFys+iV9GWJTJh+8
         gHWkumozvaRbQMT8b3y9Gc8sFx7vzkCyp1zO84VthbB8uvKPT00lk/vOzcwkxBf0wQ7W
         0BGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r4bT7HeLBcKZhFeUiGhpGlFbEiM6IKHw69zvHFi+0OI=;
        b=iGUYTQEFdhfXEGpSUQhMB5SmcwFvTg6cF5iqLjutAvimbBM5h2uGHZlrpNXXouJzAp
         FJrwWIGmfNrMpsA+K/mxA4vQsTeQqqBlEfGXyGztjg+d4Rl8mahI7iFil2bsg51FKkmQ
         gByvXuBN3SAaF4DT3RvzRcbQtdrffjC9VgAdAEoPWSpYKzLX6djV+BUtNiBJwneqzTY3
         fRV+eJKy2oqhbIw3Jd1n1/l+S+JbqqqNuF6XCjqoni6cnxNPrwkdZPS9fKSu9iM05rBp
         hEJsixBPnKgLETSopqoVn74ZLUy/078BbC2x/qoUgpHX8SO6Vo+po/+yULhuCNo7gt7M
         wDlg==
X-Gm-Message-State: AOAM5337O0o231pouC9lBhMQhF/wRL2oyzPfvLiseUKtsvVFSd+NT/cG
        /u4cafVCaZfPh0NH5wx/BYI=
X-Google-Smtp-Source: ABdhPJxhUi4M6oeb56hQKhC4KGdtinmzDqTAdwG8q8BTHFBHy8Nmr0fLMHKPJSjIi1vEdsEdq11KKw==
X-Received: by 2002:ae9:ed56:: with SMTP id c83mr896641qkg.101.1627495262173;
        Wed, 28 Jul 2021 11:01:02 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:b58:2ae8:d75f:660a])
        by smtp.gmail.com with ESMTPSA id r5sm223341qtm.75.2021.07.28.11.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 11:01:01 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] arm64: dts: rockchip: adjust rk3568 pll clocks
Date:   Wed, 28 Jul 2021 14:00:32 -0400
Message-Id: <20210728180034.717953-7-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728180034.717953-1-pgwipeout@gmail.com>
References: <20210728180034.717953-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk3568 gpll should run at 1200mhz and the ppll should run at 200mhz.
These are set incorrectly by the bootloader, so fix them here.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index c74072941da1..66d1919dd7eb 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -226,6 +226,8 @@ cru: clock-controller@fdd20000 {
 		reg = <0x0 0xfdd20000 0x0 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
+		assigned-clocks = <&cru PLL_GPLL>, <&pmucru PLL_PPLL>;
+		assigned-clock-rates = <1200000000>, <200000000>;
 	};
 
 	i2c0: i2c@fdd40000 {
-- 
2.25.1

