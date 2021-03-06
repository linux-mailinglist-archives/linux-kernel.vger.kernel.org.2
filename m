Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2504932FDAF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 23:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhCFWNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 17:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhCFWMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 17:12:52 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9AFC06175F
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 14:12:51 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id p5so3132667plo.4
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 14:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7MGR4tp7113VprvERcZazEvUbTtIdBfVouZlCmQkY0=;
        b=W69RTXonP1fds/GcIu/bkUaKdrmw6W0tcMcyiAPtrnItsml0CNWNtBi6EWpcFBPOPF
         BbIzIEUTbZ0mNbKeb1W7YEqeEJR1ANXzgjGM3HjK8jljKQu+FgoiD101/9ATvzxidi/v
         6aPsaIjbvVUXGapB9Yiq4CxOfJp4rmHqjh7RM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7MGR4tp7113VprvERcZazEvUbTtIdBfVouZlCmQkY0=;
        b=biCHpv179mq4Zn2YL7pZzzBVKanTczDV794sRLMjBzrbVldZlQDJHPGV3hbOEaG3ei
         qoKmcvmJZBVGr4aSoZbOh6FOskyF1dNJInvs08G6kh9VnZuDYgl+QnIbxBk1RfrbO2VM
         Y2oQPquG+ao4+/yxoFAgp8B/P120YmrSVYdQ2pKiGZskd3Qtx1X0frtCiV9caspnPhpO
         FvXhPLWQfYAOH55CKgNcVFeQXmbyP4aP/93l9t+SzyEYKTa8JyVo49okHNamyVsMVERk
         BLQsWV4tHPae2jE2GUia5KCeG6BSIL39iLFkNCC/CMnSFoDtECsv1oEnrp/qTBTPhbTS
         bjig==
X-Gm-Message-State: AOAM532jfNNM+F7TTlYk6nIf4klyvHX//KgPbow10Aj3NgTzOxak7Cx2
        rFwAE4XHSx4iMg3OOdRJaCh8ew==
X-Google-Smtp-Source: ABdhPJyQJuStOVPAVNxLQKM0F/hD8RTA94a4og2w0dk3TocJDb3fHWzmLFoPbmTPXqO0DtsJlm2fVQ==
X-Received: by 2002:a17:90a:16d7:: with SMTP id y23mr17876263pje.227.1615068771551;
        Sat, 06 Mar 2021 14:12:51 -0800 (PST)
Received: from grundler-glapstation.lan ([2600:1700:3ec2:905f:9c5:ceb0:502e:f28d])
        by smtp.gmail.com with ESMTPSA id n125sm5763198pfn.21.2021.03.06.14.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 14:12:51 -0800 (PST)
From:   Grant Grundler <grundler@chromium.org>
To:     Oliver Neukum <oneukum@suse.com>, Jakub Kicinski <kuba@kernel.org>
Cc:     Roland Dreier <roland@kernel.org>, nic_swsd <nic_swsd@realtek.com>,
        netdev <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Grant Grundler <grundler@chromium.org>
Subject: [PATCH net-next] net: usb: log errors to dmesg/syslog
Date:   Sat,  6 Mar 2021 14:12:32 -0800
Message-Id: <20210306221232.3382941-2-grundler@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210306221232.3382941-1-grundler@chromium.org>
References: <20210306221232.3382941-1-grundler@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Errors in protocol should be logged when the driver aborts operations.
If the driver can carry on and "humor" the device, then emitting
the message as debug output level is fine.

Signed-off-by: Grant Grundler <grundler@chromium.org>
---
 drivers/net/usb/usbnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Reposting to net-next per instructions in https://www.spinics.net/lists/netdev/msg715496.html

I've applied this patch to most chromeos kernels:
    https://chromium-review.googlesource.com/q/hashtag:usbnet-rtl8156-support

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 1447da1d5729..bc7b93399bd5 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -887,7 +887,7 @@ int usbnet_open (struct net_device *net)
 
 	// insist peer be connected
 	if (info->check_connect && (retval = info->check_connect (dev)) < 0) {
-		netif_dbg(dev, ifup, dev->net, "can't open; %d\n", retval);
+		netif_err(dev, ifup, dev->net, "can't open; %d\n", retval);
 		goto done;
 	}
 
-- 
2.29.2

