Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80B83C7A1B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 01:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbhGMX2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 19:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbhGMX2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 19:28:09 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6E8C0613EE;
        Tue, 13 Jul 2021 16:25:19 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t5so746545wrw.12;
        Tue, 13 Jul 2021 16:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ckTGbZYjMBN6bQFIKxKbHf0AEy0oeeo0/u3w8Y3OyWc=;
        b=M2FB1G/+Bzb0HbxnguydMGZ5+c+DNtTkZdOVh5J+32yPwzMGwJSdU2Wg57LKNMV0Nc
         16LYy1mcfvowk5ZBECRfC1mJozfC42fLyxU5/hTv6+DRppzGv0YyxiM0xYyBERZbvi3O
         2UIMOr1ju/QPmwuTxniUT+3PrxKFHolhiRllxh6LeMiwcNqs1rN+wpFNihwRu+Zbmhns
         eoHRYOLHKFsjmMe1crKh1YtSbEoSsC5LVzfxm8Ve4d5j767nVZk+PhrvnFyGJpwTAlgL
         i9iDSmstrrlXXCOOU76QeKMQEasCFiCCRcTEcoyiZteqLK83a5xONkIKG6y/L3fnUn3F
         N3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ckTGbZYjMBN6bQFIKxKbHf0AEy0oeeo0/u3w8Y3OyWc=;
        b=XaOl5XNP4Z/uXGDdATbFH5StAo1X8KvFdDv0HHyfEuZD7IotEjAQSpDr0BnNnDL2Ih
         gkorDrKgrWkAAuYfiYBDhCRPH+kTtq7H0ioIeJYS1nwgcMrPrUuRX/iLF2pqTMqpEMK1
         NBwyto0cFbZ+uSCRnxsipn9yHGOqhD2Syw1qTPc2311N4bUPIOQh7SdjOx6B7SHNxQaC
         z4RmTSFU1WKzfDSXhxFt8owQpeiGQOyAqCszZsIk6I6Y9AXNhdJD8tOEOGJxRjSxIQXi
         slm03trke0YQpvlpP1+NND9j1WdGf7Wlz56Nj2nmxw5YNugKi33oGw3pZUuaMmoMYuBE
         A6KA==
X-Gm-Message-State: AOAM531KnyYDluAJ5FK9rl+dwwSVYz3XOXIC6SEcmwIKjmiKrm5o2Aff
        tHIyqdAvyxckQ4KqJFv99Z8=
X-Google-Smtp-Source: ABdhPJw3h3gd6eTLJMr6Skks+aXz9E25IeOGjNqYyBOuIUrXawnRbKh7RPGk85sG6Y6UZWP6kskkTg==
X-Received: by 2002:adf:a148:: with SMTP id r8mr8528226wrr.415.1626218717651;
        Tue, 13 Jul 2021 16:25:17 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c041-6f00-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c041:6f00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id o11sm3857390wmc.2.2021.07.13.16.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 16:25:17 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, jbrunet@baylibre.com,
        narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/6] clk: meson8b: video clock tree fixes and making it mutable
Date:   Wed, 14 Jul 2021 01:25:04 +0200
Message-Id: <20210713232510.3057750-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first two patches in this series are small fixes before we can
actually make the video clock tree mutable. One patch adds
CLK_SET_RATE_NO_REPARENT for better rate control and the other adds
a missing clock gate.

The third and fourth patch are targeting the HDMI PLL. Add the known
working M/N combinations. Also this PLL has some special "doubling"
setting, which is calculated like this:
  OUTPUT = (IN * M / N + FRAC) * 2
Since not all register bits are known we use a copy of the 2970/2975MHz
magic register values from the vendor driver.

The fifth patch makes the clocks in the video clock tree mutable. The
final patch in this series exports the clocks needed for rate control.

