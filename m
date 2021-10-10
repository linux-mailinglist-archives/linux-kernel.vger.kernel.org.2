Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAEE4282D7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 19:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhJJSAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 14:00:42 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:47528
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230271AbhJJSAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 14:00:40 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 12B6340016
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 17:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633888721;
        bh=NrDH+pD98VXNyjr2vH7l+H1QFNZaZ87D1CmJMseVHwg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=NWCSSF0eTBda+g3ft/cMMU3rQwPx4INuVeg/nufSJdAdqZj+AhXcRNH8RTjCmmYx3
         L8KIQs2xfv4yr6YjUANr5h1QtfsUY+svLojwQg35Z6da9HbUB7/QD6Tx/pHlcdx2nT
         VDcsogosoiDaD9F+zP39SR2+DzrctEBk0duGUNVnVBVApAUZDfhKVEXuqNoGomWXg2
         TxnOnpLQbMpKI/kn0RNDXAxEFgX/tCkDsukSAZ+IudExQyEFsm3RqkUZ5+DY5VSkY1
         xK1hcPm4SJvLY/LLbXh39YRixEQ4+y+NgbGIYwxTS3L/Sl9g1bpoDRFHAf10ybcLH8
         sr8xX2s4rImTQ==
Received: by mail-ed1-f69.google.com with SMTP id t28-20020a508d5c000000b003dad7fc5caeso13703076edt.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 10:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NrDH+pD98VXNyjr2vH7l+H1QFNZaZ87D1CmJMseVHwg=;
        b=AOsHtzbG4na+GuHWS0TnZDeOkvCCD3vhNLmVSOPLSliguCSA0FG7xI79AZAaDJxq3M
         JuuuKdi35mG3aOm2/28jVIwk5ascBC4+FJVhGC8G7GoVXlZ+zYruzrPY1vbxnLxGlGgD
         76N0AJqly0qcHu3wpCnoruHQLMRqkAwL9LFXoBBy9wgm8Eb2aEK0bNw/CEvvcf3+i6A6
         Mpc0lql+brOZNWxAjnKHm3JX0wkHxoAb4pgwdIAePgO7e7QcJrwa4lHgxVETiuFcL6/o
         AScrAkCarg2pags63RA+9TcDEr88Rd40s5BaKBEna3mEFv1yaPsA9qoJuV8917V+A+p1
         4Mpg==
X-Gm-Message-State: AOAM531IoupnLAv0z6MVjBTZ1rPlj/59Rv3BOQiud+jxmlNdx+cJIXAk
        2v3h+hxHCVCBFgKFfqlFzjXXVWKcYA1MZAILaV9t2bMpLBjLIi+S5GxkIAojpz8vRTKKRfFIcnG
        HAWW5lk3hBNwlwlApLEVp/NmZXBMKg3g8jNXnoGU8uw==
X-Received: by 2002:a05:6402:410:: with SMTP id q16mr34342276edv.286.1633888720338;
        Sun, 10 Oct 2021 10:58:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRBcHo7+oZQEmrhMN0Ckl6vC4HpNLDrOgA8llriI5pHb/ju1hwmod3EdbAZOO9ZCwlbohnQA==
X-Received: by 2002:a05:6402:410:: with SMTP id q16mr34342257edv.286.1633888720207;
        Sun, 10 Oct 2021 10:58:40 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id au26sm2347948ejc.53.2021.10.10.10.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 10:58:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/3] memory: drivers for v5.16
Date:   Sun, 10 Oct 2021 19:58:34 +0200
Message-Id: <20211010175836.13302-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-5.16

for you to fetch changes up to d611d7ea120bbef45e836565dfa2ddc85a168c16:

  Merge branch 'for-v5.16/renesas-rpc' into mem-ctrl-next (2021-10-10 19:45:00 +0200)

----------------------------------------------------------------
Memory controller drivers for v5.16

1. Renesas RPC: fix unaligned bus access and QSPI data transfers in
   manual modes.
2. Renesas RPC: select RESET_CONTROLLER as it is necessary for
   operation.
3. FSL IFC: fix error paths.
4. Broadcom: allow building as module.

----------------------------------------------------------------
Andrew Gabbasov (1):
      memory: renesas-rpc-if: Avoid unaligned bus access for HyperFlash

Dongliang Mu (1):
      memory: fsl_ifc: fix leak of irq and nand_irq in fsl_ifc_ctrl_probe

Florian Fainelli (1):
      memory: brcmstb_dpfe: Allow building Broadcom STB DPFE as module

Geert Uytterhoeven (1):
      memory: renesas-rpc-if: RENESAS_RPCIF should select RESET_CONTROLLER

Krzysztof Kozlowski (2):
      memory: samsung: describe drivers in KConfig
      Merge branch 'for-v5.16/renesas-rpc' into mem-ctrl-next

Wolfram Sang (2):
      dt-bindings: rpc: renesas-rpc-if: Add support for the R8A779A0 RPC-IF
      memory: renesas-rpc-if: Correct QSPI data transfer in Manual mode

 .../memory-controllers/renesas,rpc-if.yaml         |   1 +
 drivers/memory/Kconfig                             |   5 +-
 drivers/memory/fsl_ifc.c                           |  13 +-
 drivers/memory/renesas-rpc-if.c                    | 159 ++++++++++++++++-----
 drivers/memory/samsung/Kconfig                     |  13 +-
 include/memory/renesas-rpc-if.h                    |   1 +
 6 files changed, 141 insertions(+), 51 deletions(-)
