Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7262C37494D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 22:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbhEEU1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 16:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbhEEU1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 16:27:24 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524EFC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 13:26:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l14so3219535wrx.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 13:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1GWhhI0iSMmmiuEZ5hKTPTRltVs1yqT5L0KMdXtcVHo=;
        b=RrH29E/xtX6Nqr3atmcD7x0ouuE24Sx1nGS0MCqKymullmhi/P+fe/ymO1n4FQvNjH
         W0om+HX99ly8h5Zf+mMXOiBepZjshqSNA1BCkyfCRnv+9HEHmEeASrkq1FBLW//Mzs0X
         t1vff6HBPbIR8S/wuDJbonLq3k463f1+I8gNUsRhcVCpl2Is0GPy1kK6odS95NNzwt/V
         1URhXA6kdhioyxys+TFXFsGF6fAWwmGhnSfoHZFRwA7GT4ki2AyoyUEEeyj3Rv7ZQlUZ
         3jbvlXATyuON1X829sdsRV9A18HaDN3QQAy2XnU6dg0TfsrY120EtCKEszOAKnJOdp/c
         qtbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1GWhhI0iSMmmiuEZ5hKTPTRltVs1yqT5L0KMdXtcVHo=;
        b=bX9ge+S9oCX4KDm0BfWUTW0mmJzrmUpiY9M5HWkO71P1jUd5ZB3cjKM3sQlR8DYS5R
         8MK5RdyJCsOMVGVK0Bm7k7HoEX/jA6otAvquHZpjfQQwurd0AeKFQH7eC8vtz1ST+z7j
         7jlMolx3YfkmSgcwFu61Yxvlv6dcJWf72kc8S6vzmLPdiC171HYuNTvhbDZOWv+mFYZf
         9jX2olFOkqLQQwbMSGFbct0WD2R1O2Gs/X+B3K0uO6HQ3cvat8tshKBxnDPQ113UKJGb
         uNKqunDPSaLo5TPX4K1Wlpn2NjsTopJ0am3bNaBRmAXUPTqv7zr1dHuAFmyO6HAQViHr
         imPQ==
X-Gm-Message-State: AOAM530xXAvXdd64NUjbZmt3Mk5v4hPHSSfAVUD2l+tDiA3fCv0pUHVk
        ToySudwpOwKDNkabpE3lw30eHw==
X-Google-Smtp-Source: ABdhPJyzDQo9IN4BHvaWNRhY7cq1F8rfYdFnnq5prH8HvMU4JBI2fV8FyqoRYW7YqVCXo+bnRMTlow==
X-Received: by 2002:a5d:47a8:: with SMTP id 8mr948064wrb.124.1620246385100;
        Wed, 05 May 2021 13:26:25 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a15sm497245wrr.53.2021.05.05.13.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 13:26:24 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     chohnstaedt@innominate.com, davem@davemloft.net,
        herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 00/11] crypto: start to fix ixp4xx
Date:   Wed,  5 May 2021 20:26:07 +0000
Message-Id: <20210505202618.2663889-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Loading the ixp4xx crypto driver exhibits lots of error.
All algorithm fail selftests with different reasons.
This series start to fixes some of thoses problem.

Corentin Labbe (11):
  crypto: ixp4xx: dma_unmap the correct address
  crypto: ixp4xx: update IV after requests
  crypto: ixp4xx: fallback when having more than one SG
  crypto: ixp4xx: convert unsigned to unsigned int
  crypto: ixp4xx: convert all printk to dev_xxx
  crypto: ixp4xx: whitespace fixes
  crypto: ixp4xx: Do not initialize static to NULL
  crypto: ixp4xx: remove brackets from single statement
  crypto: ixp4xx: Correct functions alignment
  MAINTAINERS: add ixp4xx_crypto to the right arch list
  MAINTAINERS: add myself as maintainer of ixp4xx_crypto

 MAINTAINERS                    |   7 +
 drivers/crypto/Kconfig         |   5 +
 drivers/crypto/ixp4xx_crypto.c | 277 +++++++++++++++++++++------------
 3 files changed, 188 insertions(+), 101 deletions(-)

-- 
2.26.3

