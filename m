Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB96036F1D1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 23:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbhD2VRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 17:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237352AbhD2VRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 17:17:37 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4818C06138B;
        Thu, 29 Apr 2021 14:16:48 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id c18so55013528iln.7;
        Thu, 29 Apr 2021 14:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vTK3mS4c8midbEPil3hRb/cf5O5Pz60GCjhUinVTKwQ=;
        b=c3Q3gxKti2doNidSQpOmnHW1AUzSAXcBtiQoHbM6MBIw7fVrygPICGD/8WC2S0KLtW
         28NZbFHZ4cRXC0g3IL1+3OIPnSc4V67vDjcfvumkSax+7tRVPEz7DSTDcyRIt+GW8PGY
         AO+GId61ZtWFO4/BlXamDeX39RTN+Yn5bhPZSRM7OuFInxPYm2zl8smklzmi2Jaqyhu+
         QV5P9pOcFf3vRkwDpWwZuYjabNq+0WJX+yhDAthQOgAWI8x/EEERS8a253Frct+sEbpz
         8abZMa3aT4vaHZjp5CioKmZ+altmUTxas4wZfYtHtIlkrRho6pthS2wCwc7n0foDvTfF
         OiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vTK3mS4c8midbEPil3hRb/cf5O5Pz60GCjhUinVTKwQ=;
        b=gNeLxjB6CAf8iycBtG3L1Jjjx+KmBi48y723Kr+JwnHlsKiULZgT+IZWuwIp+lg+/U
         FgMla0dtk+ewIMaEgZW5F+8tgjdetWALvrPai3E2AALn0I0Z+JVclWD1DDMzngDqP0p5
         ynSAgp5OXXVc78dkzOZLbTsfRGIGWzR3gl+/2D38t2s9rFUdiq5pLzvKxol9itc6RfoK
         zI16MEnh8rWgrXkwZw794qMHZFla29YpQ1+aukNIBa+pN5zo/DqPkeX8a2aOKeYFsi7r
         vpACHm8+9XQ9K1jQtCP3zszoCPtB/8rCQhAGOC/N6ZDEJAqaDmiDJecnHc+74U0R7C8Z
         XUyQ==
X-Gm-Message-State: AOAM533FIQwAfqiOrFDEyt+a+tdRtaqGTMPtaM57TbHUM2Xw4dhY2/gR
        re4JZGbLEtcjfT+9Y2cCqNg=
X-Google-Smtp-Source: ABdhPJx2AZEYz94gbie7+hSs9P3oH1b/Hu2t/eXSV8750JBqXy8MpdLV8tFszyERP3pseT6Kg4j4YQ==
X-Received: by 2002:a92:1a0a:: with SMTP id a10mr1400984ila.195.1619731008220;
        Thu, 29 Apr 2021 14:16:48 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:8a74:d2ad:27b:e619])
        by smtp.gmail.com with ESMTPSA id q11sm1808076ile.56.2021.04.29.14.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 14:16:47 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     peng.fan@oss.nxp.com, marex@denx.de, frieder.schrempf@kontron.de,
        tharvey@gateworks.com, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/5] arm64: dts: imx8mn: Add power-domain reference in USB controller
Date:   Thu, 29 Apr 2021 16:16:23 -0500
Message-Id: <20210429211625.1835702-5-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210429211625.1835702-1-aford173@gmail.com>
References: <20210429211625.1835702-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB OTG controller cannot be used until the power-domain is enabled
unless it was started in the bootloader.

Adding the power-domain reference to the OTG node allows the OTG
controller to operate.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V3:  Rebase on series starting https://lkml.org/lkml/2021/4/29/72
V2:  No change

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 609294329c7b..a2ca25aa8eb6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1000,6 +1000,7 @@ usbotg1: usb@32e40000 {
 				assigned-clock-parents = <&clk IMX8MN_SYS_PLL2_500M>;
 				fsl,usbphy = <&usbphynop1>;
 				fsl,usbmisc = <&usbmisc1 0>;
+				power-domains = <&pgc_otg1>;
 				status = "disabled";
 			};
 
-- 
2.25.1

