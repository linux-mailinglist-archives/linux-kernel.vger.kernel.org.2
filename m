Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644C837BC6C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhELMZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbhELMZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:25:03 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374EEC061574;
        Wed, 12 May 2021 05:23:55 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id j10so7639150ejb.3;
        Wed, 12 May 2021 05:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5kmeS+nP3CmJVZdwXbNkWQh2vxe2fkR1l6Dh3bLEmEY=;
        b=FZVLUW/3zsBvC4EOC6o1FXqQYISK/B9fzR1kaPEZah0OJXzpYeCefe4Wb10MDWc07W
         HW6675sciZd2zrssX0+dj8nhG7IKvWbCqIXBL7clAxfqEWI/dQi3jBsWbmS6d+6Dg/mv
         o9xETW0IOyALa3aALt1lm/k5zZE0yC2t1rO7fzC9cH1ryT8CD0m02IPs4LdmF8rsMzYD
         L/gOia/JLjjYnAWCqgwUPJoZkTk9DdjvaenhVlK+27KgahmDwzzJI9IoYH0+YGK/v1d9
         yibNHP2B8hTTffdvxQYkfhuWLbAOEdirrzvj5UJnYPods4ZAbAaUnYOpuYHFzfqQZutn
         XLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5kmeS+nP3CmJVZdwXbNkWQh2vxe2fkR1l6Dh3bLEmEY=;
        b=kN7PDBWaK8AFRWIa3mUiXvh87/IMfbiUHRK282oI7VcpdeOAZK7arGwxUUUvi/RjOG
         gJqiwmz68hflF0XARNRMISf5RjHdoYj770HdbdQAXRSJ3r8bLrfsdZHCMFQWm0qoYx5P
         CeKQcv6t3W9aSQvwuP0xxlFUIKqtGRTZ8WEhYKNwKzmJCE1Iza9NoaulT5J1jWFSG+v4
         L6feyMIZ3vLo/4rmhESQCsTWhTrQVHjyU5dER5aoOflOE/rup2ZyFhDZFMOZdkrCcDvg
         FbnrlkVSVWdnqQ6anLp+7lK4xwh1nUEnPKsfw7FKpwfXDP1ELD1IwQRJbkWLZglbR/1b
         9uKg==
X-Gm-Message-State: AOAM532/i8jRuUQQGpH1jPh1UUJn/hAuZQfuX2g49geJLX5QA3DvQfOc
        znL14v+NzCSU+s9BdXwOkdA05VU6YSY=
X-Google-Smtp-Source: ABdhPJyL/A02iHlXMGs1GvLo/Vpabb4JGISfTlYROGOastlv45I5mrXPrIN6cyfn2/RUWSji16c75A==
X-Received: by 2002:a17:906:22cf:: with SMTP id q15mr38101309eja.474.1620822234011;
        Wed, 12 May 2021 05:23:54 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g17sm21459665edv.47.2021.05.12.05.23.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 May 2021 05:23:53 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linus.walleij@linaro.org, kishon@ti.com,
        vkoul@kernel.org, jay.xu@rock-chips.com, shawn.lin@rock-chips.com,
        david.wu@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com, cl@rock-chips.com,
        linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] convert grf.txt to YAML
Date:   Wed, 12 May 2021 14:23:42 +0200
Message-Id: <20210512122346.9463-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed V5:
  changed compatibles for rk3066/rk3188
  add rockchip-usb-phy.yaml
  move and restyle grf nodes rk3066/rk3188
  remove applied patches

Changed V4:
  revert separate schemas for each 'if' subset
  add additionalProperties
  move properties to top level

Changed V3:
  remove select
  change unevaluatedProperties
  add separate schemas for each 'if' subset

Changed V2:
  add rockchip,rk3328-grf-gpio.yaml
  rename grf-gpio nodename

Johan Jonker (4):
  dt-bindings: phy: convert rockchip-usb-phy.txt to YAML
  dt-bindings: soc: rockchip: convert grf.txt to YAML
  ARM: dts: rockchip: move and restyle grf nodes rk3066/rk3188
  arm64: dts: rename grf-gpio nodename in rk3328.dtsi

 .../devicetree/bindings/phy/rockchip-usb-phy.txt   |  52 -----
 .../devicetree/bindings/phy/rockchip-usb-phy.yaml  |  86 +++++++
 .../devicetree/bindings/soc/rockchip/grf.txt       |  61 -----
 .../devicetree/bindings/soc/rockchip/grf.yaml      | 260 +++++++++++++++++++++
 arch/arm/boot/dts/rk3066a.dtsi                     |  53 +++--
 arch/arm/boot/dts/rk3188.dtsi                      |  53 +++--
 arch/arm/boot/dts/rk3xxx.dtsi                      |   2 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |   2 +-
 8 files changed, 406 insertions(+), 163 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip-usb-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/grf.txt
 create mode 100644 Documentation/devicetree/bindings/soc/rockchip/grf.yaml

-- 
2.11.0

