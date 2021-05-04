Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EB43730DA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhEDTgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhEDTgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:36:01 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BD0C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 12:35:05 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n2so10675988wrm.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 12:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/wlkno7pRty5OfZRb8J5gIbUcerkat2d/Bw1XsvXcxA=;
        b=cQwuhcRbcCqXF84od/9QObdaYeQP08k05+eaYKRXsWjfB8+uK8p0Rew0weWkCYskXA
         XzJPK2gWVgMfQu81aw7g1F1FHwOtP3iU8hguoWKm1B2zpiIt7kAxrA5UHLZYaBxk9zri
         DUO5XmmmZ1drzcHgZhgOVFXZAXJ3MDqPUrsp2qoatan9C8w8qk81YqOOuNkvGWf8eNtq
         f8gU/gXLdCurvwLOqLHQVU5Z91fWQAaZHsgv67KDPM90OyZBdSQN0QmIGCLoeUHRc5Cz
         HV3I7445/U9WHR8/VUINZHiG8nk0q53HEI+sL4Me54akckuGl2dbb3+ijnefVdPaQ/YF
         hISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/wlkno7pRty5OfZRb8J5gIbUcerkat2d/Bw1XsvXcxA=;
        b=lw9n6z+3mwl4792cFKURTrlJK5H7WYOyeKmnwlsBLYJqIT5OrEq2eiHN8ISPE3/58G
         XQD6j7/RUadJpwCNwr18akEQQbzi7Gi8AQZcXGaUNrFT9pP2gbnVDCskerptAzzfioH9
         pIuSKi3E4HfgQ4Hj76O+uL/DKqjTRLH8IbxsnjV92vEl83ce7MeX9jCByoy3tePPM23z
         LA26muEw64xuwTi0pGrcixj2/fPJl9bx345ZhxIEll9tr+1/G0PhuyOLo6OsQhvz43Uc
         ogIndDMf0PgvGmQfxA/yy0w6F8lu78rogmjopfeN0faZeD/GmVbSkuE97Z5BqsV1DhGF
         iLag==
X-Gm-Message-State: AOAM5322F9BjtQZX+w7NaQPushwEO3nTagTOMcgTCnYbpUMb9z8WrQ8E
        QydARRWUVrbahoQu/NU1dwm/Zg==
X-Google-Smtp-Source: ABdhPJyRqQn35aDMtuJzXmdCWQFefsfXBopf6kCEyTozbNmoBqhTRobePV2+CeNp53C7ihebxE0Leg==
X-Received: by 2002:adf:e3c6:: with SMTP id k6mr10179868wrm.236.1620156903866;
        Tue, 04 May 2021 12:35:03 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x8sm17072136wru.70.2021.05.04.12.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 12:35:03 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, kaloz@openwrt.org, khalasa@piap.pl,
        linusw@kernel.org, linux@armlinux.org.uk, olof@lixom.net,
        robh+dt@kernel.org, soc@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 0/5] ixp4xx: add welltech-epbx100
Date:   Tue,  4 May 2021 19:34:52 +0000
Message-Id: <20210504193457.4008384-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The welltech epbx100 is a small IP PBX board.
It ship an Intel IXDPG425 Network Gateway Reference (IXP42X 533MHz) SoC.
Original image ran an old 2.4.31 but upgrading to recent kernel was
easy.
It misses a working network interfaces but its current state is
sufficient to work on my interest, its crypto device.

More information on the board could be found on http://kernel.montjoie.ovh/welltech-epbx100.html

Corentin Labbe (5):
  ARM: ixp4xx_defconfig: add CONFIG_SERIAL_OF_PLATFORM
  ARM: ixp4xx_defconfig: add MTD_PHYSMAP
  dt-bindings: add vendor prefix for welltech
  dt-bindings: arm: intel-ixp4xx: add welltech,epbx100
  ARM: dts: add intel-ixp42x-welltech-epbx100

 .../devicetree/bindings/arm/intel-ixp4xx.yaml |  1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 arch/arm/boot/dts/Makefile                    |  1 +
 .../dts/intel-ixp42x-welltech-epbx100.dts     | 76 +++++++++++++++++++
 arch/arm/configs/ixp4xx_defconfig             |  3 +
 5 files changed, 83 insertions(+)
 create mode 100644 arch/arm/boot/dts/intel-ixp42x-welltech-epbx100.dts

-- 
2.26.3

