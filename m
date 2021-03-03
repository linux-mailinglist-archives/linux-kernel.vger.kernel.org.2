Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE5332BEED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386203AbhCCRrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383551AbhCCOjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:39:24 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65087C061A2E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:35:09 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u14so23940624wri.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TY1HutZnteRyydV5Ih0Egjx6tbg8POtzIYYu0tZ9gLI=;
        b=ZrZtPbhtMvfSfUn1CpaM/MJoaOHiS73bOkPE4fNSZTfjUEZOFTPG9QWcs/aeegYLFS
         f44kVN1zeKnnoyhuhPS7kUznosUtF1IH/wbGXk1tF/7blzw6ufR/lKeIBHYgXs8R7GB+
         S2JCCq7ed4tqHQQ6IhWJowxYnpBMk7bqNuS5OHFXDSJgUldfEl+BoB6s1HerOOMayVRA
         UsCLzhOh3MeXhozA5M4RdFT3sj5ZdhaftbNm3zAGZLlm3+v1ElhiHtH3jdQ8LbiVTWW/
         c/ZCG2Jb6uwxjh9KwFVVtPEqBGoitNp6y/WyY7ciBAbNTxs4Y6/Y9Tk/WiESIVPn6KI9
         vKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TY1HutZnteRyydV5Ih0Egjx6tbg8POtzIYYu0tZ9gLI=;
        b=uhic/qA/dZyRf3Nx0i4/VATEjZkclwkcQ4Ce8rEh9JzrPC0z84GkiRBX/4VVNJV725
         MBuQlI6M0bS8Cf3mYFhSzwOdsBn45vYLlJmY4E45pZ/URFli5QNMl8l1A9rfwn//efGT
         DJr65rR/5vShm0CHQBtdOWVUFoASmb0LvxTPYXFRbTiFzf1B11IiPGqjzvOxXsP3mKCM
         pFb2kMawWEkR/BpgKmxXesf+Xxp2aDfOs+NWs3LKj/QXJeba366PjstKC5/t/xMgvsQS
         8mBnPd45z5XcIvJpcUf2p8w7UO8e9XlXFMQCcvfHzx31MYD4CDp90VyKDATdHHYQLIoB
         Q8eA==
X-Gm-Message-State: AOAM531KN8yS6H8lJyHTp2p9Oh4pVPovH3ZCZGmx1Kgs9IKOLQrau4J8
        CLH5oKJt7jkUv4MUtXSbcsDdSbxP8h8PyA==
X-Google-Smtp-Source: ABdhPJzDZbGYGKGfQpxNOw+Cx28KOumuLa28Wak6NvF82YGJcdRai/Jr3G9CMfQtP+SeizwIrtJtHw==
X-Received: by 2002:adf:dbc2:: with SMTP id e2mr26742037wrj.227.1614782108194;
        Wed, 03 Mar 2021 06:35:08 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id f16sm31475923wrt.21.2021.03.03.06.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:35:07 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 10/10] crypto: cavium: nitrox_isr: Demote non-compliant kernel-doc headers
Date:   Wed,  3 Mar 2021 14:34:49 +0000
Message-Id: <20210303143449.3170813-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303143449.3170813-1-lee.jones@linaro.org>
References: <20210303143449.3170813-1-lee.jones@linaro.org>
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

