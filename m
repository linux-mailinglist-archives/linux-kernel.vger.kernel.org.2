Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6BF3B425A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 13:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhFYLUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 07:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhFYLUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 07:20:16 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA003C061766;
        Fri, 25 Jun 2021 04:17:55 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id i24so12879614edx.4;
        Fri, 25 Jun 2021 04:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dE455QnkJy8nl+5re8Lx5rfD/JYfjqvcjK9bczo6FJE=;
        b=Mw++bRI2fvJIToE3l1vLSDSnUIRZ2OtZ8djFYujC9ikPYvMZJd+v7Wq6zONHxLljX1
         FJyfgjbsgifse+0hxLz8HPEZILcLc9vpSB10z/mb24Y2uUydrbLgXbjbfzLtlRmWwrtq
         n5s9Cu2iEtQk62taei/9dv1pDS9yLYHlNPlKIJWuIaKNqpHEGQNlHKnTX3iO7tVLQe/9
         UVMf78oH9wY32HhNhom8SctA+YxawZEdWaeYCXBTp1zQ4ByFm6s9AZ/Ok71pyItMsWv9
         UxW5aV3mJ+/BlWdAdjEU4KGq8Zc7VKRCG1kZXemBpoDwZeAU7YXOtd/yev+CV/XE3f1O
         MwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dE455QnkJy8nl+5re8Lx5rfD/JYfjqvcjK9bczo6FJE=;
        b=Ibr8L8LoG1QZxP+8FY2laOI6Blq8waOQS3w2H1hFKfleRfujR5615gZInoJWAjfSWh
         ypJcr5j7DzjQk8hBuLwxdBlfI4P0xq6AZgEALujv0HIe05TbbmiYEX8IEI+wZrQBTXXF
         otONFZ1+wXwpfyE6tzrLHlN5vae74wuJo46YNUIcRL/RTwDKQ6/z/oMdHXy+9T6fQ4Cn
         +byK3itJ1O3EEdzeX+ZQbUwQ5FoIsReH0JvnqK7xKGYcPEDpVbNXnt3poyS5gwJCu3HX
         STR0W8u7TSoiUyPzVD8B/D4mFVijx6vM/ID47/J0KSaaSTvyXfMPcPthGqIx3iLMuWlH
         Sk7g==
X-Gm-Message-State: AOAM531sm2ziQ9aLVrlbhbQAb7iD1Ci80TexKe1cx9p/dNBytnXglCac
        uF/rHODeH8+UiE/fNYQ59buArTvcvmglyw==
X-Google-Smtp-Source: ABdhPJwlz352IyDwadTZbyzTcYUZMoyv1rX/vKfhC48/zXJ7M8/CSKhNrRhs3Yuk/OfAlxs5AI+wsQ==
X-Received: by 2002:a05:6402:1d2d:: with SMTP id dh13mr722907edb.282.1624619874547;
        Fri, 25 Jun 2021 04:17:54 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b10sm3731238edx.4.2021.06.25.04.17.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jun 2021 04:17:54 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] ARM: dts: rockchip: add io-domains node to rk3188.dtsi
Date:   Fri, 25 Jun 2021 13:17:45 +0200
Message-Id: <20210625111746.6269-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210625111746.6269-1-jbx6244@gmail.com>
References: <20210625111746.6269-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compatible string below was added to
rockchip-io-domain.txt, but never added to the device tree,
so add a io-domains node to rk3188.dtsi

"rockchip,rk3188-io-voltage-domain"

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3188.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index b36fcdd9a..2721b7285 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -641,6 +641,11 @@
 &grf{
 	compatible = "rockchip,rk3188-grf", "syscon", "simple-mfd";
 
+	io_domains: io-domains {
+		compatible = "rockchip,rk3188-io-voltage-domain";
+		status = "disabled";
+	};
+
 	usbphy: usbphy {
 		compatible = "rockchip,rk3188-usb-phy",
 			     "rockchip,rk3288-usb-phy";
-- 
2.11.0

