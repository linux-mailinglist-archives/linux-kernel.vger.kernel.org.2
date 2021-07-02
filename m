Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E287B3BA15B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 15:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbhGBNpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 09:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbhGBNpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:45:17 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAE5C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 06:42:44 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id q16so18194706lfr.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 06:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xVOZh1Cyt+07lU9O98eURJiMyRJpRRmLjbR5+r7Bs5M=;
        b=jAt+dM5oVAYDBU0YQrQEVGxLKdNpeJf/biXJmdCuKv1sQ//oc8AEzfKyPn8mxBXGw0
         D4OA5YAYdk78b30jXnMy+/bzQ8vs0SXofaIw8ljB+wy+mMNJVQ9n8hJKoHDo9puWVZEn
         d+hU97pzOEZRxdLxAKm1SO3DRpx4WoBzL4Uc79i9aJKcdPfn1WnRy8Ob/gHSCdSo28yX
         PU0xE5VObmwmxeh0OqaW93JLDdwFhhM6X3OAGQHfFiZQWKOfvXhsqAz0Sd6VLTGOLirO
         n+C/y3Hm/g3AJOt2c2Qc+/Noa0WC9pwU/Off9co0jphM42nzMaWkbd0fLTCdGjDbwlRL
         /Wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xVOZh1Cyt+07lU9O98eURJiMyRJpRRmLjbR5+r7Bs5M=;
        b=pFhnk6twQoBIckq31Bm/E9KlmnYjkwpojZ4tGaysZ2w+DKYB72hUQeLMED5P3d5XI+
         Ar32k+k8rT+fMgSIEIK6JBkDHmx/cn3JpmpPy4IbZDMqSWVZbsVO3PeADifnphXe9l1L
         V08npze9XnrmDX8OurPCpJYig9ju90vRog513PImH+bjpLWxmnCHqxv2X9Bv8jcTdOxW
         fXgUAaDyUH097l5/Vv1RCgMMUZMAGrAJf3MoDkN5wAWzzcISqg30ir/4ppto1NSyKeS4
         38FT5FGjab9zn/Rgiabj/QC0ykxa7e/twI/LSXHD7KFc3XoINx3fdbzSpOumUf3wpoDO
         +bPQ==
X-Gm-Message-State: AOAM531l8zCYYO2lsqoUmFqJO8KVbkGRaVlT+IeF2u2UauxQCrd8bzEH
        zz0qVYQ+80jU4KsuW4V2dcXP6Q==
X-Google-Smtp-Source: ABdhPJwmVwuogUgru4yT15rfARUTm9NBF9wGR2QDq8PHLusnmKd8f7EOwcoVQB5Nz9bIa9CfLwqfsw==
X-Received: by 2002:ac2:46cc:: with SMTP id p12mr3859067lfo.357.1625233362575;
        Fri, 02 Jul 2021 06:42:42 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id u5sm277486lfg.268.2021.07.02.06.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 06:42:41 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christian Lohle <CLoehle@hyperstone.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] mmc: core: Avoid hogging the CPU while polling for busy
Date:   Fri,  2 Jul 2021 15:42:26 +0200
Message-Id: <20210702134229.357717-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Step by step, code that have been dealing sending CMD13 to poll the card for
busy, have been moved to use the common mmc_poll_for_busy() loop. This helps to
avoid hogging the CPU, for example, as it inserts a small delay in between each
polling attempt. Additionally, it avoids open coding.

This series takes the next and final step, by moving the mmc block device layer
from its own busy polling loop, into using the common code.

Please test and review!

Kind regards
Uffe

Ulf Hansson (3):
  mmc: core: Avoid hogging the CPU while polling for busy in the I/O err
    path
  mmc: core: Avoid hogging the CPU while polling for busy for mmc ioctls
  mmc: core: Avoid hogging the CPU while polling for busy after I/O
    writes

 drivers/mmc/core/block.c   | 74 +++++++++++++++++---------------------
 drivers/mmc/core/mmc_ops.c |  5 ++-
 drivers/mmc/core/mmc_ops.h |  1 +
 3 files changed, 37 insertions(+), 43 deletions(-)

-- 
2.25.1

