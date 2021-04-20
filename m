Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134A33650F3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 05:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbhDTDgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 23:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhDTDgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 23:36:36 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338F1C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 20:36:04 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id l2so81828qvb.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 20:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PJriSY/3BoO1fHsVgHab2OGWTgIWKz/XuakYolqJtHg=;
        b=E0hvOm6eMmyEZ2M3MU2QsiHj0zTZy4NxvzMJ4BuGjCki4mRcIXk7NPuyXjMnsPdPAA
         T8mmB/dCDnnKTJo7waaGCoouYsM+rEdpHxjRg624Hrm+KrU319G2jfKtg5Zsn6t+JKUE
         1+p5ccwYfSWxeg05DUjA+Gh9Kiz9CiRLj1/KaNL+sHK5ixXA8oKcbNnZGGOkuN/dD7UA
         yNG89UnljPOlKQwcffDInPUHqBmauqiT1uEU/J7gopgaRVGL+aXAYaB25y0h6rpe4OLF
         j3uEo6c7Cg0EuX8EaUT51G2iok5lnUA0gkTf3S0kDpXlE9nutvI/49+aMCKwcWh+LObV
         a99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PJriSY/3BoO1fHsVgHab2OGWTgIWKz/XuakYolqJtHg=;
        b=qsrOI/J0pA0uoNxum2r991WYodBLZY+HIassZs0aJld50A/HB7bwkOql0w0MHDX6lc
         Xl4io/KNEvlr1rnS6UmYDXrODnldgHn4cw3IruPwflb/mD75TAAugAWX4JOf/UEu7DVX
         rJTmPvdnJssmJsCillZbGTM5fNVldWFB20K7ToxkFRPqG0x2PMB9OBecw0LhNUCBvMXD
         ClZ3nkzj7g3eotzEi1Rn+MwlAQAWwg/b/NhJH6qKbxgxR42E/x01m+qaUyS2/zbhyc/K
         3b+AmLiU+JVLJJv1o2DRnWI7aVlFk+cMR+lgfEGtoXnDtqFmNprZYGsZo5+AubPYJtHZ
         e+sg==
X-Gm-Message-State: AOAM533sBKWdlv0fsz4PGZ2D/O8ycgYYmtLphZ3osT/x/N6/1H7vXRk4
        9I2sIm3UKa/89GRzdWiLm0lrtA==
X-Google-Smtp-Source: ABdhPJz/76Nl3IXgE34PV0d/wfa80eH3VqGZ0YzVyMqViE0CQo5/nlB7bzYC0R6svVBMv4mFZVfzHw==
X-Received: by 2002:a0c:eb06:: with SMTP id j6mr24696769qvp.10.1618889763374;
        Mon, 19 Apr 2021 20:36:03 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id b8sm3562643qka.117.2021.04.19.20.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 20:36:02 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [Patch v3 0/7] Add support for AEAD algorithms in Qualcomm Crypto Engine driver
Date:   Mon, 19 Apr 2021 23:35:55 -0400
Message-Id: <20210420033602.1729947-1-thara.gopinath@linaro.org>
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
 drivers/crypto/qce/common.c | 196 ++++++++-
 drivers/crypto/qce/common.h |   9 +-
 drivers/crypto/qce/core.c   |   4 +
 7 files changed, 1102 insertions(+), 20 deletions(-)
 create mode 100644 drivers/crypto/qce/aead.c
 create mode 100644 drivers/crypto/qce/aead.h

-- 
2.25.1

