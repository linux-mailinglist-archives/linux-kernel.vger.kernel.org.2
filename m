Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F84A351219
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbhDAJXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbhDAJWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:22:25 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10005C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:22:25 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a7so1855441ejs.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nbVu3rJMRpPzEvX8KIP4gBi2MNcGzAmk1GnAeQ4drbY=;
        b=BFCHDpLq8dEXFN9JS+QtM/l8NFSbz2BQc8pgsqYp8BcvFKQd8+F798gyZRhOJ+86m1
         SYLiE+1NVz1nHJ3A0270A9XrK3/E0iK5T/i25QqhjJuL5aq8VQD0B3GymvrrhVR8Ik7e
         NVIfCkreA5WsCGUuEQ5WmcKPJs9zo+ZXEC8xVuy4S42HcbEFtYqDGN3UJy/kLmxoBZib
         0AKt1GOpfS7QyoiSugWPMj0Ek1aoUDcQ1Oaz8aRnRA0n32Vn4+Kp//xrv01S/LXv0oqv
         SdvK3GpOeh24vXi9u5CCwNq+xzWP6gJRcSZDeAl6nBc2bzZ8IVo0uD68+BJeJbdwrbz5
         eCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nbVu3rJMRpPzEvX8KIP4gBi2MNcGzAmk1GnAeQ4drbY=;
        b=ApUAVR00lykGeDpya7AVjmHPDOpNau6MZKOjy58J3s/0MdgDIjRS0D4uEFCFP5koo0
         w1G6e9Pm5481py/oL08n5zr9UbDASSNUoZLb9XMCyC3H5OzrZBF8mG1udJd58RMb51Xh
         bb5fEJ4uQj4W35xcB7ylF91V+/hu0JQsflQqVUMNVgij18PKZKtGklO1Yo6O35T56jkE
         0WEW4PUN+FlsxZCgS/LMmFBr6/LQpaDFFkCJCAMbOLrPsPVTiLW9MKdqVNv7P1qZd+eE
         HIBMFdfVOT38bbgxhsSmB1TngpTxnR4sZh1KMlcP6eEBPWhMQnk7CX+tM05g+5Ln0TJe
         AaXw==
X-Gm-Message-State: AOAM532nC84wRl4/wS1Np3gOtsC8l7KXvCRywqgCq/x+y4TFmteNM90K
        84+LSUJ3rypVGOVN8eEjah0=
X-Google-Smtp-Source: ABdhPJxPsIoWME7YkIcLeozvKjqTy+Q9LRsFfinJXnT2VETyMnLpcy9/cUhCFjQGlCRqf6VwP3hpxw==
X-Received: by 2002:a17:906:7102:: with SMTP id x2mr8215718ejj.355.1617268943904;
        Thu, 01 Apr 2021 02:22:23 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id u24sm2455302ejr.34.2021.04.01.02.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:22:23 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 37/49] staging: rtl8723bs: remove RT_TRACE logs in hal/rtl8723bs_recv.c
Date:   Thu,  1 Apr 2021 11:21:07 +0200
Message-Id: <f09fd8c6f74ff72d3e0067c2b6d9d13808060893.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all RT_TRACE logs

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index 17a3e7bf66ef..d27d56920a11 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -346,7 +346,6 @@ static void rtl8723bs_recv_tasklet(struct tasklet_struct *t)
 						update_recvframe_phyinfo(precvframe, (struct phy_stat *)ptr);
 
 					if (rtw_recv_entry(precvframe) != _SUCCESS) {
-						RT_TRACE(_module_rtl871x_recv_c_, _drv_dump_, ("%s: rtw_recv_entry(precvframe) != _SUCCESS\n", __func__));
 					}
 				} else if (pattrib->pkt_rpt_type == C2H_PACKET) {
 					struct c2h_evt_hdr_t	C2hEvent;
@@ -404,7 +403,6 @@ s32 rtl8723bs_init_recv_priv(struct adapter *padapter)
 	precvpriv->pallocated_recv_buf = rtw_zmalloc(n);
 	if (!precvpriv->pallocated_recv_buf) {
 		res = _FAIL;
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("alloc recv_buf fail!\n"));
 		goto exit;
 	}
 
-- 
2.20.1

