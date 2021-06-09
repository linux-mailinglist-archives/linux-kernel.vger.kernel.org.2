Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296513A1528
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbhFINMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:12:12 -0400
Received: from polaris.svanheule.net ([84.16.241.116]:48746 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235872AbhFINMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:12:10 -0400
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafb:ee01:a92e:8520:f692:3284])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 6BDB120B198;
        Wed,  9 Jun 2021 15:10:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1623244215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZlpPGMBySBGIxvBDPWbDdDfTExL8fbPLa7/mJyONJCc=;
        b=DsvrENJ931DnlQLJ7zH1xdotkmYCtDybBLJhSWrOlpkmXaNk4cYwHjlYFMVWexwX3QgzO6
        tS3VC7/uTkSXgiRiv+RLbbnAoUQpUchdz9ZymumkmCBjH9T3U5K3BKn3vOZHwB8OASfa9o
        XmLgbYXcPgyhfj9BQ1TYOX/dftBEXk+coX1QOEPAp7Mi9erg1STJF1F4G0yZ/UuaA+lxEr
        Kwc4teKZm3RfP7CYavo1GuMVrixGZbRlUhVy0kDxBv0OBVyadjihs+y+243ptlf3rqsteP
        +r2BHuiPTVIJtnN8Gjr+QZzmF7y+YAlGE2tBaKMsiVcOQjFNuoIObf/urZOXlA==
From:   Sander Vanheule <sander@svanheule.net>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Adrew Lunn <andrew@lunn.ch>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v2 1/2] regmap: mdio: Fix regmap_bus pointer constness
Date:   Wed,  9 Jun 2021 15:10:03 +0200
Message-Id: <f304ca638ffdc66d4803a6df1f75436894bd1d5f.1623244066.git.sander@svanheule.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623244066.git.sander@svanheule.net>
References: <cover.1623244066.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A const qualifier was omitted in the declaration of the regmap_bus
pointer, resulting in the following errors:

drivers/base/regmap/regmap-mdio.c: In function ‘__regmap_init_mdio’:
drivers/base/regmap/regmap-mdio.c:87:7: warning: assignment discards
‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
   87 |   bus = &regmap_mdio_c22_bus;
      |       ^
drivers/base/regmap/regmap-mdio.c:89:7: warning: assignment discards
‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
   89 |   bus = &regmap_mdio_c45_bus;
      |       ^

Fix this by ensuring the pointer has the same qualifiers as the assigned
values.

Fixes: f083be9db060 ("regmap: mdio: Add clause-45 support")
Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 drivers/base/regmap/regmap-mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-mdio.c b/drivers/base/regmap/regmap-mdio.c
index cfb23afb19eb..b772b42809e2 100644
--- a/drivers/base/regmap/regmap-mdio.c
+++ b/drivers/base/regmap/regmap-mdio.c
@@ -69,7 +69,7 @@ struct regmap *__regmap_init_mdio(struct mdio_device *mdio_dev,
 	const struct regmap_config *config, struct lock_class_key *lock_key,
 	const char *lock_name)
 {
-	struct regmap_bus *bus;
+	const struct regmap_bus *bus;
 
 	if (config->reg_bits == 5 && config->val_bits == 16)
 		bus = &regmap_mdio_c22_bus;
-- 
2.31.1

