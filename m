Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76674354AE1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 04:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243377AbhDFCc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 22:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243368AbhDFCcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 22:32:55 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9928FC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 19:32:48 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so8844313pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 19:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=3K8MDaPlGRbY3ftET9m0Ij8E3KZKZRukEowLKCuMZ8g=;
        b=nEImKKfqFD+OW8rN4yJUDbXbw0X90WNZZuYPkrqxC3Owy2H7h2Hd56p6DL8eNiypJl
         vPQZdCY63aQUMfIFzLAJJrg+jzc/AogX3MBoNWjB51ibpWbezLNNHxSEsIL02HKKIGWx
         wde80EQDRXdKBVV3VNsj33XHH3q8Locyd1XkiYIDnA7VszrHm+VXjIlwIzuknYDzcNsA
         1a0hhVTEOSP4fWC1dTaIY8ilYjyLO0bN1qLBvXdq+jtLYg5eluZsKhdx9EV4O/RUoUzN
         4wlqbnICJ/TTFnVpQP5S2793FkBEGkgINBX/X5tNO6lLrvREZN+i6FUuWze2WWRCo6LR
         8jQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=3K8MDaPlGRbY3ftET9m0Ij8E3KZKZRukEowLKCuMZ8g=;
        b=tgAEoY5b/dTO7m0aoi/HPCiJNPgFGazkWJoCJvrcRsM2NXtx+uPsIwQzou9CrkmYBk
         Q4lVPUCh+iVpap2dtO7cpdt28guahSC08FG3PsmpWmAr/T4szapR1kIGWVc6oI23vrID
         32t8tqzQYq0ZVPaX/asHD97sF+iti9IaayvD1J1khcFQ5QX2Q4f8PpD94IFm9hG1CzaV
         klu6zMerNbkEY7T3chOFUz+ajcv+PO8tmHavi9ITMAnrm5Y8Yu5WY2lGaCdVpx/mfCw4
         s/NTEbHGLXy9B8EEP0dEfrUIPLuOYGTHiFfFJ5pyDkLG5RGqTd9CE7j3OPuvemThmn4A
         j9Xg==
X-Gm-Message-State: AOAM5327lrzCdhbhydPhZI9BJMZum1AKxpOU7BIW5Oyad8k6CQaRAQjG
        TSJ/jVACBfOUtQW3cb/LYo8=
X-Google-Smtp-Source: ABdhPJzxjB1KyBrVyIglZ0Xg0+O/cotS2I+P2k7EFIPRbRav+/BbOsC/7Z4lXHujNxkaGI9baIFzZA==
X-Received: by 2002:a17:902:dcc9:b029:e9:3900:1c9a with SMTP id t9-20020a170902dcc9b02900e939001c9amr2176382pll.9.1617676368264;
        Mon, 05 Apr 2021 19:32:48 -0700 (PDT)
Received: from djbComp.hitronhub.home (S0106ac202ecb0523.gv.shawcable.net. [70.67.120.89])
        by smtp.gmail.com with ESMTPSA id e7sm281196pfv.107.2021.04.05.19.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 19:32:47 -0700 (PDT)
From:   Deborah Brouwer <deborahbrouwer3563@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com,
        Deborah Brouwer <deborahbrouwer3563@gmail.com>
Subject: [PATCH 3/4] staging: rtl8712: remove space after cast
Date:   Mon,  5 Apr 2021 19:32:19 -0700
Message-Id: <b1ba94644f5204505623ffc64614671aac30bbd8.1617674639.git.deborahbrouwer3563@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1617674639.git.deborahbrouwer3563@gmail.com>
References: <cover.1617674639.git.deborahbrouwer3563@gmail.com>
In-Reply-To: <cover.1617674639.git.deborahbrouwer3563@gmail.com>
References: <cover.1617674639.git.deborahbrouwer3563@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unnecessary space immediately after a cast. Identified by
checkpatch: CHECK: No space is necessary after a cast.

Signed-off-by: Deborah Brouwer <deborahbrouwer3563@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_xmit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_xmit.c b/drivers/staging/rtl8712/rtl8712_xmit.c
index 4be81c2546fe..ad9ea05504db 100644
--- a/drivers/staging/rtl8712/rtl8712_xmit.c
+++ b/drivers/staging/rtl8712/rtl8712_xmit.c
@@ -228,9 +228,9 @@ void r8712_do_queue_select(struct _adapter *padapter,
 	struct dvobj_priv *pdvobj = &padapter->dvobjpriv;
 
 	if (pdvobj->nr_endpoint == 6) {
-		qsel = (unsigned int) pattrib->priority;
+		qsel = (unsigned int)pattrib->priority;
 	} else if (pdvobj->nr_endpoint == 4) {
-		qsel = (unsigned int) pattrib->priority;
+		qsel = (unsigned int)pattrib->priority;
 		if (qsel == 0 || qsel == 3)
 			qsel = 3;
 		else if (qsel == 1 || qsel == 2)
@@ -359,7 +359,7 @@ void r8712_dump_aggr_xframe(struct xmit_buf *pxmitbuf,
 	struct tx_desc *ptxdesc = pxmitbuf->pbuf;
 	struct cmd_hdr *pcmd_hdr = (struct cmd_hdr *)
 		(pxmitbuf->pbuf + TXDESC_SIZE);
-	u16 total_length = (u16) (ptxdesc->txdw0 & 0xffff);
+	u16 total_length = (u16)(ptxdesc->txdw0 & 0xffff);
 
 	/* use 1st xmitframe as media */
 	xmitframe_xmitbuf_attach(pxmitframe, pxmitbuf);
-- 
2.17.1

