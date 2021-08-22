Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470473F4139
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 21:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbhHVTda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 15:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbhHVTd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 15:33:28 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43678C061756
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 12:32:47 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bt14so32275048ejb.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 12:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fV/T5HnNhSBhhXcySBbbcTxkKppswGm9K3h/snIx9Z0=;
        b=kFO76eGVYd9WPNeE1lTiO9yiZxPnKWhENPZsb+o6G9fxksSdEfg+N903JrKIIWUOOJ
         mWd1lP8UBtsTaBgZgvGCpOwwbq7ypzpnb5cm80rWKAUHy6SZeRKCjKrGmxNnzoBcNUQh
         mmyit038BxR6l8RAEjI1+/V15Av2SCvnfrVgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fV/T5HnNhSBhhXcySBbbcTxkKppswGm9K3h/snIx9Z0=;
        b=JmEcJk6GeqoVUTvTAULsHL2aysV5MXc6HBe/jx8ObL/DEC/F3doIA3be4Qhomtnz7Z
         kjQcvCXpXj4vlPv0gcmgbvWD71m//6c+6K0u89eY/0+xj2waMMo0Cx0i7UhksjuF9NWM
         0JBhOUJNImPQn5MMn4T5ySXIyQFn5zREGbva/XzoST1GfqRO2Kaoqn42Lz61f7n7TsBK
         tHjFnDyY/tQnGfXhjGBlrqy8sTLyKZ/n380jp9k4LV4QHHzSb+erxvXOoQixRCRIxhkK
         PJqlaMquRugh58LqMgnYjbA7xom4Y0qPZdfU+aomhiMM0j/mZal1I5aHelgZVB66zNuC
         mF2Q==
X-Gm-Message-State: AOAM533JTdoIgSB0dOmvCfA2a//ulSfThiymILmJsUXy/ukxvkLjDENu
        kFY3m+HJ/McYKba/PlgzZFvxLQ==
X-Google-Smtp-Source: ABdhPJzK/1xXINX2sPeplqjfZO2Wrnr7H5f3Vf0x5xtgOZ60AYVxvbHdkHQxIRpnqNjaV6yKj9SchQ==
X-Received: by 2002:a17:907:1750:: with SMTP id lf16mr32300126ejc.242.1629660765853;
        Sun, 22 Aug 2021 12:32:45 -0700 (PDT)
Received: from capella.. (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id cn16sm7780053edb.9.2021.08.22.12.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 12:32:45 -0700 (PDT)
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
Cc:     mir@bang-olufsen.dk, alvin@pqrs.dk,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 2/5] dt-bindings: net: dsa: realtek-smi: document new compatible rtl8365mb
Date:   Sun, 22 Aug 2021 21:31:40 +0200
Message-Id: <20210822193145.1312668-3-alvin@pqrs.dk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210822193145.1312668-1-alvin@pqrs.dk>
References: <20210822193145.1312668-1-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

rtl8365mb is a new realtek-smi subdriver for the RTL8365MB-VC 4+1 port
10/100/1000M Ethernet switch controller. Its compatible string is
"realtek,rtl8365mb".

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 Documentation/devicetree/bindings/net/dsa/realtek-smi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/realtek-smi.txt b/Documentation/devicetree/bindings/net/dsa/realtek-smi.txt
index b6ae8541bd55..ee03eb40a488 100644
--- a/Documentation/devicetree/bindings/net/dsa/realtek-smi.txt
+++ b/Documentation/devicetree/bindings/net/dsa/realtek-smi.txt
@@ -9,6 +9,7 @@ SMI-based Realtek devices.
 Required properties:
 
 - compatible: must be exactly one of:
+      "realtek,rtl8365mb" (4+1 ports)
       "realtek,rtl8366"
       "realtek,rtl8366rb" (4+1 ports)
       "realtek,rtl8366s"  (4+1 ports)
-- 
2.32.0

