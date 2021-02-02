Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB86C30BBC1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 11:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhBBKGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 05:06:03 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1349 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhBBKFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 05:05:10 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601923ad0001>; Tue, 02 Feb 2021 02:04:29 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Feb
 2021 10:04:28 +0000
Received: from audio.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 2 Feb 2021 10:04:24 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <broonie@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <sharadg@nvidia.com>, Sameer Pujar <spujar@nvidia.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Bard Liao <bardliao@realtek.com>
Subject: [RESEND PATCH v2 5/9] arm64: defconfig: Enable RT5659
Date:   Tue, 2 Feb 2021 15:34:12 +0530
Message-ID: <1612260252-31582-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612260269; bh=+10pkGO9zVFlguUAP9771zBsVeyhsMDB4TAfXfV2vNg=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         Content-Type;
        b=KmOnRzaeJyy7ZGe1qrCePyn+VKNPY8NCKvuSyDGoCL6sZ6UekFVBjEhltfd8ll+rf
         iMyNsj4TxPHCNj9Zc/A7tAX6yM/3YDq2i22UK/KoQ6t2ObYqqpjP/BSaqs6BEN3Jr1
         AtV7585WXJzft+sOwWoB86fX1z6ZLuIU6E1I36wutUMKQZ3AFN8MZ/DbZlSf+7LzMN
         XPKr2R/cRrJzPT/D6S6H58v3oTrdux+ja5aPUme6iSsaKUhyz9pZ/rT7gZb3H0ICyY
         bfcInlo3+RiQquB0UjiEciNqYdWlADByCtq9QKOelhAkuUozQFa3vR2dB1x+C3g/VJ
         e8zbx/rbd8tQQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the RT5659 audio codec driver.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Cc: Oder Chiou <oder_chiou@realtek.com>
Cc: Bard Liao <bardliao@realtek.com>
---
 Resending this as I missed the maintainer and email groups specifically
 required for this patch. The link for original series can be found here,
 https://lore.kernel.org/alsa-devel/1611944866-29373-1-git-send-email-spujar@nvidia.com/ 

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ec377f7..ea279e8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -754,6 +754,7 @@ CONFIG_SND_SOC_ES7134=m
 CONFIG_SND_SOC_ES7241=m
 CONFIG_SND_SOC_GTM601=m
 CONFIG_SND_SOC_PCM3168A_I2C=m
+CONFIG_SND_SOC_RT5659=m
 CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
 CONFIG_SND_SOC_TAS571X=m
 CONFIG_SND_SOC_WCD934X=m
-- 
2.7.4

