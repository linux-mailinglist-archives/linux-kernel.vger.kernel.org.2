Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC373144AA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 01:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhBIALc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 19:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhBIAL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:11:28 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A40C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 16:10:47 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id z6so19335593wrq.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 16:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GfxWeqZv74fL5wiEGR/9EmBzuid1yAKJzrUNCh2im5s=;
        b=wdNm5bwn+Mz4aaTw0P9QXJYZV5jqAH5GC1/N0tZzY3j3M9zYVyVwnN8vTkzU+Rgz54
         VY9MQODGBsDWl9dSYc6Qef3fox/zlupG9bn8dZ/RtE9yy1hOD3fkd2iu7JRuTLqJKkYD
         K1lApyDQ6dO0oqwSA7lXpKhrOJODJ2TeWp5DS0v9HTZBkRlLhrrY6p3rfCsfKy+SCihN
         TbOc9Hdk0ZonCUMtwZNdSS8FhUX9bom9Xgx7WODEb9/X2BGb4U79f7H4opXunG4T4j8i
         inD7L9Vlh4svNtxM1bBZ5UZvZihihPwob2XjPzGs/Y/FB1ubeW/Z8KWvwsBrYU/vmxWK
         f0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GfxWeqZv74fL5wiEGR/9EmBzuid1yAKJzrUNCh2im5s=;
        b=bnkwMiw7anyeXzDSW6CV+Ac9WTDeF1w+fWANXRu0ovQcgo4QNZOB4CtI+ypl3U5/Wo
         GxH//MTLHf0LKcyMpdkI/IkMFiZrmF8dLCCHIcX126B1uX1cXPvcyD2+zr4Ue9+cSL71
         t1E3gLqKbTl4QsnpGqKMdXpeI/JQMhvxveHdDP543v+E9h6OKOTFRls8tiLSPHPj+QED
         7EMtOMjZAji/tBWx0+yjrvR3DO7asRnD4li38ft6Z+rTBnHnvSwyc7vL/V/YpLFMEVru
         Ojmbd9iZssHKexjTqc1pAedmCTCycKY22AVTq6bqxhyAebYmxKP/q4aM4Vrf8m75RMdx
         Fpzg==
X-Gm-Message-State: AOAM530fOVvoBlbTnQWDfmbXMXKJ33TnjmdQKs1ujtTfQV1rmRlxqn5r
        ykmvbDk6j4etMZicZ2ycFh6r3w==
X-Google-Smtp-Source: ABdhPJzdiQojncz4FPPUjPXfIRehs9KDVfAuUpSwd7gtZzEheRHpZAkd25li6RyVgcROBCxuk9Wlfg==
X-Received: by 2002:a05:6000:1373:: with SMTP id q19mr7714031wrz.371.1612829446505;
        Mon, 08 Feb 2021 16:10:46 -0800 (PST)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id q7sm32062914wrx.18.2021.02.08.16.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 16:10:45 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     foxhlchen@gmail.com, eafanasova@gmail.com, luk@wybcz.pl,
        ross.schm.dev@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: remove braces from two single line if blocks
Date:   Tue,  9 Feb 2021 00:10:43 +0000
Message-Id: <20210209001043.165080-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove braces from both occurences of single line if blocks in
include/rtw_mlme.h, fixes two checkpatch warnings, thus clearing
this type of warning from this file.

Also swaps two if statement comparisons around, so the variable is on
the left in each one. This fixes two warnings also.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8723bs/include/rtw_mlme.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme.h b/drivers/staging/rtl8723bs/include/rtw_mlme.h
index ea0dd156051e..d8655cb619a1 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme.h
@@ -524,18 +524,16 @@ static inline void set_fwstate(struct mlme_priv *pmlmepriv, sint state)
 {
 	pmlmepriv->fw_state |= state;
 	/* FOR HW integration */
-	if (_FW_UNDER_SURVEY == state) {
+	if (state == _FW_UNDER_SURVEY)
 		pmlmepriv->bScanInProcess = true;
-	}
 }
 
 static inline void _clr_fwstate_(struct mlme_priv *pmlmepriv, sint state)
 {
 	pmlmepriv->fw_state &= ~state;
 	/* FOR HW integration */
-	if (_FW_UNDER_SURVEY == state) {
+	if (state == _FW_UNDER_SURVEY)
 		pmlmepriv->bScanInProcess = false;
-	}
 }
 
 /*
-- 
2.29.2

