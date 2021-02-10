Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2813169A1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 16:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhBJPBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 10:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbhBJPAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 10:00:53 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C478C061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 07:00:12 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id g10so2969813wrx.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 07:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+TsCv5JLxVLTrn5tdQZ7PWqPRydG1WyX4P4IhWeL27c=;
        b=MODky0j7fors6ZNV0gwEQgKiBbKnnpTDfbRNatUg9oMH/sGKT7HBtewWnKbNtnYdiV
         1JRNFRfbzuV3KkudeBLiEJZ2psl3ubPQDoM1GyscuTeN99JF9yebF2892EFN+vdH0pfL
         soAJKsGAasrF7pGg0WITy8JQCEB40mnPe6/rLUTSaHFMpBwq/jSX+TGuSGr94UmimDai
         Ti5NqCg2eYWuBbZfIC33Vaeluefo7tFEY5HECvOdHYfL2HPb70jqgoZoSeMPtmR1UrPs
         MnBQeSxb6OazoTywXlGZ8jioQMZDIMTdUW/5dWUo3vmsaXgL42l6q3IgjnmvjyISKmhG
         Rd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+TsCv5JLxVLTrn5tdQZ7PWqPRydG1WyX4P4IhWeL27c=;
        b=i3ziCmiUQlVLedC3jKzcLRhfGn7x8gblelm0z3zDPKP7JDzNIPNu6171gUMiCpOXje
         0UOJbV5XrGjdkwkbc0msQ6MaECYfkiWdUji5AOdPze9daJBWCfFObXY8J3Yr1AXd+cH2
         3qZskBNaHOuKCV5hZSYqutm+3XrEjP6xjtQJbYkG2+HOupv/iBrbPP85x07/H5Ybyy4v
         +DMWl4fLkjKtErH46N7oxajZyY/Ka5J69gNYc5pVJuC9pVYiMn1qnUeXakkZhNUHu+xv
         W5HaTDl4PwoMTTBKoc7HJgI9zRHeDyuxteA7xkywK4wjDc6N5myAZYb+RqKAB49cpOKk
         gLjw==
X-Gm-Message-State: AOAM531iOummvUHvO6AjcXMkH7G2cH90k7h7eEynaSw1HDGK280ueJAa
        ppWHEA1g4U2K3IxzQ5viNvY=
X-Google-Smtp-Source: ABdhPJxHf5Qn5nbWHtZcmniPlrCRYdBXitlIOetfhvRh3asq13R8PBtTa5Mg2zQTB1DhGN9RYeRxzQ==
X-Received: by 2002:adf:a50c:: with SMTP id i12mr2542756wrb.299.1612969211124;
        Wed, 10 Feb 2021 07:00:11 -0800 (PST)
Received: from localhost.localdomain ([154.72.150.126])
        by smtp.gmail.com with ESMTPSA id j7sm3615744wrp.72.2021.02.10.07.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 07:00:10 -0800 (PST)
From:   Mairo Paul Rufus <akoudanilo@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     trivial@kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Mairo Paul Rufus <akoudanilo@gmail.com>
Subject: [PATCH] staging: wlan-ng: Fix comments typos
Date:   Wed, 10 Feb 2021 15:59:52 +0100
Message-Id: <20210210145952.722586-1-akoudanilo@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mairo Paul Rufus <akoudanilo@gmail.com>
---
 drivers/staging/wlan-ng/p80211netdev.c | 2 +-
 drivers/staging/wlan-ng/prism2mib.c    | 2 +-
 drivers/staging/wlan-ng/prism2sta.c    | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
index 7b091c5a2984..4a6813e89916 100644
--- a/drivers/staging/wlan-ng/p80211netdev.c
+++ b/drivers/staging/wlan-ng/p80211netdev.c
@@ -274,7 +274,7 @@ static void p80211netdev_rx_bh(unsigned long arg)
 	struct sk_buff *skb = NULL;
 	struct net_device *dev = wlandev->netdev;
 
-	/* Let's empty our our queue */
+	/* Let's empty our queue */
 	while ((skb = skb_dequeue(&wlandev->nsd_rxq))) {
 		if (wlandev->state == WLAN_DEVICE_OPEN) {
 			if (dev->type != ARPHRD_ETHER) {
diff --git a/drivers/staging/wlan-ng/prism2mib.c b/drivers/staging/wlan-ng/prism2mib.c
index 7d7d77b04255..875812a391c9 100644
--- a/drivers/staging/wlan-ng/prism2mib.c
+++ b/drivers/staging/wlan-ng/prism2mib.c
@@ -292,7 +292,7 @@ int prism2mgmt_mibset_mibget(struct wlandevice *wlandev, void *msgp)
 	/*
 	 ** Determine if this is a "mibget" or a "mibset".  If this is a
 	 ** "mibget", then make sure that the MIB may be read.  Otherwise,
-	 ** this is a "mibset" so make make sure that the MIB may be written.
+	 ** this is a "mibset" so make sure that the MIB may be written.
 	 */
 
 	isget = (msg->msgcode == DIDMSG_DOT11REQ_MIBGET);
diff --git a/drivers/staging/wlan-ng/prism2sta.c b/drivers/staging/wlan-ng/prism2sta.c
index 8f25496188aa..e6dcb687e7a1 100644
--- a/drivers/staging/wlan-ng/prism2sta.c
+++ b/drivers/staging/wlan-ng/prism2sta.c
@@ -461,7 +461,7 @@ u32 prism2sta_ifstate(struct wlandevice *wlandev, u32 ifstate)
 		case WLAN_MSD_FWLOAD:
 			wlandev->msdstate = WLAN_MSD_RUNNING_PENDING;
 			/* Initialize the device+driver for full
-			 * operation. Note that this might me an FWLOAD to
+			 * operation. Note that this might me an FWLOAD
 			 * to RUNNING transition so we must not do a chip
 			 * or board level reset.  Note that on failure,
 			 * the MSD state is set to HWPRESENT because we
@@ -1352,7 +1352,7 @@ void prism2sta_processing_defer(struct work_struct *data)
 		 * we get back in range.  We should block transmits and
 		 * receives in this state.  Do we need an indication here?
 		 * Probably not since a polling user-mode element would
-		 * get this status from from p2PortStatus(FD40). What about
+		 * get this status from p2PortStatus(FD40). What about
 		 * p80211?
 		 * Response:
 		 * Block Transmits, Ignore receives of data frames
-- 
2.26.2

