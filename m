Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A582C3A85FE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhFOQFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbhFOQFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:05:49 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4175C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:03:44 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id g20so23546626ejt.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cblQaQD9GLeQUKwguE3hqeKvKR/G3+npZxaf7K86zsc=;
        b=F1qxfUNQVo/d5s0kDPwaEqgpydOjFgYWWGg3uf+BPng5XE73LbJ/1WeuGpsIO3wic/
         G6jCeVKbEroSjzopPCU9gqY7+NCjvCm9OxtvNFF2giHhFonK2PJVKRk+lnrETBGOF/dA
         xa+8q6z0Yq9Yjuz5zmhMxeAQi148i52nWF90XIMTiKwRfLNq1BwOex5s3CCxNDpAGkfZ
         pU1QF2FjM4xveVyr4xvnAvsE6ZoEUnvhoTJmxH33CWRTNyg5ZSctBvVb9qlVD40+Aq9X
         SEnDE1/TD6GNDTIe/7g7Uv1bEBvk4LvN3+sOCBCVpGiOVy1oWRlscfUh53XibEzJkFhP
         4oAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cblQaQD9GLeQUKwguE3hqeKvKR/G3+npZxaf7K86zsc=;
        b=GthDzmIwRf3sSG7fzczSX/WFAXAadoM7FdhM5dpKq5tMpuRu1zWtWuxqgMF19iLBQQ
         wcCrrngLALUh8U4OJ6NbjLSCYDIydj/J6gcV7SQcnQZ/aymjNZ67fSQcn3N6f4YYBNQS
         4WbYcwrRXK0paasJ8JdgSp+PfELKx3+wH5qfwJuva6PqcCbN34xc74RCQmNaDTtxxY3i
         lV1aarGSOuGPf5g00YzHtm47e8HVUSQWYpGqL7Ft68Qu3aatrEcrG9C9YmDEGXiOVRCp
         ldldL3GgY0s1oM6Go3GG0xQesy7tH6/aNyHKiC9YLbIucq+a7HmJWVdeCgDuuYRnekvx
         Y1xA==
X-Gm-Message-State: AOAM531L+KO1mf4fNFXyhaSqIcJict7i1L0DuiCHYHLOS5+N08UEf42y
        8yWYumwNemrYbdEe0yvz5I0=
X-Google-Smtp-Source: ABdhPJy/A/XveTNpCjqdBHem05REymrPqPVfB5BXgWac+2ysgQTpOle2sfajq13uW4mx2yPM83cBqg==
X-Received: by 2002:a17:906:a850:: with SMTP id dx16mr229670ejb.333.1623773023292;
        Tue, 15 Jun 2021 09:03:43 -0700 (PDT)
Received: from yoga-910.localhost ([188.26.224.68])
        by smtp.gmail.com with ESMTPSA id b1sm1640061ejz.54.2021.06.15.09.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 09:03:43 -0700 (PDT)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 2/3] arm64: dts: ls2088ardb: update PHY nodes with IRQ information
Date:   Tue, 15 Jun 2021 19:03:36 +0300
Message-Id: <20210615160337.1320644-3-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615160337.1320644-1-ciorneiioana@gmail.com>
References: <20210615160337.1320644-1-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Update the DTS nodes corresponding to the 4 10GBASE-R PHYs to describe
their IRQ lines.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
index 60563917be44..3e4e857db13f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
@@ -92,21 +92,25 @@ &emdio2 {
 
 	mdio2_phy1: ethernet-phy@0 {
 		compatible = "ethernet-phy-id03a1.b4b0", "ethernet-phy-ieee802.3-c45";
+		interrupts-extended = <&extirq 1 IRQ_TYPE_LEVEL_LOW>;
 		reg = <0x0>;
 	};
 
 	mdio2_phy2: ethernet-phy@1 {
 		compatible = "ethernet-phy-id03a1.b4b0", "ethernet-phy-ieee802.3-c45";
+		interrupts-extended = <&extirq 2 IRQ_TYPE_LEVEL_LOW>;
 		reg = <0x1>;
 	};
 
 	mdio2_phy3: ethernet-phy@2 {
 		compatible = "ethernet-phy-id03a1.b4b0", "ethernet-phy-ieee802.3-c45";
+		interrupts-extended = <&extirq 4 IRQ_TYPE_LEVEL_LOW>;
 		reg = <0x2>;
 	};
 
 	mdio2_phy4: ethernet-phy@3 {
 		compatible = "ethernet-phy-id03a1.b4b0", "ethernet-phy-ieee802.3-c45";
+		interrupts-extended = <&extirq 5 IRQ_TYPE_LEVEL_LOW>;
 		reg = <0x3>;
 	};
 };
-- 
2.31.1

