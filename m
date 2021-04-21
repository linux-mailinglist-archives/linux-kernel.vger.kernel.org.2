Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A782366B60
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 14:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbhDUM51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 08:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbhDUM50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 08:57:26 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D2EC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 05:56:52 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id n138so66837519lfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 05:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ULnHBQgqSbvoxbafI3CKu7NeQDJtQC81cSXhVI6lf0w=;
        b=N/8js+bsCKnk8kn2LD3IJPlGrF5nvRvn103em0ekmQid3aD4GAZLSb4TJngcFRfbnV
         M3pAQODecv8VU5htUnaqPJF2IcYMFX+uq7r7zq3offVzmzhUpAiFUJkGVsdJsrA34N5v
         ickiSLeTZ7vopPMwXWCZDSau/6+l/Z7UXZoTEWeBiTVaK546Q1qlM0YL51Fa8lomDJoK
         HLuQgiOj4nEQEd7A8AuSpyvlPg688XN81hPerSJBs13kREie5SbNsYBhOWyLKry2uqiz
         UMj5qZ1MJ6bIE2Y8O3x42818smeHst2d3F9WbX2N29E+pvFlQ++HBWOmYE93BOUAm/gj
         qEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ULnHBQgqSbvoxbafI3CKu7NeQDJtQC81cSXhVI6lf0w=;
        b=Pzwqt8m04xWF0LDdqp56ZKJGoNsL5E7YmRjK1BXN58pfGwV35+lLUP1eBnOhUE2lFw
         8prdX0q9lq2TsuaA8lq8NQYQitqI5aeJMiN3gG55CSqF0+gSP0JrweaZCE8VVeJCj+lg
         rQtwRscQyUu6ymzUy1u9P+QoUlWonL5kgbfq8/v93QkhQwHfhGCkeNRlM1/M3N9obqgP
         3sUIqn/MF7K2rGEcethASoTzRSkTNIPFeCoDXRkComYkIqt50z75Luv0gggh9wt9DrBb
         d3xoqPZh9UV++7QGdfO+zg/5zG8mTcrouzkDdE1+z3w2ZkyRvjZdbxeCdnseJQDhQSQv
         1BMQ==
X-Gm-Message-State: AOAM53111eEk16ZDLhtgmcftFFYLrXMj14dDvGWQo0E/SUh3utowDY3X
        HNuyBFpsqLiZYyEeU0K9yLNQYg==
X-Google-Smtp-Source: ABdhPJyMdN4uTIIrROWbubtFi9/LZ/4GDHBfqJu/j0dfDoLoX5neHk6e/pEGswf/0PADosfLCdpnWQ==
X-Received: by 2002:a05:6512:ba6:: with SMTP id b38mr19833917lfv.128.1619009811533;
        Wed, 21 Apr 2021 05:56:51 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-234.NA.cust.bahnhof.se. [155.4.129.234])
        by smtp.gmail.com with ESMTPSA id a28sm204584lfb.88.2021.04.21.05.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 05:56:50 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.12-rc9
Date:   Wed, 21 Apr 2021 14:56:49 +0200
Message-Id: <20210421125649.186054-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.12-rc9. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit a5e13c6df0e41702d2b2c77c8ad41677ebb065b3:

  Linux 5.12-rc5 (2021-03-28 15:48:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.12-rc5

for you to fetch changes up to 7412dee9f1fd3e224202b633fdfa6eeaebe0307e:

  mmc: meson-gx: replace WARN_ONCE with dev_warn_once about scatterlist size alignment in block mode (2021-04-19 09:49:27 +0200)

----------------------------------------------------------------
MMC host:
 - meson-gx: Replace WARN_ONCE with dev_warn_once for non-optimal sg-alignment

----------------------------------------------------------------
Neil Armstrong (1):
      mmc: meson-gx: replace WARN_ONCE with dev_warn_once about scatterlist size alignment in block mode

 drivers/mmc/host/meson-gx-mmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
