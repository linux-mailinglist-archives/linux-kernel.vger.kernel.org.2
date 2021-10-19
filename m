Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4224336BA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbhJSNPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235795AbhJSNPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:15:24 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37287C06161C;
        Tue, 19 Oct 2021 06:13:11 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w14so12678549edv.11;
        Tue, 19 Oct 2021 06:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iBrOklT6wRz3+4Sv0nSOix/uEw45k7IhgJcWd50H2V4=;
        b=deOrvOSZJ7Ax/hHX/I0bj/ua6fjX1rP1DhOlu075couX1a3c1NVd1vCXiKTksJ8yXW
         qp4uXHhYMHHGxeF0zRIXPw9gurIoJ3aRUNnKbOAe8ArOMSk57YGOgDvnqpZIjI5pEo4Z
         cNOwb5tFsa/EZb+qlgBK9hUuhTQpDnP7tE1vX1OxMa5fUH/G9FCb1T2XFaA3XjPmvKVd
         dPYjOPOJrqXvXlcYtNWa+RaDM/Y8Rn+1e9mqNRVeUb4kvgVK7Ntrb0cdAT9Ackzt55Vo
         Nf7tiQol+2HlOzjTdRwPlexTUAyoCtbWQg81M4LN82vslZ3ear0azg0nfJ7vueyiZAuk
         6H/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iBrOklT6wRz3+4Sv0nSOix/uEw45k7IhgJcWd50H2V4=;
        b=z46AzwIuTv1NuFko8Y1Ujxdko7ZaghdKIJk2+YfCBAGi/zTd/MSCY8d8XJq2X6cHnC
         Jema461/2mSMggsRdJ/VnEKIVrqlYwJcc5ZHDNAS7hzbhQwCj2TXsjQImfC4Llelb0U3
         ORgk3hS41GByvKWcFQvMvhqyOzOuXcuTJK81sc7ox7T9VwaehdfDcCk0QZ/9+vuytr7a
         CMrzoc5RXEH4tfZY6oJRzU1oIakQJ0k/WlJuPslK+MHyInK2m1dBO5tPUZD4fVc7bxaB
         rBp7QYeOketbpAZG8yzVwWMa9dof73fRzk4gvh96igVp2hW/yhWKgWMYatpQ1UbzcuVN
         hqJQ==
X-Gm-Message-State: AOAM533uCeAwRDBvm9MJAVOS5yECWubObvSBhqUlz283bRX7231kC/44
        uYGOzm4CE3l7P7SY/afx68M=
X-Google-Smtp-Source: ABdhPJzP6RuvLFjU20H2PG1567GaG8/B+U9ZCxaQnE9gpZ3riwQ97C9SC3UHkFwm4W7diIY+IG7Xpg==
X-Received: by 2002:a17:906:e104:: with SMTP id gj4mr36909389ejb.358.1634649169355;
        Tue, 19 Oct 2021 06:12:49 -0700 (PDT)
Received: from roman-Latitude-3400.. (178-133-75-113.mobile.vf-ua.net. [178.133.75.113])
        by smtp.gmail.com with ESMTPSA id g2sm11334590edq.81.2021.10.19.06.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 06:12:48 -0700 (PDT)
From:   Roman Stratiienko <r.stratiienko@gmail.com>
To:     linux-sunxi@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, jernej.skrabec@gmail.com, wens@csie.org,
        mripard@kernel.org, b-liu@ti.com, megous@megous.com,
        Roman Stratiienko <r.stratiienko@gmail.com>
Subject: [PATCH] usb: musb: sunxi: Don't print error on MUSB_ULPI_BUSCONTROL access
Date:   Tue, 19 Oct 2021 16:12:44 +0300
Message-Id: <20211019131244.1568560-1-r.stratiienko@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Error message appears during suspend, where musb driver is storing
the register state in musb_save_context():
```
musb-sunxi 1c19000.usb: Error unknown readb offset 112
```

Print warning instead to avoid confusion.

Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
---
 drivers/usb/musb/sunxi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
index f3f76f2ac63f9b..961c858fb349e1 100644
--- a/drivers/usb/musb/sunxi.c
+++ b/drivers/usb/musb/sunxi.c
@@ -440,6 +440,10 @@ static u8 sunxi_musb_readb(void __iomem *addr, u32 offset)
 				return 0xde;
 
 			return readb(addr + SUNXI_MUSB_CONFIGDATA);
+		case MUSB_ULPI_BUSCONTROL:
+			dev_warn(sunxi_musb->controller->parent,
+				"sunxi-musb does not have ULPI bus control register\n");
+			return 0;
 		/* Offset for these is fixed by sunxi_musb_busctl_offset() */
 		case SUNXI_MUSB_TXFUNCADDR:
 		case SUNXI_MUSB_TXHUBADDR:
@@ -494,6 +498,10 @@ static void sunxi_musb_writeb(void __iomem *addr, unsigned offset, u8 data)
 			return writeb(data, addr + SUNXI_MUSB_TXFIFOSZ);
 		case MUSB_RXFIFOSZ:
 			return writeb(data, addr + SUNXI_MUSB_RXFIFOSZ);
+		case MUSB_ULPI_BUSCONTROL:
+			dev_warn(sunxi_musb->controller->parent,
+				"sunxi-musb does not have ULPI bus control register\n");
+			return;
 		/* Offset for these is fixed by sunxi_musb_busctl_offset() */
 		case SUNXI_MUSB_TXFUNCADDR:
 		case SUNXI_MUSB_TXHUBADDR:
-- 
2.30.2

