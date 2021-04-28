Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA03836D966
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 16:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240226AbhD1OSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 10:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhD1OSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 10:18:24 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85D7C061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 07:17:37 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id y124-20020a1c32820000b029010c93864955so9360252wmy.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 07:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=ex4CEdE8hQUW3fUsf4MvYL21WztkQ++yVoCYzJV0AXY=;
        b=pLZqUW2joYuzGt0PK18OTNbsMpZYGuHV40Wc1naiNwNdyS7FLAcD8K258bf7QWiVkd
         QJ7AdPbUohXQ4tM+4ENaWSPjsa5jFWCiy2rwHD5q1WVpf7njN2ThkU9niig8uM4BQQEV
         R7ow0a9i9X4t6bJiCp0o9F/+6zSaKibkRCLOuip8ShyXj0D/ux/BDxBjM/GynjS6HKAw
         BwUGi7dYO2vZHotSntWIo6Q07S48iPC+nnzNkSJ/Y+UOLbx/ACydFpSHnO0NiCIbz3hj
         AdpwcR6MBEAINQCKKIij+D73G/DQ31CC1rpanWAbi+KRgzCExOMT6stoCv6avv8VMvdG
         H7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=ex4CEdE8hQUW3fUsf4MvYL21WztkQ++yVoCYzJV0AXY=;
        b=uAhSU6MJL8yuoOur6pGbVCiwlsJv9rULnkmhEGwfv8FCGec6T4h7arUVbdqb/T2EBP
         S++XEfMtjAF6juJz47cu1yOECBWnAozShhT/9Zbxax5Q8C/km0f4zsACDC/bnzNNA9Yw
         bo1Le3qZn4Q4S6UhCva8mw5V2w6FLH7qUk42M26lkNEy1r9nc22K5spNDySzYbSV/vfg
         q2rYitVmVIhZUOM20MHLKo58DLEbfYIg+EzNRLhZHRCHsh3LjIPnL1tNfynFTJcqsZMY
         Bf3NDs6ic+aXB2h3ET7Op/nTu8U+UUY5CJBQWeXSfJtyWYwnq+9JScKqRkk820U19X1T
         RoJg==
X-Gm-Message-State: AOAM5336uc0KZ/CewPmeCyfBMElpJ2jxNyXCLWpsYQA7IhHBv/qPm/Kg
        sUnGolhiWpAZht4LQaUMgFt28rvpYiWTAtsR
X-Google-Smtp-Source: ABdhPJy+F97zTGSMU9h/tJrR7nb3es1f0JLICj7YwbNp6NYsD38PRormihS5bak5KFaZgfmqaVuQrw==
X-Received: by 2002:a1c:5454:: with SMTP id p20mr4940590wmi.187.1619619456104;
        Wed, 28 Apr 2021 07:17:36 -0700 (PDT)
Received: from ubuntu (host86-178-35-221.range86-178.btcentralplus.com. [86.178.35.221])
        by smtp.gmail.com with ESMTPSA id p8sm142540wrm.14.2021.04.28.07.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 07:17:35 -0700 (PDT)
Date:   Wed, 28 Apr 2021 07:17:34 -0700
From:   Iain Craig <coldcity@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Merello <andrea.merello@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192u: fix typos in comments
Message-ID: <20210428141734.GA2498@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

correct spelling errors across 8 lines of comments.

Signed-off-by: Iain Craig <coldcity@gmail.com>
---
 .../rtl8192u/ieee80211/ieee80211_softmac.c       | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 965fa1fb5e1b..ab885353f668 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -33,9 +33,9 @@ short ieee80211_is_shortslot(const struct ieee80211_network *net)
 }
 EXPORT_SYMBOL(ieee80211_is_shortslot);
 
-/* returns the total length needed for pleacing the RATE MFIE
+/* returns the total length needed for placing the RATE MFIE
  * tag and the EXTENDED RATE MFIE tag if needed.
- * It encludes two bytes per tag for the tag itself and its len
+ * It includes two bytes per tag for the tag itself and its len
  */
 static unsigned int ieee80211_MFIE_rate_len(struct ieee80211_device *ieee)
 {
@@ -50,7 +50,7 @@ static unsigned int ieee80211_MFIE_rate_len(struct ieee80211_device *ieee)
 	return rate_len;
 }
 
-/* pleace the MFIE rate, tag to the memory (double) poined.
+/* place the MFIE rate, tag to the memory (double) pointer.
  * Then it updates the pointer so that
  * it points after the new MFIE tag added.
  */
@@ -436,7 +436,7 @@ void ieee80211_softmac_scan_syncro(struct ieee80211_device *ieee)
 		 *    So we switch to IEEE80211_LINKED_SCANNING to remember
 		 *    that we are still logically linked (not interested in
 		 *    new network events, despite for updating the net list,
-		 *    but we are temporarly 'unlinked' as the driver shall
+		 *    but we are temporarily 'unlinked' as the driver shall
 		 *    not filter RX frames and the channel is changing.
 		 * So the only situation in witch are interested is to check
 		 * if the state become LINKED because of the #1 situation
@@ -1162,7 +1162,7 @@ void ieee80211_associate_abort(struct ieee80211_device *ieee)
 
 	ieee->associate_seq++;
 
-	/* don't scan, and avoid to have the RX path possibily
+	/* don't scan, and avoid having the RX path possibly
 	 * try again to associate. Even do not react to AUTH or
 	 * ASSOC response. Just wait for the retry wq to be scheduled.
 	 * Here we will check if there are good nets to associate
@@ -1373,7 +1373,7 @@ inline void ieee80211_softmac_new_net(struct ieee80211_device *ieee, struct ieee
 		/* if the user set the AP check if match.
 		 * if the network does not broadcast essid we check the user supplyed ANY essid
 		 * if the network does broadcast and the user does not set essid it is OK
-		 * if the network does broadcast and the user did set essid chech if essid match
+		 * if the network does broadcast and the user did set essid check if essid match
 		 */
 		if ((apset && apmatch &&
 		     ((ssidset && ssidbroad && ssidmatch) || (ssidbroad && !ssidset) || (!ssidbroad && ssidset))) ||
@@ -2243,9 +2243,9 @@ static void ieee80211_start_ibss_wq(struct work_struct *work)
 	 * time to scan all the chans..) or we have just run up the iface
 	 * after setting ad-hoc mode. So we have to give another try..
 	 * Here, in ibss mode, should be safe to do this without extra care
-	 * (in bss mode we had to make sure no-one tryed to associate when
+	 * (in bss mode we had to make sure no-one tried to associate when
 	 * we had just checked the ieee->state and we was going to start the
-	 * scan) beacause in ibss mode the ieee80211_new_net function, when
+	 * scan) because in ibss mode the ieee80211_new_net function, when
 	 * finds a good net, just set the ieee->state to IEEE80211_LINKED,
 	 * so, at worst, we waste a bit of time to initiate an unneeded syncro
 	 * scan, that will stop at the first round because it sees the state
-- 
2.25.1

