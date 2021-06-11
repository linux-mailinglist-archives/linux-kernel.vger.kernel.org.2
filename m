Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C513A43BB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 16:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhFKOJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 10:09:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59987 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhFKOJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 10:09:02 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lrhoO-00086y-0M
        for linux-kernel@vger.kernel.org; Fri, 11 Jun 2021 14:07:04 +0000
Received: by mail-wm1-f72.google.com with SMTP id n2-20020a05600c3b82b02901aeb7a4ac06so5417590wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 07:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fIYGF4kspNC+k/efmO1vZxXOhwddBi7dkMQEKTd7Cos=;
        b=dhv80JqZ4qxOflIIDAoe6ISj76uI/HWuHGnP74TeOKFTGyrAWVVbiQo6mk00qtPMo1
         Dpn5GVz7RQmYfxBWu2No1lfPbH4bn9k2rPJkgUH7jepftkjaAeDa0T9F0DB0VbWK2oc6
         ieR8FYCSboRUxhZ7pGHjwlOIc+voY+zUekG4EjUuo6U20Tzf+Ikg+HQ4cd0kA9MUDFiu
         iN2DWj7Q4hbSUtx9LfcgBdki9UUgCOx33YTdsteDFxwRhitrjn6xCIhreM58CsUMhq2o
         oNBs3cGZmMN9AadVgkIBbBem4p4SDL1H5cunWF1WsXpA1X6nEsLhcGJSghdT0ZknvPfA
         61YQ==
X-Gm-Message-State: AOAM531GCBJrV6TrBiA4mDLzlGBfPbRWoG0xkKgp8RspUcbzc+OhmqVa
        xOa1YwVBGhJeSVYJSGQbJiT+Qv/nmiJewpxFQHl05PhoHv6bkkgDgFRJwK9nkpPQPsfPBoyIOW8
        vEJthEXK1qs7MbsBCmN4xLFPSlPSEauT+BUmAAA8cTA==
X-Received: by 2002:a1c:f70b:: with SMTP id v11mr4217636wmh.186.1623420422991;
        Fri, 11 Jun 2021 07:07:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGufQ334fV4fgNhOR7AObH0Gf2OKOTDGDGEm9J4z1JDqAo/np5E4xxwSOZnijrJoyx734R9Q==
X-Received: by 2002:a1c:f70b:: with SMTP id v11mr4217615wmh.186.1623420422784;
        Fri, 11 Jun 2021 07:07:02 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id j34sm12055035wms.19.2021.06.11.07.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 07:07:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/2] memory: drivers for v5.14
Date:   Fri, 11 Jun 2021 16:06:58 +0200
Message-Id: <20210611140659.61980-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This branch contains one change for pl353-smc driver, so might create merge
with my second pull request here - tags/memory-controller-drv-pl353-5.14.

I did not experience conflict and git shows the merge as:

diff --cc drivers/memory/pl353-smc.c
index b0b251bb207f,925d856663ac..f84b98278745
--- a/drivers/memory/pl353-smc.c
+++ b/drivers/memory/pl353-smc.c
@@@ -407,14 -116,10 +116,11 @@@ static int pl353_smc_probe(struct amba_
                break;
        }
        if (!match) {
 +              err = -ENODEV;
                dev_err(&adev->dev, "no matching children\n");
-               goto out_clk_disable;
+               goto disable_mem_clk;
        }
  
-       init = match->data;
-       if (init)
-               init(adev, child);
        of_platform_device_create(child, NULL, &adev->dev);
  
        return 0;


Best regards,
Krzysztof


The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-5.14

for you to fetch changes up to 729a611e6f53da00ed62a181f2d5d2bcf22d74d1:

  memory: emif: remove unused frequency and voltage notifiers (2021-06-10 09:24:46 +0200)

----------------------------------------------------------------
Memory controller drivers for v5.14

Several small fixes and cleanups for stm32, atmel, pl353, renesas-rpc,
TI emif and fsl_ifc.

----------------------------------------------------------------
Krzysztof Kozlowski (7):
      memory: stm32-fmc2-ebi: add missing of_node_put for loop iteration
      memory: atmel-ebi: add missing of_node_put for loop iteration
      memory: renesas-rpc-if: correct whitespace
      MAINTAINERS: memory: cover also header file
      memory: fsl_ifc: fix leak of IO mapping on probe failure
      memory: fsl_ifc: fix leak of private memory on probe failure
      memory: emif: remove unused frequency and voltage notifiers

Zhen Lei (1):
      memory: pl353: Fix error return code in pl353_smc_probe()

 MAINTAINERS                     |   1 +
 drivers/memory/atmel-ebi.c      |   4 +-
 drivers/memory/emif.c           | 678 ----------------------------------------
 drivers/memory/fsl_ifc.c        |   8 +-
 drivers/memory/pl353-smc.c      |   1 +
 drivers/memory/stm32-fmc2-ebi.c |   4 +
 include/memory/renesas-rpc-if.h |   6 +-
 7 files changed, 16 insertions(+), 686 deletions(-)
