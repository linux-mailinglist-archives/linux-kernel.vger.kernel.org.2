Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1B2418038
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 09:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhIYHrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 03:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhIYHrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 03:47:16 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95C4C061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 00:45:41 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x7so30601846edd.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 00:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+8PZXNRc5ZTxd7WuoBWNH6vWt+Frn9DdJuHENk685Rk=;
        b=Psx/hbfu1CqLOthiaZaXLpBqk3e4CTjIH5etc4mTfLdbjMeIZR7yZEjrslCnXjsnH2
         v7eLbPu50aTXzvj6W83uFmHmGChWYVSIZxIuW0VChbKzXlAELnQyGcw2D4igB6UFIx5E
         xjH/4c7jxT3lIlv1cgq43TJU/djyxOTlnSKA27octQMlIMSZsF7OTvX5LIE82K8TDhP1
         U8OHvetdqWHQCLaS+mLOeSCT7LWuwRTGRtd+LKINd7Lk8yFGK5hPp4WwFyvt0YIF6LMS
         rGMxsqUR2oJ6NLwi5B0Kgq/1DKsTR19Imt04lOTu7JdGmkN50Qv2C5rKe/VoZVVziYAE
         uLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+8PZXNRc5ZTxd7WuoBWNH6vWt+Frn9DdJuHENk685Rk=;
        b=sLHSDxbaWaXTjq3cxiQJTdHK/1djTCatqc6ilT77c2FiyA5BofMoYGl7szqBbMzLbw
         lDpMBiufji0wV0+m1Eiq9SB7XWyftQF9wQ8W2yeE9IkahmKBnzpoQbBV1rY5AX4xx0P2
         HkPTqvsU6M/2lLJtW1WSxBmAaOp9Z3h/wv6aQu+XirtB0MHzV2srsNKSNzV6zTN75NZ8
         gfsRlqYo2y9vmp9pGCyy64r5+hoShtA3AVaKqVtn64GCVynvUjv0R5mry/OGh5n4xkbS
         rlbRslJRqq1gQDuMFyJPWdppdteYtPcmoUly3jC1JMmM+a+x08NegXisrjtYfF64kBE8
         p36A==
X-Gm-Message-State: AOAM531vlk7Hzl1vAHQRO4cGvKrw89ce2VtyNtsWm2D5mNwQAq/Nlg17
        +ANzegvMBIPTAsrFzHZszg88YWndxe4=
X-Google-Smtp-Source: ABdhPJzKMjlmjwDx39EH55uunp2gbn19ryAemm8p6/GhD/A75doeBV+lv01hP7rUbTSUU1BVgsPe0g==
X-Received: by 2002:a50:f60a:: with SMTP id c10mr9720290edn.250.1632555940453;
        Sat, 25 Sep 2021 00:45:40 -0700 (PDT)
Received: from tom-desktop.station (net-93-71-218-228.cust.vodafonedsl.it. [93.71.218.228])
        by smtp.gmail.com with ESMTPSA id m14sm5949900ejl.74.2021.09.25.00.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 00:45:40 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Yujia Qiao <rapiz@foxmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] staging: vt6655: replace camel case variables
Date:   Sat, 25 Sep 2021 09:45:21 +0200
Message-Id: <20210925074531.10446-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series replace the following camel case variables for vt6655 driver:

bShortSlotTime -> b_short_slot_time
ldBmThreshold -> ld_bm_threshold
PortOffset -> port_offset

Tommaso Merciai (3):
  staging: vt6655: replace camel case b_short_slot_time instead of
    bShortSlotTime.
  staging: vt6655: replace camel case ld_bm_threshold instead of
    ldBmThreshold.
  staging: vt6655: replace camel case port_offset instead of PortOffset.

 drivers/staging/vt6655/baseband.c    |  58 +++++------
 drivers/staging/vt6655/card.c        |  90 ++++++++--------
 drivers/staging/vt6655/channel.c     |  10 +-
 drivers/staging/vt6655/device.h      |   6 +-
 drivers/staging/vt6655/device_main.c | 150 +++++++++++++--------------
 drivers/staging/vt6655/mac.c         |  46 ++++----
 drivers/staging/vt6655/power.c       |  24 ++---
 drivers/staging/vt6655/rf.c          |  12 +--
 drivers/staging/vt6655/rxtx.c        |  12 +--
 9 files changed, 204 insertions(+), 204 deletions(-)

--
2.25.1

