Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D5C340157
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhCRIwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhCRIwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:52:05 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785DAC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:52:04 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t9so4590084wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LyiarI8XI+wr4cdrUP10jrX5TiM2u+Q08u5Edv+SeZQ=;
        b=UFMJn5wdi36JaAz2Mtjh0Yn3v4pMvV51lK4rgktPR83seHiknusOzEY081nZ0utH9E
         XsBjfmNGLBWwL3IwX/rHlehaL5IOMB2hwQ93D6exxnriB3HyIzgE/6VqvH6oizTh6sIa
         3zJ0kloQGxi/vSZOQejyRMLGFC+hURMKXakf5Dt96K3XV+uhioLxhl6QZXadfVAPX4p1
         /AlXszKtCNVLnxxMgOWXc7FPboidwGsAsm/8HIGZ2si/gIL55PqndogUsMPaKFiH3Tcs
         87tSbTDNEz6f7vxk1Iq+05iVhdNmxWoIBxRAWK5T6riqKsGZgshzwgBsU83NAyR4rO9f
         TzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LyiarI8XI+wr4cdrUP10jrX5TiM2u+Q08u5Edv+SeZQ=;
        b=DiRRZp/6OyT0mJMRUEmTj9sZhzK+0mYGyamtvE4QGi4jdszPhS3Rt7fvs6hGHnfZRd
         mXdrRVo2mtYtYZmHAfYCBKUQjUoC5LZtH2cN7jdN6Stp11f4r8xf/lFR4IKOL71PMly9
         F81qAhR8jQ4p9YjZoXO8tq3Fo3djXRyHgC0mIlHggrLab8mBIJ8WWzcoiWRypOX4GGTr
         EW49AsmyNdsyfKpEN3TI4vz+wZaafUofmc5UZtG4xYHUbSMDoUOMe8tkdJq0rr2z0bms
         jEuCLYOst3zpk+CtRiZffO6EwhFBWO6QqXCFanAribP0/FRMj8Qss1RYoIweqn7ionzL
         0Lqg==
X-Gm-Message-State: AOAM530qGLzsJ62r3Cg9MN1di/a/0q+Yj+HCD32kSb8aUOsZC6U1nSdd
        blNmV7c983iKAoCBmHhuNY4riw==
X-Google-Smtp-Source: ABdhPJyxfLSduApCEQu/3N3aXkvQ4WqyvhVfStfESZlS6GN8wfK8Blsp+2pYr2Wqw5RKEWPWEdVMVg==
X-Received: by 2002:a05:6000:11cd:: with SMTP id i13mr8292296wrx.417.1616057523266;
        Thu, 18 Mar 2021 01:52:03 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:52:02 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 12/15] ata: pata_cs5530: Fix misspelling of 'cs5530_init_one()'s 'pdev' param
Date:   Thu, 18 Mar 2021 08:51:47 +0000
Message-Id: <20210318085150.3131936-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_cs5530.c:283: warning: Function parameter or member 'pdev' not described in 'cs5530_init_one'
 drivers/ata/pata_cs5530.c:283: warning: Excess function parameter 'dev' description in 'cs5530_init_one'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_cs5530.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index ad75d02b6dacf..a1b4aaccaa50a 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -271,7 +271,7 @@ static int cs5530_init_chip(void)
 
 /**
  *	cs5530_init_one		-	Initialise a CS5530
- *	@dev: PCI device
+ *	@pdev: PCI device
  *	@id: Entry in match table
  *
  *	Install a driver for the newly found CS5530 companion chip. Most of
-- 
2.27.0

