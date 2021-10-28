Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FF143E67C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 18:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhJ1Qt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 12:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhJ1Qt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 12:49:26 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F478C061570;
        Thu, 28 Oct 2021 09:46:59 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s136so6966183pgs.4;
        Thu, 28 Oct 2021 09:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ffa161gA4EvJtmVnOlg8DPccovJS7ZtlelqcF1oheOw=;
        b=SsZQl8IrnhYXP6BCnP7VD+eqgxUGrpp5sGi77QQmDCB6L3Gwu9iLhF+QAoWacqqkdS
         gW4VIDLUlwdo43Wd56pfDAqmbuBrTiUQXKh7PgxNWLNGnledhVlFXKWqn4+dcII20Ct+
         wSWZDEwo92AtGzkeHgg9YjTGRXV/Eepaa+1GfNaZRR1dyAOjW0/gw+CexWhmBWzQF5oA
         mVa9jxglddKelInmTW8zcNFZyFfwnpXW7Iv6Khs57olFgYydhFmzFfeHOx9gTKhmMLH8
         t8qR27fVyrWMBnYWSIrZAQPBJenvp7LitydGIabLG4DrOzgJzPRQMnbhtnvPRjFCVnwM
         VZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ffa161gA4EvJtmVnOlg8DPccovJS7ZtlelqcF1oheOw=;
        b=WLZvL++ILpRKn1piO/voF/r51YZzzXpPhQ3/3zX2Ltd306l40ujIBydrxZHOAO0+u1
         F4oKnxAOyKIyfT5252qWF9B202e99oqZ8Z7SIEN41qqi31wzvtCuvSGk1rd0qFZpc+mK
         GyZetTIhok6rdWmroyNVY1S+i+SjPiiBUMztUwU1Un/BfHP63J9dfGZ6De1q9oAfuUaw
         IpSEau2Ic9ZQa/BTcKhgOdElwelInUn/Kpo0OXimo7Bk0Kwg6JdxSvs0u1WmmbC4Uzy7
         SIp6bmSxLpDvyhmSq7rjsdJXx/Co85Q8+LlZrVruXumQHRG2qD2u4FUPAag59ZQjpnjn
         Pkmg==
X-Gm-Message-State: AOAM530IHTOqC1Cs7W6EkdfQbTHVIVfVaexDX8LzBMxwfYboIKBKQC7o
        6oVCtJrg0i78XrPmS82toOU=
X-Google-Smtp-Source: ABdhPJx1yi+cEBvD5yaZMWOBTR6AJr4PNm7Igp8eovJQzKBFFnqbtfoRSNg0G8Ip7uYr1Bk6uIM4ww==
X-Received: by 2002:aa7:96d0:0:b0:47c:efd:9ab4 with SMTP id h16-20020aa796d0000000b0047c0efd9ab4mr5586384pfq.30.1635439618948;
        Thu, 28 Oct 2021 09:46:58 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y19sm4011406pfn.23.2021.10.28.09.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 09:46:58 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     chunkeey@gmail.com, arinc.unal@arinc9.com, mnhagan88@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM5301X ARM
        ARCHITECTURE), Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: dts: BCM5301X: Add interrupt properties to GPIO node
Date:   Thu, 28 Oct 2021 09:46:53 -0700
Message-Id: <20211028164654.4014646-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO controller is also an interrupt controller provider and is
currently missing the appropriate 'interrupt-controller' and
'#interrupt-cells' properties to denote that.

Fixes: fb026d3de33b ("ARM: BCM5301X: Add Broadcom's bus-axi to the DTS file")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm5301x.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index ec5de636796e..1ff21951d24a 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -242,6 +242,8 @@ chipcommon: chipcommon@0 {
 
 			gpio-controller;
 			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 
 		pcie0: pcie@12000 {
-- 
2.25.1

