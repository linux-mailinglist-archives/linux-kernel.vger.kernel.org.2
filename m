Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9680A340150
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhCRIwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhCRIwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:52:00 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139A2C061760
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:52:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e18so4609768wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qBw5nJooq34YS/jxcj30RML2GTr2FUzleakjhCquzqA=;
        b=y6Bd33NPTlbrNrDNk5ltgxDfqEu0YSGOTuMoUR/1UIjYmrZYLJlAWNrU1Kji+onJFN
         JZlNNLamvo6yZuyOIOxIIHkCxXNVENB12TaV8AtSTH04T3LeDaNwngt+LtB8VbfnbFWd
         RgPClcK0v0wmyVHRHHnp26/0tuLBlpjb0p2At/D1FK0Q7bvn7U+s7ccmnxX9xmnXGlRq
         54CsgzbbI60bJVuc2od8/tCuFyEchLxML+jJYCoMeQ8ghmgo0JDRUYPYdOK81luLQdAA
         lAlyub2xO6vdYol6boQGUEj2MmSPFGiyosjp+QdjBaKkQeMmUuVdt3aYiIfv8y0uE3Fy
         pTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qBw5nJooq34YS/jxcj30RML2GTr2FUzleakjhCquzqA=;
        b=EXAvdGaQ9keCCrfj1aQ9FtS+Z3p2w8vWwwnL8t8CzgIfO+pduFGP8+MtJu7F8RaIuu
         9qIp2ItMsg9SuxCpqqLil1dnuQZG7XcHmXRUaxu8jG4oBZtgB1vE7Z8ml6r+MX52J/9+
         LSXAjoXniQIsV4TBMcUycDQ1yCHZdpazwWZ1bxtjdBdwBJ2oxhAoSTjRGEF1qI57HwHU
         64BJ1IgEjj/jkn5u/msEX3JFbtjSbU0Qv5KADMGU3xm0I7YNT/K2QbnAuK8N1xkMLxyo
         Sz7Ut0gIDLhegCn1RJg37K738sY+ExXK0QbRgR8WvQl/UC+2JVE46BhiP5wdMHMQXOND
         MSxg==
X-Gm-Message-State: AOAM533PXnRoFxL/i0aeN7fwEWGIBzyIrJQnOLObuTyNRuacjBgkoe6L
        z8c9LHxxMZSEZF43tr+5s51APQ==
X-Google-Smtp-Source: ABdhPJwLSz3XO+Lumh3wZ6Y75pm80hiRCK36mLGAazKBoInU/8OojCpv+2FWnoiz3qOtUJTUp+nQNw==
X-Received: by 2002:a5d:526b:: with SMTP id l11mr8299694wrc.385.1616057518854;
        Thu, 18 Mar 2021 01:51:58 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:51:58 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andre Hedrick <andre@linux-ide.org>, Hat Inc <alan@redhat.com>,
        linux-ide@vger.kernel.org
Subject: [PATCH 07/15] ata: pata_piccolo: 'ata_tosh_init()' is misnamed in its header
Date:   Thu, 18 Mar 2021 08:51:42 +0000
Message-Id: <20210318085150.3131936-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_piccolo.c:87: warning: expecting prototype for ata_tosh_init(). Prototype was for ata_tosh_init_one() instead

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Hat Inc <alan@redhat.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_piccolo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_piccolo.c b/drivers/ata/pata_piccolo.c
index 35cb0e2632379..389b63b13c706 100644
--- a/drivers/ata/pata_piccolo.c
+++ b/drivers/ata/pata_piccolo.c
@@ -74,7 +74,7 @@ static struct ata_port_operations tosh_port_ops = {
 };
 
 /**
- *	ata_tosh_init		-	attach generic IDE
+ *	ata_tosh_init_one		-	attach generic IDE
  *	@dev: PCI device found
  *	@id: match entry
  *
-- 
2.27.0

