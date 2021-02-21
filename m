Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31E1320D9A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 21:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhBUU3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 15:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhBUU3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 15:29:41 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E0EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 12:29:00 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id t11so25923691ejx.6
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 12:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DXNugBGB0R8hXYsSzzEua1tMZzyOESjH2acUqGOVMAk=;
        b=ng/tYMoWGOENzSQyaxlYYL/CYGAMQ1/B0f7U2j7e2L5MGpf+2K67nmABqAdlg9+Ed8
         AeBX8L96IYodlLEhu71/BCwpoLUV6E/hAQpaQD7OIijGM1MXqYZcDUzA9DPVbI1Zz3j8
         /XbCtp6lSZKsAgDvrpU2j177uOCV96uUq2XXPqKLlA0OnTXM9ZB/byz0srpZ2AFxJJx/
         xCIcluSMOWdl/MdLz/rCWarCxnv9JcYM5kfJZBwBrgCsEuxAA8AqqayDQuIlAdgDls9/
         NCiVzgJQUMO9FkQc4iOSjEu3qZq8O18mmaxSIG3MBc2OLCpEQdNp2OCrxefjWnQGN3rw
         3gFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DXNugBGB0R8hXYsSzzEua1tMZzyOESjH2acUqGOVMAk=;
        b=BXeFGVTGKDqfXISnF3QQmOIVtxH/OX0AClHzwQkZalk6cyZFTl/O0m+ObyPlq+GrKm
         gG3Xu3lsBK/0lcDExBV6+h/9pJ8a3Jynwr5/gCaqhVdmmPvynWiSaueXmP4dMPlEc/31
         s68XXtDv8mOZZCh5aZXaMGvlSUeHQYWFFFZeeh+xEH7lE7NJUljSruKdwbxoRzpYKJH4
         ezqZd8M4q55L1Rx5VCfGi5HE1HeagdTtV1Jqc02uKWntjHezzoFBnwVe71q/A3qX/Usq
         GZcVSSJ11KYUaNANuA+dmPN6BnzpZPLANldwoFPL1KLMjZcp94IPJnLEz8hI++cANIPb
         oz4w==
X-Gm-Message-State: AOAM531KSSI6visRDcAUXOCsndwf/mvu4E9JVu19SaonlH1RNZQnKdeH
        EaS6wh4EPbBcWZHUxuaDMhY=
X-Google-Smtp-Source: ABdhPJyHDpbSQR7yNuLB/WDehJjjnmJiVleRYdCPMur3bjeVV36E0PKWmLGbd0zLB0VR1xgJg0GtmA==
X-Received: by 2002:a17:906:115a:: with SMTP id i26mr13124196eja.10.1613939338771;
        Sun, 21 Feb 2021 12:28:58 -0800 (PST)
Received: from TRWS9215.usr.ingenico.loc ([88.245.22.54])
        by smtp.gmail.com with ESMTPSA id k27sm9124393eje.67.2021.02.21.12.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 12:28:58 -0800 (PST)
From:   Fatih Yildirim <yildirim.fatih@gmail.com>
To:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        gregkh@linuxfoundation.org, grandmaster@al2klimov.de
Cc:     Fatih Yildirim <yildirim.fatih@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next] staging: comedi dt2814: Removed unused variables
Date:   Sun, 21 Feb 2021 23:28:55 +0300
Message-Id: <20210221202855.12442-1-yildirim.fatih@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unused variables.

Signed-off-by: Fatih Yildirim <yildirim.fatih@gmail.com>
---
 drivers/staging/comedi/drivers/dt2814.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/comedi/drivers/dt2814.c b/drivers/staging/comedi/drivers/dt2814.c
index bcf4d5444faf..bd329d7b4893 100644
--- a/drivers/staging/comedi/drivers/dt2814.c
+++ b/drivers/staging/comedi/drivers/dt2814.c
@@ -186,21 +186,17 @@ static int dt2814_ai_cmd(struct comedi_device *dev, struct comedi_subdevice *s)
 
 static irqreturn_t dt2814_interrupt(int irq, void *d)
 {
-	int lo, hi;
 	struct comedi_device *dev = d;
 	struct dt2814_private *devpriv = dev->private;
 	struct comedi_subdevice *s = dev->read_subdev;
-	int data;
 
 	if (!dev->attached) {
 		dev_err(dev->class_dev, "spurious interrupt\n");
 		return IRQ_HANDLED;
 	}
 
-	hi = inb(dev->iobase + DT2814_DATA);
-	lo = inb(dev->iobase + DT2814_DATA);
-
-	data = (hi << 4) | (lo >> 4);
+	inb(dev->iobase + DT2814_DATA);
+	inb(dev->iobase + DT2814_DATA);
 
 	if (!(--devpriv->ntrig)) {
 		int i;
@@ -229,7 +225,6 @@ static int dt2814_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 	struct dt2814_private *devpriv;
 	struct comedi_subdevice *s;
 	int ret;
-	int i;
 
 	ret = comedi_request_region(dev, it->options[0], 0x2);
 	if (ret)
@@ -241,8 +236,8 @@ static int dt2814_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 		dev_err(dev->class_dev, "reset error (fatal)\n");
 		return -EIO;
 	}
-	i = inb(dev->iobase + DT2814_DATA);
-	i = inb(dev->iobase + DT2814_DATA);
+	inb(dev->iobase + DT2814_DATA);
+	inb(dev->iobase + DT2814_DATA);
 
 	if (it->options[1]) {
 		ret = request_irq(it->options[1], dt2814_interrupt, 0,
-- 
2.20.1

