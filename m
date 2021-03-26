Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD0834A3CA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhCZJKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhCZJKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:10:04 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3602EC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:10:04 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so5551792wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NTRDjOB0Z/XWkk3yB0atpiz7nFAoEAEsKk8b97HqiF4=;
        b=bAVfC9smoc/GoiPdohSLl1LGwUjJWSKELqk5eIpnhC/OaNb8662/YKOZUujOWa8h7Y
         bPd3lXPh73b/E7DYess+eeUQ59THsw+fBJqLXGCBFy2fd8TwaTtGvihCFm4sJ/61wSdp
         xdj6pOwspCqUEb3rRSBc3vmHED/3B6HdFhpz98KVCdCqid1mMD1OZC5lqvbl9uEqwhH/
         giDib/QOJzvo+x4E6D2agtIRzjflQqrDA2UTQ3xNavS9kUDs803JVXzut4FFsAfCvdiC
         fIKfQ5+yf31knWE9k56avQKmTOchgWaqE4ENmCgGH0wsTfp7D8NXxYrP9GmtnfWyN43l
         IM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NTRDjOB0Z/XWkk3yB0atpiz7nFAoEAEsKk8b97HqiF4=;
        b=pocZhIckDX73OVF6kyvQuI4qox/8Ib8ymF7ghyOgy3JwB2nrC6eGl0zWlH9l3qp1ui
         ijyxhOOGahkss4tCIowQk4Qk5K+Sgo7UgSdfJCRw+u8FrWH+e3mORUQkKY5UjrBw7CS8
         XaCMs5qIykKnLV631V4cPkOlFgQN9WWO74VVWNXvfDgTIttc44YFMVlu64az940sYY4Y
         64G91b806k7jDRtuOju6INmUa8/eBUZhv3FIyY4eJP2dMU/gTu22Zxey6NZKAxq26HXD
         ZE204HutLgWoqT8kM3ImeJVlov6vrUJae9BmHUVA25RfKccTUwxPxGv++4wWgToHZuYN
         cgzw==
X-Gm-Message-State: AOAM5303NnuhIy/dS0V/PPIE4/tK5PoKlaDaf2OikssMYfEvZR8yiSqT
        UWqmDnKZpFo+yQ4E5hBx8yI=
X-Google-Smtp-Source: ABdhPJzvYoM3bWgJwFrjKJrXuCIwb2scEh8foTUS9y5Y5EHK/j1fjR7+rvUxcFbtnZHjYGGwSryJpA==
X-Received: by 2002:a7b:c3cd:: with SMTP id t13mr11862633wmj.109.1616749802846;
        Fri, 26 Mar 2021 02:10:02 -0700 (PDT)
Received: from agape ([5.171.81.75])
        by smtp.gmail.com with ESMTPSA id v3sm10014726wmj.25.2021.03.26.02.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:10:02 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 14/15] staging: rtl8723bs:  put parentheses on macros with complex values in include/sta_info.h
Date:   Fri, 26 Mar 2021 10:09:21 +0100
Message-Id: <24e684c1eff8911dacff1b61957ce25bafc46631.1616748885.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616748885.git.fabioaiuto83@gmail.com>
References: <cover.1616748885.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch warnings:

ERROR: Macros with complex values should be enclosed in parentheses
284: FILE: drivers/staging/rtl8723bs/include/sta_info.h:284:
+#define STA_RX_PKTS_ARG(sta) \
--
ERROR: Macros with complex values should be enclosed in parentheses
289: FILE: drivers/staging/rtl8723bs/include/sta_info.h:289:
+#define STA_LAST_RX_PKTS_ARG(sta) \
--
ERROR: Macros with complex values should be enclosed in parentheses
294: FILE: drivers/staging/rtl8723bs/include/sta_info.h:294:
+#define STA_RX_PKTS_DIFF_ARG(sta) \

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/sta_info.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/sta_info.h b/drivers/staging/rtl8723bs/include/sta_info.h
index abde3e3df988..1cdf93ec3b66 100644
--- a/drivers/staging/rtl8723bs/include/sta_info.h
+++ b/drivers/staging/rtl8723bs/include/sta_info.h
@@ -282,19 +282,19 @@ struct sta_info {
 	} while (0)
 
 #define STA_RX_PKTS_ARG(sta) \
-	sta->sta_stats.rx_mgnt_pkts \
+	(sta->sta_stats.rx_mgnt_pkts \
 	, sta->sta_stats.rx_ctrl_pkts \
-	, sta->sta_stats.rx_data_pkts
+	, sta->sta_stats.rx_data_pkts)
 
 #define STA_LAST_RX_PKTS_ARG(sta) \
-	sta->sta_stats.last_rx_mgnt_pkts \
+	(sta->sta_stats.last_rx_mgnt_pkts \
 	, sta->sta_stats.last_rx_ctrl_pkts \
-	, sta->sta_stats.last_rx_data_pkts
+	, sta->sta_stats.last_rx_data_pkts)
 
 #define STA_RX_PKTS_DIFF_ARG(sta) \
-	sta->sta_stats.rx_mgnt_pkts - sta->sta_stats.last_rx_mgnt_pkts \
+	(sta->sta_stats.rx_mgnt_pkts - sta->sta_stats.last_rx_mgnt_pkts \
 	, sta->sta_stats.rx_ctrl_pkts - sta->sta_stats.last_rx_ctrl_pkts \
-	, sta->sta_stats.rx_data_pkts - sta->sta_stats.last_rx_data_pkts
+	, sta->sta_stats.rx_data_pkts - sta->sta_stats.last_rx_data_pkts)
 
 #define STA_PKTS_FMT "(m:%llu, c:%llu, d:%llu)"
 
-- 
2.20.1

