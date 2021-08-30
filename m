Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F573FB1A7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 09:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbhH3HLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 03:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbhH3HLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 03:11:16 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC1CC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 00:10:22 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id z9-20020a7bc149000000b002e8861aff59so9742645wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 00:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dQOEpVE/C5dPQ93Tb+yBF/RNgfmLwzTx629HAf0Qgcs=;
        b=uiELm4PTLBuhU7cgEqNnEg/k/V8uMGvTMgOPgR3QQxJefAQmj5HcwfiJLC54Hkg4Vh
         RidYD+FPn/GpI6z7kqIKlv/OhXpynG6so3RSJ+CmZffvwl7DT7l90FKIzQiprsVHpmSM
         R5Nv/ceMiOHX4DWrxcr4TlytcoHtLzgqfaPMLogPVJVPR3ia6lGtiKx/SJbZb/N3qdr/
         fPG4hXjZH7q1lbK2tSmKwF8xknr12rqqw4zz6uuvGXDXHk+jLFijOfPnCNPiGQrqPz2M
         vAnz3aRP0WrM/hkue2UijdcGTXSfD8172yoRbuDylh60LRyyJTr3ZtnHCqWu8AjlKnVY
         CHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dQOEpVE/C5dPQ93Tb+yBF/RNgfmLwzTx629HAf0Qgcs=;
        b=XBW5tCw7ddYVsWwIivy/qo2L9yZyMCH6EILY3jRVD/1zd3EiWoWwD5genu8p+OotDC
         JEjCZBnEOgJ10gPEyyPpWLzSCj1jaW/zx5v8FYqUR0OalqivSIW+5OWmhNAfRlOGd81e
         K6f8XI+bUp2VVQrxUBdYQ6r2qa9QyhSWW9MEfFNYaSFCDUcrCJNUoQ1fcDBh0fAmIO6w
         KlD9WXCGEYdPpeQXMF63VBctRkRiQPWlP2JBxNHTXYBMptdquZKOz8ayL84D4Kthy9BW
         yRAc/QxyvJ8YAelz3REj+G3/5Gg3ohGPmupSTYgB/v7NMhA8MFrkX/pIPi5FNskUletR
         RC8Q==
X-Gm-Message-State: AOAM531+ajaJIVBJJTuw2HAYAAX4INHRPeIc17fQPgVXiOvIkwaHZWE3
        Mb8ujUfzZwlAVUvKEZ4QgjY=
X-Google-Smtp-Source: ABdhPJxMCEKVn1y7BMu5P1w6JKn20bQsG5ZgkajYeYMBq5atkbsXeVV+o3+7xo/G2TYRdlUcdjjiOQ==
X-Received: by 2002:a7b:c041:: with SMTP id u1mr20002423wmc.95.1630307420944;
        Mon, 30 Aug 2021 00:10:20 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id o5sm14362073wrw.17.2021.08.30.00.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 00:10:20 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 3/3] staging: rtl8723bs: remove unused _rtw_init_queue() function
Date:   Mon, 30 Aug 2021 09:09:25 +0200
Message-Id: <3c03fcfbe799195c84608b05fc54efe921bef4de.1630307025.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1630307025.git.fabioaiuto83@gmail.com>
References: <cover.1630307025.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove _rtw_init_queue() left unused by previous commit
in this series.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/osdep_service.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
index c58555a4012f..2d630ecef08b 100644
--- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
@@ -49,13 +49,6 @@ inline int _rtw_netif_rx(struct net_device *ndev, struct sk_buff *skb)
 	return netif_rx(skb);
 }
 
-void _rtw_init_queue(struct __queue *pqueue)
-{
-	INIT_LIST_HEAD(&(pqueue->queue));
-
-	spin_lock_init(&(pqueue->lock));
-}
-
 struct net_device *rtw_alloc_etherdev_with_old_priv(int sizeof_priv, void *old_priv)
 {
 	struct net_device *pnetdev;
-- 
2.20.1

