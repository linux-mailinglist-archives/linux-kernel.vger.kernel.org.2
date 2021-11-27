Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCD345FF29
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 15:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244833AbhK0OYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 09:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbhK0OWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 09:22:39 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301C3C06173E;
        Sat, 27 Nov 2021 06:19:25 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o29so10478255wms.2;
        Sat, 27 Nov 2021 06:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xFp9yJ8rZkXgj7ePptPkWdw3Q/P2qqDL2o/jvz8fSVA=;
        b=Dn/5p85mul5rJG5QzcqwN+ymmrQpsTyNF1VyBb2/2WRiYgMzUPB9hGQ11+b0LyEUv2
         ncY3otlJKo7WXwk9WFGo8fPd3fvHZfDvV+nC9rv6ka9AzI36Bwx50riZVrIMKsNSUhcz
         zkbt4l7psn/G8HNBZDoCQbWZX0l0ivQ010vBHlF9yWMZ2rMGoStb1C1Ce7OxiX620dVl
         ALe5zhflAINYKJK8fyI5FLz8jFdc+sZTzmMJiAdMxfiKMDDO27LeAry0i4p/QlvLdd5+
         0534c51K3c+DjQEAKBqha2Q0v16Cm7ZjdBeA4UOkaQpWFRwFN3fmnra7U3hDprTRTfrl
         2hSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xFp9yJ8rZkXgj7ePptPkWdw3Q/P2qqDL2o/jvz8fSVA=;
        b=Q7QRqrGFtcNXqsjcGj/+Pd34A63F/SMv3aC3Gy/SFHDEHU8hkXRHu+ssXnZTvrTHnA
         QlHrYh8yVeM0ty8e5T2kNudCnCzXbQtV89GTx2+AVSzuhXFRL+WRCzRi7N7SpRxNdhpH
         f9eMU694QP/9A4T6xZW/4jnAhHXtNGoutXLo7YuMWm9nQfBjRqgBTYQCTHb+dmxkGSFe
         Ydu7YplERTGu+OILWxuPAp4BV0cHDEF7ph0v4g4t5GWkEUdxwc40IelHpbW7sxrhxYA1
         KAW/Bvi1SB0OCKQVn3B3fwNMCD81BZdrMMuNeEOryZ33zR2eV/iA8mNlX8H0c6Nw1Z74
         fD4A==
X-Gm-Message-State: AOAM533DOwRxhLzpLV8exZgyCcD/JNmnZxFl94ELKnnWhhEFfuNwp1PO
        Bxz0YPOIja+rVG9Nz1DdufLyis52kes=
X-Google-Smtp-Source: ABdhPJzBzdfHExsOWLTrSNW4E0mEbnVK370gPl2fRqZmj0TWJi+4C4nBiEub4EfNn6LocJn0l3xXOw==
X-Received: by 2002:a1c:f418:: with SMTP id z24mr23529383wma.95.1638022763324;
        Sat, 27 Nov 2021 06:19:23 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id o1sm8509839wrn.63.2021.11.27.06.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:19:22 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] RK356x/Quartz64 Model A SPI
Date:   Sat, 27 Nov 2021 15:19:06 +0100
Message-Id: <20211127141910.12649-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
 - sort properties in rk356x.dtsi correctly
 - remove pinctrl-1 line from rk356x.dtsi as it refers to
   non-mainline stuff

Original cover letter:

The first patch of this series adds a compatible for rk3568-spi
to the DT bindings.

The second adds the SPI nodes for RK3566 and RK3568 SoCs. The nodes
were lifted from the downstream vendor kernel's devicetree, and were
double-checked for correctness.

The third patch sets up the broken-out SPI pins on the Quartz64
Model A; they use the "m1" set of the pins, not the "m0" set. I
assume the "m" stands for "mux".

I've tested both patches by connecting an MCP2515 SPI CAN bus
controller to the spi pins, which initialised fine.

Regards,
Nicolas Frattaroli

Nicolas Frattaroli (3):
  dt-bindings: spi: spi-rockchip: Add rk3568-spi compatible
  arm64: dts: rockchip: Add spi nodes on rk356x
  arm64: dts: rockchip: Add spi1 pins on Quartz64 A

 .../devicetree/bindings/spi/spi-rockchip.yaml |  1 +
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   |  5 ++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 64 +++++++++++++++++++
 3 files changed, 70 insertions(+)

-- 
2.34.1

