Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C17640CD1E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 21:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhIOTWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 15:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhIOTWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 15:22:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C06C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 12:21:25 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b6so5531349wrh.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 12:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=DOXV/L0FMmr2vq6xpFbmxxs1V6wMYY7kaHkXwiiZy2o=;
        b=hGO3sQXGCTX/wFkw30BiIrZ6mp66oOQez9imBZzrY3Rja4NpG4qSK+v+olv8ffWQJy
         yESY4vsV/cBus/IXTTP/apxRMX0yd6PDWhs7w063GhXbV3p8amcnykab99CN4fidzAQ/
         82gEPvambYXXVG+6PlG6Z1B4scn9jLkxTygd2JSIPmpHkdu/Y4+iDtQnQ0qV2WOrFJbf
         1Os4XvksK642iNzwJyedJRIilOc1vfVyqIy7ea+Xp5/uEGCvSz5yUpLCokV1XEVjBhoO
         6lzfI0tuynYvnkb89s6GtaLDV3mZjvH+3Dntkpi8CDutxVXvrV+fybp1yGn1LxihvP6G
         YMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=DOXV/L0FMmr2vq6xpFbmxxs1V6wMYY7kaHkXwiiZy2o=;
        b=6ivOduW4GDxHIxTUtZqP7f/GUgpzGeROu8/Hurej0iPTHsBET3ay++biOJ2L/JaFG3
         t45T6OdVLSibHCHieEiqBePKrwWo/h5wFYg1bov3htqgaU0TdvG/o+XbuObBXU9gdmdA
         VJDhuHZXe9EebbM51joEqge5N9NCbSK0gX8SkaVFOrK4k0VRtokLRA/c6ZGdGDH5rSoH
         dRPQ8We7qwO4j/Emk3CGNEsLp3pMa47pptCYYcNDmCTwMJizQ5kAQejg8m/aBfn4o91P
         pLVdR8TnYwe0OjWf5RDjFiXgeatFkMM1kKh/tnn5pKuqFplPmajTecaEU5Vq59wj8HqD
         QWHw==
X-Gm-Message-State: AOAM532SPY8ytfD0TolplTGrgEHA16ZuPCJ5EhysaSpd79LQOQU+rvTC
        8+mqvZD8VlJziLMk/+a2xtUk9dBrLlY=
X-Google-Smtp-Source: ABdhPJweCSvaNEhZ+MJ/Ea+cv7pXsnOUTNxstxAQxAbclX5WpYiqOhnkCA0AKg3ysw3/7uXJ02q7lg==
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr1792035wrs.316.1631733684096;
        Wed, 15 Sep 2021 12:21:24 -0700 (PDT)
Received: from peggy-InsydeH2O-EFI-BIOS ([129.0.102.24])
        by smtp.gmail.com with ESMTPSA id i27sm5029252wmb.40.2021.09.15.12.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 12:21:23 -0700 (PDT)
Date:   Wed, 15 Sep 2021 20:21:10 +0100
From:   Tawah Peggy <tawahpeggy98@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wlan-ng: cfg80211: Fix lines should not end with
 '('.
Message-ID: <20210915192110.GA325036@peggy-InsydeH2O-EFI-BIOS>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning;
CHECK:lines should not end with '('.
by replacing  ieee80211_frequency_to_channel()
 with ieee80211_freq_to_channel()

Signed-off-by: Tawah Peggy <tawahpeggy98@gmail.com>
---
 drivers/staging/wlan-ng/cfg80211.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index 7951bd63816f..d00f1c48e1a9 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -328,8 +328,7 @@ static int prism2_scan(struct wiphy *wiphy,
 		(i < request->n_channels) && i < ARRAY_SIZE(prism2_channels);
 		i++)
 		msg1.channellist.data.data[i] =
-			ieee80211_frequency_to_channel(
-				request->channels[i]->center_freq);
+			ieee80211_freq_to_channel(request->channels[i]->center_freq);
 	msg1.channellist.data.len = request->n_channels;
 
 	msg1.maxchanneltime.data = 250;
@@ -449,7 +448,7 @@ static int prism2_connect(struct wiphy *wiphy, struct net_device *dev,
 
 	/* Set the channel */
 	if (channel) {
-		chan = ieee80211_frequency_to_channel(channel->center_freq);
+		chan = ieee80211_freq_to_channel(channel->center_freq);
 		result = prism2_domibset_uint32(wlandev,
 						DIDMIB_DOT11PHY_DSSSTABLE_CURRENTCHANNEL,
 						chan);
-- 
2.25.1

