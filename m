Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0DE35A787
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 22:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbhDIUA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 16:00:27 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:34439 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbhDIUAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 16:00:25 -0400
Received: by mail-oi1-f181.google.com with SMTP id k18so2049370oik.1;
        Fri, 09 Apr 2021 13:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=QOQ58AXfwjk0/AzOQh8EAAOFinSluabNzc0ckaQgU5s=;
        b=C0+UFZAlslhwEs2RFTpmeJ33UtvwIeVLiZmzN+CCOLqgtUD/i2QFzLlurLIKPa/YCE
         i8dqfzolF9XWfFY6pbqxf/essOIeI3UCArHS8yQeENXkVim2OpajPuT/G9ngx86lrrPe
         e6EMkHeQmuZon8Xv3XXtbZxck/EEOPhlunpCy8D6DvwQ5I+pfu9PPT58S5KZwSK0oyf1
         wpHocZaTpxHREZB1gH57DPYMBuFXrDLJngOLpdtF4gw13QG1d8vd2cQ3u+QamuNBDlfm
         QMC5XAIDijZkhGUinUP3SMmdPVwdhLTfR4z4yGciUzIr/DX3zdW2ERUEESe0dVdd/BVt
         dP0g==
X-Gm-Message-State: AOAM531MaPHbdpqi3MLbgE4tvfDu0X38Ab3em7jDg/j3ED6Lc7z82AXY
        mIpFRIA/9DVUaj01qN5YPI98wPPlAg==
X-Google-Smtp-Source: ABdhPJwoA+CuyF7r/Z2UNUCT/lu5mRl0ph6CgB8dH+lUuR2iQoPYYNPNIXe4IhREAmcdtv9XO99K3Q==
X-Received: by 2002:aca:486:: with SMTP id 128mr1099097oie.117.1617998411492;
        Fri, 09 Apr 2021 13:00:11 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d24sm779685otf.12.2021.04.09.13.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 13:00:10 -0700 (PDT)
Received: (nullmailer pid 4062208 invoked by uid 1000);
        Fri, 09 Apr 2021 20:00:09 -0000
Date:   Fri, 9 Apr 2021 15:00:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [GIT PULL] Devicetree fixes for v5.12-rc, take 2
Message-ID: <20210409200009.GA4050302@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull. This has the fix for the OpenRisc regression Guenter 
reported.

Rob


The following changes since commit b5a95bb1883e2bac1009cc88e65c71cff6f931e6:

  dt-bindings: media: Use graph and video-interfaces schemas, round 2 (2021-03-01 11:30:21 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.12-2

for you to fetch changes up to d473d32c2fbac2d1d7082c61899cfebd34eb267a:

  of: property: fw_devlink: do not link ".*,nr-gpios" (2021-04-09 14:24:25 -0500)

----------------------------------------------------------------
Devicetree fixes for v5.12, take 2:

- Fix fw_devlink failure with ".*,nr-gpios" properties

- Doc link reference fixes from Mauro

- Fixes for unaligned FDT handling found on OpenRisc. First, avoid
  crash with better error handling when unflattening an unaligned FDT.
  Second, fix memory allocations for FDTs to ensure alignment.

----------------------------------------------------------------
Frank Rowand (2):
      of: properly check for error returned by fdt_get_name()
      of: unittest: overlay: ensure proper alignment of copied FDT

Ilya Lipnitskiy (1):
      of: property: fw_devlink: do not link ".*,nr-gpios"

Mauro Carvalho Chehab (3):
      dt-bindings: don't use ../dir for doc references
      dt-bindings: fix references for iio-bindings.txt
      dt-bindings:iio:adc: update motorola,cpcap-adc.yaml reference

 .../devicetree/bindings/hwmon/ntc_thermistor.txt   |  2 +-
 .../devicetree/bindings/iio/adc/ingenic,adc.yaml   |  5 +--
 .../devicetree/bindings/input/adc-joystick.yaml    |  4 ++-
 .../input/touchscreen/resistive-adc-touch.txt      |  5 ++-
 Documentation/devicetree/bindings/mfd/ab8500.txt   |  4 ++-
 .../devicetree/bindings/mfd/motorola-cpcap.txt     | 16 +++++-----
 drivers/of/fdt.c                                   | 36 ++++++++++++++--------
 drivers/of/of_private.h                            |  2 ++
 drivers/of/overlay.c                               | 24 +++++++++------
 drivers/of/property.c                              | 11 ++++++-
 drivers/of/unittest.c                              | 22 +++++++++----
 11 files changed, 88 insertions(+), 43 deletions(-)
