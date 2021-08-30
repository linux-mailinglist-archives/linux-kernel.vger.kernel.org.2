Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416D43FB5D9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbhH3MQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbhH3MQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:16:44 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783EFC0613D9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:15:50 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id g138so8652979wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ykIIFku5+vbZUnxk+devw/re+bV9Aj//c6+PrJONt+A=;
        b=gqJXO904PPfLL3EP6MgmiZc50UqY0bkRjqkpyorUiiYxwanCzmexIJSMXG1ERz1d61
         0N0oIEZCKRLl7D+Ir0Z5pTsKPHGD9YXD58zzjbk2UjMBg5tUeLuJSEZY2CJBnPyKpH61
         vRlHUYTwL9aHdd8GDDo5VPGCjzXHqS/b20+LVafq1XLfrsAx5dukkTnFZRTbkKw1MiVm
         rLqQRmMvofc0jKS41YVmebTq9XJidPe2VWuo2X3tqXN2wzSUwqYKTHIEMIyyIpD6wjtd
         wbriECVE+WMpNLcuICuh4c49qa/FcwEoYqW8gf/eq+xq+6VKvXFBl3iXNkdXrawN+SFE
         Yc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ykIIFku5+vbZUnxk+devw/re+bV9Aj//c6+PrJONt+A=;
        b=eWQbohq35BT7qYaTAZ25f/eeClGwS0H5rZlmD5xlXVtoBWzaMXvuk0TirnHx8h2FsP
         ergHu0oKGgDnaSulXpq7nCFaKnr29LDd3d6ZFfxCZbyQpUXD3zhPxtnzH9v2sSiJc/uP
         2QNEcwDGjMb+e1Up8UsebJhnbSE7IL1PQdMLRBp9WIm89lB+OXdnHugyElJlvLeOj8/K
         w+TEASby/0s6XYPre9ii6Y5Mjp4b7zLybAJYo6J7aIkCM3t17N+Dy7XulrFfUuDKeh8s
         jASiNptktIuQLViv4Vx9SvzzURdKq8FOXwK5r/tSwXZcnY0K23biub8Hn7UKGAF5VaRR
         qZGg==
X-Gm-Message-State: AOAM530MKkZk0axlHtv/wZtrXnIW9q69UEQnzh5XVZ2YHra50x4ctW2M
        LXQ+kW7tRnLoYDGLm0ZfzUQ=
X-Google-Smtp-Source: ABdhPJz4lz9Glp0CP3yYvCy0L8tI1okEmv2kK6cTAAPXILbfZeuxR1ItdN2vepsxpiRNLvJ+1vNNOA==
X-Received: by 2002:a1c:cc05:: with SMTP id h5mr32766792wmb.5.1630325749142;
        Mon, 30 Aug 2021 05:15:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id x11sm15492116wro.83.2021.08.30.05.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 05:15:48 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 6/8] staging: r8188eu: use ether_addr_copy() in rtw_macaddr_cfg()
Date:   Mon, 30 Aug 2021 14:15:06 +0200
Message-Id: <20210830121508.6411-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830121508.6411-1-straube.linux@gmail.com>
References: <20210830121508.6411-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ether_addr_copy() in rtw_macaddr_cfg() to copy the mac address.
The buffers are properly aligned.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index 370a710ab7cb..c37358be631f 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -1026,10 +1026,10 @@ void rtw_macaddr_cfg(u8 *mac_addr)
 
 	if (rtw_initmac && mac_pton(rtw_initmac, mac)) {
 		/* Users specify the mac address */
-		memcpy(mac_addr, mac, ETH_ALEN);
+		ether_addr_copy(mac_addr, mac);
 	} else {
 		/* Use the mac address stored in the Efuse */
-		memcpy(mac, mac_addr, ETH_ALEN);
+		ether_addr_copy(mac, mac_addr);
 	}
 
 	if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) {
-- 
2.33.0

