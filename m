Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02A143AADF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 05:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbhJZD6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 23:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbhJZD6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 23:58:17 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D77C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 20:55:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id y1so9352379plk.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 20:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=jT56R8thic/ZxbSI8kRsJDsnZUfYJtsBr78ZdkZB++g=;
        b=KTXsGqDUekb/etDelz3qvN9JZR/TMLaUheLzeZvpokHqY+rDelz+x8QQqMnuSxo8vx
         IahoSrHuzbmRjQvRie7WfRxB/bBQHTgBYDcYDrbayZlydlPEK9iCfjXmHJHuVxU51YS+
         3ZhH3UZNITCYZDcg4fh6rQwE6KjQ12f5sOakxfv4YGHKCjkea8VmZ9ZJW3yabbP7uFxr
         FFPgIC6YpffjvJSi55IoTT7aOpg+E6V1cwjJxDs6AZFmuYtYdYuItkSmCGmjxvGLDHQY
         RNH7RPOsH35KEqcMIOsAG+x5AwP7hUipnQyUlYbYjQooJIKU/zoVUFT6r8XWMqR9P/aW
         lY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=jT56R8thic/ZxbSI8kRsJDsnZUfYJtsBr78ZdkZB++g=;
        b=M9H4unSpXRVP4m9DNWMP3WiECkHEm7UT1tXGK4+iH/BJGvf0QWKYffNUldKSqeAuJo
         YH0kxKxTOkoRUJGl08iHahQuEgPnfDwLlYML/P3SpfFzLz/Q9io7nuSRVlrrRhTiBFrP
         ZOOgHNUpCv5JU3lsLDprpNaizDcsTYzsQQ2v5DoMYiTaRha4wQwbkoTbqvAOehvDp5kw
         WLgCK7USlqsE5V5L6DoZ3tYeCgvsNBcxXMWkH5UDCTX3jlOuQIM6qXx/SzRgCQ6Ct+lw
         ejKN0Q2aXHw67rakTbqkpzCI0df1Isf7O7/FE1t9h/FDwc06Kn0WyRaj7ur+e4FfrdrY
         hgkg==
X-Gm-Message-State: AOAM530A0eK+voyYYAJDqgzsYr2BfBi5RYCM0tb8P7HOhlM6xdvHCaxB
        CSy73MT4AuGkL/n3Gp3p8CM=
X-Google-Smtp-Source: ABdhPJx/tbq495MTTzwmabiKX0Rxbwvklp7Cbb+CJPJE5IPtAdBBLA/Y0DNZDBiyWzY0pKSuAfuljw==
X-Received: by 2002:a17:902:7e4b:b0:13d:b90d:cdc1 with SMTP id a11-20020a1709027e4b00b0013db90dcdc1mr20615321pln.72.1635220553779;
        Mon, 25 Oct 2021 20:55:53 -0700 (PDT)
Received: from Sauravs-MacBook-Air.local ([59.95.95.35])
        by smtp.gmail.com with ESMTPSA id t40sm5167291pfg.142.2021.10.25.20.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 20:55:53 -0700 (PDT)
Date:   Tue, 26 Oct 2021 09:25:45 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        saurav.girepunje@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: core: remove the goto from
 rtw_IOL_accquire_xmit_frame
Message-ID: <YXd8QdhiNX3B1nqe@Sauravs-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the goto statement from rtw_IOL_accquire_xmit_frame(). In this
function goto can be replace by return statement. As on goto label
exit, function only return it is not performing any cleanup. Avoiding
goto will improve the function readability.

Remove the assignment of NULL to local variable xmit_frame just before
return of function. As function return, local variable will be not
available on memory. So assigning a NULL value to local variable just
before function return does not required.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_iol.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_iol.c b/drivers/staging/r8188eu/core/rtw_iol.c
index fe6078864158..7e78b47c1284 100644
--- a/drivers/staging/r8188eu/core/rtw_iol.c
+++ b/drivers/staging/r8188eu/core/rtw_iol.c
@@ -13,15 +13,14 @@ struct xmit_frame	*rtw_IOL_accquire_xmit_frame(struct adapter  *adapter)
 	xmit_frame = rtw_alloc_xmitframe(pxmitpriv);
 	if (!xmit_frame) {
 		DBG_88E("%s rtw_alloc_xmitframe return null\n", __func__);
-		goto exit;
+		return NULL;
 	}

 	xmitbuf = rtw_alloc_xmitbuf(pxmitpriv);
 	if (!xmitbuf) {
 		DBG_88E("%s rtw_alloc_xmitbuf return null\n", __func__);
 		rtw_free_xmitframe(pxmitpriv, xmit_frame);
-		xmit_frame = NULL;
-		goto exit;
+		return NULL;
 	}

 	xmit_frame->frame_tag = MGNT_FRAMETAG;
@@ -35,7 +34,7 @@ struct xmit_frame	*rtw_IOL_accquire_xmit_frame(struct adapter  *adapter)
 	pattrib->subtype = WIFI_BEACON;
 	pattrib->pktlen = 0;
 	pattrib->last_txcmdsz = 0;
-exit:
+
 	return xmit_frame;
 }

--
2.33.0

