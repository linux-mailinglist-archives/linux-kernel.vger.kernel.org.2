Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D36C398645
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhFBKUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbhFBKTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:19:42 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432B8C06138E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:17:52 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v23so1699390wrd.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hghg5eiTw+XcFBcIuWtxfTHWZai/nFkGzTUoTFHy7tQ=;
        b=YZ50AN5U3jBUZLeLdk7DDuN3K2pMrIbrP2OHxpOHagH6mjsZMPmeQDsP5T2ltLpkqK
         jyb6gYRUE+7u9ExtFV15pSYX8tbD+1umFd/Hg8eP1mBac1Ltzedrfm/6gfD7OfHR+3nb
         gqyVpZM/tGwNkGDcOy3t0u9hAA6B3vnFnlsPNhUm9a69uhYauQp+PF7rqCIQ8hpjSrKx
         WaVNka9st+UOsX1NAM9B4S5QJ8FwsNarQeBSPFpAkWM/9LQIHjZ4cuQGKT1p/98hdI5S
         ZuOT0MskdJg1ZF8ErA3UzdDJNUxMAqIHvZB+vJ8whbQocROtF5g2WW8MiIijMITA9Qmp
         3Hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hghg5eiTw+XcFBcIuWtxfTHWZai/nFkGzTUoTFHy7tQ=;
        b=mvaBtj4wxeLRfCghNeRWxQIzYYmSmDNSzTlvEAAet2bV+aCNjv4ucU4W5HqrKWn1j/
         uSZijo86X+APFlQPu4RFHzO5w9t4lwW/LE5iWhv/vLXb5/U1nRUiwtNtqjD1BP0sikVx
         gci1tduvwkFSiim+HTwWgVzX4Pu14Arn/dP30G5ZQ0g2YCzNp+e8ULGlL0Xpzoa9Onf6
         S05svSHCR4J49Rh/zq98dw5AIwCwyK3sKjleXExZGpK7DUX6t8m9AQLc11nEMLVNJjdh
         QS07PoRf7YMROa9/WXqiSJVNjjGqbqIZj16Z0OgKZVwDumbo+AC4doJV3SBDOD9riVE/
         dTzw==
X-Gm-Message-State: AOAM530BnRZe90teLSFiSNUNQe7h8tUmxrh0SeOGXtLq9Wq8yUqYGEak
        5tM+IUEYMyboEZYZY7Am58LSuQ==
X-Google-Smtp-Source: ABdhPJwNaESo8dgf3KZKl5D5IQxpN86T+b+Vg1TYMkBROXmXd/GZTTNXjRq21dG0p1Brd60StOt6NA==
X-Received: by 2002:adf:a489:: with SMTP id g9mr20930775wrb.103.1622629070953;
        Wed, 02 Jun 2021 03:17:50 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:50 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
Subject: [PATCH 18/21] ide: ide-io: Document ide_intr()'s param 'irq'
Date:   Wed,  2 Jun 2021 11:17:19 +0100
Message-Id: <20210602101722.2276638-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/ide-io.c:775: warning: Function parameter or member 'irq' not described in 'ide_intr'

Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/ide-io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index bd3e78985bcc7..129d036645f85 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -750,6 +750,7 @@ static void unexpected_intr(int irq, ide_hwif_t *hwif)
 
 /**
  *	ide_intr	-	default IDE interrupt handler
+ *	@irq: IRQ number
  *	@dev_id: hwif
  *
  *	This is the default IRQ handler for the IDE layer. You should
-- 
2.31.1

