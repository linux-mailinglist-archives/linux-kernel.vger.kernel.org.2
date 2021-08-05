Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5351E3E1B77
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241459AbhHESh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241428AbhHEShr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:37:47 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31870C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 11:37:33 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id z6-20020a0568302906b02904f268d34f86so5810223otu.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 11:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lFSSR+B2VNCO9CHsb870x2POa5wOsOAfxAuwjoPuEis=;
        b=K4BRMbfUK6XZeLpv4Kb1TgO7NqJGJrrA8ef+LHvB6W1vcOYc/3IQ26WyGe2kyheXZ1
         5JkybDvhXeuimuFGXtVp4MsX7LPOXbtV1cqdlPZaV4R136f35PeHzkNuUKtFhqq9onor
         QA3AdT2hgNNo448KBRyYKVYZCky85bCwhtxx9iWfNrvcxF6lZwVsj/mqFzBcJ3e2C+49
         7ZyjrMSKSOK73M5KuJq/fH9FTCcEkE4RpTC2x0fcYScHdkpb/n2Y0DHyB64TwYSZ2bLY
         gUlITBpMNYopjktkFoaUUze9m8OIJizAb3Y4SQ3wwtyDX1KTaU20o6yyV77SOlt9Az2S
         7fJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=lFSSR+B2VNCO9CHsb870x2POa5wOsOAfxAuwjoPuEis=;
        b=sl9PCCLcizxvsQiS8+3hw393GzlgqM4eLx7unZS1MQ9qAwv58h1AgxtXUJR3sgbrGH
         2FMdRrlnByzfGBMpx1eRIpJcIzWURPV1vjQ1ImB4TS+M91ixWW2NItZE/pNGIyqxMNCA
         BYg83gWbe+4+3PDVot8x6KX/4fbcxD1lr0QBvB+68nHCpX7W0JSTe9GicQ3Q2bUI0Jy1
         zoPrHQ2IiA12XnoD4aqjyrkO4jzsPbfqwyskcFehoIZrd4O7hMlA0WA6GNCjZkPFGQ9p
         dNBI++8xO95AGCL+wP6jOQ10GCRZept3+nvviNqvZ6/eDXb65Smz7aM3Fz/8NS35Y3E0
         HVZQ==
X-Gm-Message-State: AOAM53119mMQ0t/Jse5Vc3zhSTpGQy5/Rd0gQv2IqNv7HtiKhXGZIbp6
        pewymjXAunr8DDhqX7g8L/c=
X-Google-Smtp-Source: ABdhPJxX2pVqOzXaAaY1MUFcMFy9KZFbXojNb5gWWQMobWy8MqnqcG+yHSS4CzkVvesw/OcvGOj66w==
X-Received: by 2002:a9d:75da:: with SMTP id c26mr4696519otl.289.1628188652637;
        Thu, 05 Aug 2021 11:37:32 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1016.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-1016.res6.spectrum.com. [2603:8090:2005:39b3::1016])
        by smtp.gmail.com with ESMTPSA id q32sm1156726oiw.37.2021.08.05.11.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 11:37:32 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 5/5] staging: r8188eu: Remove rtw_buf_free()
Date:   Thu,  5 Aug 2021 13:37:17 -0500
Message-Id: <20210805183717.23007-6-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805183717.23007-1-Larry.Finger@lwfinger.net>
References: <20210805183717.23007-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This routine is just a wrapper around kfree(). The wrapper also sets
buffer length to 0, and the pointer to NULL. The length variable is in
the struct to be freed, thus setting it to zero is meaningless. Setting
the pointer to NULL is also not needed.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/staging/r8188eu/core/rtw_mlme.c         | 4 ++--
 drivers/staging/r8188eu/core/rtw_mlme_ext.c     | 9 ++++-----
 drivers/staging/r8188eu/include/osdep_service.h | 1 -
 drivers/staging/r8188eu/os_dep/osdep_service.c  | 7 -------
 4 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 4ffed8a35054..e3d5a721d25c 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -99,8 +99,8 @@ static void rtw_free_mlme_ie_data(u8 **ppie, u32 *plen)
 
 void rtw_free_mlme_priv_ie_data(struct mlme_priv *pmlmepriv)
 {
-	rtw_buf_free(&pmlmepriv->assoc_req, &pmlmepriv->assoc_req_len);
-	rtw_buf_free(&pmlmepriv->assoc_rsp, &pmlmepriv->assoc_rsp_len);
+	kfree(pmlmepriv->assoc_req);
+	kfree(pmlmepriv->assoc_rsp);
 	rtw_free_mlme_ie_data(&pmlmepriv->wps_beacon_ie, &pmlmepriv->wps_beacon_ie_len);
 	rtw_free_mlme_ie_data(&pmlmepriv->wps_probe_req_ie, &pmlmepriv->wps_probe_req_ie_len);
 	rtw_free_mlme_ie_data(&pmlmepriv->wps_probe_resp_ie, &pmlmepriv->wps_probe_resp_ie_len);
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index a8ed4e1a0278..470c338b44e1 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -1519,11 +1519,10 @@ unsigned int OnAssocRsp(struct adapter *padapter, struct recv_frame *precv_frame
 	UpdateBrateTbl(padapter, pmlmeinfo->network.SupportedRates);
 
 report_assoc_result:
-	if (res > 0) {
+	if (res > 0)
 		rtw_buf_update(&pmlmepriv->assoc_rsp, &pmlmepriv->assoc_rsp_len, pframe, pkt_len);
-	} else {
-		rtw_buf_free(&pmlmepriv->assoc_rsp, &pmlmepriv->assoc_rsp_len);
-	}
+	else
+		kfree(pmlmepriv->assoc_rsp);
 
 	report_join_res(padapter, res);
 
@@ -5534,7 +5533,7 @@ void issue_assocreq(struct adapter *padapter)
 	if (ret == _SUCCESS)
 		rtw_buf_update(&pmlmepriv->assoc_req, &pmlmepriv->assoc_req_len, (u8 *)pwlanhdr, pattrib->pktlen);
 	else
-		rtw_buf_free(&pmlmepriv->assoc_req, &pmlmepriv->assoc_req_len);
+		kfree(pmlmepriv->assoc_req);
 }
 
 /* when wait_ack is ture, this function shoule be called at process context */
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index cb876b50d68c..10f0203fd905 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -370,7 +370,6 @@ void rtw_free_netdev(struct net_device *netdev);
 		(a)[3] = (u8) (((u32) (val)) & 0xff);		\
 	} while (0)
 
-void rtw_buf_free(u8 **buf, u32 *buf_len);
 void rtw_buf_update(u8 **buf, u32 *buf_len, u8 *src, u32 src_len);
 
 struct rtw_cbuf {
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index db6ee1dca48e..232d3a337be4 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -283,13 +283,6 @@ int rtw_change_ifname(struct adapter *padapter, const char *ifname)
 	return -1;
 }
 
-void rtw_buf_free(u8 **buf, u32 *buf_len)
-{
-	*buf_len = 0;
-	kfree(*buf);
-	*buf = NULL;
-}
-
 void rtw_buf_update(u8 **buf, u32 *buf_len, u8 *src, u32 src_len)
 {
 	u32 dup_len = 0;
-- 
2.32.0

