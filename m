Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1B83E1EA2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 00:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbhHEW2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 18:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239838AbhHEW2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 18:28:44 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0E5C0613D5;
        Thu,  5 Aug 2021 15:28:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a8so12450637pjk.4;
        Thu, 05 Aug 2021 15:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=G7AJcm8fOQqUhjFWYk2UN/7Uz0dfNNvyDbmqqe3ttDA=;
        b=SxRdkHyQPBwwyirpGyIXezUPbdDoEsp4VVrXlFG5lSKNH/YLU+ZkIJMfVOQSDasuah
         joqgB8BhwcdiWHUJRLuGBJEZew232GG2nx9rEmocOQlTeXf/4bvullaixRrO2qTNl8tQ
         WUhfN+KAOmAWZo9Nkf+XuOobM4Bvhr/47slFBOEto01Dg4slGxsQecQ/WM3X71Um/PFC
         5MofTL34uiebaz8MJqOSV001bTASaUixGi5dTSSXbt2XIkjAMruv8uAhNLKZMc9r0oDk
         u8BZqtxN1BImL4PskLd0VfOGx7aWS5ihdsQZXSCZ2qsq77I+lOjUKTizUmiZgZVGjpN4
         krrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G7AJcm8fOQqUhjFWYk2UN/7Uz0dfNNvyDbmqqe3ttDA=;
        b=qGyC9C8tnMgeWlwBqrHf12DMqopKahwcPO6BtEN0yIsNbw4GVN97+p4DnMFWET9Rtp
         NKfIHNWnKjTTl9ud/Dy6OrPuhtvwnktEdrydot1Iy+SBM/VUSQA/0PFOXRSUlqDFRTgF
         3YpxRmhqJBWKruGRNuG986jmuUNuxRjl6CGJaQaxkr00IGasNkUGDze6VF812GXAToAD
         LX7uJe40O09+OTdX0CYiEmrQCU+8nkc5/IapDMS5g++rLaf65zkcMx/Z3uyqK8q2Ittd
         SnQndlSYQe9Kbjhm35XTS0WLD3NVyNlIGPPRiLDuccONuCo6ZnLYaXJHDY0jSuaMogWZ
         z9jQ==
X-Gm-Message-State: AOAM531nSMgU9ywLhv08YtaZg8G8ZWyVhBIooliWXOa5/yRDxpf1vsTy
        mxhRmubpcIXNVzAix0o8J+I=
X-Google-Smtp-Source: ABdhPJw5VVE+dy/T9QASyoUM4UYts9qEOKA/h08HTH7cLwzt441x0wobT26tUg+hM/bCyiu/JUOTDg==
X-Received: by 2002:a17:902:c20c:b029:12c:ef04:faa3 with SMTP id 12-20020a170902c20cb029012cef04faa3mr263057pll.44.1628202508308;
        Thu, 05 Aug 2021 15:28:28 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id b26sm8082292pfo.47.2021.08.05.15.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 15:28:27 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v2 0/6] ARM: dts: Add Facebook AST2600 BMCs
Date:   Thu,  5 Aug 2021 15:28:12 -0700
Message-Id: <20210805222818.8391-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

The patch series introuces 3 new BMC platforms for the Facebook's next
generation switch platforms: Cloudripper, Elbert and Fuji.

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
 .../dts/aspeed-bmc-facebook-cloudripper.dts   |  539 +++++++
 .../boot/dts/aspeed-bmc-facebook-elbert.dts   |  185 +++
 .../arm/boot/dts/aspeed-bmc-facebook-fuji.dts | 1251 +++++++++++++++++
 .../boot/dts/aspeed-bmc-facebook-wedge400.dts |   48 +-
 .../dts/ast2600-facebook-netbmc-common.dtsi   |  169 +++
 .../dts/facebook-bmc-flash-layout-128.dtsi    |   60 +
 7 files changed, 2208 insertions(+), 47 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-fuji.dts
 create mode 100644 arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi
 create mode 100644 arch/arm/boot/dts/facebook-bmc-flash-layout-128.dtsi

-- 
2.17.1

