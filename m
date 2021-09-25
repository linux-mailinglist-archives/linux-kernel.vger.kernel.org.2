Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2309E418056
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 10:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbhIYIfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 04:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhIYIfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 04:35:31 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6C8C061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 01:33:56 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y89so34860855ede.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 01:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+8PZXNRc5ZTxd7WuoBWNH6vWt+Frn9DdJuHENk685Rk=;
        b=htbmNl2o3YA3698zSUgpUR/7+4z/HV/NNO8yUyeUSTsgrZg/Y4g6NzbT9CJkOOVHUB
         C0WUxhI5ydrshPEVZgT5w2SeyJ0xbjtJqoTFsjK6BkbJshkvPUFXv5zSL0SQWQpNhdpa
         9Iy0xqfm/J90enfGK2Jcn5aODyTHcaXIn0CLxRhHNp0hFRsTvin9OeUp5H1w5nE6qoZ/
         Jwc2MTZ64XuI8nPeiJcPR/cU6eUlVqee1STvcspUSItS6d0lGd5RfU+nm3EuXLR/Lkj4
         /9KHrvhnuhsBOXgvyfHwGgjeZpydR3xRI/T/Sk+UzUYqKaIu2gAP+pZ+wB1YQceIf1r4
         tpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+8PZXNRc5ZTxd7WuoBWNH6vWt+Frn9DdJuHENk685Rk=;
        b=a5B/ZjYFtM0JlYbnVmfCGPZ1085agZjXnX7KWismlT8rxio/OU1qgATnZHHFkUsNkD
         rLOY1zrNS7sqdRhQuD0IqMZtbQG4BcPxQA9k8SS2eLS1yoCF1l3IdTFZbzK3v3SyAJyc
         3qT6WmDMpwKXrvhOUkdHuZF5Bvx9hL2ogB4QVmCaB5VQN8nHLtW2h6b1fZmQiH9qcQtD
         PPVh89fRla+HkANqOYXiDPwFE/5eWxViNLDFskaY7aihCjJYLfDFxqvfVUiBYgIQk/sv
         CbkidfgVCxaT655qCTdM7hx1P3lGX81R32xFRCSsf9Ijh7tPf9Od4xE5TsqfimHebcgN
         //6g==
X-Gm-Message-State: AOAM533qMk/cXXtwr2yIzhGzOEHEJ3F2f4XQUcW433szPqV9ZfFQAiHt
        mbqzVBMYa1pnIhtn5g2V/KM=
X-Google-Smtp-Source: ABdhPJyhJtrlU2Its5h+KQJZDgFdjzIYD7xZB7Y1ldhgbzlcBEMuXC1PNCc0zbXf4f3so7+ETiRJkg==
X-Received: by 2002:aa7:df92:: with SMTP id b18mr9787595edy.47.1632558835293;
        Sat, 25 Sep 2021 01:33:55 -0700 (PDT)
Received: from tom-desktop.station (net-93-71-218-228.cust.vodafonedsl.it. [93.71.218.228])
        by smtp.gmail.com with ESMTPSA id p21sm6056514ejm.88.2021.09.25.01.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 01:33:54 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Yujia Qiao <rapiz@foxmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] staging: vt6655: replace camel case variables
Date:   Sat, 25 Sep 2021 10:33:41 +0200
Message-Id: <20210925083350.13996-1-tomm.merciai@gmail.com>
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

