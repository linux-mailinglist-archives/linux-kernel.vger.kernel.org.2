Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7313F2458
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 03:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbhHTB2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 21:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbhHTB2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 21:28:02 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D91C061575;
        Thu, 19 Aug 2021 18:27:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id u15so4917986wmj.1;
        Thu, 19 Aug 2021 18:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3wG+ySzeEprV+yc+XWum1zV/cM3qSLdGZx6RBGuGrt0=;
        b=MC3iafjo+Dorj/liOIIpypUPSUXqDWuPtYKvRUvkTqfh2Gsn4aRlTg0YC39VONrvoj
         GjDIKZryQTITsJ3YUZFdJ0GVlAJWTEuzZZ3bVtZ0PLq8bEFIwv1aZdHEGzRXO7xM8yKd
         xhrwd+isreeVxgJRR8OaSRadR4oD9cJVCluZvSW7tbYKLRMULSq3LmxUCYGI+oEUZIo9
         BBqbdFF99eRBgG7y7vlTIwdIK11rbxDhRI/9dQ+IK19ZtQGo1dvivojZ6++yXljEFc2b
         V6ySFYdp03X4MVd+NGh5p2rBXx1rEteQuTzig5LpxHe3brW29c888MYr/cpuyf2OHMSi
         WbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3wG+ySzeEprV+yc+XWum1zV/cM3qSLdGZx6RBGuGrt0=;
        b=WIal47pNTlHyTjE/cm41LEV2t3YKlWao4nYZcHVnQi6TTrKQGaW/lDccGVG3Qu2oWW
         zfxOSMlad1Otiza0SI7iXwlv6rCuhjHE+VkwzowtoUrjtsS+9zGM7IVabsxHyqbPHofu
         xGsn5fYJNM1mi6B1djhs3+I9QjtgVFh9rZZi6NOw5BTTipoqB1/pFYQsD6/rpFIrTVMJ
         tuOdWVVlXtmhbOfP5Cvj9d98OzTXpjd9pJUXQB6mpnLrJqRNBzOhJTSF/xAyBFBY5evp
         NJSNqUGZgHqv38W+A7ER9wuY5a7mfHwDSKiO+35TO16HMO12Hh1uf7P+HPF9SO1D7FeC
         5vFA==
X-Gm-Message-State: AOAM531Qf8Ln7cFp9ryFlRiF72FiX/MM0eNxRS3gkm1g+e2IdruhDDNc
        Ffh7lD/FlQiZU3iucXdAdRpimdLDDhX1cQsdV8M=
X-Google-Smtp-Source: ABdhPJwocTP8uyu6GqN2EoUfhbMIpjrUuVQMr3ItXPa4ajbQtMa22xWFeB0vy1BpmjtownDPwNlrNQ==
X-Received: by 2002:a1c:7904:: with SMTP id l4mr1278603wme.42.1629422843780;
        Thu, 19 Aug 2021 18:27:23 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id l2sm4316517wrx.2.2021.08.19.18.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 18:27:23 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] soc: amlogic: meson-gx-socinfo: Add S905Y2 ID for Radxa Zero
Date:   Fri, 20 Aug 2021 01:27:18 +0000
Message-Id: <20210820012718.10761-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SOC ID for the S905Y2 used in the Radxa Zero. Before/After:

[    0.321650] soc soc0: Amlogic Meson G12A (Unknown) Revision 28:b (30:2) Detected
[    0.318533] soc soc0: Amlogic Meson G12A (S905Y2) Revision 28:b (30:2) Detected

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 drivers/soc/amlogic/meson-gx-socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index 6f54bd832c8b..165f7548401b 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -65,6 +65,7 @@ static const struct meson_gx_package_id {
 	{ "A113X", 0x25, 0x37, 0xff },
 	{ "A113D", 0x25, 0x22, 0xff },
 	{ "S905D2", 0x28, 0x10, 0xf0 },
+	{ "S905Y2", 0x28, 0x30, 0xf0 },
 	{ "S905X2", 0x28, 0x40, 0xf0 },
 	{ "A311D", 0x29, 0x10, 0xf0 },
 	{ "S922X", 0x29, 0x40, 0xf0 },
-- 
2.17.1

