Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77327437544
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 12:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhJVKMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 06:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbhJVKMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 06:12:51 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301CEC061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 03:10:34 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id ec8so9388174edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 03:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4LeBk9mKvA7THBr02ThBK2DGWw4nA3oZq6PqI9mSeIo=;
        b=J80ueK4Od9w7JI2xbZ8DGcOB9hspdUoG9Px8+I5/33VSdRMOe1zNQfJlqL/d/Efvgz
         WBkVoehQyIFcE9zqz4Y656zxl9kFJUXTPuhWb3pkJqo5Lpdsea8izHBmpKe+xllNXvUN
         ymHjNMRCGjqq2s/48QXRn26znQxBoaQmo22MvZKHfIgPDS5ZDFSfWgVp44VUSAI6mvJS
         gfRZORMIsB7H07TGc+JCbEFUnrqc9c3PLWu9p9FJ1QpfPM+QITXqbTaZSUx0pJp1Wq14
         Yi8BMhaAXhkyuMb4ssak8/aTrlqtswMGDkh9sD0EY2lvTBxlL6PukMiS3s0P8GncEWcp
         pAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4LeBk9mKvA7THBr02ThBK2DGWw4nA3oZq6PqI9mSeIo=;
        b=vOTNfzB5f5dO1tLCN6qX8sEJhU56EM6xWp1nuUnVTw4HbM8h9YXdaTIgLUDTmNgLhA
         +lh7aECMtugduK4SABlqlRffPxU09VU0dWwxEfcTxRakvrAwZ3/yTcpescYsqsKT1I8T
         C5AzZxQB6w9u/JR6xTuBpPbZfswFIrGc3lDWOrSpB9MyAwKsyRG0oUKIFTBUxcI9YUSk
         DTSGQxWRf7nMqt09KHwA+6QGi82VCV00VuhwwND40Igr1rpt93hMNzNkTN4nUZw1wjSL
         HCRLU/5yPgFp0PtFKStxpIoxwU0ny1e1mchaZQZ1AT74pAHeaHH/4602yZJH/zRtf/Kz
         HACg==
X-Gm-Message-State: AOAM530jaEmbqvDsYve0fxtAXgHS3xxU7mjkXUWPYIQeBGpqwLR/mAcr
        1m7MwldHpgxRGV9ohOyHUad+Eys3O8I=
X-Google-Smtp-Source: ABdhPJyzVW7IMScoqeA0lti5W06Pk2xOMUTiDaed/DaUwwSt08cTQx/bnl+ixj84xxq0bLkBaLpC8g==
X-Received: by 2002:a17:906:6403:: with SMTP id d3mr13748443ejm.37.1634897432749;
        Fri, 22 Oct 2021 03:10:32 -0700 (PDT)
Received: from localhost.localdomain (host-80-181-148-119.retail.telecomitalia.it. [80.181.148.119])
        by smtp.gmail.com with ESMTPSA id j15sm4243446edl.34.2021.10.22.03.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 03:10:32 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 1/2] staging: r8188eu: Remove initialized but unused semaphore
Date:   Fri, 22 Oct 2021 12:10:27 +0200
Message-Id: <20211022101028.30367-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022101028.30367-1-fmdefrancesco@gmail.com>
References: <20211022101028.30367-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove semaphore "xmit_sema" from "struct adapter" because it is
initialized but never used.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c    | 1 -
 drivers/staging/r8188eu/include/rtw_xmit.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 720e190a7436..0c033a077bf9 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -49,7 +49,6 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	/*  We don't need to memset padapter->XXX to zero, because adapter is allocated by vzalloc(). */
 
 	spin_lock_init(&pxmitpriv->lock);
-	sema_init(&pxmitpriv->xmit_sema, 0);
 	sema_init(&pxmitpriv->terminate_xmitthread_sema, 0);
 
 	/*
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index ea8e82e0b4be..b2df1480d66b 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -256,7 +256,6 @@ struct agg_pkt_info {
 
 struct	xmit_priv {
 	spinlock_t lock;
-	struct semaphore xmit_sema;
 	struct semaphore terminate_xmitthread_sema;
 	struct __queue be_pending;
 	struct __queue bk_pending;
-- 
2.33.1

