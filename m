Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702093D998A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 01:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhG1XiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 19:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhG1XiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 19:38:09 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEE6C061757;
        Wed, 28 Jul 2021 16:38:05 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d1so4718167pll.1;
        Wed, 28 Jul 2021 16:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SfhM5hIjH4I2dOHB9xgS2+AKrC0SvF1WxH5UJ+fSmRk=;
        b=DHHzoOVXCFpB2m+umRRgHMk+kFAqECOeEl5r1oi4ckNWeivoGTI7aAz4oGGAr7LbAT
         E7qu8ZeZbpQrwKhiWLnhQ1L1yuaQIOi8WRfuTLsaIy6fB9UIvwKSwt23RSmGoTV6Pgx2
         s/RSqrrUd52uFOZqAd6r9JzRVBiZN56m+Rfnu9DeysgNaBeGA/2A1fEFymHivV3rXEY5
         JVRLMeGgcP5ZS/orWw5L5LIJuVshEUGfmJdntab/jA/1lP1hYGdt2cWyjahQ3df0O5OA
         ZcYaWK9r5Y5oozvErh9m0J8eHzKdduGjWSanUXVITeN031HEknOZGVUasXewZ8DwS7dm
         YAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SfhM5hIjH4I2dOHB9xgS2+AKrC0SvF1WxH5UJ+fSmRk=;
        b=DMKG2oEg79XGBF2SRfndT5IFw/1YqY+/6erJsK9RUqCHU1Q+o8RLYbhKtWZ4QHnl0W
         VZKF3oAGJUP3z6tnjWxdzWOO12z6pC6muSdf1hPNyMdIDiROx+/B3byye8/FGweMKh0T
         LkLy096YL0JSjDWSLFTPcTdSHTm1YTVM0/5TRbdn5x8s1iLeYtoUTNHrq4WYO5CMJ8mG
         44skmiQ4IeqDrnHDGLghHdoQqtd6CP92ZII95pYrMRGGkdIGWcKiowq+90yfYuAjCKvH
         DFSW1jZodWuITITwWV/WgbAqACn9Sa0lod+DbNZwY7YOMFyY4WmrLQEUNFDnHGpQKeyp
         Atgw==
X-Gm-Message-State: AOAM53010CXPtU0WaiSlNpOabSi/ug6xcx2Px2YGPre7vc6zhN2IDKBo
        196xXvNcChl2UyhyefbRJnI=
X-Google-Smtp-Source: ABdhPJw9M4Lxsn7ys7mPlyLWaO6vlx6TfaLR1km4tFwmfpcL1zh55ty79nFEMvIxyek5uv8z6iI/9A==
X-Received: by 2002:a17:902:8bc4:b029:12b:8470:e29e with SMTP id r4-20020a1709028bc4b029012b8470e29emr2080316plo.2.1627515485326;
        Wed, 28 Jul 2021 16:38:05 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id k37sm1038671pgm.84.2021.07.28.16.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 16:38:04 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 0/6] ARM: dts: Add Facebook AST2600 BMCs
Date:   Wed, 28 Jul 2021 16:37:49 -0700
Message-Id: <20210728233755.17963-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

The patch series introuces 3 new Facebook AST2600 Network BMC platforms.

Patch #1 adds dtsi file to describe the fixed flash layout of 128MB mtd
device. The flash layout is used by all the 3 AST2600 BMC as well as
Wedge400 (AST2500).

Patch #2 simplies Wedge400 dts by including the flash layout dtsi.

Patch #3 adds common dtsi which is included by all the new Facebook
AST2600 Network BMC platforms.

Patch #4 adds the device tree for Facebook Cloudripper (AST2600) BMC.

Patch #5 adds the device tree for Facebook Elbert (AST2600) BMC.

Patch #6 adds the device tree for Facebook Fuji (AST2600) BMC.

Tao Ren (6):
  ARM: dts: Add Facebook BMC 128MB flash layout
  ARM: dts: aspeed: wedge400: Use common flash layout
  ARM: dts: aspeed: Common dtsi for Facebook AST2600 Network BMCs
  ARM: dts: aspeed: Add Facebook Cloudripper (AST2600) BMC
  ARM: dts: aspeed: Add Facebook Elbert (AST2600) BMC
  ARM: dts: aspeed: Add Facebook Fuji (AST2600) BMC

 arch/arm/boot/dts/Makefile                    |    3 +
 .../dts/aspeed-bmc-facebook-cloudripper.dts   |  564 ++++++++
 .../boot/dts/aspeed-bmc-facebook-elbert.dts   |  185 +++
 .../arm/boot/dts/aspeed-bmc-facebook-fuji.dts | 1276 +++++++++++++++++
 .../boot/dts/aspeed-bmc-facebook-wedge400.dts |   48 +-
 .../dts/ast2600-facebook-netbmc-common.dtsi   |  176 +++
 .../dts/facebook-bmc-flash-layout-128.dtsi    |   60 +
 7 files changed, 2265 insertions(+), 47 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-fuji.dts
 create mode 100644 arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi
 create mode 100644 arch/arm/boot/dts/facebook-bmc-flash-layout-128.dtsi

-- 
2.17.1

