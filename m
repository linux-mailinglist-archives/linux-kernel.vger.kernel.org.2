Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F346B33EC0A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCQI6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhCQI51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:57:27 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0418AC061763
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:57:15 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r15-20020a05600c35cfb029010e639ca09eso2925175wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l+1EJFBCtfo9l4gZLbyeXef//j2IlwdufiBKnHN8Ms4=;
        b=SKA3psbfj5f7Um44JGG8FKNE9H0hMuOoWt6WNZmaOG3Zqzw4HRofNMesdpsoJxVplR
         j4yvm5gbPpdspzpBGwdC1paXhtqKo0lblnAavll/x0LLH2fW1iJR1qnrrGGkW8i0u3R0
         ibov7RikkU5XHX3MtoFuzFsbG8BD5l2If2FkQDcc3PdWALyJSxekxL62SZa53XdVWyQr
         Vya6eZRAf2PQ8Y0oh1GEQtFLV9Y4RAJxba+YdVg5dk2R9xbf9rPPLvsdKLIh+v/gl3LT
         i5FPw5F6clmJxzE8ljdyz3ZbHwm8EYKC0rEb1Pxm1Llx1B6F6drv6BmFmvYeLiNhVfRQ
         agAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l+1EJFBCtfo9l4gZLbyeXef//j2IlwdufiBKnHN8Ms4=;
        b=StHVOyrGJvx9AYsIZ7dZX7JnAiaP4c2llDB+8+TbGHem4TsZU8NKiz/YixyzNwFH0r
         iEj42h2ZZPJ4M7PqdxhctRLv09nwHsJw/DOHLaj7S7+0RWe1lsiVpagKguqukmU8KLBu
         3Emg+GdbtXFF3mwjbWXAAr1tXXX+VYjJoLC1lcfOPJxR7jt0ozXRr1Kx5wpC2e5ZkHfz
         3t2D28qEF47Zz4TVqp5lXg6nNEaXbiTxZWt6/0TGjVhdISy7b1ttHl/hrt5xTVHo1ufD
         M3OgnZZcQyttPkPT08bZT9eJnZu8cArrQs36ciuAqjRGmqEUdT/kxxd0BK+jn2TSM4+a
         gXdw==
X-Gm-Message-State: AOAM532SgmPNLaoXpaysbdUtZaGtviahjiojCBJO+KPBnNo+3pg/y8yW
        Tbbt68SJ7TC18OeCJI+iD7x4Wg==
X-Google-Smtp-Source: ABdhPJz181LhBLmutFOYGnihVIaN6OavW4rkwV7VElcenpA9Qb98+4DwhdTWR24irt6eFOE5AFPGEg==
X-Received: by 2002:a05:600c:210a:: with SMTP id u10mr2649152wml.147.1615971433784;
        Wed, 17 Mar 2021 01:57:13 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j123sm1807243wmb.1.2021.03.17.01.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:57:13 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-scsi@vger.kernel.org
Subject: [PATCH 08/18] scsi: a100u2w: Remove unused variable 'bios_phys'
Date:   Wed, 17 Mar 2021 08:56:51 +0000
Message-Id: <20210317085701.2891231-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317085701.2891231-1-lee.jones@linaro.org>
References: <20210317085701.2891231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/a100u2w.c: In function ‘inia100_probe_one’:
 drivers/scsi/a100u2w.c:1092:8: warning: variable ‘bios_phys’ set but not used [-Wunused-but-set-variable]

Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/a100u2w.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/a100u2w.c b/drivers/scsi/a100u2w.c
index 66c514310f3c5..c99224a128f82 100644
--- a/drivers/scsi/a100u2w.c
+++ b/drivers/scsi/a100u2w.c
@@ -1089,7 +1089,6 @@ static int inia100_probe_one(struct pci_dev *pdev,
 	int error = -ENODEV;
 	u32 sz;
 	unsigned long biosaddr;
-	char *bios_phys;
 
 	if (pci_enable_device(pdev))
 		goto out;
@@ -1141,7 +1140,6 @@ static int inia100_probe_one(struct pci_dev *pdev,
 
 	biosaddr = host->BIOScfg;
 	biosaddr = (biosaddr << 4);
-	bios_phys = phys_to_virt(biosaddr);
 	if (init_orchid(host)) {	/* Initialize orchid chip */
 		printk("inia100: initial orchid fail!!\n");
 		goto out_free_escb_array;
-- 
2.27.0

