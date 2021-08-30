Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A93D3FB5DA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbhH3MQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbhH3MQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:16:43 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95029C061764
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:15:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b6so22097194wrh.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7cHO6aqtFRbZaEb7acvE6qfuRagtWYmYRLazF/3j2zU=;
        b=lYxrfdq28M2UtVN+RGrnP+krx6fmtgoIeqRo/Gn02DZjL+yIPJJKdBdeY7+kodxQb4
         j3Wuyt9lo1QxSwRTldk0cpuct34D1/xIp8KWcTwUb93+QuonfmebnNc8nkToaYRed85I
         ixBWjrqRogTfT3LbiMufX5KrnuFOH59SfoL6g5SU/T1gcStfJIy/077W3IJy4SODeXOx
         XHm6GQ69x+uPOaeGgBHb2gRb5OGE9TlGXBqOaA1az3XgeYcVibOEjZ1pc9z6cFLqQ0U7
         w+pQta/xfALlhR042vQcSM6Wl7rb+kxCU2Apf+xqvtc+rIVTxvumRSdLk5ZgJ2ONik7n
         kDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7cHO6aqtFRbZaEb7acvE6qfuRagtWYmYRLazF/3j2zU=;
        b=UQpko0tOrR1j9qvStEK5k9Dg2lncbLVGn22IYSUHrisKVlU6ekswLtcBbATD+SaZG+
         XzimR9Lf2w2+XM1h5HEpIUm2eQexT5NBKeYnYygpJqLJ14LIm4lvr25OYivWLI28bWid
         3xOVcp/Ni5mjO1pzenR8DHdR7fAUg/cQzfcTJpvjlk8Imgo/r/OfFLjMZ6HUidQVZdNM
         ID+5ACTN7mkdhG7X5NxToNa1P7T/4c4RUVt5Kc12dFKnEAH/K9Aay/LKWoRs9y8Mc5k4
         Hy0x7GSUGnKdSSfu4jxaRhYSH9cJxiSs+1ZlscOqURhAGAcqMSEHEZVHmvUohVHI8v2h
         KLzQ==
X-Gm-Message-State: AOAM530lY9a6xYx4npgEpbNkbnUj/Voj6l0FtLLQJSp005rlJr92islc
        X4Z37ixAkLRuBTt9DUGNunI=
X-Google-Smtp-Source: ABdhPJxMgFCmbfkhv6FbtiLoyu3VL1xeRWrCjjezOABm8MEeZGSDhbE0doMiC6og2V4YwZkdnu5esA==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr26290535wrr.382.1630325748285;
        Mon, 30 Aug 2021 05:15:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id x11sm15492116wro.83.2021.08.30.05.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 05:15:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 5/8] staging: r8188eu: use random default mac address
Date:   Mon, 30 Aug 2021 14:15:05 +0200
Message-Id: <20210830121508.6411-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830121508.6411-1-straube.linux@gmail.com>
References: <20210830121508.6411-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a random default mac address instead of a fixed one to reduce the
likelihood of mac address collision.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index 35a548e1c92e..370a710ab7cb 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -1033,15 +1033,8 @@ void rtw_macaddr_cfg(u8 *mac_addr)
 	}
 
 	if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) {
-		mac[0] = 0x00;
-		mac[1] = 0xe0;
-		mac[2] = 0x4c;
-		mac[3] = 0x87;
-		mac[4] = 0x00;
-		mac[5] = 0x00;
-		/*  use default mac addresss */
-		memcpy(mac_addr, mac, ETH_ALEN);
-		DBG_88E("MAC Address from efuse error, assign default one !!!\n");
+		eth_random_addr(mac_addr);
+		DBG_88E("MAC Address from efuse error, assign random one !!!\n");
 	}
 
 	DBG_88E("rtw_macaddr_cfg MAC Address  = %pM\n", (mac_addr));
-- 
2.33.0

