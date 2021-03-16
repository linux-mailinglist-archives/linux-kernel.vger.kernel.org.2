Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3ED33D77A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbhCPPbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbhCPPbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:31:01 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF7AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:31:00 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso1687541wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x4jfn/t4bc0MDGe7AHsdkIwj3uzunRuHI4a+bTkpqQc=;
        b=mBswRYxiIo3zj9EDWmOreA+1Xp4knX4lDNRqi432X+rH9ocQh9sQVWNRmaG/cV4Nzf
         D+Mm2khvm0RhouRfqbXCxenz+hedafhx/NPalcC3zCz3EABm9GYfkxmETnGJmMapGCjB
         m8ucq42TPOULo1srNnGp+bVM6ILsProBJrR0sOKOgjFlYc/JTxMIBchXuWBLt1bd31iY
         yj8eQZy2k4ZcOZqDhYX4clMRq4gRHuW+0oWj851ZFq8YKLAKgbm63njKflNzfo2QNZZP
         NyNAqAK40dSevXIJsSxZab16q/aoelV61M35ry+A8s80Tg4JmA/VsAYWLgTJ39uWR2Qc
         /tiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x4jfn/t4bc0MDGe7AHsdkIwj3uzunRuHI4a+bTkpqQc=;
        b=kAzqL8VlqocVTc2IlWf+f5JpPYr8sRMC6tgvsP5HK/Kgp2gmA3g/2hUPbY8dGcDL/b
         gK0+g2J720nqbkysx58v/SGowy4cOa+EUO+i8h8AEdHnuQU4gcs2Ijt5f1R1WZMbhoyH
         AOgG+u8KJYl04jG2c8tqkNajH9AFFsB6IBTRqWo8v9iHTFwANOfOdfhgjJl+HDFixcI5
         WBD/ZKOPcCMofQZjRo2ILgnSCLIlNCZUQ959Bux2RBBz2mMuJfsbJH4dSjl+FQiILYWc
         qrcISuxT1dBgOiASZFeTGyPQpIlbZMZqaSQi3woI+daFwujYgLU37JqFJk3lojdT9U4k
         ZvuQ==
X-Gm-Message-State: AOAM533LqyoA/mVC1tTCI/HMGC0w1NJ3ltzw0UKsW8aqx9F2+OpVp9lm
        kqELfhFtzMOnoeOhkrVh5jE=
X-Google-Smtp-Source: ABdhPJxEYG+PGWjzrXgrJkkX7exb0NSUAg+8Q2NHbrv7Kx/N8k8IXcFE756k0HINXSttEn3P5fU5Ew==
X-Received: by 2002:a1c:4e07:: with SMTP id g7mr209792wmh.29.1615908659109;
        Tue, 16 Mar 2021 08:30:59 -0700 (PDT)
Received: from agape.jhs ([5.171.72.71])
        by smtp.gmail.com with ESMTPSA id s20sm3391555wmj.36.2021.03.16.08.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:30:58 -0700 (PDT)
Date:   Tue, 16 Mar 2021 16:30:56 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] staging: rtl8723bs: remove unused code blocks
 conditioned by never set CONFIG_UPDATE_INDICATE_SEQ_WHILE_PROCESS_ADDBA_REQ
Message-ID: <ae8f1ff89a3642449b1d2f9951001b0a3ef01b91.1615907632.git.fabioaiuto83@gmail.com>
References: <cover.1615907632.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615907632.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove conditional code blocks checked by unused
CONFIG_UPDATE_INDICATE_SEQ_WHILE_PROCESS_ADDBA_REQ

cleaning required in TODO file:

find and remove code blocks guarded by never set CONFIG_FOO defines

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 2dd902b04509..ea690dbbfebb 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1809,15 +1809,7 @@ void process_addba_req(struct adapter *padapter, u8 *paddba_req, u8 *addr)
 
 		preorder_ctrl = &psta->recvreorder_ctrl[tid];
 
-		#ifdef CONFIG_UPDATE_INDICATE_SEQ_WHILE_PROCESS_ADDBA_REQ
-		preorder_ctrl->indicate_seq = start_seq;
-		#ifdef DBG_RX_SEQ
-		DBG_871X("DBG_RX_SEQ %s:%d IndicateSeq: %d, start_seq: %d\n", __func__, __LINE__,
-			preorder_ctrl->indicate_seq, start_seq);
-		#endif
-		#else
 		preorder_ctrl->indicate_seq = 0xffff;
-		#endif
 
 		preorder_ctrl->enable = pmlmeinfo->accept_addba_req;
 	}
-- 
2.20.1

