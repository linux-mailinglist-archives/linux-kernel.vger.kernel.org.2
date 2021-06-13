Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E962F3A5765
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 11:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhFMJuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 05:50:51 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:41880 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhFMJuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 05:50:50 -0400
Received: by mail-wm1-f41.google.com with SMTP id y13-20020a1c4b0d0000b02901c20173e165so3121112wma.0;
        Sun, 13 Jun 2021 02:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DIgDiWl4iCy2anFFqyIPL2t42uojiajXvda67OAw2z4=;
        b=Ncyfia/HC2eVv63ke+DsqnQTUiyIxFpnZtS8BjNxZa/eVPKo+M9jsKVboJSAnnceQi
         81q7cNC3vnElMzRvyhyW3iPb6Qw8b+R5ZCAzmCKmR3Zaf2tP1z4tf7rCCJkRBGJx7jxH
         bNFKsBzRVrYdO/BnJMQFI3efb52O1XeABb7iPnpwblp5XIfGSKJc4oj+9yVJFOm5FWmh
         XNJ/A7q/PZXuNWl9lKXbrCkLuXKAS5BU25s1eUwSQ+c63FesrT+Lvv3Yr7SS4HLdoP65
         UhDO8GrLQOZtmbZr9WkqloDgjz+XtxcyZRJWJLfIz/N5OsovNrEIZ1Kztp7vcN5dNjmR
         ShCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DIgDiWl4iCy2anFFqyIPL2t42uojiajXvda67OAw2z4=;
        b=RVqsDG8jhn2WjxL4SCnwyfUXcmfztR0F/cT9fWVWAq194pDxbm+2AhFOiaQdwRas00
         gAm31PMx+r9dhmtQZUvWmOlqyUecSmbqajLEJlcoss5zUaU1pdvtyclYtldqJkzNF7Bh
         XLysvIJHwO+CmI8lRC/hbanoeIeQ07d+QHXSnjNR26d1ASJZsKsXgt2Ldw9KNz5ndIzT
         Afvvsrx3LwnVW4xojXlfGPQp5HHzh7rreiDA4lBu32sRbLVeX/TWI8PzKCJKUqACXZ6h
         Y2aDhxWT00Yam1OKlnfj/gwybrvQcj7XV2irumvyDY3cmCTL8Lc2elF2FF7Wv0BqIF24
         DMlA==
X-Gm-Message-State: AOAM530sfYs9spGoZ3SsvEi7/Gn9oMNeGIpX3JHKxtIj5l/jX0kHfeIG
        UWnu8nB0rirQMAeURtVGun11DMeJuEA=
X-Google-Smtp-Source: ABdhPJzBEkHW1i+rmP3wvj5vETRCaGR2D+QVtFk4mX935/+jWKv/SwvT4zBqg5J9JMg+nYa9sv3ueQ==
X-Received: by 2002:a1c:4e03:: with SMTP id g3mr27160166wmh.127.1623577668650;
        Sun, 13 Jun 2021 02:47:48 -0700 (PDT)
Received: from cluster5 ([80.76.206.81])
        by smtp.gmail.com with ESMTPSA id g21sm13558793wrb.46.2021.06.13.02.47.48
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 13 Jun 2021 02:47:48 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivek Unune <npcomplete13@gmail.com>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ARM: dts: NSP: add MDIO bus controller node
Date:   Sun, 13 Jun 2021 10:46:36 +0100
Message-Id: <20210613094639.3242151-3-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210613094639.3242151-1-mnhagan88@gmail.com>
References: <20210613094639.3242151-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the node for the MDIO bus controller, present on the NSP
SoC.

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 043d3bfaf1cc..e91a68996986 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -363,6 +363,13 @@ pwm: pwm@31000 {
 			status = "disabled";
 		};
 
+		mdio: mdio@32000 {
+			compatible = "brcm,iproc-mdio";
+			reg = <0x32000 0x8>;
+			#size-cells = <0>;
+			#address-cells = <1>;
+		};
+
 		rng: rng@33000 {
 			compatible = "brcm,bcm-nsp-rng";
 			reg = <0x33000 0x14>;
-- 
2.26.3

