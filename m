Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DB5417CA5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 23:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346301AbhIXVCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 17:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhIXVCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 17:02:02 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35009C061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:00:29 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v18so5591371edc.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+RhLarViYwGGbP25CxUD/jDy/s2t/4w9AZqg5EOT7Hw=;
        b=NagVNupFxjAvxPWCK33utYcdQ0e3WD1NklqnaifczqAPmuXMZ6QTLA2kNFnDRQwjZA
         jh84b+iNxTu/1UQ3xoeUVOtWIrs8cOrT+f/BSJDjgvffbyaOIp4zrAbaCkHd+nCiF4Q2
         5i/DCKk4vRPH7WAny2dwIOZNPURQHm4cNelzOceVqjWfnAUnL5vzvTYkZQ/aRDH8Ny5t
         lJQo3moA8T4fV2m2+a2Mv6yak9t/9Am8/+MdSBV1o6aKMtDAJCfgcAswHVV3JESHA3Da
         87bdpluMScl6wIiffbME7ubd6vlv2wyQdUxL981CqyxCZZSjIvc52onhnCfsC7Kwfnuz
         8WcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+RhLarViYwGGbP25CxUD/jDy/s2t/4w9AZqg5EOT7Hw=;
        b=57G6KK9C3bCzAmGuldk1KDjSUyo2J4sgIRKtw/uZ5Fycu5r15zZVUowfCd1mgXz+su
         BsLHY55SIpaFtZEKPzzXtnMOkmf5stld+FfFdSItnyzHd2/eBtLaUgDpujhvmVQd+naD
         S+fVHJ0KozbjaBSxZ6MagxrUU+7rQMGb+N3zerbZBvI4KErUxiXvtCQ/KdXKlbmvcmqi
         tR78oRSWio9JnGu/iCxskXC5B1r6/3hCmZwBxaAaaxNl0G2OjvLmFX5k6wg7yC5nGUtV
         tISICZOmSyTvoCfLcdzKZ4m+fPwyNiuvzPXVPalIc4AA7cj4Doy/qwLr3EpSKZXO+CnM
         8k7g==
X-Gm-Message-State: AOAM531IQg2KvXUpR3XEke65Rtx97h4JtnMZgEI5J00ocQeuEfyCxfoc
        xnLLebilk3KiMOcxhhoL6P4=
X-Google-Smtp-Source: ABdhPJx+cFJl5Z33gdtZEAKeibcSlrJqDnX3STossivb/eeRq5b7EAJVrjCST1fDkS7LxenJ2oYcQQ==
X-Received: by 2002:a05:6402:c8b:: with SMTP id cm11mr7484866edb.368.1632517227567;
        Fri, 24 Sep 2021 14:00:27 -0700 (PDT)
Received: from tom-desktop.station (net-93-71-218-228.cust.vodafonedsl.it. [93.71.218.228])
        by smtp.gmail.com with ESMTPSA id 11sm5456109ejw.50.2021.09.24.14.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 14:00:26 -0700 (PDT)
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
Subject: [PATCH v2 0/3] staging: vt6655: replace camel case variables
Date:   Fri, 24 Sep 2021 22:59:59 +0200
Message-Id: <20210924210008.106355-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

