Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F033CC3ED
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 16:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbhGQPAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 11:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbhGQPAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 11:00:05 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8CBC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 07:57:08 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a13so15497185wrf.10
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 07:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LBk5UwZLnUnusI8tJJ9UTs4/cIfOhq6Hn/jE2i8X2Z4=;
        b=DNsvmn1OTxLVkCw+4u07ctBLqkE4Sl+hz+WbN59BFF1cp6jxq++APyA3TvaN5cni5A
         1JbuiOl0CXdwJPXBk+x6KLhyCg6dGSPsOzhfnRjPds1GvkE1PldOvqb5sB8kbo1OfteR
         m4RibZn7R5LJsF3999Mmn1l/EGmZFEZETem+h3n6LIjJfCVVuv/KVUGbrf6W6SfsxMAg
         bwtZzQbNUS9K5GGwR86caNs0jGLkmDDZnGuFxoTtnxLMwtIwcW0CfTzqOulKNwAFF6Fr
         /8hoyd6MITv4sK803tDX8/XNgJzl3MekytGXDRSMbxpZsUu3NG2wML2p7y2JMafrkwPu
         4BkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LBk5UwZLnUnusI8tJJ9UTs4/cIfOhq6Hn/jE2i8X2Z4=;
        b=bAlRiWQiTSALbnQJyylGOecQqwGmx07gqNz/Pf/MSP/h0QvdsT1zrYl7/DP8+Uwt3l
         UP+pevt22L8mX1DY2SKxyKeTZgJZgRo4anEOoWRTAfUZOUT0HHAhe5ZSWawtDvVetCMl
         dhKw/OJ6jh2ysBR4un2uOhRIp0RGn8IYHf5+7h9nP1xkDP1tTU9M2cju5ZbBCkdlxp+l
         Wjl+F0pa8LHHrX1CJMx40/JZZukjFaVllpKcYxG08jbv00s30xxnG8h1q5ODzSRjNAeC
         iOaVxRVKnl+UCNRW9RvBpwB4Dhs9lGRzs0w0OUcjpUZR2vD8wdTtasxRbHLcs6hejPgo
         rwYQ==
X-Gm-Message-State: AOAM532/x+rXBbrFU/IUWkgzm7VeZgsyGaQJAxxeJGH8mv3cGg0HGX/E
        SvExDB5uTQJgZuO/Mg9Qjge6+cssvfM=
X-Google-Smtp-Source: ABdhPJwLiCYrkyPzKik4u4QgFBpdMTw447xRnzBZ2nChUpnaX+xjp+ItNRbMlbLyvd8cKLPUbd6ewA==
X-Received: by 2002:a05:6000:1867:: with SMTP id d7mr19390601wri.199.1626533827354;
        Sat, 17 Jul 2021 07:57:07 -0700 (PDT)
Received: from agape ([5.171.72.101])
        by smtp.gmail.com with ESMTPSA id h20sm7642856wmb.17.2021.07.17.07.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 07:57:07 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/10] staging: rtl8723bs: fix camel case argument name in macro is_supported_tx_cck
Date:   Sat, 17 Jul 2021 16:56:51 +0200
Message-Id: <f38fbb1388a54c78602750ecb86d0716d1aaf66b.1626533647.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626533647.git.fabioaiuto83@gmail.com>
References: <cover.1626533647.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix camel case argument name in is_supported_tx_cck

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/ieee80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index 07cff4c490a0..b3a9bcce4c44 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -158,7 +158,7 @@ enum network_type {
 
 #define is_supported_24g(net_type) ((net_type) & SUPPORTED_24G_NETTYPE_MSK ? true : false)
 
-#define is_supported_tx_cck(NetType) (((NetType) & (WIRELESS_11B)) ? true : false)
+#define is_supported_tx_cck(net_type) (((net_type) & (WIRELESS_11B)) ? true : false)
 #define is_supported_ht(net_type) (((net_type) & (WIRELESS_11_24N)) ? true : false)
 
 struct ieee_param {
-- 
2.20.1

