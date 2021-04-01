Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3A83521B3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbhDAVhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbhDAVhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:37:02 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D49C061788;
        Thu,  1 Apr 2021 14:37:02 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ap14so5019316ejc.0;
        Thu, 01 Apr 2021 14:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4Qm+59uCAR9vp39Y7VT6xDQzUUw6xyOHk+iDumVodlE=;
        b=aZaO17+SGBUHuOxA6HLN3ByDQQNSRVM+chqYLrdJJ6PpeS1J1+jxWRRzwq1eadKtNz
         1YqHBcrMTc6Lx/7dgAuPobooE6Q/GVFX20PgXkkqtvBB/lTkzoOAx0qx1CvP+F5NbXIP
         TEvdr4ZNNIAD4+7zvp58r7Xvj7aA8RFKp0+9AbYYS/r02tl4lSrif1PnqGVXXisgRPf/
         xr6/IrlgXxaG46icbzVZHY8ZlLyBb4GAihqV2GJzeWUaztMO4bDAghPmYzKEmF8VIyue
         p6FGkubFp5GUOj1vc8WAtacOutyDcm4NM7Y3AKS0353XTA9NZHay1Bfflj2uzHRKpet3
         KX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4Qm+59uCAR9vp39Y7VT6xDQzUUw6xyOHk+iDumVodlE=;
        b=lsQwLciWNKrjiQHa40RP+uyt1JPDdDmkvWzrdRWQ9ZUw8JEQYfbYPt3alNgnWCbbAo
         cFSA6wWJEOYn2QHQfjoFRdHVgvNaIvIh/yKg7ZxiipFYUF07WjKsahDlMSqFbHfcIyvl
         2/zfjE/uBDYnto+1qaMfF7gXeHs9i3rOuZqeLzUCmnhDq8JR4d+LZTaIXAdeeZhAYnsl
         ZQ5xyNepDlQ+w4Ph10LDyeYbRqgPEHQujXoEV3Y/1KL83rJfoBSwMYn1mVPOiBGPVD9m
         6TE2mk0eJsybA1WyzshW9PSvscU4Zpxcmg1ofx8vVCpi+fFvg26GMB8u+4sqbKhZhaKM
         SQ2Q==
X-Gm-Message-State: AOAM533ZqN04HabMMgWcfgx+GKG/VaBRetpdpCz1+Eo5gWRgsP5qUJpK
        T7W1KMtlfm11+JJH7VfHWH72F6JMCf+4Cw==
X-Google-Smtp-Source: ABdhPJyaSXrftQ9tYxNcnNignEGJiUDe3HXyDFGr7eJTmFv4CQAPnKl7qADsjGYi/P/aUIgDskYPFA==
X-Received: by 2002:a17:906:ae88:: with SMTP id md8mr10805611ejb.264.1617313019611;
        Thu, 01 Apr 2021 14:36:59 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f9sm4237006edq.43.2021.04.01.14.36.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Apr 2021 14:36:59 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v6 0/4] convert rockchip,dwc3.txt to yaml
Date:   Thu,  1 Apr 2021 23:36:48 +0200
Message-Id: <20210401213652.14676-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion of rockchip,dwc3.txt to yaml was added to linux-next,
but the necessary changes for rk3399 are still pending.

For rk3399 dwc3 usb the wrapper node for only clocks makes no sense,
so that was removed in the YAML example.

Now dtbs_check still generates notifications for the compatibility string in
the dts files that doesn't match, because it changed from
"rockchip,rk3399-dwc3" to "rockchip,rk3399-dwc3", "snps,dwc3".

The problem is to keep compatible with old device trees.
I.e. a device running an older device tree should still work with newer
kernels.

Comment by Rob in version 3:
Presumably you are getting lucky here (with link order). The kernel
has no logic to decide which driver to bind to if there are 2 matching
drivers. If we did, it would probably be the opposite of what you want
here as we'd pick the most specific match. This driver should probably
bail probe if no dwc3 child node.

Please advise how to move forward with this serie.

Changed V6:
  rebase
  remove accepted patches from serie

Changed V5:
  add select

Changed V4:
  removed patch "of-simple: add compatible for rk3328"
  add patch "of-simple: bail probe if no dwc3 child node"

Changed V3:
  remove aclk_usb3_rksoc_axi_perf
  remove aclk_usb3

Changed V2:
  remove node wrapper

Johan Jonker (3):
  usb: dwc3: of-simple: bail probe if no dwc3 child node
  arm64: dts: rockchip: restyle rk3399 usbdrd3_0 node
  arm64: dts: rockchip: restyle rk3399 usbdrd3_1 node

Wu Liang feng (1):
  arm64: dts: rockchip: optimize clks for rk3399 dwc3

 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts      |  4 +-
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts    | 12 +--
 .../boot/dts/rockchip/rk3399-gru-chromebook.dtsi   |  6 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |  6 +-
 arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts | 12 +--
 .../boot/dts/rockchip/rk3399-khadas-edge.dtsi      | 12 +--
 arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts  | 12 +--
 arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi   |  8 --
 arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts   | 12 +--
 .../boot/dts/rockchip/rk3399-pinebook-pro.dts      |  8 --
 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |  4 -
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      |  6 +-
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi    | 10 +--
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi | 12 +--
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts    |  4 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi   |  8 --
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi | 12 +--
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi  | 12 +--
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 86 ++++++++--------------
 .../boot/dts/rockchip/rk3399pro-vmarc-som.dtsi     |  4 -
 drivers/usb/dwc3/dwc3-of-simple.c                  |  4 +
 22 files changed, 59 insertions(+), 197 deletions(-)

-- 
2.11.0

