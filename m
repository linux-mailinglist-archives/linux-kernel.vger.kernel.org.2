Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE2D3A6A53
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbhFNPal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:30:41 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:38881 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbhFNP3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:29:22 -0400
Received: by mail-ej1-f48.google.com with SMTP id og14so17363804ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pllXmoBfaR6v88nI2EZLyWocXDe+jNv0XQ5J5eU4TTM=;
        b=tNhCiBjft4gAGezGOEY01305uPLFvbGlntQ75S9hcVMivlTh1CsHgj1Ts/Pdqtyxxm
         g4L73E/3ZYsp+h3f6oFMn82D+yzuM2SMuE1NlmWIB45oH1/vS59o1s6llrm4PNVC5Fu+
         FZ6csi0dtbkjyVCaKSM8r7frt5X9Qor3xdpsmGVwf2l0FtTYVaIBCSzBgpCqJnHXPwHj
         PJtC+oNLAt0BzSxqGxer3v/VOFT2ctJwBoLwRC/3bVr9ZuVlem7tnXr0yAJ5tq9sIgZE
         UkagtiakPqVCjKzUUJsrN+Q8M1q7XpHnuJostqmbrOCVc427k0jAGt/w0Enddmihh24h
         Y55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pllXmoBfaR6v88nI2EZLyWocXDe+jNv0XQ5J5eU4TTM=;
        b=p67PKzRbSeGWN1Pgz1kiKfYgMIhaKaRiSHiazzOQzE3igQKB9iVlcrAYPS99LL4GTX
         In0/DXntkPbtmKM3Fd+u/0FpYcnI0m90juV0KAfKrNQgdSFJ+bziVR6c3PHGPHtJ0ydv
         AYUgEP+eAYC0Xc/+LYwpJ1Y/LlEaAO5cPbPJESBaRrdt3vp+27gSsH6BGGSSA0Mr9YhA
         UwdTPxv1zusxAIlL5coMQy0wPwXn1KU7SMRbnbKwcSMKP8huo9IMQ15WsHydehO23WCB
         ZZym0NxIxx2t2opv26bn2yTe2vj6cHnMgj+1GjVJoLLzZTafxRoL8WS8+Wf8g2vxJ0Y3
         GEbg==
X-Gm-Message-State: AOAM530AaDvZvSkDXbmUA8LVbqS477Kxby3KCHoiuK2AVZpM8RE+t2M5
        x8er5wXVGXu7a/HWaBHdTGn/8Q6YgLl1abLB
X-Google-Smtp-Source: ABdhPJyN519iEKLtVvVKu7t8tCtnyNqBAJriCu+SZizb3tk+MUM0VrkFIdsD9TGxuNAku0sClJkqoA==
X-Received: by 2002:a17:906:39d7:: with SMTP id i23mr15653970eje.121.1623684378748;
        Mon, 14 Jun 2021 08:26:18 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id x13sm7773746ejj.21.2021.06.14.08.26.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jun 2021 08:26:18 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 24/33] arm64: zynqmp: Remove information about dma clock on zcu106
Date:   Mon, 14 Jun 2021 17:25:32 +0200
Message-Id: <17973ffda4e163a4b89d4732fe6fc7e089962ae7.1623684253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623684253.git.michal.simek@xilinx.com>
References: <cover.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock setting is not static anymore that's why it depends on firmware setup
that's why remove this comment.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 2c1c4d96fb21..464a76a13c24 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -160,7 +160,6 @@ &dcc {
 	status = "okay";
 };
 
-/* fpd_dma clk 667MHz, lpd_dma 500MHz */
 &fpd_dma_chan1 {
 	status = "okay";
 };
-- 
2.32.0

