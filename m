Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DB8374B64
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 00:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbhEEWnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 18:43:46 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:44031 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbhEEWnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 18:43:41 -0400
Received: by mail-oi1-f175.google.com with SMTP id j75so3694041oih.10;
        Wed, 05 May 2021 15:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=pbTlir03f0JEZL64fVklM0dp7uurLByJoVkfzt7FKdI=;
        b=XN08j/vW9QaMNUq3Q444A/1WcNfex/xHUtWQAybcGm0FhDKYbXWhUr62GmMgJBp2Gr
         HWngVa/LgumwwuGMcEmq6sMC52EjbRYZ/afVlKFwI/kriDC/HmEIMcW7qTjsDyrcOeJs
         qD3VWFtRnHioDf8BB/2Qyi8qsEZJVCmf//4NSej7Z0llKn5g4+P4Y1hzbslIFMc6EmNO
         XqvEsejrmxj4C5DPsuYcLcmbWF2NuIHywYhydVd+ziBK5AnlsBqFOv6SF7m02ysaArsE
         pumylosMQ2ofMEZNLqn1gBT0DSeHz82eORZliIfJLhJNXIJKLu4vGxy66tabFb0rLORV
         xUcw==
X-Gm-Message-State: AOAM531I6QrJEPDgPSIera6it7G2a8bfZn4papdAaKHUqXFyQXh+mTxx
        hlyYNfTqXmEd9fdcBis/vw==
X-Google-Smtp-Source: ABdhPJyfhzdfd6UA46DZ7biewQHZJ1JerOBhiE0Rdlmh198apmqJb8vyJ4wq6S2rQepxN7Yo4EwwRA==
X-Received: by 2002:aca:ad48:: with SMTP id w69mr836848oie.21.1620254564008;
        Wed, 05 May 2021 15:42:44 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h12sm189909otk.55.2021.05.05.15.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 15:42:43 -0700 (PDT)
Received: (nullmailer pid 2970657 invoked by uid 1000);
        Wed, 05 May 2021 22:42:42 -0000
Date:   Wed, 5 May 2021 17:42:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fixes for v5.13, take 1
Message-ID: <20210505224242.GA2953573@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a couple of DT fixes.

Rob

The following changes since commit 8ca5297e7e38f2dc8c753d33a5092e7be181fff0:

  Merge tag 'kconfig-v5.13' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild (2021-04-29 14:32:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.13-1

for you to fetch changes up to 6799e3f281e962628be531e8331bacd05b866134:

  dt-bindings: net: renesas,etheravb: Fix optional second clock name (2021-05-04 09:05:46 -0500)

----------------------------------------------------------------
Devicetree fixes for v5.13-rc:

- Several Renesas binding fixes to fix warnings

- Remove duplicate compatibles in 8250 binding

- Remove orphaned Sigma Designs Tango bindings

- Fix bcm2711-hdmi binding to use 'additionalProperties'

- Fix idt,32434-pic warning for missing 'interrupts' property

- Fix 'stored but not read' warnings in DT overlay code

----------------------------------------------------------------
Geert Uytterhoeven (4):
      dt-bindings: PCI: rcar-pci-host: Document missing R-Car H1 support
      dt-bindings: media: renesas,vin: Make resets optional on R-Car Gen1
      dt-bindings: display: renesas,du: Add missing power-domains property
      dt-bindings: net: renesas,etheravb: Fix optional second clock name

Jiapeng Chong (1):
      of: overlay: Remove redundant assignment to ret

Maxime Ripard (1):
      dt-bindings: bcm2711-hdmi: Fix broken schema

Rob Herring (1):
      dt-bindings: Remove unused Sigma Designs Tango bindings

Thomas Bogendoerfer (1):
      dt-bindings: interrupt-controller: idt,32434-pic: Add missing interrupts property

Zhen Lei (1):
      dt-bindings: serial: 8250: Remove duplicated compatible strings

 .../bindings/display/brcm,bcm2711-hdmi.yaml        |  2 +-
 .../devicetree/bindings/display/renesas,du.yaml    |  3 ++
 .../interrupt-controller/idt,32434-pic.yaml        |  4 ++
 .../devicetree/bindings/media/renesas,vin.yaml     | 46 ++++++++++++++--------
 .../devicetree/bindings/mtd/tango-nand.txt         | 38 ------------------
 .../devicetree/bindings/net/renesas,etheravb.yaml  |  2 +-
 .../devicetree/bindings/pci/rcar-pci-host.yaml     | 12 +++++-
 .../devicetree/bindings/pci/tango-pcie.txt         | 29 --------------
 Documentation/devicetree/bindings/serial/8250.yaml |  5 ---
 drivers/of/overlay.c                               |  3 --
 10 files changed, 49 insertions(+), 95 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/tango-nand.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/tango-pcie.txt
