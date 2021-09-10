Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1B94072CC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 23:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhIJVFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 17:05:48 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:44852 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhIJVFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 17:05:45 -0400
Received: by mail-ot1-f53.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so3998028otg.11;
        Fri, 10 Sep 2021 14:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=vgHIM4Ct31Y31nZq6uyxNUaBJB+NoA1rPrBjIZ9bcLA=;
        b=e68TXzk4aApcZzQg9iYVfFHa3LQXf8yUIkdufWEoXYDRwbiE7a4eDFq8d5RfxjlfkI
         4D9DW3SzHc7exeSmF0xy/4TKfMGOZ8sW4bH9cE5Z1/V+/CleW0HVP66moP/glYt/L5M/
         30X0nfWfosWT1o4c4egOH9X95w3XyenKaoQF6qb9qXJH7V4zGK9wWCc89mpnvK9yLE06
         R0gG0mWwajZ3NAZLX7l3YU5iUvszgY68Q9s1Bz1gq+y0F49MFcCSsSXon4SjloJEF65O
         jpM+QpgGYywqzy5p7Xk1JUT0zptj0i5PmH83642iQTHeMrojgY836Pt8Qx1M93efk/zP
         T0gw==
X-Gm-Message-State: AOAM533Lfcx2DRyUjCDMaMe+ieCdTNdea0PTyjS3jQVazb54Mc5ojtSi
        61OZg0wvS30C8/DbJJ2DwaU5vR/7TQ==
X-Google-Smtp-Source: ABdhPJz667Jb44ra/AD13hNO/0SIw8b6ZHh1K4XA6Lv3SBIW3AcpdVu1n2MvnNI17kqtZ1EKdXL4kQ==
X-Received: by 2002:a05:6830:78c:: with SMTP id w12mr4357491ots.196.1631307872751;
        Fri, 10 Sep 2021 14:04:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 99sm1499759otd.2.2021.09.10.14.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 14:04:32 -0700 (PDT)
Received: (nullmailer pid 3378802 invoked by uid 1000);
        Fri, 10 Sep 2021 21:04:31 -0000
Date:   Fri, 10 Sep 2021 16:04:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fixes for 5.15, take 1
Message-ID: <YTvIXzO2QJ4n9RmM@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a couple of DT fixes.

Rob


The following changes since commit bf9f243f23e6623f310ba03fbb14e10ec3a61290:

  Merge tag '5.15-rc-ksmbd-part2' of git://git.samba.org/ksmbd (2021-09-09 16:17:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.15-1

for you to fetch changes up to 094b147c766289baa0f370d124609c3ac2b5a420:

  spi: dt-bindings: xilinx: Drop type reference on *-bits properties (2021-09-10 14:54:27 -0500)

----------------------------------------------------------------
Devicetree fixes for v5.15, take 1:

- Disable fw_devlinks on x86 DT platforms to fix OLPC

- More replacing oneOf+const with enum on a few new schemas

- Drop unnecessary type references on Xilinx SPI binding schema

----------------------------------------------------------------
Rob Herring (2):
      dt-bindings: More use 'enum' instead of 'oneOf' plus 'const' entries
      spi: dt-bindings: xilinx: Drop type reference on *-bits properties

Saravana Kannan (1):
      of: property: Disable fw_devlink DT support for X86

 .../devicetree/bindings/display/msm/dsi-phy-7nm.yaml       |  8 ++++----
 Documentation/devicetree/bindings/spi/omap-spi.yaml        |  6 +++---
 Documentation/devicetree/bindings/spi/spi-xilinx.yaml      |  2 --
 .../devicetree/bindings/watchdog/maxim,max63xx.yaml        | 14 +++++++-------
 drivers/of/property.c                                      |  3 +++
 5 files changed, 17 insertions(+), 16 deletions(-)
