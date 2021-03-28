Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1649734BDA3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 19:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhC1RbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 13:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhC1RbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 13:31:16 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7E8C061756
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 10:31:16 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id v26so10458281iox.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 10:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qvSgj8I9eDaxPdP5e7vVuXr6s/TxuUun1zKDOzJcOiA=;
        b=q63jiTFFAg+757VY0epSDOwFLNmmsE8Bd8vnUx+sVU5Jx3CBBnI6l4s1oJexqlLb6z
         QZgX8EnoqHwXEUJBfJRdo7EZAJhmQ9NvezghZamQFYSMWhbSTyaLwkikyXExaG/V+Hcd
         zHZZdiOeV1efIR+bHMcuCN+FNhSuBgXSGx85pAXwc75OWpMyQ79NSC/R3fYh7PqN6iXd
         +kP6ktoPhUsIxA2P3f0+Cbhi9cX1Q0yDv4zt2Cy39zbUvM+7sufOLxFfpgWUAf3ztN19
         ElTg6zkQftVADXhEs1T/tTAIu34oH2up/PkBtvB0m1yJ27AE/MJ3EXpCrvuBl9KNW8Pq
         BLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qvSgj8I9eDaxPdP5e7vVuXr6s/TxuUun1zKDOzJcOiA=;
        b=Tlyv5whMtm2kZavYJgFqCvdtKBLH7DTUBCqLPByJftOJLMElsqd4SpNh8TljzEt8bm
         ARrP6VfhEt1Fhy7t/ZbNePS3fpjGm2Tz7RXK4r4wDuA4IFkuK/cwFRyapf/4V17Y2xaS
         cQLtHH/0mYNoVKBSfWjYTBlLU/fiuO3Y16kkOL0h960TEM8MuXEA4JTsPXliC7O9U+pp
         o3nTH+4nndwtE/JQvt78nrihrHfVySH3vfgEjFWcMB0Ks5FJIhAG4Xs357G2AoWZaOkr
         Rvax3PVt/zRQ0hDQ/bpr6JWuF9Rj9zfe5YCrBCRLxIKSWSAc7iUBZsFi1hhPabYA+PLy
         /aEw==
X-Gm-Message-State: AOAM532E/DAxjgm9yzeWw34BYfTgcp7OWXtLnV78Vaz2+rg3VK0sfIyO
        InkORPM9saAZv1LqfEfhTx1RMg==
X-Google-Smtp-Source: ABdhPJy9SjCyW/f3/Gm6hvNFC0dav3D1Ar0K/RbuECoG+4W7PkQKMCIORXesB3yrnXTwj69ma9qpig==
X-Received: by 2002:a5d:9b18:: with SMTP id y24mr17229437ion.24.1616952675452;
        Sun, 28 Mar 2021 10:31:15 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id d22sm8014422iof.48.2021.03.28.10.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 10:31:14 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/7] net: ipa: a few last bits
Date:   Sun, 28 Mar 2021 12:31:04 -0500
Message-Id: <20210328173111.3399063-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series incorporates a few last things that didn't fit neatly
with patches I've posted recently.

The first patch eliminates all remaining kernel-doc warnings.
There's still room for kernel-doc improvement, but at least what's
there will no longer produce warnings.

The next moves the definition of the value to store in the backward
compatibility register (when present) into platform data files.

The third removes two endpoint definitions that do not need to be
defined.

The next two switch the naming convention used for configuration
data files to be based on the IPA version rather than the specific
platform.  I was skeptical about this at first (i.e., I thought a
platform might have quirks separate from the IPA version).  But
I'm now convinced the IPA version is enough to define the details
of the hardware block.  If any exceptions to this are found, we can
treat those differently.  Note:  these two patches produce warnings
from checkpatch.pl about updating MAINTAINERS: these can be ignored.

The sixth removes unnecessary checks for alignment of DMA memory
allocations, based comments from David Laight.

And the last removes a symbol representing the size of a table
entry, using sizeof(__le64) in its place.

					-Alex

Alex Elder (7):
  net: ipa: fix all kernel-doc warnings
  net: ipa: store BCR register values in config data
  net: ipa: don't define endpoints unnecessarily
  net: ipa: switch to version based configuration
  net: ipa: use version based configuration for SC7180
  net: ipa: DMA addresses are nicely aligned
  net: ipa: kill IPA_TABLE_ENTRY_SIZE

 drivers/net/ipa/Kconfig                       |  3 +-
 drivers/net/ipa/Makefile                      |  2 +-
 drivers/net/ipa/gsi.c                         | 13 +--
 drivers/net/ipa/gsi_private.h                 |  4 +-
 drivers/net/ipa/gsi_trans.c                   |  9 +-
 drivers/net/ipa/gsi_trans.h                   |  5 +-
 drivers/net/ipa/ipa.h                         |  7 +-
 drivers/net/ipa/ipa_cmd.c                     |  2 +-
 drivers/net/ipa/ipa_cmd.h                     | 19 +++--
 .../{ipa_data-sdm845.c => ipa_data-v3.5.1.c}  | 39 ++++-----
 .../{ipa_data-sc7180.c => ipa_data-v4.2.c}    | 25 +++---
 drivers/net/ipa/ipa_data.h                    | 10 ++-
 drivers/net/ipa/ipa_endpoint.h                | 29 +++++--
 drivers/net/ipa/ipa_interrupt.h               |  1 +
 drivers/net/ipa/ipa_main.c                    |  8 +-
 drivers/net/ipa/ipa_mem.h                     |  2 +-
 drivers/net/ipa/ipa_qmi.c                     | 10 +--
 drivers/net/ipa/ipa_qmi.h                     | 14 ++--
 drivers/net/ipa/ipa_reg.h                     | 21 -----
 drivers/net/ipa/ipa_smp2p.h                   |  2 +-
 drivers/net/ipa/ipa_table.c                   | 83 +++++++++----------
 drivers/net/ipa/ipa_table.h                   |  6 +-
 22 files changed, 153 insertions(+), 161 deletions(-)
 rename drivers/net/ipa/{ipa_data-sdm845.c => ipa_data-v3.5.1.c} (90%)
 rename drivers/net/ipa/{ipa_data-sc7180.c => ipa_data-v4.2.c} (90%)

-- 
2.27.0

