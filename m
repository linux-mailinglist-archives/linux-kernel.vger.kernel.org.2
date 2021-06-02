Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B9D398652
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhFBKVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbhFBKUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:20:08 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDCAC061357
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:17:53 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v23so1699453wrd.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ffhlhORa9MD76Qfgf3sMwz4+X77WIAnMaM3VUopGK6E=;
        b=E4V+Pbwmmui80575wZa/0HhSIL4NfmUAqtTHl/YRjmu6QInCPP/KB5KEEriGSKXHYu
         s5Hse/hhPpcrhWx0SLnX+Sh+/3HROvL2RP8P06SdD79B5eiv/xEgE4Ponkno2YUEPta1
         Duz2MBcgS4T6dmyyC9S0FnOe3cStkUhW0rHGCVDE2Mbw7c7CAdgps0CHZRPE6wTfe+9c
         QqeMES6A5NarvrSp3SsYlt8oPbdmsYZmxulLxnrEWfeYBrnMz7muy4XYqeR83G1pt8Ox
         5+HdsMR+MDvaVQsVHj4m+MoopxDr57VOByrt96OZU3xjrdimwZ+mJcMkk5VnjSzXcJ7w
         JYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ffhlhORa9MD76Qfgf3sMwz4+X77WIAnMaM3VUopGK6E=;
        b=DQwLJyu5DPqc4XQRv7hZtRxdc4JSEDuHHN7X7ucpGz7XsqYmc6vRf2GLTrPauludNW
         mHy8LiPlPuFLkuOPbLlFtmJy/MxH4VoHCVAQvDv517s/ghqF6UIDLZUJmbfzbnjERscl
         3JPlPFxoJs4q+8A1cvxoidCoHMQH+tbanvxcy/rLaPEItsOnKCcqyIB6gY73tjukWdfo
         EPUGg62fJnr+gIacf1LOQgbQKdQNGJEIDuZFj4wCRpECvDX6537D7z6cdaSOfCBR1cUv
         b/9EoRXkzWLZl0WefL0J3WW5FvH077lPyFJIK91r/h1QffPNNXcgmzYz8pXBAAUK7WKx
         ucBQ==
X-Gm-Message-State: AOAM5303wP7Y6nLvtHZEBx0a2GCia+yyJxfnhBGNz4Djk3oWpUN+G6oC
        udHllA+aixXksLngeUmna1TpGw==
X-Google-Smtp-Source: ABdhPJxxspuwt2Ws7/m8yQcpkZD3Kik31bJdkaR9gIDi5maHoFcQtmHfbDYEw48CsQ+js9D8owBZbQ==
X-Received: by 2002:a05:6000:50d:: with SMTP id a13mr31460242wrf.130.1622629071932;
        Wed, 02 Jun 2021 03:17:51 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:51 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Andre Hedrick <andre@linux-ide.org>,
        "Software, Inc" <source@mvista.com>, linux-ide@vger.kernel.org
Subject: [PATCH 19/21] ide: piix: Fix incorrectly documented param 'hwif'
Date:   Wed,  2 Jun 2021 11:17:20 +0100
Message-Id: <20210602101722.2276638-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/piix.c:69: warning: Function parameter or member 'hwif' not described in 'piix_set_pio_mode'
 drivers/ide/piix.c:69: warning: Excess function parameter 'port' description in 'piix_set_pio_mode'

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: "Software, Inc" <source@mvista.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/piix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/piix.c b/drivers/ide/piix.c
index ede42d2a5b0b1..6a22c281ea90a 100644
--- a/drivers/ide/piix.c
+++ b/drivers/ide/piix.c
@@ -59,7 +59,7 @@ static int no_piix_dma;
 
 /**
  *	piix_set_pio_mode	-	set host controller for PIO mode
- *	@port: port
+ *	@hwif: IDE interface
  *	@drive: drive
  *
  *	Set the interface PIO mode based upon the settings done by AMI BIOS.
-- 
2.31.1

