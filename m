Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF5F39B9D3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 15:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhFDN1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 09:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbhFDN1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 09:27:48 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078ECC06174A;
        Fri,  4 Jun 2021 06:26:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f2so9286473wri.11;
        Fri, 04 Jun 2021 06:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=owsITsW7WWW5bJWpPZtkVZ9CzzbUl5LHy/XoqtgBc8A=;
        b=WSMR1+zbalCIGTJjAs+iXa49HTsKGjOdTcRKzi8oeapJNuMzfTpJJAUS2Tb3A59Xt2
         30VWq5RMWzZiVAUdwg9jMpN6vF60/4PNy7fNrBL45T7jJstCCAKEmOHkLJhjmZa/DG41
         WJCtoWyC6EYXOShpyscBH3Wqj5O382nL8akhEB1SyfUM7hu6Uvle0Bdf2HRlJkik726M
         Yt/lwCSys94IzW9MnxxQwe/rQolqLTsbKJLpDfgxgwJtuhT112/sUzpFg+ZNanSl6VJ9
         QEb4yP6R0mKaCXIgC/ME9gpe91E3YTdnkWo80Eh7TYhkFS4NQ9AZupw+6So/6yfeXz2Q
         hnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=owsITsW7WWW5bJWpPZtkVZ9CzzbUl5LHy/XoqtgBc8A=;
        b=Vd+h86vhf8fKPn/B1CoyP2QpzGZQ2q/4H5mUzDpU8xKfHNpSFV1w3p72TWmc0y4UUX
         Z2iLx86h1+4dwi2JNJhz/cRpDs53GScY21ZLBAjLkitgIecT/nmjZRsVrXj4ICogEGFG
         Aq00IRQ5b4bGvDOrT7vUP02gCM2hY9wKHnoCyW5oo+z0kl0arrfRFgsEGgiQX8XWBAFk
         JWWSjxhBzqRntDg8I6sb86RI8JnTBprYeicro1OYWesy9Tc8wjz4dGvAYA2Hqb1k1XiP
         ygEmFcNABQblE6P4PmLGc4v5WRLWQaMhD6gWb1c9eHDn1yvPwVEq2KnTcimcioQ8soG8
         I6bQ==
X-Gm-Message-State: AOAM530OU6IwLi7qO63ZmQ1GuJ5qorJOD7s6umE3YoH8N6DTQOAW5KM3
        co5meyz9T6FSJK+NzKw2qYe60SkJ37s=
X-Google-Smtp-Source: ABdhPJx+YpJKGWgpUNVl87I/p783cOw2ND2z3H7FMkJJr9ErwMVUkjeXZMA9f4dslr+6usrngvOLPw==
X-Received: by 2002:adf:fd82:: with SMTP id d2mr4030696wrr.218.1622813159837;
        Fri, 04 Jun 2021 06:25:59 -0700 (PDT)
Received: from xws.localdomain (pd9e5aba0.dip0.t-ipconnect.de. [217.229.171.160])
        by smtp.gmail.com with ESMTPSA id l16sm9009034wmj.47.2021.06.04.06.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 06:25:59 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH] platform/surface: dtx: Add missing mutex_destroy() call in failure path
Date:   Fri,  4 Jun 2021 15:25:40 +0200
Message-Id: <20210604132540.533036-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we fail to open the device file due to DTX being shut down, the
mutex is initialized but never destroyed. We are destroying it when
releasing the file, so add the missing call in the failure path as well.

Fixes: 1d609992832e ("platform/surface: Add DTX driver")
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_dtx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/surface/surface_dtx.c b/drivers/platform/surface/surface_dtx.c
index 5d9b758a99bb..1203b9a82993 100644
--- a/drivers/platform/surface/surface_dtx.c
+++ b/drivers/platform/surface/surface_dtx.c
@@ -427,6 +427,7 @@ static int surface_dtx_open(struct inode *inode, struct file *file)
 	 */
 	if (test_bit(SDTX_DEVICE_SHUTDOWN_BIT, &ddev->flags)) {
 		up_write(&ddev->client_lock);
+		mutex_destroy(&client->read_lock);
 		sdtx_device_put(client->ddev);
 		kfree(client);
 		return -ENODEV;
-- 
2.31.1

