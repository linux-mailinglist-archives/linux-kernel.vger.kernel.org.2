Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBBE409BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 20:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346477AbhIMSF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbhIMSF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:05:26 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B223C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:04:10 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id j13so15636372edv.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Fsbje8F1pW32+ZfIecam+8RLNkt/s56842lLWFPAzCM=;
        b=HNss1m/u0RI3QLd5LOqVZMUI9jjmGGFLt4SasEnP5iJZhvd/RiLARyjcnVr0KAX8Uh
         FQHoMSO5vmFtInXUSXPT7VNCHow0pRTaMkQ6zE11OYejfyKUdjyi6E8qIgNZkcbvkNwa
         /vP40jQ5DCPuPI+cahzbz12Ftu+d87IkBVTRhGxXbDGMEyjVuKrNxBMklbgSy2aa4jf6
         cC48rX2cWmx7zPky9MtBVVNH4sK5Q2zpzsSOt1CECY2Ox2SPVv+YAMRQmP7OEtL1TcJ6
         IvLO0RCy9p5jkqTCte2EmHqO/89KOzbgtU+LkO5oznfhXA2f3PDHuc9gdYNrRe1BMz7V
         UDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Fsbje8F1pW32+ZfIecam+8RLNkt/s56842lLWFPAzCM=;
        b=Y639vLHiipq07SwX28vXeRxyBo/iEC6p+2YnRKRhEKMUpJw2eQXhk8NJksI4rtwKIx
         LZiUkBdmLgYNuQ8Ncni+q2u/gpiOZo9FUu6Zl8F3aikoopYj0tt7oIYnbwo6Pp/jCOG4
         bSoYJwjZpy9JXQpCfKOKp02axc+dHxjPZ0C/qEnUKF1sKddlSKlEiQEPKP/S1FCOaoik
         Y+osZrGTCv8+bcYBf++AwmT7NISg25V/H3qND+LwnIvau8uBD5ZBaxzoFzRbgVP76lP1
         VqxiLK3l+UQmV13he3sIauL6Zjq+qwCe6e7/dGa67evqEEqDPKyMnlBMHiaDrG+CzmIa
         vLDg==
X-Gm-Message-State: AOAM531jObGSj52VllJRyxPp9sVezmJ4ZTKwN0Y2y0DjEIEoNZXa0LD8
        VCpHxIDkPcSocEBy3Hg6dnDcPPnlZ6w=
X-Google-Smtp-Source: ABdhPJwh3gUaWqXnBfz6oU/a6c6RejP73s+t1COiPJbISRd5pf2H6CMFqg5YAw+I6tECyrOAEYZufg==
X-Received: by 2002:a05:6402:455:: with SMTP id p21mr14404637edw.309.1631556248923;
        Mon, 13 Sep 2021 11:04:08 -0700 (PDT)
Received: from peggy-InsydeH2O-EFI-BIOS ([154.72.153.216])
        by smtp.gmail.com with ESMTPSA id h13sm4265502edr.4.2021.09.13.11.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:04:08 -0700 (PDT)
Date:   Mon, 13 Sep 2021 19:04:04 +0100
From:   Tawah Peggy <tawahpeggy98@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kroah-Hartman <greg@kroah.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] Staging:wlan-ng:cfg80211: A better fix for: Lines should
 end with a '('
Message-ID: <20210913180404.GA325222@peggy-InsydeH2O-EFI-BIOS>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Bcc: 
Subject: [PATCH v2] Staging: wlan-ng: cfg80211: A better fix for: Lines should
 not end with a '('.
Reply-To: 

This patch fixes the checkpatch error : lines should not end with a '('
by reducing length of function name to enable the arguments be passed on a single line.

Signed-off-by: Tawah Peggy <tawahpeggy98@gmail.com>
---
 drivers/staging/wlan-ng/cfg80211.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index 7951bd63816f..711c88c59e78 100644
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
-- 
2.25.1

