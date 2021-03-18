Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13468340151
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhCRIwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhCRIv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:51:59 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2305BC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:51:59 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 12so3008882wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ww/weUvcZaIAW1/4IpRQWiCV/q1/L856MjOkNuPC5RA=;
        b=FhDE3pfDksVXYUzEAGqiZS7G/a/+SpHaqrnIPtUgrDi7hdV61S1cwwFL6WibH4DVQA
         7BYLoK7xBgnnaaP3+FWe5Hx1ZSFbe0tB3LfaFiEBebsk859pSyITDQVX+R8WXg6OFWJR
         WMroLtrHgqmabUKp8sMZ9k7h6cQA+N+6QmL1e42KvPqFkT51/V4/BY2am8yYv8shTfA3
         jlGnlEPSO5cObJFOlKN+7u3g3RaqtppW57ikKS4C4nh60k2kn4HZyX/LuKLmWBeR0o/a
         focEbvW9E3SfdgGhbW2y5cput/Td7tTJH8s7WCvsgvDpwZL77dZfrOszNjEfmrlEi787
         bTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ww/weUvcZaIAW1/4IpRQWiCV/q1/L856MjOkNuPC5RA=;
        b=f1d8TG0hsb0BFJPP1DOr6mZypa96EuqeqmRGGbg0JEuiP7M/V7Qdf2FDnFXXqxailX
         lP1Uh1JlCBVbdWfAQLr3Xer9LF7px3t4PgUrm3H73kAe0WCgfNrf2jbVze+ND9G3T3BD
         nx6qMmwh2Lq6miyQ25xCpfxF8JlICIwOlusGClkMvyGRNlQeUw2dENoF2QlFIHW0btYQ
         hdj0BGulnoEQyOXxP2gYeUnyUfwWu3KV6cGy9w7nqghyY2+q2/L+mcHkj0vABB+QuUgq
         3kYB4jJJUgVBI9Uh/pamkPsq6vdbDiwtN7/+21KSPl0kAhcMsLWkakCPifgO/uanWyRU
         moqQ==
X-Gm-Message-State: AOAM5313Ivqv5d1Wnz2H8Zmra7mkDZckZPgJvUC4uPKkWPnY+iXnAX69
        L0iP9mudcnwO6DYoOUnBmLCg9A==
X-Google-Smtp-Source: ABdhPJyolUMm6pIu0p+Uaj0fKL7mW2TP2e9kaIVExOqOtxpFxB3CiGiRHpoOpYTwD5PBccU6tDJZdw==
X-Received: by 2002:a1c:c282:: with SMTP id s124mr2515271wmf.99.1616057517906;
        Thu, 18 Mar 2021 01:51:57 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:51:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 06/15] ata: pata_via: Fix a kernel-doc formatting issue
Date:   Thu, 18 Mar 2021 08:51:41 +0000
Message-Id: <20210318085150.3131936-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_via.c:675: warning: Function parameter or member 'pdev' not described in 'via_reinit_one'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_via.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 38044e6797951..4750320489843 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -663,7 +663,7 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 #ifdef CONFIG_PM_SLEEP
 /**
  *	via_reinit_one		-	reinit after resume
- *	@pdev; PCI device
+ *	@pdev: PCI device
  *
  *	Called when the VIA PATA device is resumed. We must then
  *	reconfigure the fifo and other setup we may have altered. In
-- 
2.27.0

