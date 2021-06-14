Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FD93A6A57
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhFNPbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:31:05 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:35743 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbhFNP3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:29:43 -0400
Received: by mail-ej1-f42.google.com with SMTP id h24so17362917ejy.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7oJwRO3J9jsXmvuasxwt6m5nmE8ox262htAbis2LIe0=;
        b=g8e9UPd5m++/bsKtpjy0SKK56O/EIJ0TNYtPt4RDDmAotHcvci+d+fn+1zDFhUxKqi
         5XgjWhEE5FCbGUSwuQQ+s8mRFmAo220zwYXKqniHbjLbHMzzMPSI6IZcJNuwwdGkCFeB
         mn95RIElMkFSIDeBNopyXB3kaZmrZZUBUewiZrq3KNNhp/eOE3XryqaTqSJ26jFpD4Tl
         /9pM0Dm00i3mSqHqGo8L4OW1yCSWmE86s00uuAcBbLgcg+5W2mfJWB6t0brEGPLwHpJq
         wz7oZcXt1wHIqSfjYhDieSMJbP9lOQU9ZLKfvBrNwK6SbOlIWRzugfi6pg+eUnR7EcZn
         +42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7oJwRO3J9jsXmvuasxwt6m5nmE8ox262htAbis2LIe0=;
        b=OKMfRCdHwFdhHn5lfL+w3b4NU8Y158VXl17mQIvNr6b+21pMs/qjBJIDaGRxmN+VMq
         83x6IETwuB5aQYkPv0cfyCRCkzrVBdb1ikBtTuunJwu3skwv71CBl1O5AM0AbGBA1Df3
         9MRvNQk3QI1piBRvKS5iW2J2b/XidJySbMd20JkWwRoB9sRBnVLOlEBjaxIdx8wKHjwN
         hq7ppB89Sflz23nv3Pomi9rcCTCSoDsWV6FpIVm9yJHTAGTM+YxilkD5XU/KftcyeM7E
         zlAwyM/RINMSjAwnln8WqSMXkLqx2grv27UyMct9pdUtO+pdEVhe8uhLBHDbmomel8yh
         AyYA==
X-Gm-Message-State: AOAM532Y8kvBMIojiJ98/U4N8nYpKbaJl2TWHxi2SUhbYpk2O9/ozYX9
        lKjh9W9A1ANAakUoB3BNeBtVAAP9xilBuFBa
X-Google-Smtp-Source: ABdhPJyPEaoqCbnrYu5oTZQNlG7qQAfkayDwR9/gkwveb93tMT+o5W+4MrRTvYbSCosMwkE2jwsNXA==
X-Received: by 2002:a17:906:7946:: with SMTP id l6mr4788556ejo.50.1623684389997;
        Mon, 14 Jun 2021 08:26:29 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id w8sm1380828edc.39.2021.06.14.08.26.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jun 2021 08:26:29 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 32/33] arm64: zynqmp: Add psgtr description to zc1751 dc1 board
Date:   Mon, 14 Jun 2021 17:25:40 +0200
Message-Id: <51d9a5e0aa26b0ea79b8823bf3d15f4e2542f927.1623684253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623684253.git.michal.simek@xilinx.com>
References: <cover.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire psgtr for zc1751 dc1 board.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- New patch in the series

 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
index c1cedc92e017..c488c6812084 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
@@ -422,4 +422,7 @@ &zynqmp_dpdma {
 
 &zynqmp_dpsub {
 	status = "okay";
+	phy-names = "dp-phy0", "dp-phy1";
+	phys = <&psgtr 1 PHY_TYPE_DP 0 0>,
+	       <&psgtr 0 PHY_TYPE_DP 1 1>;
 };
-- 
2.32.0

