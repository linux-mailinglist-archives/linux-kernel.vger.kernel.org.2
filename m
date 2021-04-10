Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B73935A96F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 02:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbhDJAMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 20:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbhDJAMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 20:12:30 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81001C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 17:12:17 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso3992477pjh.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 17:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=2lxfN5ByZEbEMKEjmWp1Q7WunCY5qRG4cae/+TcjBiw=;
        b=nNLrhJg01t54nH/nElkvEhcvw2owYft633IxmHULTyL9BdkUnROR8QFoRypeZfkKRa
         etaDJ1PEK3ghpeEaXfO1legoCBaVQ55m9elz9GtyRAmCBd7hD2+jsvZZG16od8vZSaOp
         fcgc85nlx9VDpTU0rudcm/NrKKvTVpBZ+tZbsAFLbN6do8LQlndorth2PBAssBTrH0+o
         IR4LXu56UUnTb4W5dqCF4cc2PHfq4eP+ENoIMaa9BaZ6WQJZTgK30qXW98ydovS+xffZ
         pGoeIIpXDxzVuErKvFY1ebqZIcEUp/eY+S29dW7kQaTVz1fUVYVvGdus9WhMMpSrPxtU
         GdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=2lxfN5ByZEbEMKEjmWp1Q7WunCY5qRG4cae/+TcjBiw=;
        b=qX9MNH8iMh8Lxrc3PLb8tux8oE0eTnaH6cu1fIm86pDlclUHfDOmoZSTRLJ4mVI6ND
         0gZoWMwXHx8KzS8J6tIcQpTyf8DH6tkT0kSYHn90nQk1pM3atjKpyEVUQn/m5d35zCTR
         vy1J/qT+ZJEVLTMXTNi/B1m5t/ycVUHiTSyQKpz3Y0PsyUxtUE6ah9afY93fUMfM98Sq
         MIVcaRuCb8oeRBOX94pBKYHRDiaQ6WcpAROjMYDTrghsWlttDqM3lT6F5b0wLf2i/jJD
         MDxW1MMbdoJ0WWAcNbbb748LNC5LkDngUpkLyTpHmhiTtrQgECkWfUgl1UHEuTMFDzEb
         e0dQ==
X-Gm-Message-State: AOAM5330koDCcJobDFs3gVvdJWl8wBX6SOV6JxUU6igTf+ZMzHm8lqBf
        ua4+j9udqPWiUPOXH6KNhpw=
X-Google-Smtp-Source: ABdhPJz2YsGjbI6FPzSN5p2ywTltyFXdJSttu1EElON6QcZ8OoXr2NIz9jI033O5O+SKRvfsoeN8yw==
X-Received: by 2002:a17:90a:2bc4:: with SMTP id n4mr5147236pje.52.1618013536891;
        Fri, 09 Apr 2021 17:12:16 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id s19sm3203011pfh.168.2021.04.09.17.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 17:12:16 -0700 (PDT)
Date:   Sat, 10 Apr 2021 05:42:10 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH] staging: rtl8192e: remove unnecesasry f-trace like logging
Message-ID: <YHDtWizzh5EVLL4/@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed Check: Remove unnecessary f-trace like logging by simply deleting
that statement as we have other modes of logging like ftrace.
Reported by checkpatch.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 476875125e87..4457c1acfbf6 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -136,7 +136,6 @@ void TSInitialize(struct rtllib_device *ieee)
 	struct rx_reorder_entry *pRxReorderEntry = ieee->RxReorderEntry;
 	u8				count = 0;
 
-	netdev_vdbg(ieee->dev, "%s()\n", __func__);
 	INIT_LIST_HEAD(&ieee->Tx_TS_Admit_List);
 	INIT_LIST_HEAD(&ieee->Tx_TS_Pending_List);
 	INIT_LIST_HEAD(&ieee->Tx_TS_Unused_List);
-- 
2.30.2

