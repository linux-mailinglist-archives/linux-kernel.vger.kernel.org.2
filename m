Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8D74373DF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 10:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhJVItz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 04:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbhJVItv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 04:49:51 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E42C061348
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 01:47:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 5so1083861edw.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 01:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4LeBk9mKvA7THBr02ThBK2DGWw4nA3oZq6PqI9mSeIo=;
        b=LGSEergeG/fObDf4CwCzPxECyDmdvD8gofl19vP0jL8SnWpqBpiziyPqqAQ3gsqyRU
         yUo2PR2ACCTPhcC24i0ypHCmUY7tng9AO1pBbq7i6YvQ2Bz9C9RFOJBYNyyYsPqfdDYD
         G8//euFK2h2TN7Hie3bwal/n+XhjXs8XAwvovImWGa7eMI6PGfnHNhbobBhF+MTTceWa
         OUk8yGQTa7cmK47bS3AG9nGGHBaEwlK1Zkv2DS3pIjgq/kgm2kzB2fhsfbvlIj6dsXO+
         WlJNqcMRl465tjj7LFcs4pvrI3p+n03QszONrBS2UlTe1JSM/JxQ6aL2dn83zYD7++Jf
         teVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4LeBk9mKvA7THBr02ThBK2DGWw4nA3oZq6PqI9mSeIo=;
        b=5YGLEqJqUqKVa0wLpIkQBAglKbrvP2/lM3poZvr7IrTZ841enW/wHE6d3074FRLJzk
         fvls1aqNiMP8evxfNfHIkxHtXll4Y7D6PQDDwdVVmC74OG3Y/LKzwIamwJMu6uRVhZkx
         LNB9cE17AajhniPcHj986WrwwAJhs+shTh6qBVW2F64tOJRM2Iq/2npvRm26z2xT+/sV
         setVAwcsJwUoR0gg1DLI07jqMu9oIjwQkL5plFFbRafl7++VOYyNHblfS4WnUOWivMzU
         WhixBhK5ac0WsISPrU+U70WTyFjspx6Qve/Wc+p5S1+rumNUYF0oRDXr+VigjeMpHkxf
         ZNRg==
X-Gm-Message-State: AOAM533XvA//hqyjpkpoXV/pFv1vK3kVsSlUUecAOonKEsQ8e1W6P8+S
        P9cv1R7pCcMXzDQhj8D/6N3TeFHIJ7w=
X-Google-Smtp-Source: ABdhPJz6Ei1KJbqXS1wHRN2XAgKoCsdqBZ6ci1rm13UDEz6V9atRhADpWrNgNr1q0VAq2cAUWGJLTw==
X-Received: by 2002:a05:6402:4315:: with SMTP id m21mr15210326edc.277.1634892452793;
        Fri, 22 Oct 2021 01:47:32 -0700 (PDT)
Received: from localhost.localdomain (host-80-181-148-119.pool80181.interbusiness.it. [80.181.148.119])
        by smtp.gmail.com with ESMTPSA id au26sm3446979ejc.53.2021.10.22.01.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 01:47:32 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: Remove initialized but unused semaphore
Date:   Fri, 22 Oct 2021 10:47:26 +0200
Message-Id: <20211022084727.28035-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022084727.28035-1-fmdefrancesco@gmail.com>
References: <20211022084727.28035-1-fmdefrancesco@gmail.com>
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

