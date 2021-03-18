Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334B13405F1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhCRMpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbhCRMol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:44:41 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FB6C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:44:41 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g20so3459548wmk.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TY1HutZnteRyydV5Ih0Egjx6tbg8POtzIYYu0tZ9gLI=;
        b=YpCedp9IdwWeyxohsMCGQpMQoLV/hkD4ApREPjeUj04im6YuhY7tA13/cQE/+ppygN
         gD4CV7xwu/vJdv5lQCoaNMHriSIdIv5N5QBPK4Wmn0C4U2djRnpU7/C+E5upxSCkWGzE
         tOHe9MF2in8lHi0Op/RB+Od7D9SCVOqREpzBkQArb4HKpO6hAcjGDN64seMVmvqwHPEP
         r9nseEw/mDgKSTAg8kqsHIeCaOWrJc1XDZrInFEKRSwtrMPhD7pJ9wZh3wzYT+Lm4bQO
         CoTKTy2nH43TNBDPGKNNWkgx4Qf9u4MvFGSgQqtWJC8oTc7Xsla9O4alkLDH06QTK7hS
         e9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TY1HutZnteRyydV5Ih0Egjx6tbg8POtzIYYu0tZ9gLI=;
        b=pXELaC6mX1uVFwywoOBP1YzG1ZG35pcVHIzxc3GpzjXG31XcObRUTF7PDwNKDtWb1m
         l+ZzeAqD5UGDr7/SnvnroQbsmtEIKZZnm0k60us+YlAXVamC4Mb7vR9PRRL49Q46J6v7
         I64gU5rv35hqk6tJAO4Rq7t9o79cJRQEuIVdWUYsmIbUz5p8wdMYNwhCkV3OEmpw8nfJ
         pZt2YJ6NPX37RqfcB6Syh6di37+p98Cd6rRNLfNv/3tSXicZ/nwH9e+ch9p3k6OBHosI
         EFW9vvC+rN+yySeu6BWzLi6GzQw3l79YqIJ+HrjPqSWZAgMnvTMumUn2bauFzuT4zg2L
         ULHw==
X-Gm-Message-State: AOAM533zd2AdAPCJPuUoVcqjr1MxsJf4tPhBPATQ6GQJsHqrZjwmGfK5
        ZZhkP08EoggmkYuFW0fr40dvGZbwKzLoKQ==
X-Google-Smtp-Source: ABdhPJwayS+6aJydxHj5yStfZeVa3lyWXiOrvhsKnl33t0rWgECJEOb5yGGRqE5y2RprFfC7xgfXqg==
X-Received: by 2002:a05:600c:3514:: with SMTP id h20mr3567716wmq.45.1616071480151;
        Thu, 18 Mar 2021 05:44:40 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id q15sm2813900wrx.56.2021.03.18.05.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 05:44:39 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 10/10] crypto: cavium: nitrox_isr: Demote non-compliant kernel-doc headers
Date:   Thu, 18 Mar 2021 12:44:22 +0000
Message-Id: <20210318124422.3200180-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318124422.3200180-1-lee.jones@linaro.org>
References: <20210318124422.3200180-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/crypto/cavium/nitrox/nitrox_isr.c:17: warning: expecting prototype for One vector for each type of ring(). Prototype was for NR_RING_VECTORS() instead
 drivers/crypto/cavium/nitrox/nitrox_isr.c:224: warning: Function parameter or member 'irq' not described in 'nps_core_int_isr'
 drivers/crypto/cavium/nitrox/nitrox_isr.c:224: warning: Function parameter or member 'data' not described in 'nps_core_int_isr'

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/crypto/cavium/nitrox/nitrox_isr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_isr.c b/drivers/crypto/cavium/nitrox/nitrox_isr.c
index 99b053094f5af..c288c4b51783d 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_isr.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_isr.c
@@ -10,7 +10,7 @@
 #include "nitrox_isr.h"
 #include "nitrox_mbx.h"
 
-/**
+/*
  * One vector for each type of ring
  *  - NPS packet ring, AQMQ ring and ZQMQ ring
  */
@@ -216,7 +216,7 @@ static void nps_core_int_tasklet(unsigned long data)
 	}
 }
 
-/**
+/*
  * nps_core_int_isr - interrupt handler for NITROX errors and
  *   mailbox communication
  */
-- 
2.27.0

