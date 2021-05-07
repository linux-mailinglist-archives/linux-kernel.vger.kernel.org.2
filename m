Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2F1375FFF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbhEGGCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEGGCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:02:46 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7C5C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 23:01:45 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id b19-20020a05600c06d3b029014258a636e8so4181012wmn.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 23:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gdoi/Ql794n4I6ECv2j9dtEFRugBMOEUCreF0AscFPk=;
        b=ZRs7XjuVmWRbqGlwoI/5q5k9lWVg/dGkjtzP/COgnl8vyQaVMjg9aGtksgTZeVojDY
         qKaY+5mtSPQRzlWo8E4XPy1qhS4Ld9v1vIWSDJJmPwCOw1zQ0CG2K5qZH1/GxOMDMKCU
         VOcsTDv1g6AajWCd7fH8/bW6tg/SeOD9xITxni1YAS+xP3WZeZYssGesuYshEk9SgC9u
         GGspo+/l2X9B2YDDJqYq/gwDcKQxO3aBaoRfTixaCA39UWR5a9J8S77il0HCl8PalyFa
         aLZkrCnWiSDCAOpFoipN4ZdyALgVDEC4n0ayLhIP9p5wsUAZpmM7t3sPl/RpWjjQGU1Y
         rNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gdoi/Ql794n4I6ECv2j9dtEFRugBMOEUCreF0AscFPk=;
        b=VW3yyGS3y68mD9i5GkWRZGB2YyChjTSm0y7RyKUbyqFaonqgt5g+C5/+6eB48xmILp
         EYOfeD8fm+Ra6I+/lnbhK3rowFfJQz4qJqFNwQ8M7gEWklIsrYWvjPWUP+2ZuUJfCnmo
         6bdpYe/uZzq+G/ZOSBONoITy8b1SC8wIhvlQn2qJZlBPk9cxFAXtB62zf2Dz5NajRoTp
         TyUfoK1nx6FdfC/ZdQ8EpKJFP1TANQZYeVmQaAKNoizXJ7nueI457ggGTNc/LuBVm7ze
         fOWpPp95qdOpDOgF3DUeYoLhkyGRTpq+uKC0N/1EQHrdJ6DzJZ3JJmbTxJ7Vvorcjm1r
         OXFw==
X-Gm-Message-State: AOAM5335UFp0Z7DkDKLNvN+WwCXEOro60nZMeCDt0N4YZ1rSwQIo/RuL
        k/BOd5otUpOqYTWVY8YQ5LpJoCMohpAiAg==
X-Google-Smtp-Source: ABdhPJy6AVR/t54PlZkE7ZrKrOCcVGpPfgWXcYCh5LyVUnABjvf/JzN7PpjBMHth6obsTFxS1ZPHrg==
X-Received: by 2002:a05:600c:3205:: with SMTP id r5mr7967581wmp.78.1620367304414;
        Thu, 06 May 2021 23:01:44 -0700 (PDT)
Received: from localhost.localdomain (231.red-83-51-243.dynamicip.rima-tde.net. [83.51.243.231])
        by smtp.gmail.com with ESMTPSA id r2sm7120242wrt.79.2021.05.06.23.01.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 May 2021 23:01:43 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     vkoul@kernel.org
Cc:     linux-phy@lists.infradead.org, kishon@ti.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, neil@brown.name,
        ilya.lipnitskiy@gmail.com, kernel test robot <lkp@intel.com>
Subject: [PATCH] phy: ralink: phy-mt7621-pci: properly print pointer address
Date:   Fri,  7 May 2021 08:01:42 +0200
Message-Id: <20210507060142.17049-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The way of printing the pointer address for the 'port_base'
address got into compile warnings on some architectures
[-Wpointer-to-int-cast]. Instead of use '%08x' and cast
to an 'unsigned int' just make use of '%px' and avoid the
cast.

Fixes: d87da32372a0 ("phy: ralink: Add PHY driver for MT7621 PCIe PHY")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/phy/ralink/phy-mt7621-pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/ralink/phy-mt7621-pci.c b/drivers/phy/ralink/phy-mt7621-pci.c
index 753cb5bab930..4705931fb072 100644
--- a/drivers/phy/ralink/phy-mt7621-pci.c
+++ b/drivers/phy/ralink/phy-mt7621-pci.c
@@ -272,8 +272,8 @@ static struct phy *mt7621_pcie_phy_of_xlate(struct device *dev,
 
 	mt7621_phy->has_dual_port = args->args[0];
 
-	dev_info(dev, "PHY for 0x%08x (dual port = %d)\n",
-		 (unsigned int)mt7621_phy->port_base, mt7621_phy->has_dual_port);
+	dev_info(dev, "PHY for 0x%px (dual port = %d)\n",
+		 mt7621_phy->port_base, mt7621_phy->has_dual_port);
 
 	return mt7621_phy->phy;
 }
-- 
2.25.1

