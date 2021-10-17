Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7774309C3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 16:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343901AbhJQOav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 10:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343876AbhJQOaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 10:30:46 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918A3C061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 07:28:36 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r18so59942012edv.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 07:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mycPYYzNiy40/QpQ966UCwEVtMGhxE3IcAOGWpXWkHY=;
        b=Xwyw9Ecgu7OEjt+tqPeAThlTdTamtQyQF5yxfjhGsfULy54V8gdNzVPOa08FGAHfNm
         7sJzEmg/z7IT9mCFLBd9IZBBbKdONdhDXCgfjVHUE2QNjvdmgXP0kgzdksjo/5YGpzmL
         NdIynIh78w0e8tLz1nC6RsXeWIAmLWHIJL/VdhbRsKKcCe6m6BxgMLhgF1Zh/hc79wDJ
         fS4IV/IqPLC6nHtwxneif6urdjEjW6ACecDnVW+Tgdk6aLrgDnbMjI/Jfwjk7RaEc7/l
         czWKJMe+4TUqt8lbOxF6Hoexth+TucKBZdgQCgJRvpRQxgKgEFeyoOh87Ju2Kgv4uaoc
         IFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mycPYYzNiy40/QpQ966UCwEVtMGhxE3IcAOGWpXWkHY=;
        b=3C3Ixe6EeCEow3Io5Be2ek4/Rx0ts9v+JGneItJ61Snr9pH18NC+a/h7DDGUvYqZoB
         rE8fPZrUmRlvC8qf4Dh7oqu/EU0QRDRYnHB57NlRO6iV+cpMRD1soJg01+MDydUnETeW
         X3VdzeEWUjy4YVjyq6jtU5lZz0brtAgX3+WFAy4h4tyzq3B3wo8pnTKJw/i/PRueLc5G
         BrA0Zy8l6Zcie12zb7VfCrsG0bvxR6yXVsYwrLMIhlyBTb2nthBOo5NSNWbNE6xsN/9n
         bov9WoYrp3urJ4xE3RNHd2Mg5SbwW4d7jsPtGsKfiZIoATHTEZUP5NU3M5U13RE3DYYB
         /Jlg==
X-Gm-Message-State: AOAM532Yaoh4q4scsR/SN6QbR0vP1YtJJ2F+NgUzkUN6d8vE/ryOnI4f
        HUbWXJHdK+gD8s0vM7iRRCE=
X-Google-Smtp-Source: ABdhPJyQPKRGwHPaRMBKuAqQuiuaNmagiV6GxgI9HlXVz0jm/s8NZw7AhYTTss9FHr3mhGqHMhrxMw==
X-Received: by 2002:a17:906:af0e:: with SMTP id lx14mr21156096ejb.76.1634480915156;
        Sun, 17 Oct 2021 07:28:35 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-47-104-180.retail.telecomitalia.it. [79.47.104.180])
        by smtp.gmail.com with ESMTPSA id p23sm9094537edw.94.2021.10.17.07.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 07:28:34 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 3/3] staging: r8188eu: Remove redundant 'if' statement
Date:   Sun, 17 Oct 2021 16:28:12 +0200
Message-Id: <20211017142812.4656-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017142812.4656-1-fmdefrancesco@gmail.com>
References: <20211017142812.4656-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a redundant 'if' statement.

Acked-by: Martin Kaiser <martin@kaiser.cx>
Acked-by: Phillip Potter <phil@philpotter.co.uk>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 6fb79d711692..42084b029473 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -254,12 +254,6 @@ int rtw_cmd_thread(void *context)
 	while (1) {
 		wait_for_completion(&pcmdpriv->enqueue_cmd);
 
-		if (padapter->bDriverStopped ||
-		    padapter->bSurpriseRemoved) {
-			DBG_88E("%s: DriverStopped(%d) SurpriseRemoved(%d) break at line %d\n",
-				__func__, padapter->bDriverStopped, padapter->bSurpriseRemoved, __LINE__);
-			break;
-		}
 _next:
 		if (padapter->bDriverStopped ||
 		    padapter->bSurpriseRemoved) {
-- 
2.33.0

