Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939B73539F7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 23:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhDDUwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 16:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhDDUwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 16:52:02 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6D3C061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 13:51:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 12so14685675lfq.13
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 13:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QzV++jhT27uc2t1qnJFUNLJDodKEuAS8LLzpt9xx8wo=;
        b=K6VyeHCogGvRhUaBohFgBjE1xxM8DQJuwnJ23Z2pijJO/xgS37x+tTOGtC3Z9xV7T/
         cOpn9Ov3F7KQG5/+OCGXCn2DZrOJ0EReKDuF3JSaB31CwGDT+sLhVy21/wvK202leU8m
         qOdQNWyNi1GaCb3Otgmy2a48vcKqBdmaJ2iCX0gygSx2LC6qpwD1YPVrR2FQym0+WLz2
         uTkkEcJU+wdTHu4xs65+dG/dNIbujWo/sVUzEpcr/9YuL9Qze+2N9CkMk3BfdkvDncxS
         am1C8UEXo+/6X1+lWYSVqfXTEeOvYDXsxYG9pg3lncbRTdJZyEiF/+4uFRnyIKCLbc/g
         ZJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QzV++jhT27uc2t1qnJFUNLJDodKEuAS8LLzpt9xx8wo=;
        b=b63QBJvYPcHIeFqoaucwwIuUG2+u1O9EPwGa0D+katDzSNoonEw5zug24OBBGZC9he
         ofIPqUlgLoXFM/fookODiJ2Fv6v7xd87XMGRmRAGHvNERht5SLzSFshxj5UL0/4spMDt
         nov3pkv+xj+FKnJlO8tOX975f2JDeP0Hptrf7JjhFYLQ7UczicU6+Z5hgFpioy8F+cMo
         R3n3su2uVYnBTffGHOiSyGkiHTXJsTDeFGWxNBxpUNm6Y6BOG51jxqHrDRDwQWj1ozxN
         goGdgF7ztsITFxOk1xbYRD8bvoOC03fttHi8iiSGqPVk2xEY7GxcIF5m2huDU6i9CsIG
         UGlg==
X-Gm-Message-State: AOAM531yntuVSoPPg5YnmxNGg/l2t78VTzEdIOyfjtp0edLT9xcmVkAN
        WYbW5wGvgnzLBVzaIi7Nz28=
X-Google-Smtp-Source: ABdhPJybCeIuCQ/d7Jozd1PGm1So8NTlkYU4ZevulfXxDK3NY/5AaUh1u9+go2wmcGVncLtnukVXFQ==
X-Received: by 2002:ac2:53a7:: with SMTP id j7mr16793134lfh.305.1617569515361;
        Sun, 04 Apr 2021 13:51:55 -0700 (PDT)
Received: from zhans ([37.151.32.231])
        by smtp.gmail.com with ESMTPSA id y23sm1657365ljm.53.2021.04.04.13.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 13:51:55 -0700 (PDT)
Date:   Mon, 5 Apr 2021 02:51:54 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 2/2] staging: rtl8712: remove extra blank lines
Message-ID: <d56183614a04590bdf3a6280b7f23664a5bb394c.1617568354.git.zhansayabagdaulet@gmail.com>
References: <cover.1617568354.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617568354.git.zhansayabagdaulet@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra blank lines to adhere to Linux kernel coding style.
Reported by checkpatch.

Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_recv.h    | 1 -
 drivers/staging/rtl8712/rtl871x_mlme.c    | 3 ---
 drivers/staging/rtl8712/rtl871x_pwrctrl.h | 3 ---
 drivers/staging/rtl8712/rtl871x_recv.h    | 1 -
 4 files changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_recv.h b/drivers/staging/rtl8712/rtl8712_recv.h
index c70b37ff554e..f4d20b0efd4e 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.h
+++ b/drivers/staging/rtl8712/rtl8712_recv.h
@@ -85,7 +85,6 @@ union recvstat {
 	unsigned int value[RXDESC_SIZE>>2];
 };
 
-
 struct recv_buf {
 	struct list_head list;
 	spinlock_t recvbuf_lock;
diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index f5886b39b3b5..8a97307fbbd6 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -124,7 +124,6 @@ static void free_network_nolock(struct mlme_priv *pmlmepriv,
 	pmlmepriv->num_of_scanned--;
 }
 
-
 /* return the wlan_network with the matching addr
  * Shall be called under atomic context...
  * to avoid possible racing condition...
@@ -358,7 +357,6 @@ static void update_scanned_network(struct _adapter *adapter,
 		plist = plist->next;
 	}
 
-
 	/* If we didn't find a match, then get a new network slot to initialize
 	 * with this beacon's information
 	 */
@@ -621,7 +619,6 @@ void r8712_indicate_connect(struct _adapter *padapter)
 			  jiffies + msecs_to_jiffies(60000));
 }
 
-
 /*
  * r8712_ind_disconnect: the caller has to lock pmlmepriv->lock
  */
diff --git a/drivers/staging/rtl8712/rtl871x_pwrctrl.h b/drivers/staging/rtl8712/rtl871x_pwrctrl.h
index dd5a79f90b1a..bf6623cfaf27 100644
--- a/drivers/staging/rtl8712/rtl871x_pwrctrl.h
+++ b/drivers/staging/rtl8712/rtl871x_pwrctrl.h
@@ -17,7 +17,6 @@
 #include "osdep_service.h"
 #include "drv_types.h"
 
-
 #define CMD_ALIVE	BIT(2)
 
 enum Power_Mgnt {
@@ -63,12 +62,10 @@ enum Power_Mgnt {
 #define		PS_STATE_S3		(PS_ALL_ON)
 #define	PS_STATE_S4		((PS_ST_ACTIVE) | (PS_ALL_ON))
 
-
 #define		PS_IS_RF_ON(x)		((x) & (PS_ALL_ON))
 #define		PS_IS_ACTIVE(x)		((x) & (PS_ST_ACTIVE))
 #define		CLR_PS_STATE(x)	((x) = ((x) & (0xF0)))
 
-
 struct reportpwrstate_parm {
 	unsigned char mode;
 	unsigned char state; /* the CPWM value */
diff --git a/drivers/staging/rtl8712/rtl871x_recv.h b/drivers/staging/rtl8712/rtl871x_recv.h
index e83c256e1474..7c9995060a6f 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.h
+++ b/drivers/staging/rtl8712/rtl871x_recv.h
@@ -29,7 +29,6 @@ struct	stainfo_rxcache	{
 #define		PHY_RSSI_SLID_WIN_MAX			100
 #define		PHY_LINKQUALITY_SLID_WIN_MAX		20
 
-
 struct smooth_rssi_data {
 	u32	elements[100];	/* array to store values */
 	u32	index;		/* index to current array to store */
-- 
2.25.1

