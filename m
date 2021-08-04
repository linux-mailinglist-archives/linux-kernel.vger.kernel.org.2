Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98773DFDE6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 11:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbhHDJXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 05:23:19 -0400
Received: from mo-csw1514.securemx.jp ([210.130.202.153]:49114 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbhHDJXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 05:23:17 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 1749MnUk003666; Wed, 4 Aug 2021 18:22:49 +0900
X-Iguazu-Qid: 34tr8rsmplAFb8DW5K
X-Iguazu-QSIG: v=2; s=0; t=1628068969; q=34tr8rsmplAFb8DW5K; m=3WCU0AJIjs6jEOfrFboTTCoKRWn+QnzA6S4cxWAXIlQ=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1510) id 1749MlDJ008934
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 4 Aug 2021 18:22:48 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 88195100114;
        Wed,  4 Aug 2021 18:22:47 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 1749MlD7014994;
        Wed, 4 Aug 2021 18:22:47 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v4 0/4] clk: visconti: Add support common clock driver and reset driver
Date:   Wed,  4 Aug 2021 18:22:40 +0900
X-TSB-HOP: ON
Message-Id: <20210804092244.390376-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series is PLL, clock and reset driver for Toshiba's ARM SoC, Visconti[0].
Since the clock driver and reset driver are provided as one function, they are
provided in cooperation with the clock driver.

This provides DT binding documentation, device driver, MAINTAINER files.

Best regards,
  Nobuhiro

[0]:
https://toshiba.semicon-storage.com/ap-en/semiconductor/product/image-recognition-processors-visconti.html

  clk: visconti: Add support common clock driver and reset driver
    v3 -> v4:
       - Remove osc2 clock's code. Move to DT.
    v2 -> v3:
       - Fix return value in visconti_register_pll().
       - Remove initialization of flags used by spin_lock_irqsave().
       - - Change function name from *7708* to *770x*.
       - Fix some coding style.
    v1 -> v2:
       - Fix warning with W=1

  dt-bindings: clock: Add DT bindings for PLL of Toshiba Visconti TMPV7708 SoC
    v3 -> v4:
       - Fix node name to clock-controller.
       - Remove osc2-clk-frequency, and this defines to DT as fixed-clock.
       - Add clocks.
    v2 -> v3:
       - Change file name.
    v1 -> v2:
       - Update subject.

  dt-bindings: clock: Add DT bindings for SMU of Toshiba Visconti TMPV7708 SoC
    v3 -> v4:
      - Move reset dt-binding header file.
      - Move clock dt-binding header file.
      - Change dt-binding header's License to 'GPL-2.0-only OR BSD-2-Clause'
      - Fix node name to clock-controller.
    v2 -> v3:
       - Change file name.
    v1 -> v2:
       - Update subject.

  MAINTAINERS: Add entries for Toshiba Visconti PLL and clock controller
    v3 -> v4:
       - no update.
    v2 -> v3:
       - Change path of DT binding files.
    v1 -> v2:
       - no update.

Nobuhiro Iwamatsu (4):
  dt-bindings: clock: Add DT bindings for PLL of Toshiba Visconti TMPV770x SoC
  dt-bindings: clock: Add DT bindings for SMU of Toshiba Visconti TMPV770x SoC
  clk: visconti: Add support common clock driver and reset driver
  MAINTAINERS: Add entries for Toshiba Visconti PLL and clock controller

 .../clock/toshiba,tmpv770x-pipllct.yaml       |  57 +++
 .../clock/toshiba,tmpv770x-pismu.yaml         |  50 +++
 MAINTAINERS                                   |   3 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/visconti/Makefile                 |   5 +
 drivers/clk/visconti/clkc-tmpv770x.c          | 232 +++++++++++
 drivers/clk/visconti/clkc.c                   | 220 +++++++++++
 drivers/clk/visconti/clkc.h                   |  75 ++++
 drivers/clk/visconti/pll-tmpv770x.c           |  85 ++++
 drivers/clk/visconti/pll.c                    | 369 ++++++++++++++++++
 drivers/clk/visconti/pll.h                    |  63 +++
 drivers/clk/visconti/reset.c                  | 111 ++++++
 drivers/clk/visconti/reset.h                  |  35 ++
 include/dt-bindings/clock/toshiba,tmpv770x.h  | 181 +++++++++
 include/dt-bindings/reset/toshiba,tmpv770x.h  |  41 ++
 15 files changed, 1528 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pismu.yaml
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
2.32.0


