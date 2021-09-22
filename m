Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A758A415121
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237642AbhIVUJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237605AbhIVUI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:08:27 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA2FC0613E4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:06:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u15so10389148wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F/iH+36SldsQBoDkg2Y4zZm5zAqT3XUaCffb3gcQJM8=;
        b=dF4GuDagkP7l0tztCZkm7IPpcUcbRWySAr/D8OpsxVo+YIHJwc2NEV6i1Wi5kT20QJ
         42aqPiwJWdNahxpc7VHFJN5161BxLqnCtTPMC0Z4AN76A4ItYjEWkLCWpEdEs2r3UC8a
         5mJVX95iC5IP9jVA7O7/7MEt98zqxQ5cxvfZ2ZY6uxdvW/vc+ygeuQlrMQdvr8yv+o0N
         MCk29azpPJJPbTXHw9LazBxWMg1Yo64zAGocIfxFCRTG2tChwVYNk7W+OJbRpaCXJTsZ
         NbloOw++ZvNkwbLOz2HZm61sw7aS/QsaMansLioQVIjJpQGamFfKM6FHLrdu+/LWkriS
         5/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F/iH+36SldsQBoDkg2Y4zZm5zAqT3XUaCffb3gcQJM8=;
        b=uaIX0+GchDdDx1qEqiAXDdFZe9bCX5JEqPw2YYCn+Gluplc1W9+rTS3kCbuIvG8MHz
         8HNGD/ZeNb2bbOtBqiVYh0O+2E5jkW1uYgRKHiSndeSaFbtfTi24jvwoYfKMzb3w0RJm
         bV8Q7FwcsyFth9Tt4ZFIY9n2tEvUdJnSVJ2cX76BJfO44I8iR/7rkhR0bOSpCl7jYP9O
         VSS1FeiF95W2OLkpV+uUWwCxBqNLhIT/t9EAhMe3uqgVEBski1zamTUAasKuyDsEOCPe
         gJesa/m3aZeBhoFPQJVCGV6LmW9CchEZEw9WEWbtr/iwaSg2lOCnc4e8IQbZpoF7bu4i
         iXKw==
X-Gm-Message-State: AOAM530nfWDg64WiOvHjSsaqZL/4nWocu6iUtXTFWK3pwhBOYqn3W6ZU
        icvmMYU6TaTBgEebJnQqVNE=
X-Google-Smtp-Source: ABdhPJwN4t7uhD3jXF3PhhZs1jrwCC80z0rQWgnIHnRz+zVrKqbj+1StIEGxNhBWRH6L/3IqoB89Mg==
X-Received: by 2002:a7b:c104:: with SMTP id w4mr860839wmi.160.1632341165104;
        Wed, 22 Sep 2021 13:06:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:06:04 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 46/47] staging: r8188eu: remove rtw_calculate_wlan_pkt_size_by_attribue()
Date:   Wed, 22 Sep 2021 22:04:19 +0200
Message-Id: <20210922200420.9693-47-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_calculate_wlan_pkt_size_by_attribue() is not used,
remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c    | 18 ------------------
 drivers/staging/r8188eu/include/rtw_xmit.h |  2 --
 2 files changed, 20 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index f9ae48f73cdf..6213244450e7 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -861,24 +861,6 @@ s32 rtw_txframes_sta_ac_pending(struct adapter *padapter, struct pkt_attrib *pat
 	return 0;
 }
 
-/*
- * Calculate wlan 802.11 packet MAX size from pkt_attrib
- * This function doesn't consider fragment case
- */
-u32 rtw_calculate_wlan_pkt_size_by_attribue(struct pkt_attrib *pattrib)
-{
-	u32	len = 0;
-
-	len = pattrib->hdrlen + pattrib->iv_len; /*  WLAN Header and IV */
-	len += SNAP_SIZE + sizeof(u16); /*  LLC */
-	len += pattrib->pktlen;
-	if (pattrib->encrypt == _TKIP_)
-		len += 8; /*  MIC */
-	len += ((pattrib->bswenc) ? pattrib->icv_len : 0); /*  ICV */
-
-	return len;
-}
-
 /*
 
 This sub-routine will perform all the following:
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index 1244545070c7..01e8b90becf5 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -333,8 +333,6 @@ struct xmit_frame *rtw_dequeue_xframe(struct xmit_priv *pxmitpriv,
 
 s32 rtw_xmit_classifier(struct adapter *padapter,
 			struct xmit_frame *pxmitframe);
-u32 rtw_calculate_wlan_pkt_size_by_attribue(struct pkt_attrib *pattrib);
-#define rtw_wlan_pkt_size(f) rtw_calculate_wlan_pkt_size_by_attribue(&f->attrib)
 s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt,
 			   struct xmit_frame *pxmitframe);
 s32 _rtw_init_hw_txqueue(struct hw_txqueue *phw_txqueue, u8 ac_tag);
-- 
2.33.0

