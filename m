Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79B732556F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhBYS2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbhBYS16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:27:58 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA00C061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 10:27:18 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id r24so4805045qtt.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 10:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3qSHutfjPy0EOhPiH6AWkm82ddTRUb/cgeNETSCNBCc=;
        b=FBYbGpWJCE+HSYVdV5pw2twtzkKMT+QzWxslw7/BhILvYCUfVXTEcQrASttmL4Z+mq
         7ZiwQDVAKnLPnM0thr9I4RyPIc0tPMpmbbS9WdaN/W5elbbolcvwnV4MI0egLeeo+LmM
         +C109WKTh6FqVHXVqWMKBWt4esqtR6BXTZGCxF3Fdem1p0vuR69kTxIwLVjJ8QPuv3UV
         xtJRl40sV3T1SkXqZKgX4dQvdTKs01zbIIl5A3v/8MWjmquEGjsvL6SE7js5wEXaXkm2
         JOr8JDtH6mdoh4CJRfjj6+wiJqaSBj/B5XoVsk3Q+DrioVDyXEi4kqQw1GBVoqX+An7k
         VuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3qSHutfjPy0EOhPiH6AWkm82ddTRUb/cgeNETSCNBCc=;
        b=cjpnzAX7JMc9/vnuGmf2y8UNaOe6BtYZUL0XU9jtaa4xS2MrSPAR90dFIXc+wNAe4e
         XJ4W5xYBiFJl2NJwSYW8Mzvm8ISk86L3mnVlFADGhjE6humO/CmwHq0fmikGgRLgAu5U
         t1IeN3rUoDBqomevHlR1cDoh5M7WdbAU1b2v22BmJJFimOl0kiJ4Ef86inRlkmrWEsRe
         F76YfwqdZ50Jqy31iO648wsRRkAJ9hciemZF1JaDVX46U6aSWSUrCJFdDXFbktrznhgK
         sB3DR4AMbpvBJ0CvRTek2xdoPjCHw+K5ajkOd8vvNQwfLBU6cC27SH6dbh/jndlLF+3N
         HJ1g==
X-Gm-Message-State: AOAM53067CK1j9gCSCDPbXYl33ERH0/ksVNpdt9Eknw8t9FSjZmMUDeK
        mkLJXMUYhBzQwbc0uEyqzHdIss82vpLhKg==
X-Google-Smtp-Source: ABdhPJxRRGKChcV9zwck2AHYqWey+QMaXwyT+/UEQ7Tn/44kcqcNFuStrxW14hAzlrYCKuorP/9wAw==
X-Received: by 2002:ac8:53c2:: with SMTP id c2mr3491946qtq.166.1614277637530;
        Thu, 25 Feb 2021 10:27:17 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id l65sm4519678qkf.113.2021.02.25.10.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 10:27:17 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Add support for AEAD algorithms in Qualcomm Crypto Engine driver
Date:   Thu, 25 Feb 2021 13:27:09 -0500
Message-Id: <20210225182716.1402449-1-thara.gopinath@linaro.org>
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

This series is dependant on https://lkml.org/lkml/2021/2/11/1052.

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
 drivers/crypto/qce/aead.c   | 817 ++++++++++++++++++++++++++++++++++++
 drivers/crypto/qce/aead.h   |  56 +++
 drivers/crypto/qce/common.c | 198 ++++++++-
 drivers/crypto/qce/common.h |   9 +-
 drivers/crypto/qce/core.c   |   4 +
 7 files changed, 1077 insertions(+), 23 deletions(-)
 create mode 100644 drivers/crypto/qce/aead.c
 create mode 100644 drivers/crypto/qce/aead.h

-- 
2.25.1

