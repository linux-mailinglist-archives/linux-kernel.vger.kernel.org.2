Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478EC438800
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 11:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhJXJpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 05:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhJXJpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 05:45:50 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBEAC061764
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 02:43:30 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id c4so1964140plg.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 02:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MrbROqXyWzGGo891/8i0TiDfYYNlRGnvVXjh5R350kQ=;
        b=D+IxJfDTlaPFHKaGSkioy3KtuQXAKXoegBDkVlSbcllXOwIHRRyMIa7Zv91I43dZql
         hBWdUqkXVcEeSHZhqwr+VnbHMAPUZCCtH+X9mV6xoARE+uK7jrSWxRYJUp/69/+5owS5
         /q7mlV1/vb9e0OgQiW8CJnfTEjyLksgQR6MpmvloVH2v59MAR1Z4ddBCXhEMAg1f5U/x
         Ywn0ghtXOFckGFtYY4z083bAW6e5jBo2kfaFzxgCe0Vahyop2rw58fXv5B3dAdL2lN4k
         Lhut7Shn7L1WDXQrgJq2XYc/t2f9OmbaABEM57Zighlw6THGixL70aFORR1gIrVaXcUc
         xXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MrbROqXyWzGGo891/8i0TiDfYYNlRGnvVXjh5R350kQ=;
        b=1+4CJy1xk8OGTvpGjl2IeQU2hdBwh1X3pHDqyC1h0Uhty+/xinWEhslzJxBwSa0Pot
         NMnrkSQHptjQnHmflR0W7NITOjn9H6CiL047GvZBR1X/SCINJpSRC9/9kWbS+KsvdfJ1
         gfFth58rbwm+4yrXjuEKBQutblnLkfw338KSpbOTGqsIhtSRzHZWPw2lwwqtiEzdHr6S
         7qxbevpOHj7Aeka7ZSGQt3rz4DJGnMRVfmf3QwRE/Nge9URoRpLgPAh5DN6Oi8/odqeg
         bCWyVwFnCnPCFK+nPuDjhhVxLMlfz4CFdiuHkTWI3+9dQFRc4uDMU0hltdl8PGxasJ3A
         2N1g==
X-Gm-Message-State: AOAM5322r4twe7RRQR6Iu/kEuP7RtKMFjAzSVEWnkvh2MauZAv2avoOV
        cUeDVCe0LcKT73szrvEp/Ts=
X-Google-Smtp-Source: ABdhPJwFuPHuB7BVXh0QqTHXKQUbZjDsXO1xJtOvODqb+NmKn6K070jcwnL7BE4xtB1oGrrJapxgZA==
X-Received: by 2002:a17:90a:34b:: with SMTP id 11mr12652753pjf.188.1635068609645;
        Sun, 24 Oct 2021 02:43:29 -0700 (PDT)
Received: from lxb-server.lan ([2403:18c0:2:7e::1926:817])
        by smtp.gmail.com with ESMTPSA id p16sm17636619pfh.97.2021.10.24.02.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 02:43:29 -0700 (PDT)
From:   Yunhao Tian <t123yh.xyz@gmail.com>
X-Google-Original-From: Yunhao Tian <t123yh@outlook.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Yunhao Tian <t123yh.xyz@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] Rockchip S/PDIF Reciever Driver
Date:   Sun, 24 Oct 2021 17:43:14 +0800
Message-Id: <20211024094317.1641949-1-t123yh@outlook.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunhao Tian <t123yh.xyz@gmail.com>

Hello,

This patch series adds support for S/PDIF receiver found
on RK3308.

The code is based on Rockchip Kernel 4.4. Several ALSA
controls such as synchronization status, sample rate and
channel status bits are added. Also some basic error handling
such as parity error or BMC decode error are performed. The 
implementation took stm32-spdifrx and mchp-spdifrx as reference.

The driver is tested to be working on my custom board based
on Firefly CORE-3308Y, with a TOSLINK receiver.

This is my first time submitting a new driver to kernel, so
I'll appreciate it if I can be corrected for anything wrong.

Yunhao Tian (3):
  ASoC: rockchip: add support for spdifrx receiver
  ASoC: dt-bindings: rockchip: add spdifrx bindings
  arm64: dts: rockchip: add spdifrx support to rk3308.dtsi

 .../bindings/sound/rockchip-spdifrx.yaml      |  80 +++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/rockchip/rk3308.dtsi      |  16 +
 sound/soc/rockchip/Kconfig                    |   8 +
 sound/soc/rockchip/Makefile                   |   2 +
 sound/soc/rockchip/rockchip_spdifrx.c         | 660 ++++++++++++++++++
 sound/soc/rockchip/rockchip_spdifrx.h         |  90 +++
 7 files changed, 863 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-spdifrx.yaml
 create mode 100644 sound/soc/rockchip/rockchip_spdifrx.c
 create mode 100644 sound/soc/rockchip/rockchip_spdifrx.h

-- 
2.25.1

