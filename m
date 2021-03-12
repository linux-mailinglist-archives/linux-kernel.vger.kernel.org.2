Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F8933892D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhCLJt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbhCLJsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:48:25 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085C9C061763
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:14 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id r15-20020a05600c35cfb029010e639ca09eso15396223wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l+1EJFBCtfo9l4gZLbyeXef//j2IlwdufiBKnHN8Ms4=;
        b=etOJppZ0N6Hc5WuXjMl/Rq7RPdhqLpqkPvoenm70t2iJLGNWCJF3hUhVcYbGHzOsaP
         ISlklt18zy37gZIRUD0Sh0/GoGxM0vTMfkb+dPoWq8wwXLl5BLbNZDXDUcbuohHwd6QY
         KazOWxWWTjHc9hdnB3RhLrNh66P5mUt1SCagZX1l/4cEEy6i7vSrNZIywzKYA4uNFIP1
         OP1uo2gTEQUqR4kHhCVU9QFfvEX6kj/jBTe2TpGrrmx3Jd2Masl2xT5THLwm3I/lfCt6
         +xeT/KHaQr3T/c5gX7iM+h2PWlQCUheqfYg87dPIAFHbbRkNxYkFp18sb1Zs4fDu/IOy
         lgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l+1EJFBCtfo9l4gZLbyeXef//j2IlwdufiBKnHN8Ms4=;
        b=s5GpDNXN7xdUWYeej5hxC8ebC9TFP4XK9zFWpfzLc9SiVcnRMx8C26xmITSjeJyJom
         7n9MIj5UMNFo9RdUxQtwfBOJuTAufdZ9Xl5X/dX8XMgASTPN7++eMHFaz7EpqNaqwMIp
         Fm8NNeWdj6u9HA/3Wnw/3lcqI65XkQXGld7Q5xT5i4SbHNDzBfp8yAbR8MVwi9NCr7xc
         H2vnJCYGtpHgMDuppa0nJudZbrQW4asC11kSacoOG+txWQdqJIlm+shdqzgWBNeHjDDp
         Pfg6vt9Wii8wyzjyljAAu/Xs9TL/Mktq2pntBV0wmw6lEuBQTJbXta0aVFtCf+4/Io83
         qreA==
X-Gm-Message-State: AOAM533LcbdJTpasrFTKAi+l77dUbamXbovh1jwuUOptjrZO1a+d0+BZ
        pLx4caI3P6r1NER6ZQLzkq+1jaGgDtVPdQ==
X-Google-Smtp-Source: ABdhPJzMXSxiudKZzRxEjzG62a0M6Fz7KbcGhlbgRIF1Jxho9qurTmOPoLb1MMSXuRI9AFO1Pgg0uw==
X-Received: by 2002:a1c:a543:: with SMTP id o64mr12229175wme.107.1615542492647;
        Fri, 12 Mar 2021 01:48:12 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f7sm1539536wmq.11.2021.03.12.01.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:48:12 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-scsi@vger.kernel.org
Subject: [PATCH 24/30] scsi: a100u2w: Remove unused variable 'bios_phys'
Date:   Fri, 12 Mar 2021 09:47:32 +0000
Message-Id: <20210312094738.2207817-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312094738.2207817-1-lee.jones@linaro.org>
References: <20210312094738.2207817-1-lee.jones@linaro.org>
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

