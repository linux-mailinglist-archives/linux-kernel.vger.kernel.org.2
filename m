Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A760A36693C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 12:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbhDUKcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 06:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbhDUKck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:32:40 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E881C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 03:32:07 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id b38so5964722ljf.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 03:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fBQWyNtRNzkXZ2Gc9WUvzsz7njLiu60umO7wwJKluZY=;
        b=LKOFJpHSObmujmQdunPXOFFv/fgR3WYfzBlUopgCGKd3UJChtrfRG0BfGIocMOYwhy
         p+JGmUdiga+COnlSgspTSEEmLIIB851zeucmhnQ3rGwPYlLIJ3uJOJC6nybTICFpq9AT
         jRbghH9a23GbT/Brtcm9voCyswA0OIAvk3oWea5cq4SNq480J0zPKeHpm2sdppSPhW+8
         /0JPkyATAZa8OXpNB0ePQqks8jjWwnEWhWhmzVdTS4klK5r8bB6Wz6Fqee6Lf5FSEsGi
         ZKaAiXmU5O28U261JKx1Nf4k3+LQoLgDVYS07XXOuIaoJua9cwp2PZuJPo3OhSKNr0ns
         Vvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fBQWyNtRNzkXZ2Gc9WUvzsz7njLiu60umO7wwJKluZY=;
        b=kHnwxMKGlcacDWEN8VqOOLpiO/FP8FZU5nkLuNgVrH+n4Z8HC/iOjVrCARjmym9eZ2
         fOQ/H+y9yrVR8p7fTO08bx5hUiu4VYr4E/TOpnHZDhHI2OwvJbrYRhjC6W3JByOTN21P
         qmyKwSPfjhnkKIH4ErfDzb7Lkb5gk847FItwD+Y3gL8bfxWok1GKp7BR1yNYhChlw8Hy
         Ah2hD6zlr7jKmyddUoLSgQ2n+ztK9vcs+pqOlryKdjoixZ5ZR6gcnNo48Ut0F1wWcyUg
         xz5VV3zv7FYMUbTnx3+yURcmpR/uRmkE1CLyuL65rLdWYysx6DZyD3xSoD+stF/ck8VB
         bkng==
X-Gm-Message-State: AOAM530KYWMCNen1dJFKX04xwdauUqUsIZdnl5eWvTv05udyVadehn9O
        EoDkEmv53DEJK60ovlfXDJjuwA==
X-Google-Smtp-Source: ABdhPJy2QAMm2KR9a2HuLbV6o3dBB1eV4thW4JJzL9UYl4tSBGf5+jl5vFKnquBcNTYNJBkExFvAfQ==
X-Received: by 2002:a2e:7817:: with SMTP id t23mr17354186ljc.240.1619001125567;
        Wed, 21 Apr 2021 03:32:05 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-234.NA.cust.bahnhof.se. [155.4.129.234])
        by smtp.gmail.com with ESMTPSA id u13sm170603lfg.139.2021.04.21.03.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 03:32:04 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] mmc: core: Read/parse SD function extension registers
Date:   Wed, 21 Apr 2021 12:31:50 +0200
Message-Id: <20210421103154.169410-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the SD spec v4.x the SD function extension registers were introduced,
together with a new set of commands (CMD48/49 and CMD58/59) to read and write
to them.

Moreover, in v4.x a new standard function for power management features were
added, while in v6.x a new standard function for performance enhancements
features were added.

This series doesn't implement the complete support for any of the new
power/perf features, but starts out by reading and parsing the new registers
and stores the information in the struct mmc_card about what features the SD
card supports.

Note that, there are no HW updates need for the host to support reading/parsing
of the these new SD registers.

Tested with a 64GB Sandisk Extreme PRO UHS-I A2 card. Additional tests and
reviews are of course greatly appreciated.

Kind regards
Ulf Hansson


Ulf Hansson (4):
  mmc: core: Parse the SD SCR register for support of CMD48/49 and
    CMD58/59
  mmc: core: Prepare mmc_send_cxd_data() to be used for CMD48 for SD
    cards
  mmc: core: Read the SD function extension registers for power
    management
  mmc: core: Read performance enhancements registers for SD cards

 drivers/mmc/core/mmc_ops.c |  11 +-
 drivers/mmc/core/mmc_ops.h |   2 +
 drivers/mmc/core/sd.c      | 222 ++++++++++++++++++++++++++++++++++++-
 include/linux/mmc/card.h   |  21 ++++
 include/linux/mmc/sd.h     |   3 +
 5 files changed, 252 insertions(+), 7 deletions(-)

-- 
2.25.1

