Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0A73CBC25
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 20:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhGPTB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 15:01:29 -0400
Received: from mail-il1-f179.google.com ([209.85.166.179]:33650 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhGPTB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 15:01:28 -0400
Received: by mail-il1-f179.google.com with SMTP id z1so9255372ils.0;
        Fri, 16 Jul 2021 11:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=JaHBZHQkUG9nkOZjub36ylaekqJrFIALCWzr0fx4JWc=;
        b=sKSgu+Ok5qYStzj+ksn9SITOS500BZ8hkxzcSAkw8QVGc/PZ/XHsOz7T/Io9dwP2o8
         IcAPKJDVQpcXWLDdQcj3fWsQblVmVRyRb0CHZoZi+nzQbixPWnz7YhhcyI1VbI6TYpEk
         a2J13qGNTCrV2LTdoD3zkgchsn7mijlhBc0uTjKfw7bx65+pLA0JADV0m/kBmUJaq6yB
         Svy0RnulXGZxgizkJ/RUz4MqRkOiUU6HzjBsOlCMa17JBzltAA+NvItvD8u0LG35hEuW
         mZvpEBx6gt0LLmdb1SgPv2uzpNTIrHD4N4IpCKaBTq5VL9YgoZD40NTayzxmozZ0qSLk
         8MXA==
X-Gm-Message-State: AOAM532Iyzd52VLTrIz6QNFjGfO5V87MH9Rg9RDw482PEyJMgfj6yJ1/
        Fh/GqQPIZ9awSWA99nzMACOQajBQKg==
X-Google-Smtp-Source: ABdhPJxcCfSiJYlaSJg7zp99bZboAlcPkcE0opIjiH4rYWrGZsAPR7Zx1/1wpHwJcYdNAneih3pasA==
X-Received: by 2002:a05:6e02:1d0f:: with SMTP id i15mr6859976ila.199.1626461913286;
        Fri, 16 Jul 2021 11:58:33 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t8sm5467464iog.21.2021.07.16.11.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 11:58:32 -0700 (PDT)
Received: (nullmailer pid 3772587 invoked by uid 1000);
        Fri, 16 Jul 2021 18:58:30 -0000
Date:   Fri, 16 Jul 2021 12:58:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fixes for v5.14, take 1
Message-ID: <20210716185830.GA3769653@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a couple of DT fixes for 5.14.

Rob


The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.14-1

for you to fetch changes up to 50d8d7e19c4398da74d028f367754e73547b078b:

  dt-bindings: display: renesas,du: Make resets optional on R-Car H1 (2021-07-16 12:03:27 -0600)

----------------------------------------------------------------
Devicetree fixes for v5.14, take 1:

- Drop 'resets' as required on renesas,du

- Moving of fixed string patterns for 'properties' instead of
  'patternProperties'

- Drop more redundant minItems/maxItems that we merged in the merge
  window

- Indentation warning fix for sja1105

----------------------------------------------------------------
Geert Uytterhoeven (1):
      dt-bindings: display: renesas,du: Make resets optional on R-Car H1

Rob Herring (2):
      dt-bindings: More dropping redundant minItems/maxItems
      dt-bindings: Move fixed string 'patternProperties' to 'properties'

Thierry Reding (1):
      dt-bindings: net: dsa: sja1105: Fix indentation warnings

 .../bindings/clock/brcm,iproc-clocks.yaml          |  1 -
 .../devicetree/bindings/display/renesas,du.yaml    |  1 -
 .../devicetree/bindings/hwmon/adt7475.yaml         | 22 ++++-----
 .../devicetree/bindings/iommu/rockchip,iommu.yaml  |  2 -
 .../bindings/memory-controllers/arm,pl353-smc.yaml |  1 -
 .../devicetree/bindings/mtd/brcm,brcmnand.yaml     |  8 ----
 .../devicetree/bindings/net/dsa/nxp,sja1105.yaml   |  4 +-
 .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml  | 56 +++++++++++-----------
 .../devicetree/bindings/regulator/mps,mpq7920.yaml |  6 +--
 .../bindings/regulator/nxp,pf8x00-regulator.yaml   |  3 +-
 .../devicetree/bindings/rtc/faraday,ftrtc010.yaml  |  1 -
 .../devicetree/bindings/spi/spi-controller.yaml    | 32 ++++++-------
 .../devicetree/bindings/usb/nxp,isp1760.yaml       |  2 -
 13 files changed, 62 insertions(+), 77 deletions(-)
