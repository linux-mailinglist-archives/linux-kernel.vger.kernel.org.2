Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEB03B2459
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 02:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhFXAzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 20:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFXAzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 20:55:31 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64310C061756
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 17:53:13 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id d16so7249378lfn.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 17:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hi1YbzpzCridy/vQ8hgizgyXmNuKaQ2Nkv0Kcn9srVY=;
        b=IbkuQi3Lsis6XdOo041PEiUdza67ZYLueW6eeFY9IHRHupcoNmz32sylAbB7DKNGil
         LyryqlxPd1VcbgiYgOLAWrtSBxIlhgr66wnfd2M9CL6Eqs/i0eS+WXA4tamuYkdAd+mV
         n2kw7xkiOMejUr6bElaBKZnAFbKSwSPcC4tcoifQE/aGyMfEvXePTjCjVAr8wBLYwdZD
         7dw8h+QLJ76vrlPZgoHz6hrk7jkT9ke6E9g3H0Y6g7y0C/c8ZUHBxilbTm/kh7qX+6C1
         S70bAV7VX8omEHtohhRV3AC2AVC8deN8DSdeQPEjqLmenqs3opix9xoqjINt/hasP/1M
         C/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hi1YbzpzCridy/vQ8hgizgyXmNuKaQ2Nkv0Kcn9srVY=;
        b=MmTrqd4d0+9L+peLYPMno3Hn6NbYE4TGA8TyCWyvHw0dDu+PBQkPy5bG0xycDopD8P
         EcUFQDssUhDe4JJubxYBiLSPp/5tlExk5xvJD7P/0qfCKKZ8t7UPPgkZOZmFYST9k5I5
         AeLI+0JHMjCGZROXw461Oi/LUWnw7bvt/ORuth2quq82ekck1vYEgVubCAKM9dXHP/dz
         NrsUQLFpyH1Zr9QPHa7R2kDBeA2vkBjLrvH4VvkzcR9amu0cOic/xsev/qRIQxv8T4nb
         Oa5MYTHwBiX+tdg6FstGF//39KIzmZxkVX4ggNoclT4Xu5nY7oUTdm+4D6S6pnSbvS0L
         w4ag==
X-Gm-Message-State: AOAM531113CvpdXD7XHEh09TT47pnLbx0eJjAL5G8Zw0BKATAfjwKCiL
        huhRgqU+0tG+C4XkhBI/WX2XK4yGmZOzDA==
X-Google-Smtp-Source: ABdhPJwT0gYoxoJzqyF+mVw5EZY02M4E2KchGORLvfheKSkDDqC/tfso23X/QH0o/X6r0jm1aYbWiQ==
X-Received: by 2002:ac2:5a11:: with SMTP id q17mr1734969lfn.479.1624495991567;
        Wed, 23 Jun 2021 17:53:11 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id b7sm53776lfe.151.2021.06.23.17.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 17:53:11 -0700 (PDT)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux@armlinux.org.uk,
        jon@solid-run.com, tn@semihalf.com, jaz@semihalf.com,
        hkallweit1@gmail.com, andrew@lunn.ch,
        Marcin Wojtas <mw@semihalf.com>
Subject: [net-next: PATCH] net: mdiobus: fix fwnode_mdbiobus_register() fallback case
Date:   Thu, 24 Jun 2021 02:51:51 +0200
Message-Id: <20210624005151.3735706-1-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fallback case of fwnode_mdbiobus_register()
(relevant for !CONFIG_FWNODE_MDIO) was defined with wrong
argument name, causing a compilation error. Fix that.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 include/linux/fwnode_mdio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fwnode_mdio.h b/include/linux/fwnode_mdio.h
index 13d4ae8fee0a..f62817c23137 100644
--- a/include/linux/fwnode_mdio.h
+++ b/include/linux/fwnode_mdio.h
@@ -40,7 +40,7 @@ static inline int fwnode_mdiobus_register(struct mii_bus *bus,
 	 * This way, we don't have to keep compat bits around in drivers.
 	 */
 
-	return mdiobus_register(mdio);
+	return mdiobus_register(bus);
 }
 #endif
 
-- 
2.29.0

