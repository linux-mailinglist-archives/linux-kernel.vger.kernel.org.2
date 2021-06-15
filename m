Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309F43A72E9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhFOATg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:19:36 -0400
Received: from mail-qv1-f41.google.com ([209.85.219.41]:39512 "EHLO
        mail-qv1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbhFOAT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:19:27 -0400
Received: by mail-qv1-f41.google.com with SMTP id u14so18549401qvq.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LDmOsYVaCzlk9qYppvZ+JP5Z48gdrmbK+dHMmlrX/Bo=;
        b=Q/mUaH+SEMTpbDavzaI68D7WdRy0KDfidEPATNMqNkRSsd/vOkRbBag/MizNQdDouJ
         SM7XVtFE0ROiOLl62pmi8Wc3UR/fXJ32pvj78xyHya5YEKuDvxeLZqdt1F0rbZ/Ubftw
         bmrKsK1Ai6ho4blVIMTqtk7FPUYX6HVgd1ba2873nzoHHiH53wMFQRjMiXZq2rxNZIRx
         eHH4eH7kyzGXBaQioqPeWhlxaG1wuztzQpGXG/gPlceYb3Yx3krUJu+oYlz0bQvgrOiq
         C/+GKIjOxsRA8y8EkSpM8mll8yKEVrCeVNb1Xzd30nrXAvnpIetAcIxalN90LN1wEcSu
         TiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LDmOsYVaCzlk9qYppvZ+JP5Z48gdrmbK+dHMmlrX/Bo=;
        b=K3USmKbRyJ8E055nXVizJGIBqvi8wXKX1QOcdHBpl0AkRr7vHdKsAorGnm3yf62RWb
         UtO/8plfguj0SLFG4/jszVV8B6q20Vaaic4b/PsbCu45CSeQEnHhDfJldssqfdoNo6Oa
         Mpow+iPwJniG9twba5lWOeu7Fhg8bkAn6hq7wOd8hnjcRes96EYHDDRRoVw5w4HT2qUq
         5+H26NducH7B+Inzj5QxyqImRMVj492kWt3LzsfQ9p9l8wagA8lhhimmsmyoY6H7dLIU
         zDg4BeICAEOY6tFAm7pMAPWcHsKVY4Cf6G0rHEOtvaMHwG/9g85mkewMos5lGI9X2dV6
         QFcA==
X-Gm-Message-State: AOAM532DDdng3F94xZSUN/fBfCRbTpqi+C9mHV0EzSLjlK2gRLiHayDR
        hbd7UsgIgoaKqPoi/PiZL5Scgw==
X-Google-Smtp-Source: ABdhPJyVS1d6pWlw7K3ltUTuHI7A4IE3bYFHqbQP16ufFau5xMsOmyMGSqUMsiSG18+/5ZjxM/WxzA==
X-Received: by 2002:a05:6214:f2f:: with SMTP id iw15mr259837qvb.33.1623716168739;
        Mon, 14 Jun 2021 17:16:08 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id m199sm11244248qke.71.2021.06.14.17.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:16:08 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 15/28] staging: rtl8188eu: remove all DBG_88E calls from os_dep/xmit_linux.c
Date:   Tue, 15 Jun 2021 01:14:54 +0100
Message-Id: <20210615001507.1171-16-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615001507.1171-1-phil@philpotter.co.uk>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E calls from os_dep/xmit_linux.c as this macro is
unnecessary, and many of these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/os_dep/xmit_linux.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
index 6935bdb2d7d2..c73f94651e93 100644
--- a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
@@ -26,10 +26,8 @@ int rtw_os_xmit_resource_alloc(struct xmit_buf *pxmitbuf, u32 alloc_sz)
 
 	for (i = 0; i < 8; i++) {
 		pxmitbuf->pxmit_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
-		if (!pxmitbuf->pxmit_urb[i]) {
-			DBG_88E("pxmitbuf->pxmit_urb[i]==NULL");
+		if (!pxmitbuf->pxmit_urb[i])
 			return _FAIL;
-		}
 	}
 	return _SUCCESS;
 }
@@ -132,16 +130,12 @@ static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
 			memcpy(newskb->data, psta->hwaddr, 6);
 			res = rtw_xmit(padapter, &newskb);
 			if (res < 0) {
-				DBG_88E("%s()-%d: rtw_xmit() return error!\n",
-					__func__, __LINE__);
 				pxmitpriv->tx_drop++;
 				dev_kfree_skb_any(newskb);
 			} else {
 				pxmitpriv->tx_pkts++;
 			}
 		} else {
-			DBG_88E("%s-%d: skb_copy() failed!\n",
-				__func__, __LINE__);
 			pxmitpriv->tx_drop++;
 
 			spin_unlock_bh(&pstapriv->asoc_list_lock);
-- 
2.30.2

