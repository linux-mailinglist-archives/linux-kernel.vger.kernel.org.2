Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245613D8A7C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 11:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbhG1JVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 05:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhG1JVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:21:02 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2365C061757;
        Wed, 28 Jul 2021 02:21:00 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id h11so2217750ljo.12;
        Wed, 28 Jul 2021 02:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VzfY90gbi7X0sIuQn8XV9NivWhzVCd/PHvSPOyC76w8=;
        b=jO2eSSAweM20bIIitDJ50YLexzO4JULRRkl93vjQZ1RD16i9/n0Gy20Jbspz6nj9WY
         NwZz7ROCAVkV7szOR1jyX30Dk8xIV0/SUmX6qe0VgT1x/cy2nf2BFrrDJdywMH4qgm+M
         aBlGDIAaP2aemq9swFyQjn6BxTvDetUqUObj39Q6o56kUAlXHZrOedeDf/JkH41lPO2S
         k23IIE26hMSnd9jtRs1yPxxaCUgmt4cV0WScaWpT9m3ZWg0Bss0GFZZ26bg2HDOkNRDw
         TvhLVOI2vX5El6JqnI/MGgMV5yahats5YH/EDHO7/ZCPUW3Qi/o1ggQbln3m0EdqqeWC
         Arvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VzfY90gbi7X0sIuQn8XV9NivWhzVCd/PHvSPOyC76w8=;
        b=AHCPG8x9nlL1V86zTtqZYW4So9H6RXELaahhztcNNfrREnewQborXYLycfgns8Xzhm
         IoRBApVVYk9myCQ9uVYACQoXNcyahj49uiLucGlB2PqlFrdJTnIO4OjQXK7rJg1qFkMV
         GzQ/W0soNMRTTCAsfHX8iGdM/GjWrJUqCL4GQailjPHdBsBUYqllDo+WWD0tBPHjwIcr
         GKEnSooEgKFyr0l236xbGG795VcUXl043O0tcgWDL57x2AuOcApGsqM3fma51W+t8Gcm
         zBo0qpqu0CRy01ggXNQ6IqpsUIVvwEWjtblvzmoGX8JjV/hfPEO0iYp+kTNr7l0ZUJx6
         pb7A==
X-Gm-Message-State: AOAM531Y3ghqZnPK76zt8cM/RTEHXAxVTutri3lGatJrwY0w2JE7RCwQ
        xelzDdyG99VFmQXRbDDnrIUuJH9H41DTeg==
X-Google-Smtp-Source: ABdhPJzHivL74mGrAiSLeIGrmLEg6kK3l2lpeTZhCxSiDgZwb5d51lcgl0jJnRRYvA9vmuArIsznOQ==
X-Received: by 2002:a2e:7015:: with SMTP id l21mr18593503ljc.72.1627464059290;
        Wed, 28 Jul 2021 02:20:59 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id m12sm535039lfo.227.2021.07.28.02.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 02:20:58 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] usb: gadget: pxa25x_udc: Constify static struct pxa25x_ep_ops
Date:   Wed, 28 Jul 2021 11:20:52 +0200
Message-Id: <20210728092052.4178-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct pxa25x_ep_ops is only assigned to the ops field in the
usb_ep struct, which is a pointer to const struct usb_ep_ops.
Make it const to allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/usb/gadget/udc/pxa25x_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
index 69ef1e669d0c..a09ec1d826b2 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.c
+++ b/drivers/usb/gadget/udc/pxa25x_udc.c
@@ -1093,7 +1093,7 @@ static void pxa25x_ep_fifo_flush(struct usb_ep *_ep)
 }
 
 
-static struct usb_ep_ops pxa25x_ep_ops = {
+static const struct usb_ep_ops pxa25x_ep_ops = {
 	.enable		= pxa25x_ep_enable,
 	.disable	= pxa25x_ep_disable,
 
-- 
2.32.0

