Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C123EABFD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 22:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbhHLUmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 16:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbhHLUmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:42:23 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D40C061756;
        Thu, 12 Aug 2021 13:41:57 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id w10so6401316qtj.3;
        Thu, 12 Aug 2021 13:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=plMp/LjZg42NsXR6HAsNlOG32rI0PkLKt5n9XUzanC8=;
        b=SYWnentim0D4AQARu53t814wnUXhtq4Sb0aZirAUhj4I1gyQ8R4vfPoX3B3JNW203S
         9CTS6wKWKKWqBkjDelqRpK46K3F7T5tYup6ijwmPhLfA1sI4+kAAHOF8SZ+mhavdON3E
         Q7v3RWOgQit45fY92Zlhc3Z1OTmzrymJ8u26CBmwZt/QBuo1Z3yp9hrt20QuOBv7HL6i
         YTV/onyRQAq9YhIhZss1yxOF/qmZK6A5uf8HK4655djFoPcsQeZjgZg8a9kHVlU/ZLTT
         06qrfZn3Fvt/J5ZMN+C2+Kn7Tws3kqnIES0agdtr4B4ZWeRYsKZtRnlV6pOLwGS9zP1b
         4E6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=plMp/LjZg42NsXR6HAsNlOG32rI0PkLKt5n9XUzanC8=;
        b=bcy21QYjQFaZBiMrs6S5QlHmSC6vbYavqy3C8cYW5zjpryvVO1anuO3+rY21JAntkV
         7YBy3Q8k7pFVVZwUn95cPDqRhnN1EXL+FxQNrK6tghM/AgV9PbywGRQD1nyQLc3xidkE
         akWD6mXA0NuUSow3s4Cpfnk9hyLWq2c+NFnfzRqbvtoKBL55EoLoWodRAPapgOzvUfrC
         jqUjIHx5GTa/6EWGQJreVuBTy99I47YhjsMvxpVkrfjnbkqNthLNHTuyrv4jxRYgPP0l
         nWQVornwAFtSpYluBKWgA9AR7eS3ARQnF1NwYyGkdEj85wtTQVZFqo26oMMfvWAlTj0b
         EYCQ==
X-Gm-Message-State: AOAM533sqHHYiY6RPQQnrRJrD1r5gTtye4JD88zBYXxT+jyy3gsvhLRD
        wA0pcJGjVniHiEU1FmH7E48=
X-Google-Smtp-Source: ABdhPJwpLDUhYhoM8cXeQua02cls7C1TE2wnIM9nGfig9WAjj7XGJuKseD4/LaDR2rvwwYfODiwZ3Q==
X-Received: by 2002:a05:622a:154:: with SMTP id v20mr5638983qtw.148.1628800916824;
        Thu, 12 Aug 2021 13:41:56 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:e89f:d077:9161:1bd7])
        by smtp.gmail.com with ESMTPSA id m16sm1940361qki.19.2021.08.12.13.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 13:41:56 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v2 0/8] phy-rockchip-inno-usb2: support rk356x usb2phy
Date:   Thu, 12 Aug 2021 16:41:08 -0400
Message-Id: <20210812204116.2303617-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Afternoon,

This is my series to support the usb2 phy devices on the rk356x.
The rk356x phy has a single muxed interrupt and has moved the usb2phy
nodes out of the grf and into their own nodes.
The phy needs to tie back into the grf for register control, similar to
the rv1108.
By moving the phys into their own nodes, they now have full
#address_cells = 2 register addresses, but they still reside below the 32bit
mmio range.

This driver series only supports the host configuration for the rk356x.
I have have tested it on the following:
rk3566 - Pine64 Quartz64 Model A
rk3399 - Pine64 Rockpro64

Please provide feedback and comments as you see fit.

Changelog:
v2:
- correct the order of the usb2phy-grf dt-bindings patch, thanks Johan
- correct the conditional requirements of phy-rockchip-inno-usb2, thanks
  Johan
- drop increase generic-ohci clocks patch, thanks Heiko
- correct rk356x.dtsi ordering
- fix a dtbs-check callout

Peter Geis (8):
  dt-bindings: soc: rockchip: add rk3568-usb2phy-grf
  dt-bindings: phy: phy-rockchip-inno-usb2: add rk3568 documentation
  phy: phy-rockchip-inno-usb2: support #address_cells = 2
  phy: phy-rockchip-inno-usb2: support standalone phy nodes
  phy: phy-rockchip-inno-usb2: support muxed interrupts
  phy: phy-rockchip-inno-usb2: add rk3568 support
  arm64: dts: rockchip: add usb2 nodes to rk3568 device tree
  arm64: dts: rockchip: add Quartz64-A usb2 support

 .../bindings/phy/phy-rockchip-inno-usb2.yaml  |  31 ++-
 .../devicetree/bindings/soc/rockchip/grf.yaml |   1 +
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   |  52 ++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  98 +++++++
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 259 ++++++++++++++----
 5 files changed, 383 insertions(+), 58 deletions(-)

-- 
2.25.1

