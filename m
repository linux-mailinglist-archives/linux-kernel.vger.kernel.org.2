Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D51398628
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhFBKTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhFBKTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:19:21 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9C7C061761
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:17:38 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n4so1722091wrw.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JYcpB4gr4G9b2N/HTEwmEP3ZKhvHq1OB6C2fuW7h01g=;
        b=SRPujFKDl9FG5cjbsJZqcYMVAtYY7G8LN7erKFPkE6GmvyX4My3D2twyDhgc9eIxqE
         7FeRVBOGkN9zRhpg2Z8zxe/GWg5+z5CIXaTjxExBU24lmunFMz7C/u468F2bu+hPTIUS
         ts7muC4hg1Dov0Mw3GirBXa6Q1RzqQpVYNu6/LXdXreFrODTbnR2bkTZI/Bq5t+93Uia
         gmeZx02H1ItteO8NfGBXztBcjtVaphcHYQ2K1hupnTZt6OwAbIduK0CzwIYQqkeGaMGM
         7co1rWuwrt2910az35uAjSnN9xF4TriNf81GLNPRheX3VD6iby6IOxMuDqdRCtQs3AKK
         IcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JYcpB4gr4G9b2N/HTEwmEP3ZKhvHq1OB6C2fuW7h01g=;
        b=Zs8TM998KJOHL5qHjdGX84xI2U2XA/4/k+7vC2D8r6SyTdt+HigZ4l2IyUepgVirX7
         Tgtf0Uk/19eFZWJrrXodlknR7dAKMlfKNiuUwrz4XX3HN4gPBzfZqJeOPw04dBQCZ0j1
         GLjMF+j93kxvS1npZTyvUzPWNje3ImFafmJQPe6JKS06ztQwuDBcxNMawMdc4SjLDznm
         1Bs7oiOVF9px7/Onkk8zJGJI27wLVZ8zif9Vz7jk5OoYfdTC7/3jE7I0TUuvB08M7h5Y
         gO7bmIbAKtkXEzzRqwlMpPH9wo3iN1go6JKz+Zk6q/ceUiNQXO2cSREfSVueSj/YxFTR
         hLyA==
X-Gm-Message-State: AOAM533vFsWCxUCknkuRW4tnyevwn97WdlCWBNmMakMfqx3dt3arez44
        EEN2SYKys9TthL2GqB7C1mYaZg==
X-Google-Smtp-Source: ABdhPJz8e++rnMpw2N98w8tVzPOnJlN85qJszJwSFdMRp5oMLbXduiYRmh5S6pRNG2utPxKqiYMKGg==
X-Received: by 2002:a5d:4b05:: with SMTP id v5mr644878wrq.330.1622629057037;
        Wed, 02 Jun 2021 03:17:37 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:36 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
Subject: [PATCH 03/21] ide: ide-dma-sff: Provide some missing 'param' descriptions
Date:   Wed,  2 Jun 2021 11:17:04 +0100
Message-Id: <20210602101722.2276638-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/ide-dma-sff.c:84: warning: Function parameter or member 'on' not described in 'ide_dma_host_set'
 drivers/ide/ide-dma-sff.c:116: warning: Function parameter or member 'drive' not described in 'ide_build_dmatable'
 drivers/ide/ide-dma-sff.c:116: warning: Function parameter or member 'cmd' not described in 'ide_build_dmatable'

Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/ide-dma-sff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ide/ide-dma-sff.c b/drivers/ide/ide-dma-sff.c
index b7c2c0bd18b53..8603df4d92fd8 100644
--- a/drivers/ide/ide-dma-sff.c
+++ b/drivers/ide/ide-dma-sff.c
@@ -75,6 +75,7 @@ static void ide_dma_sff_write_status(ide_hwif_t *hwif, u8 val)
 /**
  *	ide_dma_host_set	-	Enable/disable DMA on a host
  *	@drive: drive to control
+ *	@on: whether to enable/disable the IDE controller's DMA
  *
  *	Enable/disable DMA on an IDE controller following generic
  *	bus-mastering IDE controller behaviour.
@@ -98,6 +99,9 @@ EXPORT_SYMBOL_GPL(ide_dma_host_set);
 /**
  *	ide_build_dmatable	-	build IDE DMA table
  *
+ *	@drive: The drive to unmap
+ *	@cmd: The IDEcommand
+ *
  *	ide_build_dmatable() prepares a dma request. We map the command
  *	to get the pci bus addresses of the buffers and then build up
  *	the PRD table that the IDE layer wants to be fed.
-- 
2.31.1

