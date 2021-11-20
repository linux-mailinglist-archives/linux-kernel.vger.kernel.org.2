Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BCE457F52
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 17:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbhKTQEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 11:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhKTQEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 11:04:41 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170A8C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 08:01:38 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id l190so732989pge.7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 08:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Ky8vda2f/TaIwcftvJ93YOE0VOIb/9YtM8HnHTjeqPA=;
        b=mWTDAtl8mtYZ9uMQ+uPrBAovWt4xPcHXS6VYfK+rYZs2Lbudn6r3nG/lRcY4c5IAlg
         KzgWoSADHcdrdpE7zzDIImlY9TkTCEnHmj9zyHPHy5eQqG40YuuG8qj7NQdbCkmkqjZg
         ExQSB1pdvWF07/AW4fUHQ5H9kNFcrDYx7X9G2DIJTVWk+93LvjpU7lAWoYJApiANUdWm
         FyhqgV3MZ7z1gMK7+KbSTXmPV4StoK9ch901aH349mofyCURiRp4wTXm9MEZbOYwvhmc
         dytyHTB2fI1GUS+ZEKr5H+M9z4NuVJUdBllKpgdnVVRvdtZkZfELJZowkhZAgAa28OAu
         RoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Ky8vda2f/TaIwcftvJ93YOE0VOIb/9YtM8HnHTjeqPA=;
        b=uqz/cEUTU29o1zj3rbGOKOGo7FaBpum/ucOn1rpnT1Y7CRJpvohYZSThBHvnuD0xjG
         2dnKaGU9VDaxdY781LiMK2YkUd2/wh9oDbe37SRzI6MH7hW6omtrSQBraI3M5yXMYF58
         DtDB2LsYBDYr/CqyaoXQAztgiROofmN8LmoxZ2Aicyp/L6khteunoDiGc3rUbh+GhzBY
         HyCJ0X+iMpbcEP1PKBOvW4i2irxRCEIXlGGwv10Fp/Ak/wcRA4tzQe7dEcuReELQRgK1
         PPP+MWrLoIyB9lWi3E2uLoy4VjKudo0+eR0P011R9wPW3RnTfvJsgpvvSAnjQBKdihiu
         UtXw==
X-Gm-Message-State: AOAM531EPhCXX74yCsRGIIIBN1VfsM768pnnf1Wu/vAkXCYpV+1aeHXG
        5yGjzcbG70rvAwTtUL02rzsloDyRIARVLQ==
X-Google-Smtp-Source: ABdhPJy9OatEEdW3TF/tPuDyJN4Uj59SAgteyn4pw7iqWByZXoqHLEdPo1jBElkxa33k1b7W/P8vmg==
X-Received: by 2002:a05:6a00:234a:b0:49f:c0f7:f474 with SMTP id j10-20020a056a00234a00b0049fc0f7f474mr31424693pfj.64.1637424097498;
        Sat, 20 Nov 2021 08:01:37 -0800 (PST)
Received: from debian (ZU155130.ppp.dion.ne.jp. [59.133.155.130])
        by smtp.gmail.com with ESMTPSA id g11sm2386730pgn.41.2021.11.20.08.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 08:01:37 -0800 (PST)
Date:   Sat, 20 Nov 2021 11:01:34 -0500
From:   Satoshi Ikeke <satoshi.ikeke@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: replace printk(KERN_CRIT...) by
 netdev_crit()
Message-ID: <YZkb3t83RFxVMWH4@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace printk(KERN_CRIT...) by netdev_crit() for more uniform error reporting. Issue found by checkpatch.

Signed-off-by: Satoshi Ikeke <satoshi.ikeke@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 490431484524..8c90cb3a68ed 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -73,7 +73,7 @@ static int sdio_alloc_irq(struct dvobj_priv *dvobj)
 	err = sdio_claim_irq(func, &sd_sync_int_hdl);
 	if (err) {
 		dvobj->drv_dbg.dbg_sdio_alloc_irq_error_cnt++;
-		printk(KERN_CRIT "%s: sdio_claim_irq FAIL(%d)!\n", __func__, err);
+		netdev_crit(dvobj->if1->pnetdev, "%s: sdio_claim_irq FAIL(%d)!\n", __func__, err);
 	} else {
 		dvobj->drv_dbg.dbg_sdio_alloc_irq_cnt++;
 		dvobj->irq_alloc = 1;
-- 
2.30.2

