Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6483A1329
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbhFILro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbhFILrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:47:43 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B799C061760
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 04:45:48 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso3047890wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=958Czn2DLB+o/NZtXonc7bnisFWGNfDVO9VxvQ+P81g=;
        b=JPp+4hs+e1lRRVOlXTYSKUNgES7Yspkb4tBX4RSwbXg5kWE2KIkq3HGXzAR6gCVQ0s
         Ww3Vx3zwXajcMMpM1odY5aa27oIs0Wv3RBM3boxOh+zKOGS3Tv7BPH9IrPZMUHSlzsL0
         ousS0VsdfKsg9DCX9SO9EweV85gTIBSybH1CZq/z2LU77FGkhYHBFP0qK9qCzjwtEyIK
         BCo2DJuM4PwWKgBxs3auHmYcW3miz21ac1RTIuwqrU/r4s06+cSOmtDRIxp1nX7VBukY
         TOz+x5yRq9e0SBzcogdny1zahZ9j/1cvCBV1bxUU5hQyMjMdfCMZy340Rb1fFY08tunN
         vwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=958Czn2DLB+o/NZtXonc7bnisFWGNfDVO9VxvQ+P81g=;
        b=gyxwACOt7uKCnQPmZy49r1DA29jM1FNe3qq8KSarHiuAYSgVBD7zONFG1cBtNjX6p8
         y0VcCdYUeBH7qpLtNG5I+/Y6rlVEs2nMT1c+RYqwh2Sgrsu+tmXUzbzUfqNvaKZqECFw
         ahMPUi5XIj3oAfqp9MBgJWh10R4GiKNYCfmIG9ivJl0VyBmPghIpusmfYHetJrYSs47E
         NMTXMgcfEfhbimtRJOBoB3IOuecwkbw1GURhxlExh0dkIldN5Scn8cOzBxCJRBVB6Lhl
         /bzQLcxBct0jX9e4mFcx5guEaMxh+mPkQ8h6oJLYtdNm7fEzT/Kd2R7M5XuanYQxR8Su
         Nomg==
X-Gm-Message-State: AOAM5332jG0NARTtDQFrAnAKrZkGutL/2mvE74Y9L7OeGN5NbkiG8/CQ
        BCryqBPl8MW6oQwzaDiTu/ZUab9L3A4NcHTO
X-Google-Smtp-Source: ABdhPJxWWYa3eVsbzmR8sPamyReW3RB7KhmZEZSUIEmZ+yyq4NYQyOeC4FZSkJ5ONT0Z5UCxzr4UVg==
X-Received: by 2002:a05:600c:4f4e:: with SMTP id m14mr9333276wmq.157.1623239146885;
        Wed, 09 Jun 2021 04:45:46 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id j7sm21467822wrm.93.2021.06.09.04.45.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jun 2021 04:45:46 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 15/31] arm64: zynqmp: Remove additional newline
Date:   Wed,  9 Jun 2021 13:44:51 +0200
Message-Id: <16f6f41c8d748d3c7cd4f49b2839e63a5b41c944.1623239033.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623239033.git.michal.simek@xilinx.com>
References: <cover.1623239033.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is sync between Linux and U-Boot. Trivial change.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 719a9e5e1b01..1a45e4946dd4 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -463,7 +463,6 @@ max15303@20 { /* u8 */
 				status = "disabled"; /* unreachable */
 				reg = <0x20>;
 			};
-
 			max20751@72 { /* u95 */
 				compatible = "maxim,max20751";
 				reg = <0x72>;
-- 
2.31.1

