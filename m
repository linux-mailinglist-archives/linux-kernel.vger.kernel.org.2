Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A8242C3F3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237728AbhJMOxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236626AbhJMOwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:52:54 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D3DC061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 07:50:50 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r18so11179753edv.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 07:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nf83J1G4eVCARqMFa6zkKQ6aKu2xkOANkKzZx/058z0=;
        b=cDKwZv5QJ3E2LdK8ZqxSt7nHeShCLZKzQbHBFbMqGt1J9pchxflQflh/jtsjBAvq2/
         ImrnoVkoENXVNa8h5BpN6HHPDT36GDQWpB1GSSTo+XqJHZ13FsZyuLRz17ZqOwm47//X
         t5SSYkqFNpE7rzaieCoqnXhP7GEW06OP6lki4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nf83J1G4eVCARqMFa6zkKQ6aKu2xkOANkKzZx/058z0=;
        b=Zjpkp5B6HI7Xxrgq08Nxdq9Zp3pqdXDonzUIR1iBlX2qF+GojUNfFkyJtWHMIRSXv+
         CdpSPNUa9ST4Dtm8hJdFt/OjnX5K9gwcwmaXXU7T7MIYnyKGXMboXvQ7RuWdtuuVU9R0
         rQBZsOZyeVp262q96vka4s6Wk37oPd1BzuZXospNbD+6jwCb9+8wm9GVbqCaifKUg1NE
         vTKJ7JfwEBeTzQFgNc2IhvRmvk+KPU3bD1ZN4uQ4SQUlPvZuTdCIuNQspgDAlSrfwRId
         R6VrPX//N7rm1rJ0zBrjmbBZu8jZaDQuMRrt65XSTyhI/iZISPNUp0tp6jvK5lluFc3v
         CNJg==
X-Gm-Message-State: AOAM530CjhvVsF7hcfxvlkRl8WrdFeuObIMGEDKb/eHFfTbe0zsIF2FI
        hmwDufHS/4pcuMpKUuTs858jyw==
X-Google-Smtp-Source: ABdhPJxuc7MXpenFNuj7PzZE6h84Z4WbIqVVcnPZdsomQsWWGyjvfzawcTk4S/G2dJR2SByzyGu+Gw==
X-Received: by 2002:a50:e004:: with SMTP id e4mr10346425edl.246.1634136649524;
        Wed, 13 Oct 2021 07:50:49 -0700 (PDT)
Received: from capella.. (27-reverse.bang-olufsen.dk. [193.89.194.27])
        by smtp.gmail.com with ESMTPSA id nd22sm7535098ejc.98.2021.10.13.07.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 07:50:49 -0700 (PDT)
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
Subject: [PATCH v2 net-next 1/6] ether: add EtherType for proprietary Realtek protocols
Date:   Wed, 13 Oct 2021 16:50:33 +0200
Message-Id: <20211013145040.886956-2-alvin@pqrs.dk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211013145040.886956-1-alvin@pqrs.dk>
References: <20211013145040.886956-1-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Add a new EtherType ETH_P_REALTEK to the if_ether.h uapi header. The
EtherType 0x8899 is used in a number of different protocols from Realtek
Semiconductor Corp [1], so no general assumptions should be made when
trying to decode such packets. Observed protocols include:

  0x1 - Realtek Remote Control protocol [2]
  0x2 - Echo protocol [2]
  0x3 - Loop detection protocol [2]
  0x4 - RTL8365MB 4- and 8-byte switch CPU tag protocols [3]
  0x9 - RTL8306 switch CPU tag protocol [4]
  0xA - RTL8366RB switch CPU tag protocol [4]

[1] https://lore.kernel.org/netdev/CACRpkdYQthFgjwVzHyK3DeYUOdcYyWmdjDPG=Rf9B3VrJ12Rzg@mail.gmail.com/
[2] https://www.wireshark.org/lists/ethereal-dev/200409/msg00090.html
[3] https://lore.kernel.org/netdev/20210822193145.1312668-4-alvin@pqrs.dk/
[4] https://lore.kernel.org/netdev/20200708122537.1341307-2-linus.walleij@linaro.org/

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---

v1 -> v2: no change; collect Reviewed-by from Vladimir

RFC -> v1: this patch is new

 include/uapi/linux/if_ether.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ether.h
index 5f589c7a8382..5da4ee234e0b 100644
--- a/include/uapi/linux/if_ether.h
+++ b/include/uapi/linux/if_ether.h
@@ -86,6 +86,7 @@
 					 * over Ethernet
 					 */
 #define ETH_P_PAE	0x888E		/* Port Access Entity (IEEE 802.1X) */
+#define ETH_P_REALTEK	0x8899          /* Multiple proprietary protocols */
 #define ETH_P_AOE	0x88A2		/* ATA over Ethernet		*/
 #define ETH_P_8021AD	0x88A8          /* 802.1ad Service VLAN		*/
 #define ETH_P_802_EX1	0x88B5		/* 802.1 Local Experimental 1.  */
-- 
2.32.0

