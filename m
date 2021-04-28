Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBD536DC9E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240367AbhD1QDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbhD1QDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:03:21 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5F5C061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:02:35 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id y32so45042647pga.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=fufpDmdFGWBedAM49G/O0OohK3RRP/eyeb3mWz8RtJg=;
        b=Efv7Pn8LGPw1Hcokx9BP4xbcwG1dnJ2PP5C0gUcIt5H1H2HA8F/IzTqwEX2fK/VpVD
         GiyvVryN7iaxHT0n/iLvKdNWD6msGNNrydmGNQci8v+SaavOW1Gbu8fltf8lj6EuPPZ1
         QpE3e9TUZZbvCgw3LoUr2V5MJtVUFe/g+Ytol6xKGz5XHJQR8qNA8FmDMSpTVtINv0Hs
         2dj+9khj3jD6+IsU6zfa74RsN9kRk/ETQK+pR7wist7zSyLLYROD+h4WAa1ojldndCFI
         ZiexeaFbhJPeSZeZXB7TUR9bvNqulornWAefzyoMRy2KvUgePzRIYVRuS23KlwIb8AS+
         3u+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fufpDmdFGWBedAM49G/O0OohK3RRP/eyeb3mWz8RtJg=;
        b=DXku1S4qVnZvHdg3f/WWBihdzP3guwdPBevhiRjsk4xQY1okDne7mO4T/XGOonD9FB
         3CEq9UczHYMuR+lATlcwGUky+ugwjzgkljwcKCjAU3safasRtMDFoYeI2IbllQh0zI6u
         g4aftAZGqk7LW6mQfURwGYuQMk5wbMnAwUnGKJaj4lZrSA9SfUj00TDctECcnY0abrvs
         1BkwRfiwkvjiNnj0mwlhcJVfhkZKv0GVC0M4Q9FAv5SodCllXumLuPJp3vy5R96S0uuY
         UC92L3/yJtfR6oUhaiYB8onQaLZN8JwK6doP30va/9y764YEgv6CzPPGrNoWdmCr4Vu2
         yseg==
X-Gm-Message-State: AOAM530+RhnHLNtRVafy01p3L4ctXar7UG4lVbPTTp/lN7jy4/Rvy/PK
        D6o/RHWULPkDWtoV6gaF5luhXD1/+4Fc6Ha/0yI=
X-Google-Smtp-Source: ABdhPJwWnuOFfmUHNStGxWPXDgzFbQhcg4CSt2S2GC+GKhSisIQOyH1iwioPAL600VLmTiGiohleaDcy6LJtWnAnB+0=
X-Received: by 2002:a05:6a00:2c4:b029:279:c266:abe6 with SMTP id
 b4-20020a056a0002c4b0290279c266abe6mr10150758pft.48.1619625754795; Wed, 28
 Apr 2021 09:02:34 -0700 (PDT)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 28 Apr 2021 11:02:24 -0500
Message-ID: <CABb+yY0j+ENA=z40pCEZxGYJM-hXVxiYK0CU-OB4aA24SmV5nw@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v5.13
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit e49d033bddf5b565044e2abe4241353959bc9120:

  Linux 5.12-rc6 (2021-04-04 14:15:36 -0700)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v5.13

for you to fetch changes up to 2335f556b3afadbee6548456f543f53ac3d1af42:

  dt-bindings: mailbox: qcom-ipcc: Add compatible for SC7280
(2021-04-26 09:44:21 -0500)

----------------------------------------------------------------
- qcom: enable support for SM8350 and SC7280
- sprd: refcounting channel usage
specify interrupt names in dt
support sc9863a
- arm: drop redundant print
- ti: convert dt-bindings to json schema
- misc: spelling fixes

----------------------------------------------------------------
Bjorn Andersson (1):
      MAINTAINERS: Add DT bindings directory to mailbox

Nishanth Menon (1):
      dt-bindings: mailbox: ti,secure-proxy: Convert to json schema

Orson Zhai (3):
      mailbox: sprd: Introduce refcnt when clients requests/free channels
      dt-bindings: mailbox: Add interrupt-names to SPRD mailbox
      mailbox: sprd: Add supplementary inbox support

Qiheng Lin (1):
      mailbox: arm_mhu_db: Remove redundant dev_err call in mhu_db_probe()

Sai Prakash Ranjan (1):
      dt-bindings: mailbox: qcom-ipcc: Add compatible for SC7280

Tom Saeger (1):
      mailbox: fix various typos in comments

Vinod Koul (1):
      dt-bindings: mailbox: Add compatible for SM8350 IPCC

Yang Li (1):
      mailbox: pcc: fix platform_no_drv_owner.cocci warnings

 .../devicetree/bindings/mailbox/qcom-ipcc.yaml     |   2 +
 .../devicetree/bindings/mailbox/sprd-mailbox.yaml  |  13 +-
 .../bindings/mailbox/ti,secure-proxy.txt           |  50 -------
 .../bindings/mailbox/ti,secure-proxy.yaml          |  79 +++++++++++
 MAINTAINERS                                        |   1 +
 drivers/mailbox/Kconfig                            |   2 +-
 drivers/mailbox/arm_mhu_db.c                       |   4 +-
 drivers/mailbox/bcm-flexrm-mailbox.c               |   4 +-
 drivers/mailbox/mailbox-xgene-slimpro.c            |   6 +-
 drivers/mailbox/mailbox.h                          |   2 +-
 drivers/mailbox/pcc.c                              |   3 +-
 drivers/mailbox/pl320-ipc.c                        |   2 +-
 drivers/mailbox/sprd-mailbox.c                     | 147 +++++++++++++++------
 drivers/mailbox/ti-msgmgr.c                        |   2 +-
 14 files changed, 212 insertions(+), 105 deletions(-)
 delete mode 100644
Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt
 create mode 100644
Documentation/devicetree/bindings/mailbox/ti,secure-proxy.yaml
