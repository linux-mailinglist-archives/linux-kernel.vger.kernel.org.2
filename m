Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A8C42F9D6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242126AbhJORNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242142AbhJORNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:13:16 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBD3C061764
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:11:09 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 5so10454620edw.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Edvno2sOp/O5//oFNIXgh3L32eEJg32t9M6swDx8iCI=;
        b=A3yA0lUmip7KhifwxOIt6jNKUixMdBEHMZOnTKMmMNIa/bavBSMLhSM8frc+yxmOpB
         hrj6dCtctHKvIl+hoUgPTtUazLA8852xTnlk6DjYq7qU7QvAkTFUXPbZF7vkghYrBwwV
         7O9sCQK5nA7LXrEzXFSO+SHHQII+zz6X0irWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Edvno2sOp/O5//oFNIXgh3L32eEJg32t9M6swDx8iCI=;
        b=vDMBuV62Z/n+wgrGToirB6xkU0P/06Q5NaKGq3l197BWJemB+wBIoHhhSzO3ERJzYJ
         5OAHVN795OX4p0GeqcvqFcLq3RZZJ7xHj233I1lMKztcSsFrv/PN9PMeDOpLFOMReeUp
         bHl9QEeZwafomiFiGvcU0XgCTAQRXk7TMUDbb3ydipx1+yaAvnDB9jUBxilX1DVjsNH0
         wa7aYCT0NGi3jbtS7MF3rtUDQABUwvr9RuoT1dBbKMfu0ICePWJB54cCr+EL5p1bCbc2
         Lc6jm43u/quBDKaCj4JBEWMYwElEbU3zwZfZCyief94MNhZtUAhjeL8ZAsjwFtqM8BZl
         jgyQ==
X-Gm-Message-State: AOAM531z7mHgRujr3BekwZoUsDi6btxFqSUpfk8glPdMxwkVwsywo//3
        4Nizy79KB6ikNGUVb9tktHVroQ==
X-Google-Smtp-Source: ABdhPJzCqhSthnvO7YJ9RVCCpqRKN4xPvUd+H0AcGReyP6GRi1ff/wPJVDOph2mS8+nQ45Du+5Bd6w==
X-Received: by 2002:a17:906:942:: with SMTP id j2mr8328367ejd.303.1634317867992;
        Fri, 15 Oct 2021 10:11:07 -0700 (PDT)
Received: from capella.. (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id jt24sm4735792ejb.59.2021.10.15.10.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 10:11:07 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 7/7] net: phy: realtek: add support for RTL8365MB-VC internal PHYs
Date:   Fri, 15 Oct 2021 19:10:28 +0200
Message-Id: <20211015171030.2713493-8-alvin@pqrs.dk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211015171030.2713493-1-alvin@pqrs.dk>
References: <20211015171030.2713493-1-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

The RTL8365MB-VC ethernet switch controller has 4 internal PHYs for its
user-facing ports. All that is needed is to let the PHY driver core
pick up the IRQ made available by the switch driver.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---

v2 -> v3: no change

v1 -> v2: no change

RFC -> v1: no change; collect Reviewed-by

 drivers/net/phy/realtek.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 11be60333fa8..a5671ab896b3 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -1023,6 +1023,14 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= genphy_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
+	}, {
+		PHY_ID_MATCH_EXACT(0x001cc942),
+		.name		= "RTL8365MB-VC Gigabit Ethernet",
+		/* Interrupt handling analogous to RTL8366RB */
+		.config_intr	= genphy_no_config_intr,
+		.handle_interrupt = genphy_handle_interrupt_no_ack,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
 	},
 };
 
-- 
2.32.0

