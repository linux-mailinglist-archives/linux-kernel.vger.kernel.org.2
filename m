Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B6A363046
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 15:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbhDQNZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 09:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbhDQNZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 09:25:31 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D762C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 06:25:05 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id x11so31634075qkp.11
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 06:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BZm00Xc0p/94j6srLK1r3tkA4U5Cw6X9E6ocH2iLzlI=;
        b=CWt1fRfAKh485gQO18embcRiO4WSeHn9EhQgKBOQ5P9ntIKFLrbpsVl3Vw2Punfh6t
         /gaSBJLXqDoPzr6+GELua6LGj+syhSzbZsw6grMRstR73o86A88d6gfuLJ5lrnj6hm3n
         Sqs7O4mNMkLOreVy7Er7Hc0deqdoX7C14ewhFAbDiZUoNfRJ4VHC/1SFXcYkxvWdVjoX
         iKPdHuS0FlZ/c4CUpiIMbXJLJSvesp9n2F+rsei8b75YT7vraOWEmdm0qAGmtbGE93B1
         sNCtCKV4eORY3LscHZ6822iEcXdQD9KlFarfRYoBOyQ8yzjC1NdRnuP8kye7v5MYspUU
         75Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BZm00Xc0p/94j6srLK1r3tkA4U5Cw6X9E6ocH2iLzlI=;
        b=WPwZ8VkQ3OdpbJFd6pf7oYdn1V3ozIoXqjzABqQjonCIKWsEHduMV54kP1t5WSTr6Z
         GkHEB8vw2aRbCeI2RX4+M7lTTxNB5mGDfczHv1Z4QTGes4HaKZ8tiax6hmPbVP6iLX5b
         IVvHUeV60RdUy9tMSeK1U1r28zPuz8PMOT0+ntyn60FD9e98F8mZ0bvx4w3HaixoBOr2
         TP2l0gIZfLiBrYGgv9rEqww78quwGZcr/ydz6yCAYf+DNTwM2oT+FOhwACWDDpd5EtiV
         J9xTi5gv349XSHNrKcgbnH+0Lz+IJMzt4gnzSwgYmD2V6JyuTYMJHvvG2YFGpl846bC0
         HHfg==
X-Gm-Message-State: AOAM531kdm/9ldglxCgtLUAOGn2ws7w9bOW5+5rRgQHgsFVt/dpg07j8
        t0sgK0lFvp08pjizAlUFbRllnw==
X-Google-Smtp-Source: ABdhPJzQHrRYUSGCD23lP/9i2iV3V1jvYARwoyqHLWPYfeQZ0Qyd1v2CJSiUHu8Dr2S2zwO6dy5LDw==
X-Received: by 2002:a05:620a:444f:: with SMTP id w15mr3829536qkp.437.1618665904339;
        Sat, 17 Apr 2021 06:25:04 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id o25sm1988327qtl.37.2021.04.17.06.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 06:25:03 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [Patch v2 0/7] Add support for AEAD algorithms in Qualcomm Crypto Engine driver
Date:   Sat, 17 Apr 2021 09:24:56 -0400
Message-Id: <20210417132503.1401128-1-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for AEAD algorithms in Qualcomm CE driver.  The first three
patches in this series are cleanups and add a few missing pieces required
to add support for AEAD algorithms.  Patch 4 introduces supported AEAD
transformations on Qualcomm CE.  Patches 5 and 6 implements the h/w
infrastructure needed to enable and run the AEAD transformations on
Qualcomm CE.  Patch 7 adds support to queue fallback algorithms in case of
unsupported special inputs.

This patch series has been tested with in kernel crypto testing module
tcrypt.ko with fuzz tests enabled as well.

Thara Gopinath (7):
  crypto: qce: common: Add MAC failed error checking
  crypto: qce: common: Make result dump optional
  crypto: qce: Add mode for rfc4309
  crypto: qce: Add support for AEAD algorithms
  crypto: qce: common: Clean up qce_auth_cfg
  crypto: qce: common: Add support for AEAD algorithms
  crypto: qce: aead: Schedule fallback algorithm

 drivers/crypto/Kconfig      |  15 +
 drivers/crypto/qce/Makefile |   1 +
 drivers/crypto/qce/aead.c   | 841 ++++++++++++++++++++++++++++++++++++
 drivers/crypto/qce/aead.h   |  56 +++
 drivers/crypto/qce/common.c | 198 ++++++++-
 drivers/crypto/qce/common.h |   9 +-
 drivers/crypto/qce/core.c   |   4 +
 7 files changed, 1104 insertions(+), 20 deletions(-)
 create mode 100644 drivers/crypto/qce/aead.c
 create mode 100644 drivers/crypto/qce/aead.h

-- 
2.25.1

