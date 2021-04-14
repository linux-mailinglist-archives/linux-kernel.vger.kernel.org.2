Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964E435FA92
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352364AbhDNSOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352448AbhDNSMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:41 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FACEC061348
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:18 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u21so32813062ejo.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kpF2D6lcCQKzXa0gi0zcEEwxlAaXoFqEUGWLqoobvuM=;
        b=TMChDObI251LbBAzFu73+KQvOpttCqxvvR2/cV6soZxQ5gbC7xe2bcLch1L9YSdZLc
         f7oHwMb2LNNBM+KNDsU9vvh3NviWlTtUEWOmAL311ROm+fiIqsjjXcEWg1eT7EHqQPbp
         NYKGVXtpBzXWL1sD2jUwGI7c8PBHfLVD9Y7cJyav6q/7gUsXReRgc0bdqY89Apf7Gkba
         MJkESv4WL+LlsDOE5NAFiaDmpMaVvew5rzO7wvIVGPNJ/m/ucxJy1IDh5hR/mh1aejP4
         qMuQza8pmGwCSNecJFDyRl2l6TYNVuO8emtRoVyIFyRu2O9aSWhU5v5gzmjeoCvBXrr2
         9eUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kpF2D6lcCQKzXa0gi0zcEEwxlAaXoFqEUGWLqoobvuM=;
        b=iz1Pnlbr0DWKV7PIrbWf0cv4uUWAZ2h1FsLsKZttOwaVSdTI06stiKec/1RqRtvmG+
         2IYhjAoZ9Crfcb2/iz2yHmzzdD/bQ+eZmY109psUXH0Gh6XhqxgvBY+Nu3WW2tf6jo3T
         yYIK0oxaoBcFA0TeL2b2DPp74Gd4KvHOfZK8VxYUZsEB42xQ7efBgd188lHlXsX14wzT
         gl6VaQuVBy3VuJZ/lw/APzpd8LxOFszvSgHjN7g5vqin+pDD1hqfPuHIehDHqDA3qhb7
         ii1D0mrSxFmWtf/dLZEaUIsBwcE/m/RLpNot6e4CgQ20ORbHgQjdEJ2UWTx7jfM6GJMz
         Xfeg==
X-Gm-Message-State: AOAM5315yxG5hPEULw8GOIiOgrPXiX3NGroJUiLpvDKcDSan30L82sZw
        UafZoHZxBVGTG9OCZhsa7azFQA==
X-Google-Smtp-Source: ABdhPJyTSFFjtRZgu3vEZZdMDeytL5hTBBBwwQ6RA2nexvyX2Vaz35YbBgCn5uZzcuKhgMTERy9u6w==
X-Received: by 2002:a17:906:a449:: with SMTP id cb9mr175498ejb.118.1618423937108;
        Wed, 14 Apr 2021 11:12:17 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:16 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: [PATCH 41/57] staging: rtl8188eu: os_dep: mon: Demote non-conforming kernel-doc headers
Date:   Wed, 14 Apr 2021 19:11:13 +0100
Message-Id: <20210414181129.1628598-42-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/rtl8188eu/os_dep/mon.c:21: warning: Function parameter or member 'skb' not described in 'unprotect_frame'
 drivers/staging/rtl8188eu/os_dep/mon.c:21: warning: Function parameter or member 'iv_len' not described in 'unprotect_frame'
 drivers/staging/rtl8188eu/os_dep/mon.c:21: warning: Function parameter or member 'icv_len' not described in 'unprotect_frame'
 drivers/staging/rtl8188eu/os_dep/mon.c:75: warning: Function parameter or member 'dev' not described in 'rtl88eu_mon_recv_hook'
 drivers/staging/rtl8188eu/os_dep/mon.c:75: warning: Function parameter or member 'frame' not described in 'rtl88eu_mon_recv_hook'
 drivers/staging/rtl8188eu/os_dep/mon.c:108: warning: Function parameter or member 'dev' not described in 'rtl88eu_mon_xmit_hook'
 drivers/staging/rtl8188eu/os_dep/mon.c:108: warning: Function parameter or member 'frame' not described in 'rtl88eu_mon_xmit_hook'
 drivers/staging/rtl8188eu/os_dep/mon.c:108: warning: Function parameter or member 'frag_len' not described in 'rtl88eu_mon_xmit_hook'

Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8188eu/os_dep/mon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/mon.c b/drivers/staging/rtl8188eu/os_dep/mon.c
index 73b9599fe0dc5..9b40de7d39e72 100644
--- a/drivers/staging/rtl8188eu/os_dep/mon.c
+++ b/drivers/staging/rtl8188eu/os_dep/mon.c
@@ -14,7 +14,7 @@
 #include <rtw_xmit.h>
 #include <mon.h>
 
-/**
+/*
  * unprotect_frame() - unset Protected flag and strip off IV and ICV/MIC
  */
 static void unprotect_frame(struct sk_buff *skb, int iv_len, int icv_len)
@@ -65,7 +65,7 @@ static void mon_recv_encrypted(struct net_device *dev, const u8 *data,
 		netdev_info(dev, "Encrypted packets are not supported");
 }
 
-/**
+/*
  * rtl88eu_mon_recv_hook() - forward received frame to the monitor interface
  *
  * Assumes that the frame contains an IV and an ICV/MIC, and that
@@ -96,7 +96,7 @@ void rtl88eu_mon_recv_hook(struct net_device *dev, struct recv_frame *frame)
 		mon_recv_encrypted(dev, data, data_len);
 }
 
-/**
+/*
  * rtl88eu_mon_xmit_hook() - forward trasmitted frame to the monitor interface
  *
  * Assumes that:
-- 
2.27.0

