Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EEB35FA89
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352794AbhDNSNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbhDNSM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:27 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B235C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:05 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u17so32839825ejk.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QClLq5p5qq24gkpiTHpqq1S37C0V+3FApQxcXpPj+ps=;
        b=YHm8NSCB4spX3uKxhAQGBxKvblT64WOz5g2oupOSTk4ipw1BryabxY3wD1gw0ZVB8h
         Nhl16YZw97FRS7JzsiKz6xvxjaHFTxNlZBdMWgz+F9YVfDBlfSIoCKxfG6dUIkH3p7d+
         LJnn0BLDtrpNlomImo07mRSJsj++CxxVSmsPKcTDi5p7rHQObxzOqa2dImXBudJ+euXj
         T0J5dXEsZrQaUXHoxBtrge4C+F9GRsyf+7DOD2jtrfp0bqyR0y9aPK/g/PoRNsRmSpuv
         pVrTzU4DQi0Zz1CYEyNtq793Or8wB+dpXsgQg89Ma50vfBcrTs5HGK2MoouZREaeaKhE
         w/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QClLq5p5qq24gkpiTHpqq1S37C0V+3FApQxcXpPj+ps=;
        b=uRUKLWdz5QTDGvYtkfj4pzj6ekrAs9RcGN0HtUDagYVD1MVIIQ3do23k3oZsctZiwp
         k0zkCDyW+cNOmN9afbRu+98ntFIwwFerXJIRUeFQAOJ2MCf/Ug/SzYHF5GV29sTsey1j
         EQPC6nupv+uLj/HTSkcZ3cEYWnbrkpRMQZam/IrTXaYCHoSGavEyjiK5WYzk0Od3HfkS
         Rhga4HA+mHNVG+vKjZQYQeVaj9FUK56HQren/jXqy6273Cs8W6eR3OP2i+Gvwmf4ovh9
         ZBpYUzOQg/BBkyMQ0wFI2bGz8uxlpwrOVBhuyHH2BYMrdWjfcdi+AFFXh5q4Key2S++x
         KNIw==
X-Gm-Message-State: AOAM5300B6Oay0+IqxOZ516Sw0//VXVEJzd+bJiXcFgrcMHu2wRlvZ/L
        /XGoPlrPhHMUEDi8OaX35ZdbnQ==
X-Google-Smtp-Source: ABdhPJz5PuVx2EkXSsww1ESMS66Jmw3yHMJcP6Fc485KLDS8IYkCORgy85yhVbF+YPctMFz0GcKMKw==
X-Received: by 2002:a17:907:20e9:: with SMTP id rh9mr119347ejb.523.1618423924005;
        Wed, 14 Apr 2021 11:12:04 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        linux-staging@lists.linux.dev
Subject: [PATCH 28/57] staging: rtl8192u: ieee80211_softmac: Move a large data struct onto the heap
Date:   Wed, 14 Apr 2021 19:11:00 +0100
Message-Id: <20210414181129.1628598-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c: In function ‘ieee80211_rx_frame_softmac’:
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:2009:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Romain Perier <romain.perier@gmail.com>
Cc: Allen Pais <apais@linux.microsoft.com>
Cc: Andrea Merello <andrea.merello@gmail.com>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 690b664df8fae..73f63d4510e77 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -1911,8 +1911,11 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 		if ((ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) &&
 		    ieee->state == IEEE80211_ASSOCIATING_AUTHENTICATED &&
 		    ieee->iw_mode == IW_MODE_INFRA) {
-			struct ieee80211_network network_resp;
-			struct ieee80211_network *network = &network_resp;
+			struct ieee80211_network *network;
+
+			network = kzalloc(sizeof(*network), GFP_KERNEL);
+			if (!network)
+				return -ENOMEM;
 
 			errcode = assoc_parse(ieee, skb, &aid);
 			if (!errcode) {
@@ -1923,7 +1926,6 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 				/* Let the register setting defaultly with Legacy station */
 				if (ieee->qos_support) {
 					assoc_resp = (struct ieee80211_assoc_response_frame *)skb->data;
-					memset(network, 0, sizeof(*network));
 					if (ieee80211_parse_info_param(ieee, assoc_resp->info_element,\
 								       rx_stats->len - sizeof(*assoc_resp), \
 								       network, rx_stats)) {
@@ -1949,6 +1951,7 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 				else
 					ieee80211_associate_abort(ieee);
 			}
+			kfree(network);
 		}
 		break;
 
-- 
2.27.0

