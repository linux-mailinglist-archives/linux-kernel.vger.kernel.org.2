Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCD7355F33
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 01:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbhDFXCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 19:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbhDFXCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 19:02:41 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A66C061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 16:02:32 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id v26so17286580iox.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 16:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rj2YYKWiwju3STdIjVvck7gwFTWKqKlbS/8vOJQzblA=;
        b=LjPAMgX4jEAvs46Pjf+qHRP61100oZ9gBFh8LuXJOqZ/+4s8Zd7eKgheo4sK3oKHxp
         sERChtROH5w8X7WVNvCbc9ajll7IY7lboMEg6i3jClONPUzB2iYndamvcV+rGEXvyM0V
         /w8r4v1KClZJ774YmtCVlMsESIJiTR57hldq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rj2YYKWiwju3STdIjVvck7gwFTWKqKlbS/8vOJQzblA=;
        b=AMI/3O53ovbU4+qKSnINvDDXBWaWwSc3lU08ACyFLV0nRbuL5vUxCoQuspuPztIoGm
         pOPhdM5BGOsmc7lN4j9gqDtfJoUAODwzSKKaJNKhqkfFrgexz/ouIvSSyNG67QaCiH2e
         +O2Bjkkq8eLPaifxCu2DHQIC4NxYAw0ZJQBSrOB8DabjMHoTRdr5Tv+D0OnG0rP5j9VX
         b9Cyk7zZ43lapxeDSJ0iNX4TLAJMZTEoOccoIv8us8ls52WRsIeeicwNPSNu9bOh8P8Z
         eLFUEgAoLSLNQ+Uu/6Nj8hIWhA58lodV1v7uKGVeWpFxH9mn6C6SIuzPoVknNFOw4juL
         bV1A==
X-Gm-Message-State: AOAM533l7uUa/zaVUk6U2trdN+4IgRPZ8+Of2dVxQp55Fn29wkKv1lzw
        I8dKuKIMZCbWnt44NC+xl52sxg==
X-Google-Smtp-Source: ABdhPJyIpJDK8H7I6Uevy94NM3CzpZpJax71iCAYlQWB3ZvcOLnBm9cU/gL+ZTjIV0swPVXh0JIGew==
X-Received: by 2002:a05:6638:343:: with SMTP id x3mr522607jap.44.1617750151432;
        Tue, 06 Apr 2021 16:02:31 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z10sm13186097ilq.38.2021.04.06.16.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 16:02:30 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: [PATCH] ath10k: Fix ath10k_wmi_tlv_op_pull_peer_stats_info() unlock without lock
Date:   Tue,  6 Apr 2021 17:02:28 -0600
Message-Id: <20210406230228.31301-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ath10k_wmi_tlv_op_pull_peer_stats_info() could try to unlock RCU lock
winthout locking it first when peer reason doesn't match the valid
cases for this function.

Add a default case to return without unlocking.

Fixes: 09078368d516 ("ath10k: hold RCU lock when calling ieee80211_find_sta_by_ifaddr()")
Reported-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index d97b33f789e4..7efbe03fbca8 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -592,6 +592,9 @@ static void ath10k_wmi_event_tdls_peer(struct ath10k *ar, struct sk_buff *skb)
 					GFP_ATOMIC
 					);
 		break;
+	default:
+		kfree(tb);
+		return;
 	}
 
 exit:
-- 
2.27.0

