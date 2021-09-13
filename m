Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F931409F75
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 00:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245124AbhIMWJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 18:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhIMWJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 18:09:58 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83A0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 15:08:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i21so24264646ejd.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 15:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ncdS0KUMlVwysZycr1aFAHBiBQlBAALFdQ8u91HuEWI=;
        b=n7q8ruAuNt/mfWwn1j5d91PBpL6sW3pIAvv0fz92PDYYC++soY+HXzOCs0usaVvCSV
         id0Qb8XR2crdBH8Yg90uvzshJTvYgXLtq6xE4VhKuFFwgg+H468k6d4aKucNIrtY45xr
         G8r27ndC4jJPVOP26zz/jHCpkvasTgAveQHtfqyzOVge8490r2EW8xZFOsbpGx8tCiBN
         ED0032hB8OT0QSO/kNh4JQh6il709RlJktYu24HHk/8BqP2CZry3ThPG/qhIyHlTs0se
         B0V4X2Wxx5K4NIHyvSasBHsKhWw4kQkklbwSAINH1htjApF9ExFyknVFffI/6nq9ai+s
         K/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ncdS0KUMlVwysZycr1aFAHBiBQlBAALFdQ8u91HuEWI=;
        b=2eVRHqSH+ipBNxQ5fTJCdA+SymPymuEA92xOKVBVc0fiSIFSPdp0BfBTzlND7YG7aR
         d/EjUv+/xaEGclESC6eTU4Ifwxsz1/3YdjVnI8sTfEXAgZhmaX/VzjxAGX/756OVV5bO
         HVvN0isXJ/dTuXNSIl9cukEgCw6AkqyeG0BQMXZ+bJDylX/r1A+4m2CMcrBXsWtfjFrI
         GiDyg1AMr5ANh1ggRoPwqqi64nITvWPVqUnp86YgjacFvTNWHFiYmMuA6/DLhzeSTQ7f
         eJ85uNobWAhu3iE6wb/tH1nmVM9rqZzrkMCNEiSaBZg2Wi6VLpCxTEk6wJUZOfz3YwwF
         Rcog==
X-Gm-Message-State: AOAM5316Ce7CX+eX+UoA3/pUTl8LxQNRe3YtBsgnZYNZZpNpuuCDWbw9
        8xnbHAq2LHLzItw4ftlZur+Tu4FDApg=
X-Google-Smtp-Source: ABdhPJxa3NBLOXRhVkQbETa8rLRdWEkeVZrpJnssFU2jPCK/HbZkYKvDjtRiwefli2xslLHK/ljy2g==
X-Received: by 2002:a17:906:d1d6:: with SMTP id bs22mr15448527ejb.554.1631570920109;
        Mon, 13 Sep 2021 15:08:40 -0700 (PDT)
Received: from peggy-InsydeH2O-EFI-BIOS ([154.72.153.216])
        by smtp.gmail.com with ESMTPSA id j14sm4581929edk.7.2021.09.13.15.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 15:08:39 -0700 (PDT)
Date:   Mon, 13 Sep 2021 23:08:36 +0100
From:   Tawah Peggy <tawahpeggy98@gmail.com>
To:     Kroah-Hartman <greg@kroah.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3] Staging: wlan-ng: cfg80211: A better fix for: Lines
 should not end with a '('.
Message-ID: <20210913220836.GA3790@peggy-InsydeH2O-EFI-BIOS>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

