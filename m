Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CCD30F1D7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbhBDLQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbhBDLNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:13:32 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA5EC061A27
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 03:10:29 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i9so2643790wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 03:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hrNr+lBWtFId4EzjUkysKAYnQC+wg9XBY1JaRyhRGmU=;
        b=wCl0IaHIQhVpYAG4G1XGZ11OJZCpT+nf40JxNtK/yc+i2oMo9dm0aJhJzAqrUs5tZq
         FvFd5kcpNZcSkMIkXUKXojCIAXax2YYl6f3UUb7+IcUKpRf4nxy2ZTwBCW79IwyBXPxe
         nopVLMan39vBhud+20LlTluJ6uScxi/yGDBBp/YSapWUhKBRLo35hbP6iqXDZBnKJcbC
         CFwip/DRDdTdyItXEtbWAmYNzhJE8Vvg7y6c3IcP5y2n5d0INnR0TZodPX/41Y5ytAoQ
         RaM+Ba3HalHyJBPImyICoe+EABpG6OYlwTQ/m0DC5KZBtguzx6yVEoQh2iE7p8a7P0UZ
         abBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hrNr+lBWtFId4EzjUkysKAYnQC+wg9XBY1JaRyhRGmU=;
        b=NfVWT6zsU8aSphDMwMTkZmWPmSHc9Q01h5V41TDXCp4AzFNqArHYwwVku79+xirRXc
         2Lm9qO8eI8iBFxafNKb1mRXNZzbrTF5yKJeMGQadiG2YyHoQ/HwqGxtc/bRA1KMufTig
         wy75ubU7qoyGR+tbNUsE36snJbI6pxY/z4sukCuq2D82JnqF6MmiDmC9yNIEbC8ziRT0
         3HVg9f4yG+ipl3t1VRq6Xl8/CPH4AarxvXvzIolpV3bQyJoTxRFKIheay2pua60tMRnF
         zjB+Y9sTYw9BHPf24n0r7IYXCb1tRfCb6E4TIdWmsGFm2T15aKUuF0fhg1St/oiS9OQl
         jRBQ==
X-Gm-Message-State: AOAM530JOF/ioohQ3wweYspJrXLIcYzk4CFvmhHHogeZaGMnovp1QIrs
        2xgY7PkRpRzSP+KCpaLFzTQSZQ==
X-Google-Smtp-Source: ABdhPJyQt1sKw0ek1Sz27bkoNIJ4Dc3TqSZmz3zCEA0n7R042NG3hUP1E6LQ8QMiCibzFOUbIpWBnA==
X-Received: by 2002:a1c:9ec9:: with SMTP id h192mr7238710wme.28.1612437028668;
        Thu, 04 Feb 2021 03:10:28 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id y18sm7696218wrt.19.2021.02.04.03.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 03:10:27 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 20/20] crypto: cavium: nitrox_isr: Demote non-compliant kernel-doc headers
Date:   Thu,  4 Feb 2021 11:10:00 +0000
Message-Id: <20210204111000.2800436-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204111000.2800436-1-lee.jones@linaro.org>
References: <20210204111000.2800436-1-lee.jones@linaro.org>
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
2.25.1

