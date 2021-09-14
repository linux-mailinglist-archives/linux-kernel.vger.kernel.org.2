Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA2340B717
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 20:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhINSn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 14:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhINSn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 14:43:26 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E746C061574;
        Tue, 14 Sep 2021 11:42:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d21so14118395wra.12;
        Tue, 14 Sep 2021 11:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/tAkEVveFRCNKrB9Q8J/MpncU1oa/2ziuig1e/Atj58=;
        b=pKBxny78xL+Yy+YrisGKNVtF8G9VJGo1//nJXE0WWDo4oOyrbCRpMuIQ2dVBJHwuEV
         vz73iwbm5T+Gq8tnfL70QJTi7Azewamt0lWiINm+sizLPXy/AagAeXjkYkVkxzNkXceK
         UurUUmVQOnPFnR35u0DFseQakjk/WepL8pAwxEpC0YvrcYiTLPwI7FOYhN5LqpZ/YpPG
         ZafzKHq1x58Cz0XXDAJyo+937kbvP4FouqAZF/bAuYdZXv1zUCsZ/iJE7XgSHX1bG0/D
         pPFoqSP03Shxy0CFo67DJcd0epydscItG7XiLRCtVkPPwNA9P7oLpU4iViUANPu46OnR
         Kb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/tAkEVveFRCNKrB9Q8J/MpncU1oa/2ziuig1e/Atj58=;
        b=xxyjJNAb/SjdPJCt9B+jmJ++3r32BIxtXyYtpvL089mdB0U1gcyJfIZjwrNMD8R/Gh
         E7eRC65rBZX9gR/08TkSW79M+ijSm4rslVik04lxSd809mblcUgaGsSHfBcd5ByfOF6y
         ip+39Is9UtvcBw0rL/xdIbQXkQMAhw/DVVsMmSbMgotZ7wGjcE6X++6i7ezYvfNAbby/
         ayBTfCafpzZyHDc987UzeQRYeCRYXxkZLLuNVYcJKHG7341Qw/tE5fWYfMvJN6yaBSix
         CZnBh3lO2IQh78cB5ZqzTUxf1BE4sGaBeqSpMpkMYk0ExA5cCBJ8l00o77uy4MWi8Yp9
         IJdg==
X-Gm-Message-State: AOAM530DfxvxyUA+e7qvLoiBsZACfamVbRj8RAT577sf5EtmtlR7pdwB
        ZiIoE1WlJqh7pbqlecolDVmnIaEAaLE=
X-Google-Smtp-Source: ABdhPJwoCbjAGVYepjqO8nhhrZFroVZxKXsAti0UmIhzSWtLooNulTEu9rFco8glgMeDiMZHlm2SmA==
X-Received: by 2002:a05:6000:160c:: with SMTP id u12mr696815wrb.100.1631644927292;
        Tue, 14 Sep 2021 11:42:07 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id o26sm1890230wmc.17.2021.09.14.11.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 11:42:06 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Add support for IDO-SBC2D06-V1B-22W
Date:   Tue, 14 Sep 2021 20:41:38 +0200
Message-Id: <20210914184141.32700-1-romain.perier@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IDO-SOM2D01 is an ultra-small SOM module based on SigmaStar SSD201/SSD202
SoC (ARM Cortex A7 core). The module integrates WIFI, NAND and PM
circuits on a PCB area of 2.95CM x 2.95CM. The SoC integrates 128 MB of
DDR3 on-chip.

IDO-SBC2D06-V1B-22W is an dual-ethernet SBC powered by a IDO-SOM2D01,
that embeds a MicroSD card slot, 4-lane MIPI DSI connector for 4-inch
RGB565 display or 7-inch RGB888 display, Dual 10/100M Ethernet ports,
and more.

This series adds support for this SOM and this boards.

Changes since v1:
- Removed the commit that adds me as co-maintainer (merged)
- Fixed alphabetic order in dt-bindings
- Moved the commit that adds vendor prefix before adding the DT for the
  board (re-ordered commits)
- Removed unneeded space

Romain Perier (3):
  ARM: mstar: Mark timer with arm,cpu-registers-not-fw-configured
  dt-bindings: add vendor prefix for Wireless Tag
  ARM: dts: mstar: Add the Wireless Tag IDO-SBC2D06-V1B-22W

 .../devicetree/bindings/arm/mstar/mstar.yaml  |  2 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 ++
 arch/arm/boot/dts/Makefile                    |  1 +
 .../dts/mstar-infinity2m-ssd201-som2d01.dtsi  | 20 +++++++++++++
 ...sd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts | 23 +++++++++++++++
 ...ity2m-ssd202d-wirelesstag-ido-som2d01.dtsi | 28 +++++++++++++++++++
 arch/arm/boot/dts/mstar-v7.dtsi               |  1 +
 7 files changed, 77 insertions(+)
 create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd201-som2d01.dtsi
 create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts
 create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi

-- 
2.33.0

