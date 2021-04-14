Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E20A35FA6A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349582AbhDNSMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbhDNSMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:01 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD09C061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:39 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id w3so32849552ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xTcLgnCxrmrAp2YagBVz8UAjAg6NhAzgiWybjY6w54g=;
        b=pEsjFqcXquXT0cCMsm3LLus74cWhhbhd7Mq23Y6Cs2x6v2lQ1CkGiySHaltF0w0V/z
         g8+TBusoCiTu+ZLZfRLNSPlV75fj0hWsV/2Pk+PzdT570AYAvAO8KuJqtBdicoaflVvJ
         3ghbfrLGP++YLE1KNU8rZRlpFvGhfWlHAmkwCb0HP5ddG0txWCy/AiCGR/2zACw9IUlh
         Ob0zW4yfJNZfAIsgdXfIZfzt6DpPxPVUyzxBaX3ECzMSl/QD+71Lzm14Jp1psGdNf9MS
         PSRyjhDkf7UyMG1M7esgdqU+0/HTgg+1B5PzIo8zpOqK4Cmhd1/JflnORQQKLxhqTBQi
         bMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xTcLgnCxrmrAp2YagBVz8UAjAg6NhAzgiWybjY6w54g=;
        b=XVzZksygao+Q8uIdkI+LtbWoa1pwGwoVBX9vFME54r/d10v+dOvJwEefypsPAAO4VU
         YU5lHYhg4U0Q1jE3T+YfxDhB/YC1j7W9VLJY9cEllIN5lEbsm9wv2ZzRdoelHwQsewRF
         Mx5ky5V1Nsd3Q7HTodd7bwUYIlvG68xRcyJthF/CPB993egHfdlibywRraGGsvXyMv6A
         9z0WdCmvwawFfbB/fEMt01XaMa+6VVooE0ybiqkYA0qaL03aLwjjbD1j1vI5SQ1aU/5y
         wp+rWLaduYQ93d4d7bFsLLWlz4qfWU2T6xW5T/lvQ/r6nYZCp+XHJLWptQ0EbilMYgqL
         ng6g==
X-Gm-Message-State: AOAM533pfpm/1poDKpTWDozV55YG9UC0wgl+CNFRhbGu7Izn5BznvrP9
        gvUXLnof0wv+rFvE7RFOU09M5w==
X-Google-Smtp-Source: ABdhPJzF5ziEKnFqMe6mRBwP2qeuVMWb9sbYzt8yaKPbYT/q3wgNXts2PxfzqzdR56sSSmCQxd3jbA==
X-Received: by 2002:a17:907:94ca:: with SMTP id dn10mr139954ejc.123.1618423898668;
        Wed, 14 Apr 2021 11:11:38 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:11:38 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Merello <andrea.merello@gmail.com>,
        Jerry chuang <wlanfae@realtek.com>,
        linux-staging@lists.linux.dev
Subject: [PATCH 04/57] staging: r8192U_core: Do not use kernel-doc formatting for !kernel-doc headers
Date:   Wed, 14 Apr 2021 19:10:36 +0100
Message-Id: <20210414181129.1628598-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/rtl8192u/r8192U_core.c:3714: warning: Function parameter or member 'dev' not described in 'UpdateRxPktTimeStamp8190'
 drivers/staging/rtl8192u/r8192U_core.c:3714: warning: Function parameter or member 'stats' not described in 'UpdateRxPktTimeStamp8190'
 drivers/staging/rtl8192u/r8192U_core.c:3714: warning: expecting prototype for Function(). Prototype was for UpdateRxPktTimeStamp8190() instead
 drivers/staging/rtl8192u/r8192U_core.c:4314: warning: Function parameter or member 'dev' not described in 'UpdateReceivedRateHistogramStatistics8190'
 drivers/staging/rtl8192u/r8192U_core.c:4314: warning: Function parameter or member 'stats' not described in 'UpdateReceivedRateHistogramStatistics8190'
 drivers/staging/rtl8192u/r8192U_core.c:4314: warning: expecting prototype for Function(). Prototype was for UpdateReceivedRateHistogramStatistics8190() instead

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrea Merello <andrea.merello@gmail.com>
Cc: Jerry chuang <wlanfae@realtek.com>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8192u/r8192U_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 643769e32e433..932b942ca1f30 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -3694,7 +3694,7 @@ static u8 HwRateToMRate90(bool bIsHT, u8 rate)
 	return ret_rate;
 }
 
-/**
+/*
  * Function:     UpdateRxPktTimeStamp
  * Overview:     Record the TSF time stamp when receiving a packet
  *
@@ -4294,7 +4294,7 @@ static void TranslateRxSignalStuff819xUsb(struct sk_buff *skb,
 	rtl8192_record_rxdesc_forlateruse(pstats, &previous_stats);
 }
 
-/**
+/*
  * Function:	UpdateReceivedRateHistogramStatistics
  * Overview:	Record the received data rate
  *
-- 
2.27.0

