Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C063D94D8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 20:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhG1SBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 14:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhG1SBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 14:01:00 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D3BC061757;
        Wed, 28 Jul 2021 11:00:57 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id a12so1990017qtb.2;
        Wed, 28 Jul 2021 11:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HjqNaCu5z632c2H6OSRidttZSmwX46gUM1DC3j7exUU=;
        b=d4TQ5qxeRW8IhmFe1ZMqMdQ0ddtukgZDNvAqp2e7TuDKRmy/TxM38z44H4fP8T4lyn
         oPYUxSQJYBqqkMadCcUojtTd+HjqOMNFch2TeL3nBhMN1TQfI3lr7ByEv6hCBj8MoLOr
         GGf7+tmOJj8pJhkQ7NZj0buvHcG67PCN1Q+W3neepzoe2nbESKAJaiEyW9Otmr7hR8nP
         ADfbezM5WhwxB3/eGj0NmwQpgfUFP7dCFO7b6LIK3BL/ZA/7OKvjJ8gJt/9X+cKxdP3S
         hQY2lYe99f3sohxtKUWKvxszyogY6ivs71SWlSTde2URwGzB11NaNNtxureQrl+uv0iH
         aMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HjqNaCu5z632c2H6OSRidttZSmwX46gUM1DC3j7exUU=;
        b=HvGXlL5+pieV1I3a5CPMn+d8ghYtfts3Lf4gXlissAQAGJyyFj7bbUncJX0OfQw7Dc
         qjKt4vxr7LVObQo5YZ+ZUAF0yGDtGVEriKMYSrxs5JEGiOHD4rKcJruDhEgJCFXTUfPs
         v8L3kgPCosRZ9W57rfDw6I5QcnnQHn3hOAAQVT7DEI1Jq8i0Qik8YYmOyPBiiiuAntDf
         rhNnFDi2rkW7cFepQpxxb/h5tj4KpvfrL1kVyn0yxiqqkMx5DGANng8NJYhz1zjq25NF
         khXDrxINA+6czUoQUej0SVyf3/5qXnu2ISPE/GL8uqnmw3lHFmIuzFZWhY0KEJ8znMSR
         mNyg==
X-Gm-Message-State: AOAM533D23x942THd7J+WrQKjkN99PbhCxKcExtZp34MVX823tALjzjd
        sM0OT1kB0aW4y+sB4bDc9PU=
X-Google-Smtp-Source: ABdhPJx60cWu8UNF0XaLyoqMNCqTuJYTmTH41zklhgF7eZCQAw14sjuj4oPik3UPuJVH4/JQSxAHSg==
X-Received: by 2002:ac8:6b99:: with SMTP id z25mr763728qts.150.1627495256568;
        Wed, 28 Jul 2021 11:00:56 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:b58:2ae8:d75f:660a])
        by smtp.gmail.com with ESMTPSA id r5sm223341qtm.75.2021.07.28.11.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 11:00:56 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 0/8] fixes and enablement for rk356x
Date:   Wed, 28 Jul 2021 14:00:26 -0400
Message-Id: <20210728180034.717953-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Morning,

This series aims to fix some early issues with the rk356x and enable
nodes that are currently supported by the available drivers.

1. fixes the mbi-alias, which points to the wrong location
2. fixes the rockchip clk-pll to work without a grf node
3. adds the gpio debounce clocks which are necessary for gpio to bind
4. adds the common gmac1 node
5. adds the tsadc nodes
6. adjusts the gpll and ppll clocks to better support hardware
7. enables the gmac1 on the Quartz64
8. adds thermal support to the Quartz64

Changelog:
v2:
Drop "dt-bindings: gpio: rockchip,gpio-bank: increase max clocks"
Drop "arm64: dts: rockchip: add missing rk3568 cru phandles"
Add clk-pll fix patch as suggested by Heiko
Move ethernet alias to Quartz64 board as suggested by Heiko
Adjust tsadc pinctrl as suggested by Heiko and Johan
Move tsadc mode and polarity to Quartz64 board

Peter Geis (8):
  arm64: dts: rockchip: fix rk3568 mbi-alias
  clk: rockchip: fix clk-pll rk356x early pll init
  arm64: dts: rockchip: add rk356x gpio debounce clocks
  arm64: dts: rockchip: add rk356x gmac1 node
  arm64: dts: rockchip: add rk3568 tsadc nodes
  arm64: dts: rockchip: adjust rk3568 pll clocks
  arm64: dts: rockchip: enable gmac node on quartz64-a
  arm64: dts: rockchip: add thermal support to Quartz64 Model A

 .../boot/dts/rockchip/rk3566-quartz64-a.dts   |  71 ++++++++++
 .../boot/dts/rockchip/rk3568-pinctrl.dtsi     |   7 +
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 131 +++++++++++++++++-
 drivers/clk/rockchip/clk-pll.c                |   2 +-
 4 files changed, 204 insertions(+), 7 deletions(-)

-- 
2.25.1

