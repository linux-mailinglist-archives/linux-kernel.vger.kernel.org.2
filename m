Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9333B39F4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 02:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbhFYAKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 20:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbhFYAK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 20:10:29 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5228CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:09 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id g19so4293046qvx.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nG8czYQq+AZDzTKmy+p+Lqp8NXCVXDm6kknTx2f14Lc=;
        b=P+EwKiMwN4FapoVrvCfkmrsvmwj9UHQajHhNkZGiLQ8G4PHK6dCvKjU6SPtxQ80dh4
         OnG771XoREKp9sTRBEdZtvZUFZdxDxMqKMyycSas2M/xN81APHYFWRoOwCN4F8I7onA6
         9VcEcyxBaly0iLq4upXJGDZvppBHERXrpFufauTDpo2lO2ZZFOr/2rgAwHSTIBLxRUfH
         RFNOvnnqXEXsUMkTETFs1Z9HDYz//gD4zcBzTcYJbkaNEED1JTv+e6pQArUmcNgWZ3Lz
         QUQWcNdiqSNEAJ/p9ljY5uyjQoK1SeRIPV8Svy2g6UC4hmWjvNitZAM9B4HHr3AFx7KM
         3Plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nG8czYQq+AZDzTKmy+p+Lqp8NXCVXDm6kknTx2f14Lc=;
        b=n4rqxVC/Pwj0SxtcGWxBX312Auus6+Yo+dX4/AfQnGa1byBbzkiGzhoqB7ReQRajS1
         et2g5/Ih3TZN4+pnAJO/YmSn6VrrsVBYBHt6/a8yQgzb8z2WGXT22gXr4F5P7slNFVdx
         IaUkoPzzieEnOp8XUGNNZsxHOpUD0SIcwndyWOdv+3vWNKXXtktgrsKru+8bBbunJDyg
         hVcMl8uwAZCdYSwg1bPoDKNdlGI+MKyOtGlYmJUmyq0IlU8wkWJyHFATbhrmS4c9fMXU
         kwOeQ4+XedyoSK8ve7tq3v/8o3Aizywv3tB/2s0RkUcbZqoL7logtgnBlT61MbblF2g/
         SvvQ==
X-Gm-Message-State: AOAM533J3Ptdc4FMoic5ovuURMS1uOQdctlmV6dbPYn/vNHhw9isFR+S
        YktFzhbwqeQ1+21FxKtpi9Yxmw==
X-Google-Smtp-Source: ABdhPJytHmnMXe7eA1ldnkNnqL6Oz/5JHvpq/CHwCYuaLKx5Wb24hy4tFoi8+rfDR95jUbh0aB9E1w==
X-Received: by 2002:ad4:4306:: with SMTP id c6mr8329435qvs.37.1624579688513;
        Thu, 24 Jun 2021 17:08:08 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id m187sm3629014qkd.131.2021.06.24.17.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 17:08:08 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 05/23] staging: rtl8188eu: remove all RT_TRACE calls from os_dep/recv_linux.c
Date:   Fri, 25 Jun 2021 01:07:38 +0100
Message-Id: <20210625000756.6313-6-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625000756.6313-1-phil@philpotter.co.uk>
References: <20210625000756.6313-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all RT_TRACE calls from os_dep/recv_linux.c as this macro is
unnecessary, and these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/os_dep/recv_linux.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/recv_linux.c b/drivers/staging/rtl8188eu/os_dep/recv_linux.c
index a647cdc330e4..3460619ae08f 100644
--- a/drivers/staging/rtl8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/recv_linux.c
@@ -72,11 +72,8 @@ int rtw_recv_indicatepkt(struct adapter *padapter,
 	pfree_recv_queue = &precvpriv->free_recv_queue;
 
 	skb = precv_frame->pkt;
-	if (!skb) {
-		RT_TRACE(_module_recv_osdep_c_, _drv_err_,
-			 ("%s():skb == NULL something wrong!!!!\n", __func__));
+	if (!skb)
 		goto _recv_indicatepkt_drop;
-	}
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		struct sk_buff *pskb2 = NULL;
@@ -124,9 +121,6 @@ int rtw_recv_indicatepkt(struct adapter *padapter,
 
 	rtw_free_recvframe(precv_frame, pfree_recv_queue);
 
-	RT_TRACE(_module_recv_osdep_c_, _drv_info_,
-		 ("\n %s :after netif_rx!!!!\n", __func__));
-
 	return _SUCCESS;
 
 _recv_indicatepkt_drop:
-- 
2.31.1

