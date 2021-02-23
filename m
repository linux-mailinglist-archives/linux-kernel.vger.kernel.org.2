Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86197322E00
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbhBWPvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbhBWPu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:50:58 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B0DC061786;
        Tue, 23 Feb 2021 07:50:12 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id w7so480727wmb.5;
        Tue, 23 Feb 2021 07:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eQwe9NJal+9xVku41hj0jNRXaZ5etqUoeLkfgTJjhEE=;
        b=k9s0F1WdPXhOc6rInvcXG1IfKqZ1aerGl43gEGEk5apTwif5AKr+DWB3P4dc3Q+bZl
         r0ODdjWLkd2GmC+U2yaUltCW2oCEiBcCRMW9a+0d27T9R/PoShHvFBBt3c7bLaiMN36J
         l6NITLjIEUyEAldgvpbrC5yKJ7UcT1PKjo7SmjhOVqDzRR4DLoj1ZJq0v6sbbRln9mFS
         2T+M6g4pOu71prEVTKJVSYvjB3gp5sbEy+xAwwacJeRKIQ0iF9jyL4s2T33vq55FBX16
         amWb8FBPZSAKO0cJaHLrGig/7dajuAM7ae978VDo2Xj7Dx2FNfJ3oOeefsQEnQHeegA1
         Bulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eQwe9NJal+9xVku41hj0jNRXaZ5etqUoeLkfgTJjhEE=;
        b=q8kjCiHicLexpDcEe36xM5hc7PrJh9Ufcv9se996BdUhuN8ndyZjrIyaRA7GBMf+RJ
         WbENE/n4BcOdXQBzGyXMrt9Bz9Sx30+n3YaDeFBUUcQktmBNsuaZsJwr60Fq56mGKaLN
         scJVn37URv7wX4Z+4LUPSQVIvjRX912nosptS9l2oQUr2RiR04B+x3+BgJp27WwEVLhD
         69KIDbBJye6/pky265QtDsEdDar2fRJFVxe3BM1exspkPAJzkS5fLB6e5DVPoYaKdUC4
         13Gh/rAZDAHlDcx1rLzOt6LMmw+oNQL46Uka9qiNuA5WSEWizSfSXvjVP2rJCzX67iYx
         jvaQ==
X-Gm-Message-State: AOAM532MS9ACcqMq24ApxjC0le+ToN+XsCUTZPIJo7Y5WoZsVXwpCf5F
        doX4kONPEO1KFgdABJOvFvM=
X-Google-Smtp-Source: ABdhPJwJuLRCrJYSWXYea/XMr57BFa8YkfoPAnCwVgavZ+Kir/O1G9q1OlnbBvOxVICSUe+aTcNFnA==
X-Received: by 2002:a1c:1b4d:: with SMTP id b74mr10310085wmb.31.1614095410680;
        Tue, 23 Feb 2021 07:50:10 -0800 (PST)
Received: from skynet.lan (170.red-88-1-105.dynamicip.rima-tde.net. [88.1.105.170])
        by smtp.gmail.com with ESMTPSA id t23sm3209201wmn.13.2021.02.23.07.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 07:50:10 -0800 (PST)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     f.fainelli@gmail.com, jonas.gorski@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Prisk <linux@prisktech.co.nz>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 2/2] usb: host: ehci-platform: add ignore-oc DT support
Date:   Tue, 23 Feb 2021 16:50:05 +0100
Message-Id: <20210223155005.21712-3-noltari@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210223155005.21712-1-noltari@gmail.com>
References: <20210223155005.21712-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Over-current reporting isn't supported on some platforms such as bcm63xx.
These devices will incorrectly report over-current if this flag isn't properly
activated.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/usb/host/ehci-platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index a48dd3fac153..f8e58372f7fe 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -286,6 +286,9 @@ static int ehci_platform_probe(struct platform_device *dev)
 		if (of_property_read_bool(dev->dev.of_node, "big-endian"))
 			ehci->big_endian_mmio = ehci->big_endian_desc = 1;
 
+		if (of_property_read_bool(dev->dev.of_node, "ignore-oc"))
+			ehci->ignore_oc = 1;
+
 		if (of_property_read_bool(dev->dev.of_node,
 					  "needs-reset-on-resume"))
 			priv->reset_on_resume = true;
-- 
2.20.1

