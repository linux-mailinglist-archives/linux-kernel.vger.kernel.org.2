Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215433B6C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 03:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhF2Bbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 21:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbhF2Bby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 21:31:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196BDC061574;
        Mon, 28 Jun 2021 18:29:27 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id bb10-20020a17090b008ab029016eef083425so771178pjb.5;
        Mon, 28 Jun 2021 18:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JRlGj/MQ8RE/ZATYAF6lewLI2xCcGnw8emgVF67u0j4=;
        b=COr3/rdPwWZrvA57IqpNwQKkAkOdlgw9G3zxEDMklJgKvsOHPYj0u7v4JmWsSVTyxs
         doewSEpIm/nJq3/nDL+gWgjXlNMod6G8Lkkg9lWK2KTgcSSXVaf0tS6bHLONuymmcWwV
         BUeuQiipACrk6f4ypekuWX76xRXJJ9xbbI6gtpP0NlY0plOVn8ckYzpGVoAySpInIzer
         4SdLUBqnv+FYnoiTGmTADxFAN3Fw1jKxi4PjEiQ3yKJz5GuTyyycqpTwulLBTGKDVXFA
         /l36zxcs1wp+shDW1rUqUcYwczveCW/z7+4XrmGCesmYVpd1ga5kBxmaHBgaaeKMLejG
         1r7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JRlGj/MQ8RE/ZATYAF6lewLI2xCcGnw8emgVF67u0j4=;
        b=a9LlgtYCksG1LznUagm0XrvkeHOzdYAwomvZuDQ9XIcfTcrmIZzJIQMYXI3l9t41AW
         FHnHJiIiCw7geeI0dUaCYLARMDZXM43UZH3WCSTcyqlJuVYjoXtXZ1qxznlsTmuhvnUO
         FS6W3jJ/Sd+XXFod/ZXfiHJfet6ob8RBaAfBpd6nRZhzX6bhYAvOGfd6fIiPfeU32e4Z
         TxlCe+sa9hNCvYxLr0fMKfcv8UgDIEsgmaX56ZKuxGRR6ZsQa0bUbgyTWN3N6NqTmcQ6
         VAXQVHwYBGOLOnGIc0PbwRD3rSrDgg5mb108b7YUCvm31fFlue1WqFv3OVDRN72ZJcZQ
         HjFg==
X-Gm-Message-State: AOAM532Kx/+RE/jAi4Dr8WkUZFFnLYN0Enpj9vZD+h06DdVcZL3K6HNt
        zeNURAIKzg6iPxgpgRyEqfJNRtp3/xAc9J5cRTA=
X-Google-Smtp-Source: ABdhPJxfXGa28G4Gw9FxA/WuMOhFcXUJo8D2KmdLkusLDi27M4jCX3Bez4Ajbp4UB3i5EXvhG86joA==
X-Received: by 2002:a17:90a:b284:: with SMTP id c4mr31418084pjr.213.1624930166649;
        Mon, 28 Jun 2021 18:29:26 -0700 (PDT)
Received: from localhost.localdomain ([150.109.127.35])
        by smtp.gmail.com with ESMTPSA id k13sm15183933pfu.57.2021.06.28.18.29.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jun 2021 18:29:26 -0700 (PDT)
From:   Bing Fan <hptsfb@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm pl011 serial: support multi-irq request
Date:   Tue, 29 Jun 2021 09:29:24 +0800
Message-Id: <1624930164-18411-1-git-send-email-hptsfb@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bing Fan <tombinfan@tencent.com>

In order to make pl011 work better, multiple interrupts are
required, such as TXIM, RXIM, RTIM, error interrupt(FE/PE/BE/OE);
at the same time, pl011 to GIC does not merge the interrupt
lines(each serial-interrupt corresponding to different GIC hardware
interrupt), so need to enable and request multiple gic interrupt
numbers in the driver.

Signed-off-by: Bing Fan <tombinfan@tencent.com>
---
 drivers/tty/serial/amba-pl011.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 78682c12156a..b63164e89903 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1703,9 +1703,30 @@ static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
 
 static int pl011_allocate_irq(struct uart_amba_port *uap)
 {
+	int ret = -1;
+	int i = 0;
+	unsigned int virq = 0;
+	struct amba_device *amba_dev = (struct amba_device *)uap->port.dev;
+
+	if (!amba_dev)
+		return -1;
+
 	pl011_write(uap->im, uap, REG_IMSC);
 
-	return request_irq(uap->port.irq, pl011_int, IRQF_SHARED, "uart-pl011", uap);
+	for (i = 0; i < AMBA_NR_IRQS; i++) {
+		virq = amba_dev->irq[i];
+		if (virq == 0)
+			break;
+
+		ret = request_irq(virq, pl011_int, IRQF_SHARED, "uart-pl011-*", uap);
+		if (ret < 0) {
+			dev_info(uap->port.dev, "%s %d request %u interrupt failed\n",
+					__func__, __LINE__, virq);
+			break;
+		}
+	}
+
+	return ret;
 }
 
 /*
-- 
2.17.1

