Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B8F355134
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 12:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242685AbhDFKuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 06:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbhDFKuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 06:50:54 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98268C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 03:50:46 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id w28so21933335lfn.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 03:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3IjasWzqLdpd77pS1i7PqF29b9l9kltRxgeNazC6S+A=;
        b=G/bHtrarF3eRtDCKAeVoMEvOieVKk7gdLzBy5N20Aosf+dmmu6i13fbjp5Fxj6c559
         rqlEGsSoPdjIucgOaeLbQfvxYGLrDNoAIUpQ3p1Jp/HY8P15PCFtWl3Z6FKsY/6sY1I2
         l52JxUoTMvzGn4DsGOVc3gMgjzV/GfjYzFi5Oty0mXuQ9CktQHCKXLmkQBSp2KPJlB5I
         IUcMq8V1uSlWwNTpT4ch8hQO4UqnPn6Fq4m5TUubHIc1rHIfoJhu3BLgiFGiKK3Mqldl
         WytWe/hbRKZ8zWaNkB/6JrcAertI927g397TR2N4sZGLeLkkbI34g7UYZ+Ivz3r7Xc2/
         aC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3IjasWzqLdpd77pS1i7PqF29b9l9kltRxgeNazC6S+A=;
        b=HcnuWcNLjdXK6cGvN05xF8joyiKWJYuI/hsTSy6dymyjN8fjd5QV0uFI4dzjOFouB9
         TFo1z965KiWg+7U4x9yARXFCHl66S2OeZPsieCcmVgYxTLv8kf935S7By6DCWH4+aI0b
         DoQmb4d06ah+a6tFd6WtYF2ggCBjFmyXtyzzrRZWut3aEYpoAdPxxqnpE6mldW5z6w04
         1YKYq91oE4/R/uHksGseAivAVbS4cHZ/cMqRE89FYun59c78l6VP+N6lbdJkHL1ehfIz
         OR7ERrtfkY51aOLr6yQmiGcVgbpSvVyX6ABouo/aJPNXlA2Bs6ofav/yf8iSUHW2PSZx
         Sv2w==
X-Gm-Message-State: AOAM530miALF5AARqRIPMAGZnqWZQH89CEzw1IJ6ET/7558NLwagz+ZP
        TEd8gOGoOTMIFizOVYefqh8=
X-Google-Smtp-Source: ABdhPJxm3Km1eLJCRTeNWLVwYctyQ5MiwWKL0zuTC1PkMCMyMqlj4Y/TpgT09Ywl/xm69JxK9WOsWA==
X-Received: by 2002:ac2:4d9b:: with SMTP id g27mr20869389lfe.113.1617706245170;
        Tue, 06 Apr 2021 03:50:45 -0700 (PDT)
Received: from zhans ([37.151.32.231])
        by smtp.gmail.com with ESMTPSA id f28sm2114689lfk.67.2021.04.06.03.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 03:50:44 -0700 (PDT)
Date:   Tue, 6 Apr 2021 16:50:35 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 2/2] staging: rtl8712: Remove extra blank lines
Message-ID: <af750c2521fe0b5fbba719f3b5b7344620fc7514.1617705825.git.zhansayabagdaulet@gmail.com>
References: <cover.1617705825.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617705825.git.zhansayabagdaulet@gmail.com>
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

