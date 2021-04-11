Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F61335B46B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 15:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbhDKM6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 08:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhDKM6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 08:58:30 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DA2C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 05:58:14 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u21so15734086ejo.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 05:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ty8azWTSp8PJc78RW7jXgfpPMbgDKQilIYgTVUhzQAw=;
        b=qb7fseIOBvKqNVNCRLnk1NmkL2/ixAI2BBnOGtVuEJ7/BE1Ar7/62ld4qTtjw40HPl
         9Nvm6tWxFDb+4x1pWcqNujV1Jkl9YKC7IEXh6au97G8G5nqsEJg6I0q+f5LoiLegs9Fa
         gXiI7E6trpyGOafjXUOrGAHe1NiCnsU4+GCtDJSdtK5WDLXRf/HZtH4WHyDFwroDFjm8
         T9mpCcT5u7Zf5THBl1QSHq3cUyB4BWyoHZVuACWsfIQ+2s3DBLUG1hQJINPPuyoLi2pe
         W0FWjYz5zhyST+0JO5e1qYQekn/8NLSw97PMvFN56rP31DLBxoqSEVjtU08RxA6e/Tio
         UFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ty8azWTSp8PJc78RW7jXgfpPMbgDKQilIYgTVUhzQAw=;
        b=D2K+MW1G5MvSvHfHuE83Z6ycDLkUQmDDNrO4XtPLQaGmzt9mieAGH0pQS6vK+yNN8G
         mJNoIU7KYghSB+SQ/Q1jRMk/BNHj9r9pAiwb0UVkPg5Ph1how6KnDCDhEWVyUBsjfAPI
         Me0d9hawhpE+wkj1x8lK7isRwZyj9w/Yrm7zjJes1LD1KoNJ44E3tEEFzFHER9NjwcLR
         aRsT5LxUhSH4qliKTLqYDF1rTSLmPzg93jNnqqR0vkg/2mzMn1kX2H3rHw1TszsKpngQ
         quG9f3jzSuLkhSdelT8BoA4gMNDCUd7bcuW4jrCTC08RKCHTDtqaNZB7ujkuknNYengt
         sNAA==
X-Gm-Message-State: AOAM530WGyuBhuEAvR5xslDJz0eXo0cUWgSuTr0OId91bakfZ/ZkTwtv
        53V7nSXkHOpq7/iBif83hnQu9LIB47c=
X-Google-Smtp-Source: ABdhPJzwRBnAwpqYRDe0VJTVaxj2jq3OcSuTm2Bd7M0u2CkPeIx2RNsChhHxxbClGf1Hr5r7Zab81g==
X-Received: by 2002:a17:906:2e59:: with SMTP id r25mr14417503eji.268.1618145892847;
        Sun, 11 Apr 2021 05:58:12 -0700 (PDT)
Received: from agape ([5.171.72.218])
        by smtp.gmail.com with ESMTPSA id f19sm4031311ejc.54.2021.04.11.05.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 05:58:12 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: rtl8723bs: remove unused variable 'start' in hal/sdio_halinit.c
Date:   Sun, 11 Apr 2021 14:57:37 +0200
Message-Id: <ce1faa15052b519738656e11658dee93f9e91c29.1618145345.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618145345.git.fabioaiuto83@gmail.com>
References: <cover.1618145345.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following W=1 compiler issue:

drivers/staging/rtl8723bs/hal/sdio_halinit.c:
	In function '_ReadAdapterInfo8723BS':
drivers/staging/rtl8723bs/hal/sdio_halinit.c:1156:16:
warning: variable 'start' set but not used [-Wunused-but-set-variable]
1156 |  unsigned long start;
     |                ^~~~~

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 552afbaff081..28bb4aaedc5b 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1153,7 +1153,6 @@ static void _InitOtherVariable(struct adapter *Adapter)
 static s32 _ReadAdapterInfo8723BS(struct adapter *padapter)
 {
 	u8 val8;
-	unsigned long start;
 
 	/*  before access eFuse, make sure card enable has been called */
 	if (!padapter->hw_init_completed)
@@ -1164,9 +1163,6 @@ static s32 _ReadAdapterInfo8723BS(struct adapter *padapter)
 	val8 |= BIT(6);
 	rtw_write8(padapter, 0x4e, val8);
 
-
-	start = jiffies;
-
 	_EfuseCellSel(padapter);
 	_ReadRFType(padapter);
 	_ReadPROMContent(padapter);
-- 
2.20.1

