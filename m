Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209DD3C3513
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 17:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhGJPOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 11:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhGJPN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 11:13:56 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66789C0613DD;
        Sat, 10 Jul 2021 08:11:11 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id e14so12833681qkl.9;
        Sat, 10 Jul 2021 08:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8D7EIFwB7o5lBsBYzgDc20GRiSV4PVIHl0mW81aH3ao=;
        b=Qgby/js7lMkIIxjOk24LsdAV2ArrCT61nLBrSuyfcCNWvJL6Fc0lJLlSOB58ax2577
         aJl5zqFNzY10xNi3ONe6xnLFx08HGCNPCsSjGGIiDSkc6AdfEXX+qNWtucI2dkjaZrSm
         9oIU/MgFrRAlqrrJV1epMRLp9Gn7SBeTYQFkeYUbxfAvo4mbAZJjgwlV+Wfg8HNkkCxj
         TDOCIb4P1S2uURolNXsOWullmyvnjTZM0o9V85bOvPaBc6+jWwkSUXvHv01HWruGKD0s
         3Y3sDgskaiUlCmWhqB0NiXEmdPlW38EXnqlAAWX8otpJEdjRMsRcfbboQdoryqdJGRas
         GTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8D7EIFwB7o5lBsBYzgDc20GRiSV4PVIHl0mW81aH3ao=;
        b=pACMATmyl6h3mLzpQJjL/jncbYIJYlZxqxU4OkvhF0YeJOTkscIpoGi2b9XAr0bE3S
         344YLqRMTy3vWkdAtnTRcvws2O84FCbQyS6vvIIJi1kXqDZGmS9DmOhlRjDvnn25ajr7
         lEc7Mjt85RplovoiPc9Ci4vqSL7RHQNjAdQvK/s7Y5B59zSwC2QI+VCQQNtwALhKhm+Z
         ZSXnsWNCT/YlvEReVanFzsdqR0jenVMLPpSnf23xW8LPrGOCTxt5bgn/0d/f3SzEV8Ax
         OOPAFic4J6Vj/S0ii/UUdVmlJpfL+kPCG0KKB79hDhrpNJ30+pnhv7uvgxy5IMsIz0U6
         dJBQ==
X-Gm-Message-State: AOAM530k2ocufPEkAVsUvG7R4nDvNvNDnTm9fu5wH2Fkt8NoGzqXQvrH
        FBsZkJWo7iQnDlBRrnR2Lsg=
X-Google-Smtp-Source: ABdhPJzPNBZ5G4E3G40bv2Oo0EU79tFdSEEjxZIaE094wpCe3XBZZq/kORo/IXOKPYmBmp5Je218ZQ==
X-Received: by 2002:a37:b2c3:: with SMTP id b186mr620714qkf.172.1625929870518;
        Sat, 10 Jul 2021 08:11:10 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:ecc6:5233:6153:7b36])
        by smtp.gmail.com with ESMTPSA id w14sm3445482qtc.55.2021.07.10.08.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 08:11:10 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: [RFC PATCH 1/4] arm64: dts: rockchip: move rk3568 dtsi to rk356x dtsi
Date:   Sat, 10 Jul 2021 11:10:31 -0400
Message-Id: <20210710151034.32857-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210710151034.32857-1-pgwipeout@gmail.com>
References: <20210710151034.32857-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for separating the rk3568 and rk3566 device trees, move
the base rk3568 dtsi to rk356x dtsi.
This will allow us to strip out the rk3568 specific nodes.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 arch/arm64/boot/dts/rockchip/{rk3568.dtsi => rk356x.dtsi} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename arch/arm64/boot/dts/rockchip/{rk3568.dtsi => rk356x.dtsi} (100%)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
similarity index 100%
rename from arch/arm64/boot/dts/rockchip/rk3568.dtsi
rename to arch/arm64/boot/dts/rockchip/rk356x.dtsi
-- 
2.25.1

