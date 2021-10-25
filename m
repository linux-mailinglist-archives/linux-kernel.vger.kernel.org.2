Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF421438DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 05:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhJYDNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 23:13:20 -0400
Received: from mo-csw1515.securemx.jp ([210.130.202.154]:47328 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbhJYDNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 23:13:19 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 19P3AhKR003229; Mon, 25 Oct 2021 12:10:44 +0900
X-Iguazu-Qid: 34tIWSYHCieujeRQRA
X-Iguazu-QSIG: v=2; s=0; t=1635131443; q=34tIWSYHCieujeRQRA; m=RK/Bg2T8APxsmPrQXug5NkOjYxXvMIPYIDMolk3DfcQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1512) id 19P3AfXF019206
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 25 Oct 2021 12:10:42 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id B7BEB1000CA;
        Mon, 25 Oct 2021 12:10:41 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 19P3Af6w004067;
        Mon, 25 Oct 2021 12:10:41 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v5 0/4] clk: visconti: Add support common clock driver and reset driver
Date:   Mon, 25 Oct 2021 12:10:34 +0900
X-TSB-HOP: ON
Message-Id: <20211025031038.4180686-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series is PLL, clock and reset driver for Toshiba's ARM SoC,
Visconti[0].
Since the clock driver and reset driver are provided as one function,
they are
provided in cooperation with the clock driver.

This provides DT binding documentation, device driver, MAINTAINER files.

Best regards,
  Nobuhiro

[0]: https://toshiba.semicon-storage.com/ap-en/semiconductor/product/image-recognition-processors-visconti.html

  dt-bindings: clock: Add DT bindings for PLL of Toshiba Visconti TMPV7708 SoC
    v4 -> v5:
       - Add Reviewed-by: Rob Herring <robh@kernel.org>.
    v3 -> v4:
       - Fix node name to clock-controller.
       - Remove osc2-clk-frequency, and this defines to DT as
         fixed-clock.
       - Add clocks.
    v2 -> v3:
       - Change file name.
    v1 -> v2:
       - Update subject.

  dt-bindings: clock: Add DT bindings for SMU of Toshiba Visconti TMPV7708 SoC
    v4 -> v5:
       - Add Reviewed-by: Rob Herring <robh@kernel.org>.
       - v5: Update to use syscon.
    v3 -> v4:
      - Move reset dt-binding header file.
      - Move clock dt-binding header file.
      - Change dt-binding header's License to 'GPL-2.0-only OR
        BSD-2-Clause'
      - Fix node name to clock-controller.
    v2 -> v3:
       - Change file name.
    v1 -> v2:
       - Update subject.

  clk: visconti: Add support common clock driver and reset driver
    v4 -> v5:
      - Makefile/Kconfig
        Update Kconfig with using COMPILE_TEST
      - clkc-tmpv770x.c
        Fix location of include file.
        Fix to use clk-provider.h.
        Update clock flags in pietherpll_clk_gate_tables and others.
        Use lowercase hex.
        Update to use syscon.
        Update to use platform driver instead of CLK_OF_DECLARE_DRIVER.
      - clkc.c
        Fix check of visconti_gate_clk_is_enabled.
        Drop visconti_gate_clk_is_enabled in visconti_gate_clk_enable().
        Drop unnecessary comment.
        Update to use clk_parent_data instead of parent_names.
        Update to use devm_clk_hw_register().
        Update to use struct device in visconti_clk_register_gate().
        Update to get structure size from pointer with sizeof().
      - clkc.h
        Update struct visconti_clk_gate_table to using struct clk_parent_data.
        Drop flags in struct visconti_clk_gate.
      - pll-tmpv770x.c
        Use lowercase hex.
        Update to use platform driver instead of CLK_OF_DECLARE_DRIVER.
        Update to use size_t in visconti_pll and move position.
        Update use FIELD_GET().
        Drop braces.
        Use const point in visconti_get_pll_rate_from_data().
        Update to comparison by memcmp in visconti_get_pll_rate_from_data().
        Drop unnecessary comment.
        Drop unnecessary print.
        Drop unnecessary lock and unlock.
        Drop visconti_pll_is_enabled in visconti_pll_enable().
        Drop unused flags.
        Update to use clk_hw_register().
        Drop to use kmemdup().
      - pll.h
        Drop __init.
    v3 -> v4:
       - Remove osc2 clock's code. Move to DT.
    v2 -> v3:
       - Fix return value in visconti_register_pll().
       - Remove initialization of flags used by spin_lock_irqsave().
       - - Change function name from *7708* to *770x*.
       - Fix some coding style.
    v1 -> v2:
       - Fix warning with W=1

  MAINTAINERS: Add entries for Toshiba Visconti PLL and clock controller
    v4 -> v5:
       - no update.
    v3 -> v4:
       - no update.
    v2 -> v3:
       - Change path of DT binding files.
    v1 -> v2:


Nobuhiro Iwamatsu (4):
  dt-bindings: clock: Add DT bindings for PLL of Toshiba Visconti TMPV770x SoC
  dt-bindings: clock: Add DT bindings for SMU of Toshiba Visconti TMPV770x SoC
  clk: visconti: Add support common clock driver and reset driver
  MAINTAINERS: Add entries for Toshiba Visconti PLL and clock controller

 .../clock/toshiba,tmpv770x-pipllct.yaml       |  57 +++
 .../clock/toshiba,tmpv770x-pismu.yaml         |  52 +++
 MAINTAINERS                                   |   3 +
 drivers/clk/Kconfig                           |   1 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/visconti/Kconfig                  |   9 +
 drivers/clk/visconti/Makefile                 |   5 +
 drivers/clk/visconti/clkc-tmpv770x.c          | 291 +++++++++++++++
 drivers/clk/visconti/clkc.c                   | 206 +++++++++++
 drivers/clk/visconti/clkc.h                   |  76 ++++
 drivers/clk/visconti/pll-tmpv770x.c           |  85 +++++
 drivers/clk/visconti/pll.c                    | 339 ++++++++++++++++++
 drivers/clk/visconti/pll.h                    |  62 ++++
 drivers/clk/visconti/reset.c                  | 107 ++++++
 drivers/clk/visconti/reset.h                  |  36 ++
 include/dt-bindings/clock/toshiba,tmpv770x.h  | 181 ++++++++++
 include/dt-bindings/reset/toshiba,tmpv770x.h  |  41 +++
 17 files changed, 1552 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pismu.yaml
 create mode 100644 drivers/clk/visconti/Kconfig
 create mode 100644 drivers/clk/visconti/Makefile
 create mode 100644 drivers/clk/visconti/clkc-tmpv770x.c
 create mode 100644 drivers/clk/visconti/clkc.c
 create mode 100644 drivers/clk/visconti/clkc.h
 create mode 100644 drivers/clk/visconti/pll-tmpv770x.c
 create mode 100644 drivers/clk/visconti/pll.c
 create mode 100644 drivers/clk/visconti/pll.h
 create mode 100644 drivers/clk/visconti/reset.c
 create mode 100644 drivers/clk/visconti/reset.h
 create mode 100644 include/dt-bindings/clock/toshiba,tmpv770x.h
 create mode 100644 include/dt-bindings/reset/toshiba,tmpv770x.h

-- 
2.33.0


