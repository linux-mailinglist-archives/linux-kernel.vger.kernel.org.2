Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FF740C3EE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 12:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhIOKsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 06:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhIOKsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 06:48:51 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08ADC061574;
        Wed, 15 Sep 2021 03:47:32 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id z184-20020a1c7ec1000000b003065f0bc631so4463604wmc.0;
        Wed, 15 Sep 2021 03:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H1ww3lGPcUZ1JbC+7bYQbWQsgaNUgWkADb7sAryk5jc=;
        b=HaWIrjkKu89hiLnwgJBBned808cHiu4oXy6VsfuWT/QMkK/4n4uACMcmDVRh7KB2ts
         6FNxiKxDwYdoipeeJAqKjdyVnVBW/wRA+MOVSnrReCGmCKh4Igs9448LSxz7UzXGqLYD
         bUpltKNKV/PcJx87wSLAxkVHcZ3F4wFdEOeerfhKl9X2L7IzP2fIasEInXCyp4AHeQks
         BHcScnYjscfoUj0rAeMkJCV9Q57Yw4O6mTuT/MKSsaWaIxN+HPrNE06R9DO/s8FjzMMX
         bGFjEJnHsltpbcq4rYB11Va5B9s9typ7Xx7LDFfTPjvovj34iKCtOCsHqHS66Pi/iKlI
         7NfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H1ww3lGPcUZ1JbC+7bYQbWQsgaNUgWkADb7sAryk5jc=;
        b=eZfh267Cl/STbgB6I0AsP1bmZHelIElKloak6hPukFyraO24zFG6xm2uIbNR0HmK2M
         RbVQpy3fo0xVt2eRW50fI4ch+oKYjUYJwfu+uEVmdaub3FDYC5eagmaRRhwKtVSjPKaJ
         GTQluoCthOt3FMKXE0uHJ3OKW4/l2ZmwOUO5Fl7wL1VrXgKtqLDcBPk2a8MJFMNdK0H7
         LCoF0eQ6YF7TKVBCRcYlHn0i0DukAwJcFzp1Puz0ueJvsPyTT+qJmiCgI1ctVYQnIHeU
         me3lc2vaxc8sAYo4TJckow3v0610/dxi5OBcpKpfnE8kIM1eLMUp5t6SzfRHGEtulsae
         y0XA==
X-Gm-Message-State: AOAM532/ODxrV+LmEk9nY3pek8/ju8WjJxcffv2x97qSKhKG+2jvti4g
        IoxOavDO4ci2tpMWCgmr2YqKsL/pPaQ=
X-Google-Smtp-Source: ABdhPJx3E1ffZC5Qe6yuakcazwe5r/WczNYncBjscZXQAt+IyL0x11uyunDUNTtZDhqYNivRcYylXQ==
X-Received: by 2002:a7b:cf0b:: with SMTP id l11mr3548512wmg.176.1631702851598;
        Wed, 15 Sep 2021 03:47:31 -0700 (PDT)
Received: from localhost ([2a01:e0a:3d3:9cc4::e68])
        by smtp.gmail.com with ESMTPSA id y1sm4180704wmq.43.2021.09.15.03.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 03:47:30 -0700 (PDT)
From:   roucaries.bastien@gmail.com
X-Google-Original-From: rouca@debian.org
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Chen-Yu Tsai <wens@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Salvatore Bonaccorso <carnil@debian.org>,
        =?UTF-8?q?Bastien=20Roucari=C3=A8s?= <rouca@debian.org>
Subject: [PATCH] [PATCH] ARM: dts: sun7i: A20-olinuxino-lime2: Fix ethernet phy-mode
Date:   Wed, 15 Sep 2021 10:47:16 +0000
Message-Id: <20210915104715.2238454-1-rouca@debian.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bastien Roucariès <rouca@debian.org>

Commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay
config") sets the RX/TX delay according to the phy-mode property in the
device tree. For the A20-olinuxino-lime2 board this is "rgmii", which is the
wrong setting.

Following the example of a900cac3750b ("ARM: dts: sun7i: a20: bananapro:
Fix ethernet phy-mode") the phy-mode is changed to "rgmii-id" which gets
the Ethernet working again on this board.

Signed-off-by: Bastien Roucariès <rouca@debian.org>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index 8077f1716fbc..ecb91fb899ff 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -112,7 +112,7 @@ &gmac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&gmac_rgmii_pins>;
 	phy-handle = <&phy1>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	status = "okay";
 };
 
-- 
2.33.0

