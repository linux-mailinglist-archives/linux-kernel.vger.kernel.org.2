Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0E8355333
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 14:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343751AbhDFMKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 08:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343726AbhDFMKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:10:09 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6243CC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 05:10:01 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id z8so16164990ljm.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 05:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3IjasWzqLdpd77pS1i7PqF29b9l9kltRxgeNazC6S+A=;
        b=S1R9xTNRJ6qErMKNLecSOhfU0ZS5czLdE4zGKv2duJ4rxyIrJrsJJXLABBX9ZOGg1V
         A1Bm8UIrJrHnmZ8hoei+UoW/blHMCIUDPhlv7EvUdh/Dv8rDByVmxiBPoH9KvKE+aWOT
         gHsLe7LBWEPqbkPySQBR5ZC5zV6mdCYuDlUF561lLCL7HzYv2CZrG5lEzEXAxi5dDUuy
         pIdDyfR34V0GOtMYbLw8dv/KaNYKpVDyggmUYkJlPs1x/pdDBAQuPAjrwrh0AvKRImOm
         IwZdOnovvQ7xG+LxXWakHhEqwJhuTPSgzyPQ5REigQePE+zTAKo+ohP3jJwCl7JdxTZx
         xjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3IjasWzqLdpd77pS1i7PqF29b9l9kltRxgeNazC6S+A=;
        b=LSh46AYksNaoJ/AR0cEgLHOCoi3lRwIqHlLgPHgVf1kQnutRyrvCBVNCvE1kkukO0y
         a5DGqRMzKj6KvndKH4k2wWxxeUAYlgOZiMvNWtwJeLFl2WxpTbRd97yv9HHk/tpKvGrW
         tQ2o1KhtBPBPfaLtV+n8qHoazFfD4M4EytMXD3uhN1d/FvsNixnj5u2EzQQt/VpLP3io
         KTInXItr7brjZOLlHqb1+r54B1y4OwqVgLmkIUMqgzHWSaKX2F4hKtODoMycL2YZk/AS
         ULHw0HOMDKUw0VwxHsn6uFDV0owjW91uggRpV1FRwq6+mH4d6MZKfzg+YL/WMTdvuPKt
         +x3Q==
X-Gm-Message-State: AOAM533hqPgaZ4+ki87NejpYdhOJbmZhY8Jnu7fb0eK/oy8TI6ATUfVL
        y+98s1aEEH6KYFbZLwyTo1+0nVR/BxNGNA==
X-Google-Smtp-Source: ABdhPJwIUl0MQfZ/2/NMGem9fKhQEYoeM1YIRR54q07OehkznMauFsU6YQNzeezICHosCdxoz5TRLg==
X-Received: by 2002:a2e:9715:: with SMTP id r21mr18955331lji.224.1617710999935;
        Tue, 06 Apr 2021 05:09:59 -0700 (PDT)
Received: from zhans ([37.151.32.231])
        by smtp.gmail.com with ESMTPSA id a7sm2135510lfo.177.2021.04.06.05.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 05:09:59 -0700 (PDT)
Date:   Tue, 6 Apr 2021 18:09:58 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH v2 2/2] staging: rtl8712: Remove extra blank lines
Message-ID: <f61f6d330bc3fa53d4d420754d1d461b6cfcb2de.1617710602.git.zhansayabagdaulet@gmail.com>
References: <cover.1617710602.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617710602.git.zhansayabagdaulet@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra blank lines after an open brace to adhere to Linux kernel
coding style.
Reported by checkpatch.

Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_io.h   | 1 -
 drivers/staging/rtl8712/rtl871x_mlme.h | 1 -
 drivers/staging/rtl8712/rtl871x_recv.h | 1 -
 drivers/staging/rtl8712/sta_info.h     | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_io.h b/drivers/staging/rtl8712/rtl871x_io.h
index c20dd5a6bbd1..c5b12f74ebf8 100644
--- a/drivers/staging/rtl8712/rtl871x_io.h
+++ b/drivers/staging/rtl8712/rtl871x_io.h
@@ -123,7 +123,6 @@ struct	intf_hdl {
 };
 
 struct reg_protocol_rd {
-
 #ifdef __LITTLE_ENDIAN
 	/* DW1 */
 	u32		NumOfTrans:4;
diff --git a/drivers/staging/rtl8712/rtl871x_mlme.h b/drivers/staging/rtl8712/rtl871x_mlme.h
index 46effb469fd4..d7d25f240111 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.h
+++ b/drivers/staging/rtl8712/rtl871x_mlme.h
@@ -77,7 +77,6 @@ struct sitesurvey_ctrl {
 };
 
 struct mlme_priv {
-
 	spinlock_t lock;
 	spinlock_t lock2;
 	sint	fw_state;	/*shall we protect this variable? */
diff --git a/drivers/staging/rtl8712/rtl871x_recv.h b/drivers/staging/rtl8712/rtl871x_recv.h
index 4aa39f4f3b84..1c8298bde033 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.h
+++ b/drivers/staging/rtl8712/rtl871x_recv.h
@@ -37,7 +37,6 @@ struct smooth_rssi_data {
 };
 
 struct rx_pkt_attrib {
-
 	u8	amsdu;
 	u8	order;
 	u8	qos;
diff --git a/drivers/staging/rtl8712/sta_info.h b/drivers/staging/rtl8712/sta_info.h
index d042d900f30c..9b7e5ffa380d 100644
--- a/drivers/staging/rtl8712/sta_info.h
+++ b/drivers/staging/rtl8712/sta_info.h
@@ -36,7 +36,6 @@ struct wlan_acl_pool {
 };
 
 struct	stainfo_stats {
-
 	uint	rx_pkts;
 	uint	rx_bytes;
 	u64	tx_pkts;
-- 
2.25.1

