Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E713E48CC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbhHIP1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:27:15 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:38330
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233102AbhHIP1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:27:14 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id C63D93F356
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 15:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628522811;
        bh=bKc2q2GsSAUcXGWOiwttCYEPNo65JA70tLWaCsvxMvg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=VeRlSovdf6IGA5+6lM9BMIf6qV0TP24VsWpUTbm81qbeYPD+XwGcWMKPmepnJEljE
         7rOygxMybq+8ZPfJvYk5RaT2yIvhY1ud1aOsHV2kQyca0QzhjL5/BKymgls9i7tbeZ
         jb8Y2e5LZG68upJH+SEcG2BXH0hXovRerdw+9olA4fzp7iNcHlCW4r2Q6aCMTdm7gR
         TxmQDpkB/Jm8ba39Hd4pDgDWB60ReqCKec5fKnPw+V2lRoruoLrx4E8/txeIurn96y
         dRy5RaDNMC5Ig+e+1rUS6nHi8qYbbk+gQGVAjCSvhJlG5P2ImSw/3jD3VJHIWbdmrU
         4og+8yu6c1yng==
Received: by mail-ed1-f69.google.com with SMTP id ec47-20020a0564020d6fb02903be5e0a8cd2so2736125edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 08:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bKc2q2GsSAUcXGWOiwttCYEPNo65JA70tLWaCsvxMvg=;
        b=tMAs1kH3adXi+7w2D1aviUM5442VTGibGZxywd3gLK8eDTjuVi7JECREfShSfc+jh2
         0ir9VcceW3qicGj3vY13e2lKi0XH5QsyaJde+zkcIrYipfKFsOwrlDdwETurMGyJtqMW
         2bC/WYISGo5raRBhmHuAFmRp3qHWkpmhl6okrGu/dcBp0zvL0Ydkg3kcDEm6iYQA8nXf
         5+mY812UdPToDmObrqHT4lE2nHUpFkLM4Z0UJnClwAyjVbl32BRTv035fniPBGxJw0JV
         ZenY8MR/EhlXSVe403WzH8jqDuxjLV/0XjLG+abevMjdy26x7GEyQoiO1qKTlZxelHJ4
         /IYg==
X-Gm-Message-State: AOAM533wvmVlQhPMOOAn8a2+1dqcMO8zrP2VvLMRyri3V77gCrNW3EFc
        hsyz3xb5t4UP2nLi1c861EcTfH9Ex3xMLm1vFztg1kLYuiCJtUn9VTQrj2Uh9oRswpW2rUSzkxh
        IBACQQ6P1FRXcxH+MAoncew2mPcRRQ85CgUA9rFms8w==
X-Received: by 2002:a17:906:d147:: with SMTP id br7mr23527594ejb.126.1628522810897;
        Mon, 09 Aug 2021 08:26:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9H/dobnWwRqC8K7RHya8QBOc6Stqn0f87KhEofscI7OHEFlLrwSuPyBlXqQQYdXGLWouyyQ==
X-Received: by 2002:a17:906:d147:: with SMTP id br7mr23527569ejb.126.1628522810704;
        Mon, 09 Aug 2021 08:26:50 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id fp5sm2604577ejc.6.2021.08.09.08.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 08:26:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: changes for v5.14
Date:   Mon,  9 Aug 2021 17:26:39 +0200
Message-Id: <20210809152639.110576-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I organized changes on separate topic branches just in case I need to share
them with SoC maintainers.  They are all merged back to main branch.

Best regards,
Krzysztof


The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-5.15

for you to fetch changes up to c28b584deb1bc81f8a2454b43c82cdda17ed29f6:

  Merge branch 'for-v5.15/omap-gpmc' into for-next (2021-07-29 09:03:32 +0200)

----------------------------------------------------------------
Memory controller drivers for v5.15

Few minor fixes: maintainer pattern, unused-function warning in
Tegra186 and suspend/resume in OMAP GPMC.

----------------------------------------------------------------
Arnd Bergmann (1):
      memory: tegra: fix unused-function warning

Krzysztof Kozlowski (2):
      Merge branch 'for-v5.15/tegra-mc' into for-next
      Merge branch 'for-v5.15/omap-gpmc' into for-next

Mauro Carvalho Chehab (1):
      MAINTAINERS: update arm,pl353-smc.yaml reference

Tony Lindgren (2):
      memory: omap-gpmc: Clear GPMC_CS_CONFIG7 register on restore if unused
      memory: omap-gpmc: Drop custom PM calls with cpu_pm notifier

 MAINTAINERS                     |   2 +-
 arch/arm/mach-omap2/pm34xx.c    |   5 --
 drivers/memory/omap-gpmc.c      | 191 +++++++++++++++++++++++++---------------
 drivers/memory/tegra/tegra186.c |   2 +
 include/linux/omap-gpmc.h       |   3 -
 5 files changed, 121 insertions(+), 82 deletions(-)