For reference, this is the .dts definition for the Meson8b VPU. The
code for the VPU driver is unfortunately not ready for upstreaming yet.
However, I have tested with all resolutions my monitor supports and the
clock settings are all applied correctly.
    vpu: vpu@100000 {
      compatible = "amlogic,meson8b-vpu";

      reg = <0x100000 0x10000>;
      reg-names = "vpu";

      interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;

      amlogic,canvas = <&canvas>;
      amlogic,hhi-sysctrl = <&hhi>;

      /*
       * The VCLK{,2}_IN path always needs to derived from
       * the CLKID_VID_PLL_FINAL_DIV so other clocks like
       * MPLL1 are not used (MPLL1 is reserved for audio
       * purposes).
       */
      assigned-clocks = <&clkc CLKID_VCLK_IN_SEL>,
                        <&clkc CLKID_VCLK2_IN_SEL>;
      assigned-clock-parents = <&clkc CLKID_VID_PLL_FINAL_DIV>,
                               <&clkc CLKID_VID_PLL_FINAL_DIV>;

      clocks = <&clkc CLKID_VPU_INTR>,
               <&clkc CLKID_HDMI_INTR_SYNC>,
               <&clkc CLKID_GCLK_VENCI_INT>,
               <&clkc CLKID_HDMI_PLL_HDMI_OUT>,
               <&clkc CLKID_HDMI_TX_PIXEL>,
               <&clkc CLKID_CTS_ENCP>,
               <&clkc CLKID_CTS_ENCI>,
               <&clkc CLKID_CTS_ENCT>,
               <&clkc CLKID_CTS_ENCL>,
               <&clkc CLKID_CTS_VDAC0>;
      clock-names = "vpu_intr",
                    "hdmi_intr_sync",
                    "venci_int",
                    "tmds",
                    "hdmi_tx_pixel",
                    "cts_encp",
                    "cts_enci",
                    "cts_enct",
                    "cts_encl",
                    "cts_vdac0";

      resets = <&clkc CLKC_RESET_VID_DIVIDER_CNTL_RESET_N_PRE>,
               <&clkc CLKC_RESET_VID_DIVIDER_CNTL_RESET_N_POST>,
               <&clkc CLKC_RESET_VID_DIVIDER_CNTL_SOFT_RESET_PRE>,
               <&clkc CLKC_RESET_VID_DIVIDER_CNTL_SOFT_RESET_POST>;
      reset-names = "vid_pll_pre",
                    "vid_pll_post",
                    "vid_pll_soft_pre",
                    "vid_pll_soft_post";

      power-domains = <&pwrc PWRC_MESON8_VPU_ID>;

      nvmem-cells = <&cvbs_trimming>;
      nvmem-cell-names = "cvbs_trimming";

      #address-cells = <1>;
      #size-cells = <0>;

      #sound-dai-cells = <0>;
      sound-name-prefix = "HDMITX";

      /* CVBS VDAC output port */
      cvbs_vdac_port: port@0 {
        reg = <0>;
      };

      /* HDMI-TX output port */
      hdmi_tx_port: port@1 {
        reg = <1>;

        hdmi_tx_out: endpoint {
          remote-endpoint = <&hdmi_tx_in>;
        };
      };
    };


Martin Blumenstingl (6):
  clk: meson: meson8b: Use CLK_SET_RATE_NO_REPARENT for vclk{,2}_in_sel
  clk: meson: meson8b: Add the vid_pll_lvds_en gate clock
  clk: meson: meson8b: Add the HDMI PLL M/N parameters
  clk: meson: meson8b: Initialize the HDMI PLL registers
  clk: meson: meson8b: Make the video clock trees mutable
  clk: meson: meson8b: Export the video clocks

 drivers/clk/meson/meson8b.c              | 163 +++++++++++++++++------
 drivers/clk/meson/meson8b.h              |  26 ++--
 include/dt-bindings/clock/meson8b-clkc.h |  10 ++
 3 files changed, 143 insertions(+), 56 deletions(-)

-- 
2.32.0

