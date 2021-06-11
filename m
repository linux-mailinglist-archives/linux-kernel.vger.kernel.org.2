Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8613A43BC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 16:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhFKOJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 10:09:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60001 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhFKOJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 10:09:03 -0400
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lrhoO-000880-Se
        for linux-kernel@vger.kernel.org; Fri, 11 Jun 2021 14:07:05 +0000
Received: by mail-wm1-f70.google.com with SMTP id o82-20020a1ca5550000b029019ae053d508so4468685wme.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 07:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mqsnDnK7H+bSvfKugt2B4WpV7d9OZN/SZMGSsmxI6wU=;
        b=afxKuRhG82HXolstz4yz2scnBx53X6IKBCOi0Po85X+Ztej+rLTHCPY+0KA7b/svcq
         vCACmG7zUBDqGIDZUXXWXZqBqDiq1/uDv09vX872hOiVTrTVgjzwrHQPLHwKIVKpY/sz
         i8Dl2qGw++1ZH6Zr1SD7w0Lo+KKQTwtQFK5PUqEQSAolMZ3CqH1IiTFP5p6HkZvkLtFn
         dxjMct7O0rB9PhpdlNtNP3mjct3BPdDgPvw7mvymom20rG30EU45g/GGftttNpgwXHXn
         Wat3J7qdblsG54oaCyyHGySaAupE9jQxggoTcLdWAGP1IqmU7yYK3/FUKYAOLnPeZ0BY
         v+Rw==
X-Gm-Message-State: AOAM532IwDM9GxNkJJrPBQUn/MKDIyK2SuczGva01tNku248IH4POkyc
        nKDHxZpaiaJXPHCk2KU6o+U7Mvc8YPKVkHiwiMd64WObEHYu3c9mN6hN5MtKhtbRnqnJ2Ysd1x7
        Y4nZ0lgRSD5HYEQM4avE6KSBUy8Ejq74+4JwDmVFkMQ==
X-Received: by 2002:a05:600c:3b23:: with SMTP id m35mr20872885wms.185.1623420424474;
        Fri, 11 Jun 2021 07:07:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyW0V9/o7YdR45rEYnx1wo71TwuMvkOq+3bkmhazImZbtBzmFJpq+VyYMzaUqGgT7eBeJZfOQ==
X-Received: by 2002:a05:600c:3b23:: with SMTP id m35mr20872866wms.185.1623420424343;
        Fri, 11 Jun 2021 07:07:04 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id j34sm12055035wms.19.2021.06.11.07.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 07:07:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [GIT PULL 2/2] memory: pl353-smc for v5.14
Date:   Fri, 11 Jun 2021 16:06:59 +0200
Message-Id: <20210611140659.61980-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210611140659.61980-1-krzysztof.kozlowski@canonical.com>
References: <20210611140659.61980-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dedicated branch for pl353-smc driver changes.

Best regards,
Krzysztof


The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-pl353-5.14

for you to fetch changes up to d3d0e1e857110a2f8147b1aa3a045b1fccc1e7c3:

  dt-binding: memory: pl353-smc: Convert to yaml (2021-06-10 23:09:05 +0200)

----------------------------------------------------------------
Memory controller drivers for v5.14 - PL353

Bigger work around ARM Primecell PL35x SMC memory controller driver by
Miquel Raynal built on previous series from Naga Sureshkumar Relli.

This includes bindings cleanup and correction, converting these to
dtschema and several cleanyps in pl353-smc driver.

----------------------------------------------------------------
Miquel Raynal (14):
      dt-binding: memory: pl353-smc: Rephrase the binding
      dt-binding: memory: pl353-smc: Document the range property
      dt-binding: memory: pl353-smc: Drop the partitioning section
      dt-binding: memory: pl353-smc: Describe the child reg property
      dt-binding: memory: pl353-smc: Fix the example syntax and style
      dt-binding: memory: pl353-smc: Drop unsupported nodes from the example
      dt-binding: memory: pl353-smc: Fix the NAND controller node in the example
      memory: pl353-smc: Fix style
      memory: pl353-smc: Rename goto labels
      memory: pl353-smc: Let lower level controller drivers handle inits
      memory: pl353-smc: Avoid useless acronyms in descriptions
      memory: pl353-smc: Declare variables following a reverse christmas tree order
      MAINTAINERS: Add PL353 SMC entry
      dt-binding: memory: pl353-smc: Convert to yaml

 .../bindings/memory-controllers/arm,pl353-smc.yaml | 131 +++++++++
 .../bindings/memory-controllers/pl353-smc.txt      |  47 ---
 MAINTAINERS                                        |   8 +
 drivers/memory/pl353-smc.c                         | 314 +--------------------
 include/linux/pl353-smc.h                          |  30 --
 5 files changed, 149 insertions(+), 381 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
 delete mode 100644 include/linux/pl353-smc.h
