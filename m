Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2EC40A137
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 01:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350259AbhIMXDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 19:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350233AbhIMXDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 19:03:33 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510CAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 16:02:17 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id n27so24461833eja.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 16:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=RJ675zc8F3Swo8C9yZyF7+m49sZmC7iizZr6Z819g9Y=;
        b=Tkqw6AYO9ktAElB8tmv/f8wHOeJLvR9Nkpc/i1i7tB5dXQfJl1NWPF/BpeXscvSd0G
         LC5ukv0EPBcPGQlpn7HcW0hm2PD76oYi87haTMFe2dIjlKIoRsJQNew4DNmWJ1e6w+QN
         MDcBLpWoMsyFCT9XP8wGDAPahpusDj3s6zt5WMZwlJ3IhlOHdFB3/aL/NvQrT1rkltb0
         gIbJzK4xlbHeFQZznVU0Wjh65hQJpe7rym3VBLJfeie7HqwkF3WXes+XfNgL03eZ8PA8
         ZPHaPapqtVwuXP3atNZzHy+OKUshcibpoiqJ0nIzQuU0iDyAntTRkxyFHy+xZI7TAmMF
         SoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=RJ675zc8F3Swo8C9yZyF7+m49sZmC7iizZr6Z819g9Y=;
        b=o9FEI0EX76aGiwH6OlEkT1d34Y5xUMjAZ3hQ5ZHgbuiUFnlvo5qfrtHNstRvreZ3LO
         nlaOY6tkXFqVMQYMl2QlWGpfHWEcnHgLRtv0QiAdA/p4umIL6TpaxYQVmJ379eCJqWY2
         LmMAkkUoSZzK3VSagpoU4ZDbe9sNnyYxysXprcEPkQI8LxJShw+Wa1MUh6mgOUp9GQaT
         j457YgdmGceW4haHT3OxPpkkfvonzXZePI6QMytqQuhngFRprXOv6c6D6+grcwnBRxx3
         NXATJxEqTgWwXdssw1ST23QPScNeejuwGPAAqfyVyf0gT+YPiO1OFgLCjkt2tdbB4BTJ
         pX2Q==
X-Gm-Message-State: AOAM532i36HplLBtJ9KWw6AQ4akyp4Z5nNzyO2iF0IvBymgSF6AdgPHn
        3A4zdVcnaK245hzjOy/RsatKl/4s080=
X-Google-Smtp-Source: ABdhPJzGUHHq7cFLnbyN1lmCQCpbLBtKo7Z9ZpGrpL6GQ29Rwb6K8OljTstq9lFTHibvK4iqnWeGGA==
X-Received: by 2002:a17:906:c246:: with SMTP id bl6mr15259610ejb.80.1631574135341;
        Mon, 13 Sep 2021 16:02:15 -0700 (PDT)
Received: from peggy-InsydeH2O-EFI-BIOS ([154.72.153.216])
        by smtp.gmail.com with ESMTPSA id x12sm3782428edd.51.2021.09.13.16.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 16:02:15 -0700 (PDT)
Date:   Tue, 14 Sep 2021 00:02:11 +0100
From:   Tawah Peggy <tawahpeggy98@gmail.com>
To:     Kroah-Hartman <greg@kroah.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wlan-ng: cfg80211: replace
 ieee80211_frequency_to_channel with ieee80211_freq_to_channel.
Message-ID: <20210913230211.GA63982@peggy-InsydeH2O-EFI-BIOS>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes ieee80211_frequency_to_channel(channel->center_freq)
to ieee80211_frequency_to_channel(channel->center_freq) because the
function name has originally been changed in a patch in other to fix a
checkpatch error.

Signed-off-by: Tawah Peggy <tawahpeggy98@gmail.com>
---
 drivers/staging/wlan-ng/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index 711c88c59e78..d00f1c48e1a9 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -448,7 +448,7 @@ static int prism2_connect(struct wiphy *wiphy, struct net_device *dev,
 
 	/* Set the channel */
 	if (channel) {
-		chan = ieee80211_frequency_to_channel(channel->center_freq);
+		chan = ieee80211_freq_to_channel(channel->center_freq);
 		result = prism2_domibset_uint32(wlandev,
 						DIDMIB_DOT11PHY_DSSSTABLE_CURRENTCHANNEL,
 						chan);
-- 
2.25.1

