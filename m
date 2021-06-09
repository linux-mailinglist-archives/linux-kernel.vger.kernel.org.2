Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7ADF3A1354
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239480AbhFILty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:49:54 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:43669 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239539AbhFILsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:48:53 -0400
Received: by mail-wm1-f41.google.com with SMTP id 3-20020a05600c0243b029019f2f9b2b8aso3998306wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IyfmD8DZDuvMGX8TMgLHBLVuXjpa67aulA9PCio4mUQ=;
        b=GQUZrQk2siL3MYsb3zbntAIwvSNm4XXGm3WUDGOuR8XR1JrQSF7+W2WYm7wMNj3b4N
         w0t4vk8jdCKVZHfwqvallHEnhNW3PmVUVsGK/XnqOOr2xZP5/xpaaGQEg8hKQnP//hx/
         YAi2GU2LKtQVmJ42fRZ8IuxljKlOKreT4yL2iyFmYfXunWats9CIAZnbkDrBrSIa879W
         vKH2g+pxd7Tyawqnuf37P+rnbv8kdzRLAhzbWmYnz9J2wnHB7hgVv5EWGlCeRcpw+X1R
         2gTsab24LQrPhTXE+GvKFlY+BR7za7EaJyq3oVa/UYdbKft7xZjgyJdfSiYVnW4IHkEl
         GshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=IyfmD8DZDuvMGX8TMgLHBLVuXjpa67aulA9PCio4mUQ=;
        b=UIzIBD08PJPixMdwnwoedkOrzhNSs4eJi0ehtvp+f+kNgsdVutb+JrG0zpICB0D1oU
         9l9rJU5k/0cH3XuaPizVHirF1U0naewGF89VV5xTVkPDY2erBYaGgRGHsBZjtLubeYvr
         AgnMNWT2eJWY7FQlRxd/sYhvJxmEPlJ+qX7+mdrcYwdm7VcUJo6j1MIh4AScrSnknXaX
         cEgJc9zm9k1XMwNrDYPkXTUOtuPqeAfvYd4M38sxd1oQVEkWb1kWi1bpn/GPQTjV9eHJ
         tjgtxUzj4Xnn/H9onMFP3UrfGgS8S1DDfZfcONtTtyHibmGAQj1/nm1zZhooe4fExdQw
         W6dw==
X-Gm-Message-State: AOAM532WPj5TcZWQjtZukqMr1TEm7Qx2MVpNnjl6xHP+VO8fwwMQRrrg
        3/Q8JTE7x0pixWJxijDg3z27qDa1czpTWdzj
X-Google-Smtp-Source: ABdhPJzYQshAC9lzL2og3uBVwNPXkYkx8vduU1+Nsvitalj3WqDePCR14cefVuls41RnV+uEnUInOw==
X-Received: by 2002:a1c:a382:: with SMTP id m124mr26635972wme.40.1623239138380;
        Wed, 09 Jun 2021 04:45:38 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id z5sm15172660wrv.67.2021.06.09.04.45.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jun 2021 04:45:38 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/31] arm64: zynqmp: Disable WP on zcu111
Date:   Wed,  9 Jun 2021 13:44:46 +0200
Message-Id: <88e41d4f5c6a7353762bd5ad38b92ce352c3a123.1623239033.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623239033.git.michal.simek@xilinx.com>
References: <cover.1623239033.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On this board there is SD slot without WP connected.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index 0bf29ff9c714..e646246a3b14 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -796,6 +796,7 @@ &sdhci1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdhci1_default>;
 	no-1-8-v;
+	disable-wp;
 	xlnx,mio-bank = <1>;
 };
 
-- 
2.31.1

