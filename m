Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5661E307D74
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhA1SIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbhA1SFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:05:04 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1931CC061220
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:02:58 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id s24so5622394wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=psxck1KMWyXDOgBCEv3jYVYq9cj2r/nvdYNmqCZ8a8o=;
        b=lBHSuYaf+ThEC3XoD0nFSMFQjdNXO6266Ggd88khh8AtoBXvl5UBglSmIvSRwJwD/P
         IU+b4wERYdnenTF6z5UMj7tvpnI2dsyL4IgBsQpv5O0O8Fodim0dN50K9Is4SYp+x238
         EHO/MnRTxnmFfSeI9jdmrzpL+a5AQzn2G2BuvDfXa7Ctui6GlQkZpxkp13i4VaKrl/en
         wMa/Mm1CvgoWI9IFvVRU1EorTkSXe4SkFGacVGi+RiAWSYltYNF2/zEr5+ZrI1Vru+OU
         xkDX6pGasijORHWcwHiMpzLFKoCevZIiJ4RPRx7IYiiUpkulawfPN0j1SZfCt188cWup
         S8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=psxck1KMWyXDOgBCEv3jYVYq9cj2r/nvdYNmqCZ8a8o=;
        b=sVVLPfYWSOLwRjbhol7gxddr+uEn9If3vVxhChZY5R0zXA1V0B1xscLdSA40wsa5Jc
         Pw22CGxSzLt42vijYBfSRXYm96NZdQO/grsZP9i25lKpbuEyP8VX5XW6ovqyksZTeejF
         EpDiuQz1AvkCtseTOVX6AtPMGdyN0ktYThYW9SHrN7vB9BFD22pVnvqgXdDwS13/0LzK
         XbgEaxARtP/fTuR4bB2Nvh9a3V8GcpqmTmqJ62cThfB8ODJM1NpiF6ONJVkOu0FxyJNJ
         7fB1yZvJWSC4CThNuaHsqCr06L43iTXSooqPrr0/C6dvn5iHGwuva9oxBoTikgw1v/EQ
         aE/w==
X-Gm-Message-State: AOAM532Fk2bO1wktOzRE/0id1xuk6ypWVODopih3HWxUx5dwGof3Kg+z
        RTxf/5wSqENOw2RfoxjEBKT95g==
X-Google-Smtp-Source: ABdhPJylmz84beCkITbxAGADN4SRcalxnpuBzHeS1s4xaAKVu0RnbM6Gdx3NAZPS52cxhsCp1GI+tA==
X-Received: by 2002:a1c:b682:: with SMTP id g124mr473279wmf.10.1611856976813;
        Thu, 28 Jan 2021 10:02:56 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:02:56 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 11/20] ata: pata_amd: Remove superfluous, add missing and fix broken params
Date:   Thu, 28 Jan 2021 18:02:30 +0000
Message-Id: <20210128180239.548512-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128180239.548512-1-lee.jones@linaro.org>
References: <20210128180239.548512-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_amd.c:179: warning: Excess function parameter 'adev' description in 'amd_fifo_setup'
 drivers/ata/pata_amd.c:331: warning: Function parameter or member 'link' not described in 'nv_pre_reset'
 drivers/ata/pata_amd.c:331: warning: Function parameter or member 'deadline' not described in 'nv_pre_reset'
 drivers/ata/pata_amd.c:331: warning: expecting prototype for nv_probe_init(). Prototype was for nv_pre_reset() instead

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 987967f976cb2..75b830eb3c542 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -167,7 +167,6 @@ static int amd_cable_detect(struct ata_port *ap)
 /**
  *	amd_fifo_setup		-	set the PIO FIFO for ATA/ATAPI
  *	@ap: ATA interface
- *	@adev: ATA device
  *
  *	Set the PCI fifo for this device according to the devices present
  *	on the bus at this point in time. We need to turn the post write buffer
@@ -321,7 +320,8 @@ static unsigned long nv_mode_filter(struct ata_device *dev,
 
 /**
  *	nv_probe_init	-	cable detection
- *	@lin: ATA link
+ *	@link: ATA link
+ *	@deadline: deadline jiffies for the operation
  *
  *	Perform cable detection. The BIOS stores this in PCI config
  *	space for us.
-- 
2.25.1

