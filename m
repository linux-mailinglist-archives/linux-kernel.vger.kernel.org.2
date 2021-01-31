Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820A9309ABF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 06:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhAaF5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 00:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhAaFyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 00:54:05 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13532C061573;
        Sat, 30 Jan 2021 21:54:05 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id z6so12959539wrq.10;
        Sat, 30 Jan 2021 21:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YXzz4lbNjjkYopaBrkrflVc5oiqbwCaZksxB3VFG3no=;
        b=RQGdie3S0gicwLeqDKFGNwawZh4uHkbr6wBwexO1xV5Yf3j7vlzSnOJtklpHzbyu53
         RNjzgzvAvaxINYNeTmr9EB36ymSSpdJHQlnMTttS1Bc3YUOnLdMIl4a9EoABxhQDz2Aj
         yk6BH2FkAKS6qyYfcQ1rmvDUCiUyHalRU5h+zChck/te1G2zbI9z77ctdMcF5SBMuiLq
         vgI8dnVSL7M6j15PoBmdvKkRp7uLiXQusbzH7Gd+ZQFCBby5iGZTJiA0FnMLDPiswOu9
         bHUNinxPks60NE7juX+UiGnguvp1SoPMSBOJdOkao7BSIuYmqj8LUJu23MG0RyfnXpBm
         glkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YXzz4lbNjjkYopaBrkrflVc5oiqbwCaZksxB3VFG3no=;
        b=XBG00gZkIXDtPpOAFCAyldjLf/ZyQRUztfWV/idyqyZCf+m4H4QpNy6S3cr8wQw7es
         elroJFhf3ODuJSU35l3fr49ZlbaRveTRSWKXElZsUf1ZTaQXtxTKTs0s/Xbj3Fg7vWQA
         Es7giPgiup9bHBPAAf2Phs/XBNYBWEZpGRH/obehAEdQbHXPq2K5TpNXt/FBb4V5AT/v
         PEKfHItidbSNeZmwFBkXYTKJBoQQmRfiGhhayifOCFBAa1Ocw9tueC1+WxdpYymIUTF9
         R6cB3/Sy3Mkds0OEEO7H9jO/TvXrsvf9SG0RksTAw/OTZHTfcY3dkhE6rRLlqMyJjBRI
         QMng==
X-Gm-Message-State: AOAM533wFmHN83QMIx4CK39X2d8BLxuC921KRjWqMOYFn5a1lR5u2mlg
        Aj3/aPWFMTSkJIiJ1XNHDQ8=
X-Google-Smtp-Source: ABdhPJyhvMCNemBekoiGJPrlxhrYzRg6T7AJws/jC+dLxH5Dm1qgLWZk/hOInQf0vLM+/TvgxFVH3A==
X-Received: by 2002:adf:ecc5:: with SMTP id s5mr11814784wro.423.1612072443607;
        Sat, 30 Jan 2021 21:54:03 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id c9sm20056589wrw.76.2021.01.30.21.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 21:54:02 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Dongjin Kim <tobetter@gmail.com>
Subject: [PATCH v2 0/5] arm64: dts: meson: add support for ODROID-HC4
Date:   Sun, 31 Jan 2021 05:53:53 +0000
Message-Id: <20210131055358.21293-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes minor sort-order issues in the Amlogic bindings yaml and
dtb Makefile, then converts the existing ODROID-C2 dts into dtsi so we can
support its new sister product the ODROID-HC4.

I've also given the devices different audio card names. This is partly
cosmetic, but also because HC4 is HDMI-only while C4 can be used with
other i2c audio devices via an expansion connector so users may want to
use different alsa configs.

Patches to support the spifc chip are still being upstreamed [0] so this
will be addressed in a follow up. A WIP patch for the dts change can be
found in my amlogic-5.11.y dev branch [1].

For reference, here's dmesg from LibreELEC on 5.11-rc5 [2].

Changes since v1:
- fix ODRIOD typo in patch 3
- fix SPI-NOT size in patch 5
- add Neil's Acks/Reviews

[0] https://patchwork.ozlabs.org/project/linux-mtd/patch/20201220224314.2659-1-andreas@rammhold.de/
[1] https://github.com/chewitt/linux/commits/amlogic-5.11.y
[2] http://ix.io/2NCi

Christian Hewitt (5):
  dt-bindings: arm: amlogic: sort SM1 bindings
  arm64: dts: meson: sort Amlogic dtb Makefile
  arm64: dts: meson: convert meson-sm1-odroid-c4 to dtsi
  dt-bindings: arm: amlogic: add ODROID-HC4 bindings
  arm64: dts: meson: add initial device-tree for ODROID-HC4

 .../devicetree/bindings/arm/amlogic.yaml      |   5 +-
 arch/arm64/boot/dts/amlogic/Makefile          |   3 +-
 .../boot/dts/amlogic/meson-sm1-odroid-c4.dts  | 427 +----------------
 .../boot/dts/amlogic/meson-sm1-odroid-hc4.dts |  96 ++++
 .../boot/dts/amlogic/meson-sm1-odroid.dtsi    | 441 ++++++++++++++++++
 5 files changed, 543 insertions(+), 429 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi

-- 
2.17.1

