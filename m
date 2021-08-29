Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6101F3FAB17
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 13:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbhH2L1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 07:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbhH2L1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 07:27:01 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8489AC061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 04:26:09 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id x2-20020a1c7c02000000b002e6f1f69a1eso12600499wmc.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 04:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QGo97a/NDJep+g5Rg/qGoBs9gtgsnViOlIFalmxQGzI=;
        b=IPkR5skgm4CMe1oFReL16nly+UM2N6csEDg71/BvRtnkYjjgu5FtTUrBpO2IHAaHkU
         aoYmIFxlD2SVZZ16ILcElUujThC7Lw4lKbWxx5yr9/QkEis9GtelJT65/1jEjCV+YhTp
         CWw+zEt1gAJDeB8iPpWchRjxa+KLXRooRTfDU4WJl9+966Ua282S0SOL1IPXQ00b9181
         kdJUv9eBP3gqIUxyuXz/YXCnSxYFBVZPjrnr9wkd37LBhOEtu5Qw3ze8Rub3qBCcLREV
         jMyqWTTrxXFA3iAu2kiGaFDzTdUtdOjq5jdsXvxtXKOZ+viECh43d+zoPlWHI5Jkpuv0
         AoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QGo97a/NDJep+g5Rg/qGoBs9gtgsnViOlIFalmxQGzI=;
        b=TD1QdWAklzpardnl7QeKpkSMrd1Y/aK71o5KBAheXz5fHcRuB7EE8/iDXp0iP6SXlu
         eXXFcyPHyM3OqBu0LCR+4zB3Ds/nar8PxRPswFlPpzbXxNbN1acoUY2KbfYGNy0lDd7n
         kR8TwteQaODiZJXDEMDFaO3qfWIbJ3iVL1LkJcswyRkuFZJ0rBhsnh5gPxFf7y2H90iA
         TDN0o5xjgv6qkb63/xxh5QqHssmECw3/0XQ/8FaoIsaCiWVvUKYgxFtFZZq3YOsTq82T
         VJohcKwRsUd1KXM4ol6OFQpj6V1Tq4L0i7OgDfV+biUxoQzo49KPs1c/w+k5R9JooNjx
         KWhw==
X-Gm-Message-State: AOAM532krtQuxorIsV/qqWL4WwA00DWB/WcAjiDjf8qsJ7oQTNtgG3bw
        MtrpGE6NHjj0rtLm7v0qW0g=
X-Google-Smtp-Source: ABdhPJxMNFgTH0+PTuWmU05Zg9BIAnfXSY3aCK50wvhC4hyt1oRnlcPRvekaXmkxmclIlPWEn3uXTQ==
X-Received: by 2002:a7b:cc0a:: with SMTP id f10mr17633896wmh.32.1630236368228;
        Sun, 29 Aug 2021 04:26:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id h8sm15826581wmb.35.2021.08.29.04.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 04:26:07 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: r8188eu: remove unnecessary type casts
Date:   Sun, 29 Aug 2021 13:25:55 +0200
Message-Id: <20210829112555.8726-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829112555.8726-1-straube.linux@gmail.com>
References: <20210829112555.8726-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field rx_data of struct recv_frame and the local variable pframe
both have type (u8 *). Remove unnecessary type casts to (unsigned char *).

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_security.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
index 0836f38ca284..48f77c6cf43c 100644
--- a/drivers/staging/r8188eu/core/rtw_security.c
+++ b/drivers/staging/r8188eu/core/rtw_security.c
@@ -145,7 +145,7 @@ void rtw_wep_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
 	struct	rx_pkt_attrib	 *prxattrib = &precvframe->attrib;
 	struct	security_priv	*psecuritypriv = &padapter->securitypriv;
 
-	pframe = (unsigned char *)precvframe->rx_data;
+	pframe = precvframe->rx_data;
 
 	/* start to decrypt recvframe */
 	if ((prxattrib->encrypt == _WEP40_) || (prxattrib->encrypt == _WEP104_)) {
@@ -600,7 +600,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
 	struct	security_priv	*psecuritypriv = &padapter->securitypriv;
 	u32		res = _SUCCESS;
 
-	pframe = (unsigned char *)precvframe->rx_data;
+	pframe = precvframe->rx_data;
 
 	/* 4 start to decrypt recvframe */
 	if (prxattrib->encrypt == _TKIP_) {
@@ -1412,7 +1412,7 @@ u32 rtw_aes_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
 	struct	security_priv	*psecuritypriv = &padapter->securitypriv;
 	u32	res = _SUCCESS;
 
-	pframe = (unsigned char *)precvframe->rx_data;
+	pframe = precvframe->rx_data;
 
 	/* 4 start to encrypt each fragment */
 	if (prxattrib->encrypt == _AES_) {
-- 
2.32.0

