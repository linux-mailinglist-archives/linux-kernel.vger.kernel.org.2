Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B99F41012F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 00:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344333AbhIQWOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 18:14:01 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:43579 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241373AbhIQWOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 18:14:00 -0400
Received: by mail-ot1-f52.google.com with SMTP id x10-20020a056830408a00b004f26cead745so14818329ott.10;
        Fri, 17 Sep 2021 15:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=1EE2HlUhECKdKkP5H4s8WdajxpVUY+2B3d9WLcyaqUg=;
        b=jgWcSlXZZs114pWf1qx1vumxN1f4cxawbWXKQhfISBk7IeZIbPGBTXoyqEL2VEDW8a
         Tr9MSn67mF6u1j8jig0gW73FMEnoygX8e4SndiTZ+l6E77QqQkV7qmf8RpERgqJCMpHB
         AENjFexpQsAKy2dVFBx9gkAd9M8a5EO0WdSnv7FXmbMyVLnYGDSgG31jU7oSslfyxohV
         6uGDFDfI9l4SGOHg/Kww6kkoTl5BxuTaumdFSyrod6SOqT25NJvg206iYaIUrJKMcwKE
         ftd8tphUQLGCchvxvYLoo7z3UD4BnASID9Cwbg6lOjLgyRkck2OH8tqBF8rtBbzBQhr2
         8D2A==
X-Gm-Message-State: AOAM531nfoTnt9eDEu1L7ymqou605dniREkIzOGJ9q0hgdMyQrqSktAP
        cN9rNAKE1lgz38RvqR2RJEfgxYne2A==
X-Google-Smtp-Source: ABdhPJyHDd8H36KkWw65JfXmj4m4bq006ZoE9aRmaPgRgL4E8AsH3cqc4MhFTTLHCKVFqixedrSIMg==
X-Received: by 2002:a9d:4e06:: with SMTP id p6mr11359810otf.261.1631916757514;
        Fri, 17 Sep 2021 15:12:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s8sm1873470otd.76.2021.09.17.15.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 15:12:36 -0700 (PDT)
Received: (nullmailer pid 2305030 invoked by uid 1000);
        Fri, 17 Sep 2021 22:12:35 -0000
Date:   Fri, 17 Sep 2021 17:12:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fixes for v5.15, take 2
Message-ID: <YUUS0/i5AqSmmbGA@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull another set of DT fixes.

Rob


The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.15-2

for you to fetch changes up to 55c21d57eafb7b379bb7b3e93baf9ca2695895b0:

  dt-bindings: arm: Fix Toradex compatible typo (2021-09-17 16:02:41 -0500)

----------------------------------------------------------------
Devicetree fixes for v5.15, take 2:

- Revert fw_devlink tracking 'phy-handle' links. This broke at least a
  few platforms. A better solution is being worked on.

- Add Samsung UFS binding which fell thru the cracks

- Doc reference fixes from Mauro

- Fix for restricted DMA error handling

----------------------------------------------------------------
Alim Akhtar (1):
      dt-bindings: ufs: Add bindings for Samsung ufs host

David Brazdil (1):
      of: restricted dma: Fix condition for rmem init

David Heidelberg (1):
      dt-bindings: arm: Fix Toradex compatible typo

Mauro Carvalho Chehab (2):
      dt-bindings: net: dsa: sja1105: update nxp,sja1105.yaml reference
      dt-bindings: arm: mediatek: mmsys: update mediatek,mmsys.yaml reference

Saravana Kannan (1):
      Revert "of: property: fw_devlink: Add support for "phy-handle" property"

 Documentation/devicetree/bindings/arm/tegra.yaml   |  2 +-
 .../bindings/display/mediatek/mediatek,disp.txt    |  2 +-
 .../bindings/ufs/samsung,exynos-ufs.yaml           | 89 ++++++++++++++++++++++
 Documentation/networking/dsa/sja1105.rst           |  2 +-
 drivers/of/device.c                                |  6 +-
 drivers/of/property.c                              |  2 -
 6 files changed, 97 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
