Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCD633FBA5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 00:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhCQXEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 19:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhCQXEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 19:04:20 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829AEC06174A;
        Wed, 17 Mar 2021 16:04:20 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id l13so2724251qtu.9;
        Wed, 17 Mar 2021 16:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=k8yY4wMfz/LENmaebo7PkCgeIKOG+ARQM/9FSWSmfA4=;
        b=lCW5nw1cmMmIh6FfwdC5xqsBppuivRiC14wNdawTFLZceT6j6sAGmhk5HkHgTyPY1g
         QQZbj3Dg/V/9Pmxxw+JywsRRhpXBEfNabAufcfP57K6qOsljHD4vQaFkyjpyFCPRjb7l
         snGtIn8Sm4MNFAmNY03esOJZkgdGG2QUKH3tuhQbLCF9pSEZdkQ4WusPaVYZmzy+FAwK
         XjMWUTlNSAeTDEs2Yn6eL67xIq9noyW9HGHjsT+aBhOdzA+O9WNMb7mLv7R/UXrYblRM
         llzQgboWvT+yXIVeio86kMI6xhhwOHp26yp44GB5HrQTs5lKyZY6P8vv7sUI6tDWD3xE
         8ikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k8yY4wMfz/LENmaebo7PkCgeIKOG+ARQM/9FSWSmfA4=;
        b=Q0q6FSxKp13LGozab2FSPIL8dAEdzWuEV+rSHLoWxYuKeF81VRcqg93hfweYwef4PI
         iSNA85n0as+xVLtj1iZrLhyjMYb7oiJ/bH9jVq+ihC/OxmDlC+2WYYw7nPqQ1wjGppd6
         VpX3fQ6U3YmqEU7UyV9HrFId53Xgr2n+KbAd2RsWTkf4+0QVixNubJ0ABGR1EHLmOG2x
         /9WzNyi3Edrbj5xUBHIQzKLgHd9b8cixQYigvza/sFMMVMK6SlcpwQMV4b3AmVxng+gv
         +F0vI2p0jGPtM20Yb136Xw3xDMuZ5Ep0Ps5fWrK70FHUgv/hyBLhNaflXrK/p/fv88hH
         sQyQ==
X-Gm-Message-State: AOAM532wOIeI2xj5WQK1te4k0Nk9BEHHITlf6NHEbMfbQ2ZUEFd23czw
        bxd5jNl8jla5Rka9kkQ2LvIEvVGDYnK4Sg==
X-Google-Smtp-Source: ABdhPJwx+VpvXLgI7DOPECdygfB4vpMmus7519EOexFij5AvrJTWd5oTUKGfxGL85jol6pvaFkgZFw==
X-Received: by 2002:ac8:550b:: with SMTP id j11mr1264432qtq.360.1616022257781;
        Wed, 17 Mar 2021 16:04:17 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:d4e9:423a:4aca:b208])
        by smtp.googlemail.com with ESMTPSA id t24sm190192qto.23.2021.03.17.16.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 16:04:17 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Tong Zhang <ztong0001@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Raviteja Garimella <raviteja.garimella@broadcom.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: gadget: udc: amd5536udc_pci fix null-ptr-dereference
Date:   Wed, 17 Mar 2021 19:04:00 -0400
Message-Id: <20210317230400.357756-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YFJp+It0/f7O9YId@kroah.com>
References: <YFJp+It0/f7O9YId@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_dma_pools() calls dma_pool_create(...dev->dev) to create dma pool.
however, dev->dev is actually set after calling init_dma_pools(), which
effectively makes dma_pool_create(..NULL) and cause crash.
To fix this issue, init dma only after dev->dev is set.

[    1.317993] RIP: 0010:dma_pool_create+0x83/0x290
[    1.323257] Call Trace:
[    1.323390]  ? pci_write_config_word+0x27/0x30
[    1.323626]  init_dma_pools+0x41/0x1a0 [snps_udc_core]
[    1.323899]  udc_pci_probe+0x202/0x2b1 [amd5536udc_pci]

Fixes: 7c51247a1f62 (usb: gadget: udc: Provide correct arguments for 'dma_pool_create')
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
v2: add Fixes tag and revise subject

 drivers/usb/gadget/udc/amd5536udc_pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/amd5536udc_pci.c b/drivers/usb/gadget/udc/amd5536udc_pci.c
index 8d387e0e4d91..c80f9bd51b75 100644
--- a/drivers/usb/gadget/udc/amd5536udc_pci.c
+++ b/drivers/usb/gadget/udc/amd5536udc_pci.c
@@ -153,6 +153,11 @@ static int udc_pci_probe(
 	pci_set_master(pdev);
 	pci_try_set_mwi(pdev);
 
+	dev->phys_addr = resource;
+	dev->irq = pdev->irq;
+	dev->pdev = pdev;
+	dev->dev = &pdev->dev;
+
 	/* init dma pools */
 	if (use_dma) {
 		retval = init_dma_pools(dev);
@@ -160,11 +165,6 @@ static int udc_pci_probe(
 			goto err_dma;
 	}
 
-	dev->phys_addr = resource;
-	dev->irq = pdev->irq;
-	dev->pdev = pdev;
-	dev->dev = &pdev->dev;
-
 	/* general probing */
 	if (udc_probe(dev)) {
 		retval = -ENODEV;
-- 
2.25.1

