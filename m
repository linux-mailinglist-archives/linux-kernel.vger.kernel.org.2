Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8BF307D71
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhA1SHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbhA1SEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:04:33 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576C4C061355
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:02:53 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id 6so6341131wri.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lDwxjOTNwRK/jrgXFyt6Q5KAd5bTTyW5pp6F8HQ+RfM=;
        b=e15ABOPKKSkb+A+yzXSg3oWGdKhKBFvuayIyU7x7O9IWe6tZK6N/gu6rO7l0S2hugw
         rwwIHwJ+rxrWgPhnhQeolBYxEnt17NAVO9s7PgeV09/HenT2OnZv3lhmasdL5EmvEnOG
         8AWeWwvoe9hDkviDX8GnXzVvDJg+ZlNKIJTgh6vQxOuNFbBz1uQbpO40tXYywJ32IE7I
         6pulN78q2w+jAykFNHWVSpBNxSEHSww+8xk/8mcP/m2s7LdowUovoFxZNN4cypJPoXZ3
         VBTT2omEbJYEthiAKgD9wgjuc8JBgzOXBBAPT2DAv2m3AzPztYwwoevO3ccAmrjpqQeF
         iZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lDwxjOTNwRK/jrgXFyt6Q5KAd5bTTyW5pp6F8HQ+RfM=;
        b=KH6SWgFPPE9LLkB0/2NDypEVVSwOq4arSIcc7QvUN9V8opcmCh5CXttXzXtOWmaIr4
         2Lewkum8iqUn1eovwNZ38E2Tvt0mvKCeq41axxmK+WUUVY2+vks8eQGrjYoJ1zHPH794
         V/wumuokCqMhK76kLBP7ETHS4y7rNKYs0NmYf8fV7YLaz/p/3zrrvqfSFXwLxYNeGkn3
         fftp9FQDgc7qAOJ16kwjQ7FB/QrBvE2OgXs1AyPbgnrdBWgTYPlFkaCag1zLUpfqgTaP
         gbnT46VLnAWHXlI854FCgaE+T1oNkHO8QHbcvwuB42XEbqAu11w67CWQar0TU8rXxghL
         iWNA==
X-Gm-Message-State: AOAM531hu47aB1xXzJxy8WVhLS0VN9yo4Q1tfsTXCLYEm1e/rRdU+n95
        qI418bXIz/T/FhPYzQf7YOBf8A==
X-Google-Smtp-Source: ABdhPJzWIx/SFzMc8lRIlMQ0pH/4OykRg1Xgf+E2QnrCoAgIO+1y6+Izb7pmAkfbT9U/ZC2paA+aww==
X-Received: by 2002:adf:9523:: with SMTP id 32mr244948wrs.361.1611856972100;
        Thu, 28 Jan 2021 10:02:52 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:02:51 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        CJ <cjtsai@ali.com.tw>, Andre Hedrick <andre@linux-ide.org>,
        Alan Cox <alan@redhat.com>,
        Clear Zhang <Clear.Zhang@ali.com.tw>,
        linux-ide@vger.kernel.org, and cc <htejun@gmail.com>
Subject: [PATCH 07/20] ata: pata_ali: Repair some misnamed kernel-doc issues
Date:   Thu, 28 Jan 2021 18:02:26 +0000
Message-Id: <20210128180239.548512-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128180239.548512-1-lee.jones@linaro.org>
References: <20210128180239.548512-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_ali.c:119: warning: Function parameter or member 'mask' not described in 'ali_20_filter'
 drivers/ata/pata_ali.c:119: warning: Excess function parameter 'ap' description in 'ali_20_filter'
 drivers/ata/pata_ali.c:322: warning: Function parameter or member 'qc' not described in 'ali_check_atapi_dma'
 drivers/ata/pata_ali.c:322: warning: Excess function parameter 'adev' description in 'ali_check_atapi_dma'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: CJ <cjtsai@ali.com.tw>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Cox <alan@redhat.com>
Cc: Clear Zhang <Clear.Zhang@ali.com.tw>
Cc: linux-ide@vger.kernel.org
Cc: and cc <htejun@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_ali.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index 0b122f903b8a8..e18aa02f89530 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -108,7 +108,7 @@ static int ali_c2_cable_detect(struct ata_port *ap)
 
 /**
  *	ali_20_filter		-	filter for earlier ALI DMA
- *	@ap: ALi ATA port
+ *	@adev: ATA device
  *	@adev: attached device
  *
  *	Ensure that we do not do DMA on CD devices. We may be able to
@@ -313,7 +313,7 @@ static void ali_lock_sectors(struct ata_device *adev)
 
 /**
  *	ali_check_atapi_dma	-	DMA check for most ALi controllers
- *	@adev: Device
+ *	@qc: Command to complete
  *
  *	Called to decide whether commands should be sent by DMA or PIO
  */
-- 
2.25.1

