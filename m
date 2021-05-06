Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD463752E0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 13:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbhEFLQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 07:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbhEFLQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 07:16:35 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E762C061761;
        Thu,  6 May 2021 04:15:36 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l24-20020a7bc4580000b029014ac3b80020so5118427wmi.1;
        Thu, 06 May 2021 04:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yB+63PgRDM1iyviDORNDC1cNZU2QIzi0OniCvWqYcas=;
        b=r5MNcwCk/unl+3evjl1ScAq7BM1g7s0th1VDYBoe31faBujaA8UxZV/AxfibTG4gdg
         2CVeoKS2qXJun3cABqZGXijgW3sp/MQbDojoMTOb578htTrFotqlGRUdm9LyvRnVOrgU
         PJJD7mre6+zIyjlLZj5TLbGfZL0mYCHSDrO8yPS3tumjtsUx3Ydf1noHAYFuTS1YKT0m
         /oS1eUXTCekbWsKcw/6MHZeNB04mHSc0HxI1njeK3md3VN6LZMNPnK94HPEDGv+zeD4Z
         nBID16zPinnRGBpsxUPBxUt7xeo+K9oajkJjjdSdH3tot4/a/KffYdjcAnCf55IyNvkK
         /uVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yB+63PgRDM1iyviDORNDC1cNZU2QIzi0OniCvWqYcas=;
        b=NhGNeDBJJHeVDBAJy5Pa1jd//OFtyxlNIk9YquaQbLixAjLcGkzVcRtQ+rL7edMYWi
         73t1QWRCdB0Dt+MWSNaLpBAUWPJgDjzYudtavNk7bu0yeqnGlN3d7VXXwXWL94SohcrB
         vFEGz89Rfi6IVdNbpLcYLZiB8Q8RG1BpPUAZv0tehEq8/2R43U0v1TAkK9jXaT+IvAg7
         yzjm5eHLcKDuXu7HwcMjTNxYh1wIeB1No3FSoN6B/61kO9Sgy/j+vSQx4JYZkJ3a41NO
         HcePNEps60S33JrJXYeuccVDSzwgyI8bH2949DUS+BsYOm0CdLTd7hVucZe/0of+sAxQ
         dUZg==
X-Gm-Message-State: AOAM532O23nsalm8RDw3JwYLyHOscKfaN3wpTFiaZA8x1mqrMhura1ee
        GJIWoE43m/1OqUWXuKNDatY=
X-Google-Smtp-Source: ABdhPJwQfzxRYHpKnPIQCx/PqOoEanXnfY+4NyrQ2w7d5BnNcUH2wVkxSbnS4mrZ1TPCAsEetdFZYg==
X-Received: by 2002:a7b:cc83:: with SMTP id p3mr3374846wma.170.1620299735254;
        Thu, 06 May 2021 04:15:35 -0700 (PDT)
Received: from localhost.localdomain (231.red-83-51-243.dynamicip.rima-tde.net. [83.51.243.231])
        by smtp.gmail.com with ESMTPSA id u5sm3642433wrt.38.2021.05.06.04.15.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 May 2021 04:15:34 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     vkoul@kernel.org
Cc:     linux-phy@lists.infradead.org, kishon@ti.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        neil@brown.name, ilya.lipnitskiy@gmail.com
Subject: [PATCH 1/5] staging: mt7621-dts: use clock in pci phy nodes
Date:   Thu,  6 May 2021 13:15:27 +0200
Message-Id: <20210506111531.21978-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210506111531.21978-1-sergio.paracuellos@gmail.com>
References: <20210506111531.21978-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT7621 SoC clock driver has already mainlined in
'commit 48df7a26f470 ("clk: ralink: add clock driver for mt7621 SoC")'
Hence we can use the clock in pcie phy nodes to
be able to get it from there in driver code.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/staging/mt7621-dts/mt7621.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/mt7621-dts/mt7621.dtsi b/drivers/staging/mt7621-dts/mt7621.dtsi
index 5623d542bcf2..001ff8f51033 100644
--- a/drivers/staging/mt7621-dts/mt7621.dtsi
+++ b/drivers/staging/mt7621-dts/mt7621.dtsi
@@ -549,12 +549,16 @@ pcie@2,0 {
 	pcie0_phy: pcie-phy@1e149000 {
 		compatible = "mediatek,mt7621-pci-phy";
 		reg = <0x1e149000 0x0700>;
+		clocks = <&sysc MT7621_CLK_XTAL>;
+		clock-names = "sys_clk";
 		#phy-cells = <1>;
 	};
 
 	pcie2_phy: pcie-phy@1e14a000 {
 		compatible = "mediatek,mt7621-pci-phy";
 		reg = <0x1e14a000 0x0700>;
+		clocks = <&sysc MT7621_CLK_XTAL>;
+		clock-names = "sys_clk";
 		#phy-cells = <1>;
 	};
 };
-- 
2.25.1

