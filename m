Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51037398642
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbhFBKUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbhFBKTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:19:42 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AE9C061756
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:17:48 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id h3so911648wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=htzTcpdW4AR6FOO02fF09uyWR4q4i8TTi3eEflccMFY=;
        b=zjGeF5HCKjXczIh0I1gv61WfZERqc2GBLPFhv816eSDsCbZ0p/YEmcJh0u//noMPzc
         A5jPOJAxXZUMc0uRxRZwleiKNOWQ2+WuY0t3cZXkkQHvoIYco+zApOZM4bBhC6nUpWtw
         4Ovy4k07pWbZ9cYUQaTSUAfhVVatV7S/pRCS7XDVt/cAALLq/Slovj8XTZ7gZZp88v1n
         fesO8+qq7XNt6PEx9/Yz3n+nTw9tIDftj29lJSSKQB5OwY7x8IYxYEH8YKkr9MzzQne7
         Yp/Ut5PClr/daFiaBUpNwxhdcS6CZY8+RkufdL9drv2u32hst4GaQPnfd6m9CCT1QYn3
         gKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=htzTcpdW4AR6FOO02fF09uyWR4q4i8TTi3eEflccMFY=;
        b=HdNQL4CpwN/Pvp4aL99fvUzyHGlCKlmGDBLahh9nG5RJwcQHLripHoNnVU5f/7qwHq
         GAiEBDnR/WYqarVip235bohEfyQvvKteOu83UO/JsCcZd1AEUdKhXWqu7+8rO898JiVx
         SQlBtC0tlalGwChTMfRTelgZmGOwb0/gNq/i2qyOxDRTEtdygc73/pbdduMlcSuIsKf6
         8Jr2EF3Q6EKh6ImDLF023UTFxf8x/poqGi+Vxyz0pDcm+YkF1TZxMGryIRhEP386SkP6
         tMKFaiURzNKfGpkBLDt6KAx9R0FU0IYNkqjugMYAMuQtwhxMwpD4z/d0nLZHB1qsx9nO
         5lYA==
X-Gm-Message-State: AOAM531ev++M8EXuaLn/Nbvl2GZ4jMgO17nztJs7wXF92y04nk/n+cTf
        OMOFgD0XISOS4AW+KLvNl86yOw==
X-Google-Smtp-Source: ABdhPJywrchhxFcUzDLyRI0gTv8NdS60hjXxQddFSDjmZ8WQbwt6LZhVB7Hc6j6/1S1MD5vEwK84aA==
X-Received: by 2002:a1c:1f4a:: with SMTP id f71mr4470189wmf.146.1622629067150;
        Wed, 02 Jun 2021 03:17:47 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:46 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
Subject: [PATCH 14/21] ide: via82cxxx: Fix misdocumentation of via_set_speed()'s 'hwif' param
Date:   Wed,  2 Jun 2021 11:17:15 +0100
Message-Id: <20210602101722.2276638-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/via82cxxx.c:122: warning: Function parameter or member 'hwif' not described in 'via_set_speed'
 drivers/ide/via82cxxx.c:122: warning: Excess function parameter 'dev' description in 'via_set_speed'

Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/via82cxxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/via82cxxx.c b/drivers/ide/via82cxxx.c
index 166feaeed6e38..9beb25cfa5436 100644
--- a/drivers/ide/via82cxxx.c
+++ b/drivers/ide/via82cxxx.c
@@ -111,7 +111,7 @@ struct via82cxxx_dev
 
 /**
  *	via_set_speed			-	write timing registers
- *	@dev: PCI device
+ *	@hwif: IDE interface
  *	@dn: device
  *	@timing: IDE timing data to use
  *
-- 
2.31.1

