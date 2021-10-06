Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7714234C8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 02:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbhJFAHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 20:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237068AbhJFAHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 20:07:19 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FC4C061766;
        Tue,  5 Oct 2021 17:05:27 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id d18so844134iof.13;
        Tue, 05 Oct 2021 17:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cwzb1uhRt9EdpwYAtAW3BzrEcgUPOYqIAqZ9uGq69hs=;
        b=KPEaQ2iPcxHlYfymydS0Taq0RMMu0KBkH6MLWiG3ZW/pWY64/vceJrmnHmj+qjJV+p
         l0Qi4GKI/Q3pb7b7IIb0VJw89UyaxVkSia+psuqYOxw2l5MPPzpj5IDUPGuOcnKQB3Aj
         7jliAhEPCV03gNMBg/3iMJjaMFsYGVKKEzdkwNHuQeLlF9WXEo9fC8TWJqTtmTQIIimi
         KVcmu0+4mCid3gJ8PSeeaB4Bpkz4zoyz6+LLvKCItZLCDN9yivN827Z+dogxL4lsIa6P
         x7VDpkx6Q4Sz+RealV2UsCLQC5w3VOlmkhNHAiovp+D/2nHe2Dz7FRYdigeOLjffpr1z
         3Q1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cwzb1uhRt9EdpwYAtAW3BzrEcgUPOYqIAqZ9uGq69hs=;
        b=h1+ZZSSMlCxGDa/XDi6IslU0ncJFMU7qe8SiKqknYMAdbCaLeQ3YBlqPPBJi7O/4zv
         xE3M6gjyZz3Zb2DSA1Lk7+NW3YfZYRmb17CYZhW2RWhEHE1k5MDQyqtESgZ2/uHyAV6p
         XM3EUX+bg9RWepMqDQ2DEbMD/zP9mKnV37I5ieZgC0DaqBYIEHaCdbyre3dD38YF9PIf
         G63OHYZJzAvLUo5M6qlEhQ0LIUACHNsSS9wBRNmwQocmTDDyp1dUSOqv7xGDoT+dCKSl
         2vwJSPUlcL75chIRNaNcCCtbC9/yco37wPEH+fEeTjksLOOVzWbRH9+9+FP5HebCkUOn
         n58A==
X-Gm-Message-State: AOAM531sWc2nxabARHb2SXcwVTkxUZkzkM8Rys0NvMRUsTmMPLirbuwR
        u8QKExG2gzfxBc5uMKzhd2k=
X-Google-Smtp-Source: ABdhPJx1bWyVtD6+ZxQakcc2/dX/VUy+rU1XfVhIZh4K1kMCIy47mZc4gZwCWDZycUWdwsaQdz9P0Q==
X-Received: by 2002:a5d:8715:: with SMTP id u21mr4420256iom.1.1633478726237;
        Tue, 05 Oct 2021 17:05:26 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:94fc:9a4b:2e18:e915])
        by smtp.gmail.com with ESMTPSA id y2sm11338646ioj.12.2021.10.05.17.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 17:05:25 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] arm64: dts: imx8mn: put USB controller into power-domains
Date:   Tue,  5 Oct 2021 19:05:02 -0500
Message-Id: <20211006000505.627334-5-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211006000505.627334-1-aford173@gmail.com>
References: <20211006000505.627334-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have support for the power domain controller on the i.MX8MN,
we can put the USB controller in the respective power domain to allow
it to power down the PHY when possible.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 4191b5bfcdf3..ea994dd9fb03 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1021,6 +1021,7 @@ usbotg1: usb@32e40000 {
 				assigned-clock-parents = <&clk IMX8MN_SYS_PLL2_500M>;
 				phys = <&usbphynop1>;
 				fsl,usbmisc = <&usbmisc1 0>;
+				power-domains = <&pgc_otg1>;
 				status = "disabled";
 			};
 
-- 
2.25.1

